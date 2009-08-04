class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  validates_uniqueness_of :question_id, :scope => :user_id

  validates_presence_of :user_id
  validates_presence_of :question_id
end
