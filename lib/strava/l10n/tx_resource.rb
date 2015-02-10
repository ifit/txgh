module Strava
  module L10n
    class TxResource
      def initialize(project_slug, resource_slug, type, source_lang, source_file,
          lang_map, translation_file)
        @project_slug = project_slug
        @resource_slug = resource_slug
        @type = type
        @source_lang = source_lang
        @source_file = source_file
        @lang_map = {}
        if lang_map.length
          @lang_map = Strava::L10n::TxResource.parse_lang_map(lang_map)
        end
        @translation_file = translation_file
      end

      def project_slug
        @project_slug
      end

      def resource_slug
        @resource_slug
      end

      def type
        @type
      end

      def source_lang
        @source_lang
      end

      def source_file
        @source_file
      end

      def lang_map
        @lang_map
      end

      def self.parse_lang_map(lang_map)
        lang_map.split(',').inject({}) do |result, m|
          key_value = m.split(':', 2)
          result[key_value[0].strip] = key_value[1].strip
        end
      end

      def translation_path(language)
        path = String.new(@translation_file)
        path['<lang>'] = language
        path
      end

    end
  end
end
