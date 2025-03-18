namespace :assets do
  desc "Create Cloudfront distribution"
  task :create_distribution do
    AWS.config(
      access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
      secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY")
    )

    s3 = AWS::S3.new
    bucket_name = ENV.fetch("CDN_BUCKET_NAME"){
      Rails.application.class.parent_name.underscore + "_assets"
    }
    bucket = s3.buckets[bucket_name] # makes no request

    unless bucket.exists?
      bucket = s3.buckets.create(bucket_name, acl: :public_read)
    end

    cloudfront = AWS::CloudFront.new
    cloudfront.client.create_distribution(
      {
        distribution_config: {
          caller_reference: SecureRandom.hex,
          aliases: {
            quantity: 0
          },
          default_root_object: "",
          origins: {
            quantity: 1,
            items: [
              {
                id: "S3-" + bucket_name,
                domain_name: bucket_name + ".s3.amazonaws.com",
                s3_origin_config: {
                  origin_access_identity: ""
                }
              }
            ]
          },
          default_cache_behavior: {
            target_origin_id: "S3-" + bucket_name,
            forwarded_values: {
              query_string: false,
              cookies: {
                forward: 'none'                
              },
              headers: {
                quantity: 0,
              }
            },
            trusted_signers: {
              enabled: false,
              quantity: 0
            },
            viewer_protocol_policy: "allow-all",
            min_ttl: 86400000,
            allowed_methods: {
              quantity: 2,
              items: ["HEAD", "GET"]
            }
          },
          cache_behaviors: {
            quantity: 0
          },
          comment: "Distrubution for #{Rails.application.class.parent_name} through rake assets:create_distribution",
          logging: {
            enabled: false,
            include_cookies: false,
            bucket: 'nologging',
            prefix: 'stupidverboseapi'
          },
          price_class: "PriceClass_All",
          enabled: true
        }
      }
    )
  end

  desc "Deploy precompiled assets to S3"
  task :deploy  => ['assets:clobber', 'assets:precompile'] do
    AWS.config(
      access_key_id: ENV.fetch("AWS_ACCESS_KEY_ID"),
      secret_access_key: ENV.fetch("AWS_SECRET_ACCESS_KEY")
    )

    s3 = AWS::S3.new
    bucket_name = ENV.fetch("CDN_BUCKET_NAME"){
      Rails.application.class.parent_name.underscore + "_assets"
    }
    bucket = s3.buckets[bucket_name] # makes no request
    
    Dir.glob("#{Rails.root}/public/assets/**/*") do |file|
      begin
      next if File.directory?(file)
      key = file.gsub("#{Rails.root}/public/", "")
      content_type = MIME::Types.type_for(file).first.content_type
      if(content_type == "application/gzip")
        content_type = MIME::Types.type_for(file[0..-4]).first.content_type
        bucket.objects[key[0..-4]].write(file: file, acl: :public_read, content_type: content_type, content_encoding: "gzip")
      elsif not File.exists?(file+".gz")
        bucket.objects[key].write(file: file, acl: :public_read, content_type: content_type)
      end
      rescue
        puts "#{file} - Not transfered"
      end
    end
  end
end
