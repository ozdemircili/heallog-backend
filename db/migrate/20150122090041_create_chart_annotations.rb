class CreateChartAnnotations < ActiveRecord::Migration
  def change
    create_table :chart_annotations do |t|
      t.string :type
      t.string :title
      t.text :body
      t.datetime :period_stats_at
      t.datetime :pariod_ends_at

      t.timestamps null: false
    end
  end
end
