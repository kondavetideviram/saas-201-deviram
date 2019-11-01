class Section < ApplicationRecord
	belongs_to :department
	has_many :students , dependent: :destroy

	#validations
	validates :name, presence: true, uniqueness: true
  	validates :department_id, presence: true

  	#callback

  	before_save :small_to_CAPS

  	private

  	def small_to_CAPS
  		self.name.upcase!
  	end
end
