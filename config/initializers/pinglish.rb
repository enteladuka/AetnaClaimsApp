Rails.application.config.middleware.tap do |middleware|
  middleware.use Pinglish, path: '/_ping' do |ping|
    app_name = Rails.application.class.parent_name.underscore
    ping.check(:app_name) { app_name }

    revision = Rails.root.join('REVISION').read.chomp
    ping.check(:version) { revision }

    branch = Rails.root.join('BRANCH').read.chomp
    ping.check(:branch) { branch }

    ping.check(:db) do
      ApplicationRecord.connection.select_value('SELECT 42') == 42
    end

    boottime = Time.current
    ping.check(:uptime) do
      (Time.current - boottime).to_i / 60
    end
  end
end
