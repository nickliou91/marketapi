class OrderSerializer < ActiveModel::Serializer
  # attributes :id
  attributes :id, :total
  has_many :products, serializer: OrderProductSerializer

end
