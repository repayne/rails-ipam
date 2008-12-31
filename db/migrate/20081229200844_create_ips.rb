class CreateIps < ActiveRecord::Migration
  def self.up
    create_table :ips do |t|
			#t.column :ip_address, 'integer unsigned'
			t.column :ip_address, :string, :null => false
			t.column :hostname, :string
			t.column :a_rec, :string
			t.column :ptr_rec, :string
			t.column :description, :string
			t.column :notes, :text
			t.column :pingable, :boolean, :default => false, :null => false
			t.column :reserved, :boolean, :default => false, :null => false
			t.column :allocated, :boolean, :default => false, :null => false
			#add default time now in the future
      			t.timestamps
    end
  end

  def self.down
    drop_table :ips
  end
end
