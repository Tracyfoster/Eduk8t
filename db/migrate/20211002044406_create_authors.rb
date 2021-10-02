class CreateAuthors < ActiveRecord::Migration[6.1]
  def change
    create_table :authors do |t|
      t.string :name
      t.string :title
      t.string :company_name
      t.string :bio

      t.timestamps
    end
    add_reference :courses, :author, foreign_key: true
  end
end
