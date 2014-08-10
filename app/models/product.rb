# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  price       :decimal(, )
#  active      :boolean
#  category_id :integer
#  brand_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

require 'transliteration'

class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :brand
  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 2048 }
  validates :category_id, presence: true
  validates :brand_id, presence: true
  validates :price, presence: true, numericality: true
  has_many :images, as: :imageable, dependent: :destroy
  has_many :product_attribute_values, dependent: :destroy

  accepts_nested_attributes_for :product_attribute_values

  before_update :clear_attributes

  def previous
    Product.find_by_id(id - 1)
  end

  def next
    Product.find_by_id(id + 1)
  end

  def self.find_all_by_term(search_term)
    search_term = "%#{search_term}%"
    Product.where('name LIKE ? OR description LIKE ?', search_term, search_term)
  end

  def available_attributes
    @available_attributes ||=
    transaction do
      if category.product_attributes.any?
        category.product_attributes.map do |x|
          ProductAttributeValue
            .find_or_initialize_by(product_id: id,
                                   product_attribute_id: x.id)
        end
      end
    end
  end

  def clone
    product = dup
    product.active = false # Product should be inactive by default
    product.product_attribute_values = product_attribute_values.map(&:dup)
    product
  end

  def seo_name
    Transliteration::transliterate(name).parameterize
  end

  private

  # Remove existing attributes values if we changed product's category
  def clear_attributes
    return true unless category_id_changed?
    transaction do
      product_attribute_values.each { |x| x.delete }
    end
  end
end