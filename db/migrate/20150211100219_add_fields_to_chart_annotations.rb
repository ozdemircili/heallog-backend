class AddFieldsToChartAnnotations < ActiveRecord::Migration
  def change
    add_column :chart_annotations, :status, :string
    add_reference :chart_annotations, :doctor, index: true
    add_foreign_key :chart_annotations, :doctors
  end
end
