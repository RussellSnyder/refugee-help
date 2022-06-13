class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.references :user, null: false, foreign_key: true
      t.string :body
      t.string :status, default: 'Open'

      t.timestamps
    end
  end
end
