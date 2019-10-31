class Student < ApplicationRecord  
  # associations
  belongs_to :department
  belongs_to :section

  # validations
  validates :name, presence: true, uniqueness: true
  validates :department_id, presence: true
  validates :section_id, presence: true
  validates :email, uniqueness: true

  validate :validate_section_mapping

  # callbacks
  before_create :generate_roll_no

  private

  def validate_section_mapping
    section = Section.find_by_id(section_id)

    if section.nil?
    	errors.add(:section, "Section cannot be nil!!!")
    elsif section.department_id != department_id
      errors.add(:section, "Selected section doesn't belongs to selected department")
    end
  end

  def generate_roll_no
    max_count = Student.count
    department_name = department.name.downcase.gsub(/\s/, '-')
    section_name = section.name.downcase.gsub(/\s/, '-')
    self.roll_no = "#{department_name}-#{section_name}-#{max_count+1}"
  end
end