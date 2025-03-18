class Emergency < ActiveRecord::Base
  include ActiveModel::Serialization
  belongs_to :patient
end
