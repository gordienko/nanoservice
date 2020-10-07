class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.string :body, null: false, index: true
      t.belongs_to :user, null: false, foreign_key: { on_delete: :cascade }

      t.timestamps
    end
  end
end
