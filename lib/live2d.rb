require "live2d/version"

module Jekyll
  class RenderLive2D < Liquid::Tag
    def initialize(tag_name, text, tokens)
      @config = Jekyll.configuration({})['live2d']
      if text.empty?
        if @config
          @width = @config['style']['width']
          @height = @config['style']['height']
          @position = @config['style']['position']
          @top = @config['style']['top']
          @bottom = @config['style']['bottom']
          @left = @config['style']['left']
          @right = @config['style']['right']
        else
          @width = '150'
          @height = '150'
          @position = 'fixed'
          @top = '100'
          @bottom = '0'
          @left = '100'
          @right = '0'
        end
      else
        @width = text.split(",").first.strip
        @height = text.split(",").last.strip
      end
      super
    end

    def render(context)
      <<~HEREDOC
        <canvas
        id="glcanvas"
        style="
        width: #{@width}px;
        height: #{@height}px;
        position: fixed;
        top: #{@top};
        bottom: #{@bottom};
        left: #{@left};
        right: #{@right};
        "
        >
        </canvas>
        <script type="text/javascript" src="/assets/javascripts/live2d.min.js"></script>
        <script type="text/javascript" src="/assets/javascripts/Simple.js"></script>
        <script type="text/javascript">
          Simple();
        </script>
      HEREDOC
    end
  end
end

Liquid::Template.register_tag('render_live2d', Jekyll::RenderLive2D)

