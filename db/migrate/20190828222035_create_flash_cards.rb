class CreateFlashCards < ActiveRecord::Migration
  def change
    create_table :flash_cards do |t|
      t.string :english
      t.string :translation
      t.string :part_of_speech
      t.integer :user_id
    end
  end
end
