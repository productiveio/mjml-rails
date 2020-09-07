require "mjml/parser"

module Mjml
  mattr_accessor :processing_options, :renderer
  @@processing_options = {}

  class Mjmltemplate
    def self.to_html(compiled_source)
      # Mjml::Parser.new(compiled_source).render.html_safe

      resp = AWS_LAMBDA_CLIENT.invoke({
        function_name: "mjml-prod-to-html",
        payload: { mjml: compiled_source }.to_json
      })

      JSON.parse(resp.payload.read)['html']
    end
  end
end
