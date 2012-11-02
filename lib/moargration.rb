module Moargration
  class Exception < StandardError; end

  extend self

  def init
    return unless ignore = ENV["MOARGRATION_IGNORE"]
    spec = parse(ignore)
    hack_active_record(spec)
  end

  def columns_to_ignore
    @@columns_to_ignore
  end

  def parse(text)
    text.strip.split(" ").inject({}) do |parsed, definition|
      table, fields = definition.split(":", 2)
      parsed[table] = fields.split(",") if fields
      parsed
    end
  end

  def hack_active_record(spec)
    @@columns_to_ignore = spec

    ActiveRecord::Base.class_eval do
      def self.columns
        super.reject do |column|
          (Moargration.columns_to_ignore[table_name] || []).include?(column.name)
        end
      end
    end
  end
end
