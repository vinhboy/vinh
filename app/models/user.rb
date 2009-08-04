class User < ActiveRecord::Base
  has_many :answers
  
  # replace proc with :all_blank when it becomes available
  accepts_nested_attributes_for :answers, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  
  acts_as_authentic
  
  def matches
    users = User.all
    matches = Hash.new
    numerator = 0
    denominator = 0
    
    users.collect do |user|
      next if id == user.id
      user.dna.split(//).each_with_index do |nucleotide,index|
        if (nucleotide != 0) and (dna[index,1] != "0")
          numerator += 1 if dna[index,1] == nucleotide
          denominator += 1
        end
      end
      matches[user.id] = (numerator.to_f/denominator * 100).round
    end
    
    matches
  end
end
