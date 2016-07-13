class AddDetailsToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :medium, :string
    add_column :microposts, :title, :string
    add_column :microposts, :price, :decimal, :precision => 8, :scale => 2
    add_column :microposts, :width, :float, :precision => 5, :scale => 2
    add_column :microposts, :height, :float, :precision => 5, :scale => 2

	add_index :microposts, [:medium, :title]
  end

end
