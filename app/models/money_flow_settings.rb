# RailsSettings Model
class MoneyFlowSettings < RailsSettings::Base
  source Rails.root.join("config/app.yml")
  namespace Rails.env
end
