class DoctorSerializer < ActiveModel::Serializer
  attributes :id, :full_name, :title, :specialty
end
