class AddUserIdToArticles < ActiveRecord::Migration[7.1]
  def change
    add_reference :articles, :user, foreign_key: true, null: true
  end
end
