class CreateProbes < ActiveRecord::Migration[5.1]
  def change
    create_table :probes do |t|
      t.string :name
      t.integer :field_id
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
