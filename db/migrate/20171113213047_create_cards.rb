class CreateCards < ActiveRecord::Migration[5.1]
  def change
    create_table :cards do |t|
      t.string :question, null: false
      t.string :answer_encrypted, null: false

      t.timestamps
    end
  end
end
