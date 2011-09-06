module AssetDigestHelper
  # asset_digest("logo.png")       #=> "logo-bd9ad5a560b5a3a7be0808c5cd76a798.png"
  # asset_digest("application.js") #=> "application-b01eded31fd08af304f7da4bd2d2c505.js"
  # asset_digest("style.css")      #=> "style-8af74128f904600e41a6e39241464e03.css"
  def asset_digest(source)
    asset_paths.digest_for(source)
  end
end

Sprockets::Helpers::RailsHelper.send(:include, AssetDigestHelper)
