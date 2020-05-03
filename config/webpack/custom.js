const { environment } = require('@rails/webpacker')
const webpack = require("webpack");

environment.config.merge({
  resolve: {
    alias: {
      jquery: "jquery/src/jquery",
    }
  }
});

environment.plugins.prepend("Provide", new webpack.ProvidePlugin(
  {
    $: "jquery",
    jQuery: "jquery",
    jquery: "jquery",
    "window.jQuery": "jquery",
  }
));