class AddLastSuccessfulAttemptAtToCards < ActiveRecord::Migration[5.1]
  def change
    add_column :cards, :last_successful_attempt_at, :datetime
    add_index :cards, :last_successful_attempt_at
  end
end
