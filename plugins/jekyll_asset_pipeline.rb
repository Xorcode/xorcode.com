require 'jekyll_asset_pipeline'

module JekyllAssetPipeline
  class LessConverter < JekyllAssetPipeline::Converter
    require 'less'

    def initialize(asset)
      @content = asset.content
      @type = File.extname(asset.filename).downcase
      @converted = self.convert
    end

    def self.filetype
      '.less'
    end

    def convert
      parser = Less::Parser.new :paths => [File.dirname(__FILE__) + '/../source/_assets/less']
      return parser.parse(@content).to_css
    end
  end

  class CssTagTemplate < JekyllAssetPipeline::Template
    def self.filetype
      '.css'
    end

    def self.priority
      -1
    end

    def html
      "<link href='/#{@path}/#{@filename}' rel='stylesheet' type='text/css' />"
    end
  end

  class JavaScriptTagTemplate < JekyllAssetPipeline::Template
    def self.filetype
      '.js'
    end

    def self.priority
      -1
    end

    def html
      "<script src='/#{@path}/#{@filename}' type='text/javascript'></script>"
    end
  end
end

class JavaScriptCompressor < JekyllAssetPipeline::Compressor
  require 'closure-compiler'

  def self.filetype
    '.js'
  end

  def compress
    return Closure::Compiler.new.compile(@content)
  end
end
