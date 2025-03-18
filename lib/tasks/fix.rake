namespace :fix do
  desc "Seed data for development environment"
  task :update_metrics  => :environment do
    patient = Patient.find(1)
    res = Humanapi::Human.last_blood_pressure("1mEkWCBqjD4XfKOw4l32hWy30sQ=gkkh10qe17219423e27b2336ca423f3131efb9bb91ed1cfb456cbf4273f8fbcb6ffa85d23d48b974919bc7f57c4b6ea0931caec055b1169371808daf875e9966b305b19c7b0b3148f0a788bd50db601f6e98f90646668af328a8dfb8486846f902bf58e206d9f2ce68c0413aab34340a9ffd3cfb")
    m = JSON.parse(res.body)
    patient.metrics.create({name: :blood_pressure_systolic, numeric_value: m["systolic"],
                            unit: m["unit"], taken_at: m["timestamp"],
                            hidentifier: "#{m["id"]}_systolic", source: m["source"]
    })
    patient.metrics.create({name: :blood_pressure_diastolic, numeric_value: m["diastolic"],
                            unit: m["unit"], taken_at: m["timestamp"],
                            hidentifier: "#{m["id"]}_diastolic", source: m["source"]
    })
    patient.metrics.create({name: :heart_rate, numeric_value: m["heartRate"],
                            unit: "bps", taken_at: m["timestamp"],
                            hidentifier: "#{m["id"]}_heart_rate", source: m["source"]
    })

    res = Humanapi::Human.last_blood_oxygen("1mEkWCBqjD4XfKOw4l32hWy30sQ=gkkh10qe17219423e27b2336ca423f3131efb9bb91ed1cfb456cbf4273f8fbcb6ffa85d23d48b974919bc7f57c4b6ea0931caec055b1169371808daf875e9966b305b19c7b0b3148f0a788bd50db601f6e98f90646668af328a8dfb8486846f902bf58e206d9f2ce68c0413aab34340a9ffd3cfb")
    m = JSON.parse(res.body)
    patient.metrics.create({name: :blood_oxygen, numeric_value: m["value"],
                            unit: m["unit"], taken_at: m["timestamp"],
                            hidentifier: m["id"], source: m["source"]
    })

  end
end

