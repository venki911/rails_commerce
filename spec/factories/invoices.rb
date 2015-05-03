# == Schema Information
#
# Table name: invoices
#
#  id             :integer          not null, primary key
#  order_id       :integer
#  payment_method :integer
#  amount         :decimal(, )
#  invoice_type   :string(255)
#  aasm_state     :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#
# Indexes
#
#  index_invoices_on_aasm_state  (aasm_state)
#  index_invoices_on_order_id    (order_id)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invoice do
  	payment_method 'test'
  	amount 	'100500'
  	invoice_type 'test'
  	order
  end
end
