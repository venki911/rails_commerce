# == Schema Information
#
# Table name: shipments
#
#  id                 :integer          not null, primary key
#  order_id           :integer
#  shipping_method_id :integer
#  address_id         :integer
#  tracking           :string(255)
#  aasm_state         :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#
# Indexes
#
#  index_shipments_on_aasm_state          (aasm_state)
#  index_shipments_on_address_id          (address_id)
#  index_shipments_on_order_id            (order_id)
#  index_shipments_on_shipping_method_id  (shipping_method_id)
#

class Shipment < ActiveRecord::Base
  include AASM
  include EventSource

  belongs_to :order
  belongs_to :address


  aasm do
    state :pending, initial: true
    state :ready_to_ship
    state :shipped
    state :returned
  end
end
