# set the env variables for the mbta endpoints

config = YAML.load_file("#{Rails.root}/config/mbta_endpoints.yml")[Rails.env]

SCHEDULE_CSV_URI = config.fetch('schedule_csv_uri').freeze
