# frozen_string_literal: true

# class that adds fullname and username columns to user model
class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :full_name, :string
    add_column :users, :user_name, :string
  end
end
