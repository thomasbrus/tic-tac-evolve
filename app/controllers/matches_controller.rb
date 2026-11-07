class MatchesController < ApplicationController
  def index
    @match = Match.new
    load_history
  end

  def create
    attributes = params.expect(match: %i[mode strategy])
    attributes[:strategy] = nil if attributes[:mode] == "local"
    @match = Match.new(attributes)
    if @match.save
      redirect_to @match, status: :see_other
    else
      load_history
      render :index, status: :unprocessable_content
    end
  end

  def show
    @match = Match.find(params[:id])
  end

  def move
    @match = Match.find(params[:id])
    position = params[:position]
    position = position.is_a?(String) && position.match?(/\A[1-9]\z/) ? position.to_i : nil
    revision = params[:revision]
    revision = revision.is_a?(String) && revision.match?(/\A[0-9]+\z/) ? revision.to_i : nil
    if @match.play(position: position, expected_version: revision)
      redirect_to @match, status: :see_other
    else
      render :show, status: :unprocessable_content
    end
  end

  private

  def load_history
    @page = [params[:page].to_i, 1].max
    @matches = Match.order(created_at: :desc, id: :desc).offset((@page - 1) * 20).limit(21).to_a
    @more_matches = @matches.length > 20
    @matches = @matches.first(20)
  end
end
