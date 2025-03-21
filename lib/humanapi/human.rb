module Humanapi
  class Human < Nestful::Resource
    endpoint 'https://api.humanapi.co'
    path '/v1/human'


    # Profile

    def self.profile(token)
      get('profile', :access_token => token)
    end

    def self.summary(token)
      get('', :access_token => token)
    end

    # Activity

    def self.all_activities(token)
      get("activities", :access_token => token)
    end

    def self.activity(id, token)
      get("activities/#{id}", :access_token => token)
    end

    def self.daily_activity(date, token)
      get("activity/daily/#{date.strftime('%F')}", :access_token => token)
    end

    def self.series_activity(date, token)
      get("activity/series/#{date.strftime('%F')}", :access_token => token)
    end

    # Blood Glucose

    def self.blood_glucose(id, token)
      get("blood_glucose/#{id}", :access_token => token)
    end

    def self.all_blood_glucose(token)
      get('blood_glucose/readings', :access_token => token)
    end

    def self.daily_blood_glucose(date, token)
      get("blood_glucose/daily/#{date.strftime('%F')}", :access_token => token)
    end

    # Blood presure
    def self.last_blood_pressure(token)
      get("blood_pressure", :access_token => token)
    end

    def self.blood_pressure(id, token)
      get("blood_pressure/readings/#{id}", :access_token => token)
    end

    def self.all_blood_pressures(token)
      get('blood_pressure/readings', :access_token => token)
    end

    def self.daily_blood_pressure(date, token)
      get("blood_pressure/daily/#{date.strftime('%F')}", :access_token => token)
    end

    # Blood oxygen
    def self.last_blood_oxygen(token)
      get("blood_oxygen", :access_token => token)
    end

    def self.blood_oxygen(id, token)
      get("blood_oxygen/readings/#{id}", :access_token => token)
    end

    def self.all_blood_oxygen(token)
      get('blood_oxygen/readings', :access_token => token)
    end


    # BMI

    def self.bmi(id, token)
      get("bmi/#{id}", :access_token => token)
    end

    def self.all_bmis(token)
      get('bmi/readings', :access_token => token)
    end

    def self.daily_bmi(date, token)
      get("bmi/readings/daily/#{date.strftime('%F')}", :access_token => token)
    end

    # Body fat

    def self.body_fat(id, token)
      get("body_fat/#{id}", :access_token => token)
    end

    def self.all_body_fats(token)
      get('body_fat/readings', :access_token => token)
    end

    def self.daily_body_fat(date, token)
      get("body_fat/daily/#{date.strftime('%F')}", :access_token => token)
    end

    # Genetics

    def self.genetic_traits(token)
      get('genetic/traits', :access_token => token)
    end

    # Heart rate

    def self.heart_rate(id, token)
      get("heart_rate/#{id}", :access_token => token)
    end

    def self.all_heart_rates(token)
      get('heart_rate/readings', :access_token => token)
    end

    def self.daily_heart_rate(date, token)
      get("heart_rate/daily/#{date.strftime('%F')}", :access_token => token)
    end

    # Height

    def self.height(id, token)
      get("height/#{id}", :access_token => token)
    end

    def self.all_heights(token)
      get('height/readings', :access_token => token)
    end

    def self.daily_height(date, token)
      get("height/daily/#{date.strftime('%F')}", :access_token => token)
    end

    # Location

    def self.all_locations(token)
      get('location/readings', :access_token => token)
    end

    def self.daily_location(date, token)
      get("location/daily/#{date.strftime('%F')}", :access_token => token)
    end

    # Sleep

    def self.sleep(id, token)
      get("sleep/#{id}", :access_token => token)
    end

    def self.all_sleep(token)
      get('sleep/readings', :access_token => token)
    end

    def self.daily_sleep(date, token)
      get("sleep/daily/#{date.strftime('%F')}", :access_token => token)
    end

    # Weight

    def self.weight(id, token)
      get("weight/#{id}", :access_token => token)
    end

    def self.all_weight(token)
      get('weight/readings', :access_token => token)
    end

    def self.daily_weight(date, token)
      get("weight/daily/#{date.strftime('%F')}", :access_token => token)
    end
  end
end
