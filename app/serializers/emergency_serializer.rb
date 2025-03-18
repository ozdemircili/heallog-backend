class EmergencySerializer < ActiveModel::Serializer
  embed :ids, embed_in_root: true
  attributes :id, :description
  has_one :patient
end

