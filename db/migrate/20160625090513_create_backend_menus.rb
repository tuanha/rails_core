class CreateBackendMenus < ActiveRecord::Migration
  def change
    create_table :backend_menus do |t|
      t.integer :parent_id
      t.string :name
      t.string :icon
      t.string :url
      t.string :highlight
      t.integer :display_order
      t.integer :level
      t.string :role

      t.timestamps null: false
    end
  end
end
