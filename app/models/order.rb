class Order < ActiveRecord::Base
  belongs_to :user

  validates :total, presence: true,
                      numericality: { greater_than_or_equal_to: 0 }

  validates :user_id, presence: true
	has_many :placements, inverse_of: :order
  has_many :products, through: :placements

	before_validation :set_total!


def set_total!
  # self.total = products.map(&:price).sum
  self.total = 0
   placements.each do |placement|
      self.total += placement.product.price * placement.quantity
   end
end

 def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      id, quantity = product_id_and_quantity # [1,5]
      self.placements.build(product_id: id, quantity: quantity)
   
    end
  end


end
