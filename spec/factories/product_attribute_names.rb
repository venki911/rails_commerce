# == Schema Information
#
# Table name: product_attribute_names
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category_id :integer
#  filterable  :boolean
#  created_at  :datetime
#  updated_at  :datetime
#  weight      :integer
#
# Indexes
#
#  index_product_attribute_names_on_category_id  (category_id)
#  index_product_attribute_names_on_name         (name)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product_attribute_name do
    name Faker::Lorem::word
    filterable true
    category
  end
end
