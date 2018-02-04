require 'aws-sdk'

if ARGV.count != 3
  puts 'Put "bundle exec ruby url_sign.rb [key_pair_id] [url] [second]".'
  exit 1
end

key_pair_id = ARGV[0]
url         = ARGV[1]
second      = ARGV[2]

signer = Aws::CloudFront::UrlSigner.new(
  key_pair_id:      key_pair_id,
  private_key_path: 'tmp/private-key.pem'
)
signed_url = signer.signed_url(
  url,
  expires: Time.now.getutc + second.to_i
)

puts signed_url
