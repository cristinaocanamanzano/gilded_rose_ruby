Gilded Rose Refactoring Kata
==========
This project consists of a proposed solution to the Gilded Rose Refactoring Kata in Ruby.

Specifications
-------
The challenge consists of refactoring the original code so that its design is improved in such a way that adding new functionality is easy.

To do so, any changes can be made to the update_quality method, but no changes can be made to the Item class or the items property.

More specific details can be found [here](https://github.com/makersacademy/course/blob/master/individual_challenges/gilded_rose.md).

Setup
-------
1. Download this repository and open it in the command line
2. Run 'irb'
3. Require the file 'gilded_rose.rb'


How to run the tests
-------
1. Download this repository and open it in the command line
2. Run 'bundle' to install the RSpec gem
3. Run 'rspec'

What would be next?
-------
Next implementations would be:
- Improve the change_backstage_quality method so that the quality of the item cannot get higher than 50
- Add new methods so that new items can be added to @items, @special_sellin_items and @special_quality_items after initializing a GildedRose object.
