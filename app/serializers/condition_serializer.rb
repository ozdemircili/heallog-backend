class ConditionSerializer < ActiveModel::Serializer
  embed :ids, embed_in_root: true
  attributes :id, :name, :started_at, :ended_at, :cronic, :current

end



