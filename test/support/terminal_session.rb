require "pty"
require "rbconfig"
require "timeout"

class TerminalSession
  TIMEOUT = 5

  def initialize
    @output, @input, @pid = PTY.spawn(
      RbConfig.ruby, File.expand_path("../../bin/tic-tac-toe", __dir__)
    )
    @buffer = +""
  end

  def send_keys(keys)
    @input.write(keys)
    @input.flush
  end

  def wait_for(text)
    Timeout.timeout(TIMEOUT) do
      @buffer << @output.readpartial(4096) until @buffer.include?(text)
    end
    index = @buffer.index(text) + text.length
    @buffer.slice!(0, index)
  rescue EOFError, Errno::EIO
    raise "Terminal exited before displaying #{text.inspect}. Output: #{@buffer.inspect}"
  rescue Timeout::Error
    raise "Timed out waiting for #{text.inspect}. Output: #{@buffer.inspect}"
  end

  def wait_for_exit
    _, status = Timeout.timeout(TIMEOUT) { Process.wait2(@pid) }
    @pid = nil
    status
  rescue Timeout::Error
    raise "Timed out waiting for terminal application to exit"
  end

  def close
    if @pid
      begin
        Process.kill("TERM", @pid)
      rescue Errno::ESRCH
        # The child may already have exited.
      end
      Process.waitpid(@pid)
      @pid = nil
    end
    @input.close unless @input.closed?
    @output.close unless @output.closed?
  end
end
