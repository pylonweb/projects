#Make new standard size to images
::Refinery::Images.configure do |config|
  config.user_image_sizes[:mini] = "20x20#c" 
end