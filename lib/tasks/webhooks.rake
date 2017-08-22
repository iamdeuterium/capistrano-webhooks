namespace :webhooks do
  namespace :deploy do
    task :setup do
      webhooks = fetch(:webhooks)
      webhooks = {} unless webhooks.is_a?(Hash)

      default_options = { method: :post, payload: {} }
      global_options  = {}
      webhook_index   = 0

      webhooks.each do |url, options|
        options         = default_options.merge options
        global_options  = options.select { |k, _v| default_options.key?(k) }

        %i[before after].each do |hook|
          case options[hook]
          when Array
            options[hook] = Hash[options[hook].each_slice(1).to_a]
          when String
            options[hook] = Hash[options[hook], nil]
          when nil
            options[hook] = {}
          end

          options[hook].each do |webhook, opts|
            webhook_index += 1

            opts ||= {}
            opts = global_options.merge opts

            task_name = "webhooks:task_#{webhook_index}"
            Rake::Task.define_task task_name do
              begin
                Capistrano::Webhooks::Client.new(url, opts).run
              rescue => e
                warn "Webhook to '#{url}' failed"
                warn "Error: #{e.inspect}"
              end
            end

            send hook, webhook, task_name
          end
        end
      end
    end
  end
end

stages.each do |stage|
  after stage, 'webhooks:deploy:setup'
end
