class CreateChoices < ActiveRecord::Migration
  def self.up
    create_table :choices do |t|
      t.references :question
      t.string :letter
      t.string :choice

      t.timestamps
    end
  end

  def self.down
    drop_table :choices
  end
end
