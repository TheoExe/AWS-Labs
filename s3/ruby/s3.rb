require 'aws-sdk-s3' # AWS SDK for S3 operations
require 'pry' #Interactive shell debugging tool
require 'securerandom' # Generates secure random strings

# create bucket environment variable & specify region
bucket_name = ENV['BUCKET_NAME']
# region = 'us-west-1' # specifying us-east-1 will raise errors

# initialize AWS S3 client instance
client = Aws::S3::Client.new

# s3 bucket creation
resp = client.create_bucket({
  bucket: bucket_name 
  # create_bucket_configuration: {
  #   location_constraint: region 
  # }
})  
# binding.pry # enter interactive shell at this point in debugging mode

# number of files to create = random number
file_number= 1+ rand(6)
puts "the number of files is: #{file_number}"

# loop to create and upload each file
file_number.times.each do |i|
  puts "index: #{i}"
  filename = "file_#{i}.txt" # append each file name with its number
  output_path = "/tmp/#{filename}" #local output path for the file

  # write a unique UUID to each file
  File.open(output_path, "w") do |f|
    f.write (SecureRandom.uuid)
  end

  # open and read the file in binary mode
  File.open(output_path, "rb") do |f|
    client.put_object( # then upload it to S3
    bucket: bucket_name, # bucket to upload to
    key: filename, # key (file name) for the object in bucket
    body: f # file content
  )
  end
end

