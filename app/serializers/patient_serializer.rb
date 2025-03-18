class PatientSerializer < ActiveModel::Serializer
  embed :ids, embed_in_root: true
  attributes :id, :first_name, :middle_name, :last_name, :current_weight, :current_height, :age_in_words, :age_in_months, :email,
    :blood_pressure, :blood_oxygen, :heart_rate, :birth_date

  has_many :conditions

  def blood_pressure
   @object.current_blood_pressure.join("/")+" mmHg"
  end

  def blood_oxygen
    @object.current_blood_oxygen.to_s
  end

  def heart_rate
    "#{@object.current_heart_rate} bpm"
  end

end


