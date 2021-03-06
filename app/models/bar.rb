class Bar < ApplicationRecord
	mount_uploader :image, ImageUploader
  has_many :ratings
  has_many :favorites
  has_many :users, through: :favorites
  has_many :fans, through: :favorites, source: 'user'
  @@days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]

  def self.attributes
  	%w(sports dancing beer cocktails wine rooftop cheap_food dress_code line karaoke)
  end
 
  def mean_rating
    self.ratings.average(:rating).to_f
  end

  def popular_nights= arr
  	if arr.is_a? Array
  		# the following would work if popular_night was a string
  		#super JSON.generate(arr)
  		days = 0
  		arr.each do |n|
  			days += 2 ** n 
  		end
  		super days
  	else
  		super arr
  	end
  end
  def popular_nights
  	days = super  
  	@@days.select.with_index{|day,index| days && days & 2 ** index > 0 }.join(', ')
  end

end
