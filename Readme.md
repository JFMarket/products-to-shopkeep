#JFM
## Products to ShopKeep

This script converts the file `products-fixed-units.csv` from the format `Name,Grower,Retail Price,Unit,Available,Estimate or Exact,Description` to the CSV format accepted by ShopKeep and stores it in `products-importable-to-shopkeep.csv`.

## Usage

`products-fixed-units.csv` must exist in the current directory.

`ruby products-to-shopkeep.rb`

`products-importable-to-shopkeep.csv` should be created in the current directory.

### Assumptions

The following assumptions were made for each product.

* Department           = null
* Category             = null
* Price type           = unit
* Cost                 = 0
* Taxable              = true
* Discountable         = true
* Inventory Method     = tracked
* Order Trigger        = 10
* Recommended Order    = 20
* UPC Code             = null