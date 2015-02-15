class CreateStyles < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description
      t.timestamps null: false
    end

    rename_column :beers, :style, :old_style
    add_column :beers, :style_id, :integer
    Style.create :name => 'Pale Ale', :description => 'Pale ale is a beer made by warm fermentation using predominantly pale malt.'
    Style.create :name => 'IPA', :description => 'India Pale Ale (IPA) is a hoppy beer style within the broader category of pale ale.'
    Style.create :name => 'Lager', :description => 'Lager is a type of beer that is fermented and conditioned at low temperatures.'
    Style.create :name => 'Porter', :description => 'Porter is a dark style of beer developed in London from well-hopped beers made from brown malt.'
    Style.create :name => 'Weizen', :description => 'Weizen, wheat beer is a style of beer brewed with a large proportion of wheat malt.'

    remove_column :beers, :old_style
  end
end