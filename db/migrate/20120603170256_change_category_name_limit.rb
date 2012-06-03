class ChangeCategoryNameLimit < ActiveRecord::Migration
  def change
  	change_column :categories, :name, :string, limit: 50
  end
end
