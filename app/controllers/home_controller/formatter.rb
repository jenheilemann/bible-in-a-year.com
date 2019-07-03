class HomeController
  class Formatter
    attr_reader :passage

    def initialize(passage)
      @passage = passage
    end

    def format
      ChapterTitleFormatter.clean(
        DropCapFormatter.clean(
          RedundantVerseFormatter.clean(
            PoetryFormatter.clean(passage)
      )))
    end

    # The original formatting has the "subtitle" of a psalm all mixed in
    # with the text of the psalm, only separated by a <br>.
    # This breaks them apart and adds a second p.poetry tag in place
    # of the line break.
    class PoetryFormatter
      PATTERN = /(<p class="psasuper">(.+?))<br\/>/i
      REPLACEMENT = '\1 <p class="poetry">'

      def self.clean(passage)
        passage.gsub(PATTERN, REPLACEMENT)
      end
    end

    # Remove redundant verse numbers
    class RedundantVerseFormatter
      PATTERN = /<strong[\d\s\w='"]*?>[\d]+<\/strong>/i
      REPLACEMENT = ''

      def self.clean(passage)
        passage.gsub(PATTERN, REPLACEMENT)
      end
    end

    # Add drop-cap at non-poetry chapters
    class DropCapFormatter
      PATTERN = /(<h2 class="chapter">[\d]+<\/h2>\s*<p class="bodytext">)\s*([A-Z])/i
      REPLACEMENT = '\1<span class="drop-cap">\2</span>'

      def self.clean(passage)
        passage.gsub(PATTERN, REPLACEMENT)
      end
    end

    # Add 'Chapter' before chapter numbers
    # (not psalms since 'Chapter Psalm 23' doesn't make sense)
    class ChapterTitleFormatter
      PATTERN = /<h2 class="chapter">/i
      REPLACEMENT = '<h2 class="chapter">Chapter '

      def self.clean(passage)
        passage.gsub(PATTERN, REPLACEMENT)
      end
    end

  end
end
