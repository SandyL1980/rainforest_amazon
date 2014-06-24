class Product < ActiveRecord::Base

	validates :name, :description, :presence => true
	validates :price_in_cents, :numericality => {:only_integer => true}
	validates :name, length: {minimum: 1 }

	after_validation :format_title

	def formatted_price
	    price_in_dollars = price_in_cents.to_f / 100
	    sprintf("$ %.2f", price_in_dollars)
  	end

  	def format_title
  		self.title = title.titleize
  	end

     has_many :reviews
  	 has_many :users, :through => :reviews
  	 belongs_to :category

  	 delegate :name, :to => :category, :prefix => true, :allow_nil => true

end
