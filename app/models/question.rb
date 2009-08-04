class Question < ActiveRecord::Base
  has_many :choices
  
  # replace proc with :all_blank when it becomes available
  accepts_nested_attributes_for :choices, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
  def answer(current_user)
    current_user.answers.find_by_question_id(id)
  end
  
end
