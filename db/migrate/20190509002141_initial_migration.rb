class InitialMigration < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name, null: false 
      t.timestamps
    end
    
    create_table :roles do |t|
      t.string :name, null: false 
      t.timestamps
    end

    create_table :rights do |t|
      t.string :name, null: false 
      t.text :description
      t.timestamps 
    end
    
    create_table :role_rights do |t|
      t.belongs_to :role, foreign_key: true
      t.belongs_to :right, foreign_key: true
      t.timestamps 
    end 

    create_table :user_roles do |t|
      t.belongs_to :user, foreign_key: true 
      t.belongs_to :role, foreign_key: true 
      t.boolean :is_selected, default: true
      t.timestamps
    end 

    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.belongs_to :category, foreign_key: true
      t.belongs_to :user, foreign_key: true
      t.timestamps
    end

  end
end
