#!/usr/bin/env ruby

require 'CSV'

class Item
	def initialize(name, unit, price, quantity, supplier)
		@name = name
		@unit = unit
		@price = price
		@quantity = quantity
		@supplier = supplier
	end

	def to_a
		a = []
		a << shopkeep_sanitize(@name)
		a << ""
		a << ""
		a << "unit"
		a << shopkeep_sanitize(@unit)
		a << shopkeep_sanitize(@price)
		a << shopkeep_sanitize(@quantity)
		a << 0
		a << "TRUE"
		a << "TRUE"
		a << "tracked"
		a << ""
		a << 10
		a << 20
		a << ""
		a << "active"
		a << shopkeep_sanitize(@supplier)
		a << ""
		return a
	end

	def shopkeep_sanitize(s)
		s.gsub(/(@|#|\$|%|"|&|\*|\\|'|-|`)/, '')
	end
end

# Name,Grower,Retail Price,Unit,Available,Estimate or Exact,Description
products = []

CSV.foreach 'products-fixed-units.csv' do |row|
	products << Item.new(row[0], row[3], row[2], row[4], row[1])
end

products.shift # Remove header row

# http://help.shopkeep.com/customer/portal/articles/1221292-imports-add-modify-delete-inventory
# Description             => Name
# Department              => ""
# Category                => ""
# Price Type              => "unit"
# Unit                    => Unit
# Price                   => Retail Price
# Quantity on Hand        => Available
# Cost                    => 0
# Taxable                 => "TRUE"
# Discountable            => "TRUE"
# Inventory Method        => "tracked"
# Assigned Cost           => ""
# Order Trigger           => 10
# Recommended Order       => 20
# UPC Code                => ""
# Register Data Status    => "active"
# Supplier                => Grower
# Supplier Code           => ""

CSV.open('products-importable-to-shopkeep.csv', 'wb') do |csv|
	csv << [
		"Description",
		 "Department",
		 "Category",
		 "Price Type",
		 "Unit",
		 "Price",
		 "Quantity on Hand",
		 "Cost",
		 "Taxable",
		 "Discountable",
		 "Inventory Method",
		 "Assigned Cost",
		 "Order Trigger",
		 "Recommended Order",
		 "UPC Code",
		 "Register Data Status",
		 "Supplier",
		 "Supplier Code"
	]
	products.map(&:to_a).each do |p|
		csv << p
	end
end