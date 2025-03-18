base_path = if Rails.env.production?
              "/home/deploy/"
            else
              "#{Rails.root}/../"
            end

EmberCLI.configure do |c|
  c.app :doctors_frontend, path: "#{base_path}/doctors-frontend",  build_timeout: 100
  c.app :patients_frontend, path: "#{base_path}/patients-frontend",  build_timeout: 100
end
