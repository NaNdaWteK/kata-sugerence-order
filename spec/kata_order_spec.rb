require_relative '../kata_order/Ordinal'
require_relative '../kata_order/Base'
require_relative '../kata_order/Relation'
require_relative '../kata_order/Item'
require 'spec_helper'


describe 'Kata order' do

  it 'creates a relation' do
    new_order = '0.0.0'
    ordinal = Ordinal.new
    ordinal.save(new_order)
    type = 'room'
    item = Item.new(type)
    item_id = item.id

    relation = Relation.new
    relation.set_relation(new_order, item_id)

		expect(relation.relationship.has_key?(new_order)).to be true
    expect(relation.relationship.value?(item_id)).to be true
  end

  it 'retrieves new incremented level sugerence' do
    base = Base.new
    create_level('1.0.0', 'room')
    base.add_order('1.0.0')
    create_level('1.1.0', 'item')
    base.add_order('1.1.0')
    create_level('1.2.0', 'item')
    base.add_order('1.2.0')
    create_level('1.1.1', 'subitem')
    base.add_order('1.1.1')

    parent_order = '0.0.0'
    add_to_room = '1.0.0'
    add_to_first_item = '1.1.0'

		expect(base.sugerence(parent_order)).to eq '2.0.0'
    expect(base.sugerence(add_to_room)).to eq '1.3.0'
    expect(base.sugerence(add_to_first_item)).to eq '1.1.2'
  end

end

describe 'Kata base' do

  it 'stores order in Base' do
    base = Base.new
    create_level('1.0.0', 'room')
    base.add_order('1.0.0')
    create_level('2.0.0', 'item')
    base.add_order('2.0.0')

		expect(base.keys_order[1]).to eq '1.0.0'
    expect(base.keys_order[2]).to eq '2.0.0'
  end

  it 'retrieves next major, minor and detail order' do
    base = Base.new
    create_level('1.1.0', 'room')
    base.add_order('1.1.0')
    create_level('2.1.1', 'item')
    base.add_order('2.1.1')
    create_level('3.2.2', 'item')
    base.add_order('3.2.2')

    expect(base.last_major + 1). to eq 4
    expect(base.last_minor(1) + 1).to eq 2
    expect(base.last_detail(2,1) + 1).to eq 2
  end
end

describe 'Kata item' do

  it 'is created with particular type' do
    type = 'room'
    item = Item.new(type)

		expect(item.type).to be type
  end

end

describe 'Kata ordinal' do

  it 'receives a order string' do
    new_order = '0.0.0'
    ordinal = Ordinal.new

    ordinal.save(new_order)

		expect(ordinal.order).to be new_order
  end

  it 'gets first level order' do
    new_order = '1.0.0'
    ordinal = Ordinal.new
    ordinal.save(new_order)

    level = ordinal.get_first_level

		expect(level).to eq '1'
    expect(ordinal.major).to eq '1'
  end

  it 'gets second level order' do
    new_order = '1.2.0'
    ordinal = Ordinal.new
    ordinal.save(new_order)

    level = ordinal.get_second_level

		expect(level).to eq '2'
    expect(ordinal.minor).to eq '2'
  end

  it 'gets third level order' do
    new_order = '1.2.3'
    ordinal = Ordinal.new
    ordinal.save(new_order)

    level = ordinal.get_third_level

		expect(level).to eq '3'
    expect(ordinal.detail).to eq '3'
  end

end

def create_level(new_order, type)
  ordinal = Ordinal.new
  ordinal.save(new_order)
  item = Item.new(type)
  item_id = item.id

  relation = Relation.new
  relation.set_relation(new_order, item_id)
end
