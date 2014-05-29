class AddUpVoteToLinks < ActiveRecord::Migration
  def change
    add_column :links, :upvotes, :integer, default: 0
  end
end
