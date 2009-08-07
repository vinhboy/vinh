class Choice < ActiveRecord::Base
  belongs_to :question
  
  validates_presence_of :question
  validates_uniqueness_of :letter
end
