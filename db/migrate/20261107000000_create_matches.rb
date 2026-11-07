class CreateMatches < ActiveRecord::Migration[8.1]
  def change
    create_table :matches do |table|
      table.json :cells, null: false, default: Array.new(9)
      table.string :mode, null: false, default: "local"
      table.string :strategy
      table.integer :lock_version, null: false, default: 0
      table.timestamps
    end
  end
end
