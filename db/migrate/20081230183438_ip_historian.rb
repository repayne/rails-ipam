class IpHistorian < ActiveRecord::Migration
  def self.up
      create_table :ip_historians do |t|
			#t.column :ip_address, 'integer unsigned'
			t.column :ip_address, :string, :null => false 
			t.column :hostname, :string
			t.column :a_rec, :string
			t.column :ptr_rec, :string
			t.column :description, :string
			t.column :notes, :text
			t.column :pingable, :boolean, :null => false
			t.column :reserved, :boolean, :null => false
			t.column :allocated, :boolean, :null => false
      t.timestamps
    end
  end

  def self.down
  	drop_table :ip_historians
  end

end
