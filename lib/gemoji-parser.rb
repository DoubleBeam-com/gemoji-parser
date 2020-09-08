require 'gemoji-parser/version'
require 'gemoji'

module EmojiParser
  extend self

  # Emoticons
  # ---------
  # The base emoticons set (below) is generated with "noseless" variants, ie:  :-) and :)
  # The generated `EmojiParser.emoticons` hash is formatted as:
  # ---
  # > {
  # >   ":-)" => :blush,
  # >   ":)" => :blush,
  # >   ":-D" => :smile,
  # >   ":D" => :smile,
  # > }
  #
  # This base set is selected for commonality and high degrees of author intention.
  # If you want more/different emoticons:
  # - Please DO customize the `EmojiParser.emoticons` hash in your app runtime.
  # - Please DO NOT customize this source code and issue a pull request.
  #
  # To add an emoticon:
  # ---
  # > EmojiParser.emoticons[':-$'] = :grimacing
  # > EmojiParser.rehash!
  #
  # To remove an emoticon:
  # ---
  # > EmojiParser.emoticons.delete(':-$')
  # > EmojiParser.rehash!
  #
  # NOTE: call `rehash!` after making changes to Emoji/emoticon sets.
  # Rehashing updates the parser's regex cache with the latest icons.
  #
  def emoticons
    return @emoticons if defined? @emoticons
    @emoticons = {}
    emoticons = {
      angry: ">:-(",
      blush: ":-)",
      cry: ":'(",
      confused: [":-\\", ":-/"],
      disappointed: ":-(",
      kiss: ":-*",
      neutral_face: ":-|",
      monkey_face: ":o)",
      open_mouth: ":-o",
      smiley: "=-)",
      smile: ":-D",
      stuck_out_tongue: [":-p", ":-P", ":-b"],
      stuck_out_tongue_winking_eye: [";-p", ";-P", ";-b"],
      wink: ";-)"
    }

    # Parse all named patterns into a flat hash table,
    # where pattern is the key and its token is the value.
    # all patterns are duplicated with the "noseless" variants, ie:  :-) and :)
    emoticons.each_pair do |name, patterns|
      patterns = [patterns] unless patterns.is_a?(Array)
      patterns.each do |pattern|
        @emoticons[pattern] = name
        @emoticons[pattern.sub(/(?<=:|;|=)-/, '')] = name
      end
    end

    @emoticons
  end

  attr_writer :emoticons

  def new_emoji_set
    new_emoji_set = [
      ["\u{1F929}", ":star-struck:", "star-struck"],
      ["\u{1F928}", ":face-with-raised-eyebrow:", "face-with-raised-eyebrow"],
      ["\u{1F92F}", ":exploding-head:", "exploding-head"],
      ["\u{1F92A}", ":zany-face:", "zany-face"],
      ["\u{1F92C}", ":face-with-symbols-on-mouth:", "face-with-symbols-on-mouth"],
      ["\u{1F92E}", ":face-vomiting:", "face-vomiting"],
      ["\u{1F92B}", ":shushing-face:", "shushing-face"],
      ["\u{1F92D}", ":face-with-hand-over-mouth:", "face-with-hand-over-mouth"],
      ["\u{1F9D0}", ":face-with-monocle:", "face-with-monocle"],
      ["\u{1F9D2}", ":child:", "child"],
      ["\u{1F9D1}", ":adult:", "adult"],
      ["\u{1F9D3}", ":older-adult:", "older-adult"],
      ["\u{1F9D5}", ":woman-with-headscarf:", "woman-with-headscarf"],
      ["\u{1F9D4}", ":bearded-person:", "bearded-person"],
      ["\u{1F931}", ":breast-feeding:", "breast-feeding"],
      ["\u{1F9D9}", ":mage:", "mage"],
      ["\u{1F9DA}", ":fairy:", "fairy"],
      ["\u{1F9DB}", ":vampire:", "vampire"],
      ["\u{1F9DC}", ":merperson:", "merperson"],
      ["\u{1F9DD}", ":elf:", "elf"],
      ["\u{1F9DE}", ":genie:", "genie"],
      ["\u{1F9DF}", ":zombie:", "zombie"],
      ["\u{1F9D6}", ":person-in-steamy-room:", "person-in-steamy-room"],
      ["\u{1F9D7}", ":person-climbing:", "person-climbing"],
      ["\u{1F9D8}", ":person-in-lotus-position:", "person-in-lotus-position"],
      ["\u{1F91F}", ":love-you-gesture:", "love-you-gesture"],
      ["\u{1F932}", ":palms-up-together:", "palms-up-together"],
      ["\u{1F9E0}", ":brain:", "brain"],
      ["\u{1F9E1}", ":orange-heart:", "orange-heart"],
      ["\u{1F9E3}", ":scarf:", "scarf"],
      ["\u{1F9E4}", ":gloves:", "gloves"],
      ["\u{1F9E5}", ":coat:", "coat"],
      ["\u{1F9E6}", ":socks:", "socks"],
      ["\u{1F9E2}", ":billed-cap:", "billed-cap"],
      ["\u{1F993}", ":zebra:", "zebra"],
      ["\u{1F992}", ":giraffe:", "giraffe"],
      ["\u{1F994}", ":hedgehog:", "hedgehog"],
      ["\u{1F995}", ":sauropod:", "sauropod"],
      ["\u{1F996}", ":T-Rex:", "T-Rex"],
      ["\u{1F997}", ":cricket:", "cricket"],
      ["\u{1F965}", ":coconut:", "coconut"],
      ["\u{1F966}", ":broccoli:", "broccoli"],
      ["\u{1F968}", ":pretzel:", "pretzel"],
      ["\u{1F969}", ":cut-of-meat:", "cut-of-meat"],
      ["\u{1F96A}", ":sandwich:", "sandwich"],
      ["\u{1F963}", ":bowl-with-spoon:", "bowl-with-spoon"],
      ["\u{1F96B}", ":canned-food:", "canned-food"],
      ["\u{1F95F}", ":dumpling:", "dumpling"],
      ["\u{1F960}", ":fortune-cookie:", "fortune-cookie"],
      ["\u{1F961}", ":takeout-box:", "takeout-box"],
      ["\u{1F967}", ":pie:", "pie"],
      ["\u{1F964}", ":cup-with-straw:", "cup-with-straw"],
      ["\u{1F962}", ":chopsticks:", "chopsticks"],
      ["\u{1F6F8}", ":flying-saucer:", "flying-saucer"],
      ["\u{1F6F7}", ":sled:", "sled"],
      ["\u{1F94C}", ":curling-stone:", "curling-stone"]
    ]

    new_emoji_set.each do |set|
      Emoji.create(set[2]) do |char|
        char.add_alias set[1]
        char.add_unicode_alias set[0]
      end
    end
  end

  # Rehashes all cached regular expressions.
  # IMPORTANT: call this once after changing emoji characters or emoticon patterns.
  def rehash!
    unicode_regex(rehash: true)
    token_regex(rehash: true)
    emoticon_regex(rehash: true)
  end

  U_FE0F = '\\u{fe0f}'

  # Creates an optimized regular expression for matching unicode symbols.
  # - Options: rehash:boolean
  def unicode_regex(opts={})
    return @unicode_regex if defined?(@unicode_regex) && !opts[:rehash]

    scores_file = File.expand_path('../../db/scores.json', __FILE__)
    scores = File.open(scores_file, 'r:UTF-8') { |data| JSON.parse(data.read) }
    @_new_emoji_set ||= new_emoji_set
    pattern = []

    Emoji.all.each do |emoji|
      score_id = nil
      u = emoji.unicode_aliases.map do |char|
        score_id = char if scores[char]
        char.codepoints.map { |c| '\u{%s}' % c.to_s(16).rjust(4, '0') }.join('')
      end

      if u.any?
        pattern << {
          :pattern => unicode_matcher(u),
          :score => score_id ? scores[score_id].to_i : 0
        }
      end
    end

    pattern.sort! { |a, b| b[:score] - a[:score] }
    pattern.map! { |p| p[:pattern] }

    @unicode_pattern = "(?:#{ pattern.join('|') })#{ U_FE0F }?"
    @unicode_regex = Regexp.new("(#{@unicode_pattern})")
  end

  # Creates a regular expression for matching token symbols.
  # - Options: rehash:boolean (currently unused)
  def token_regex(opts={})
    return @token_regex if defined?(@token_regex)
    @token_pattern = ':([\w+-]+):'
    @token_regex = Regexp.new(@token_pattern)
  end

  # Defines lookaround patterns for matching before and after emoticons.
  def emoticon_lookaround(opts={})
    return @emoticon_lookaround if defined?(@emoticon_lookaround) && !opts[:reset]
    @emoticon_lookaround = {
      behind: '^|\\s',
      ahead: '$|\\s'
    }
  end

  attr_writer :emoticon_lookaround

  # Creates an optimized regular expression for matching emoticon symbols.
  # - Options: rehash:boolean
  def emoticon_regex(opts={})
    return @emoticon_regex if defined?(@emoticon_regex) && !opts[:rehash]
    pattern = {}

    emoticons.keys.each do |icon|
      compact_icon = icon.gsub('-', '')

      # Check to see if this icon has a compact version, ex:  :-)  versus  :)
      # One expression will match as many nose/noseless variants as possible.
      if compact_icon != icon && emoticons[compact_icon]
        compact_regex = Regexp.escape(icon).gsub('-', '-?')

        # Keep this expression if it hasn't been defined yet,
        # or if it's longer than a previously defined pattern.
        if !pattern[compact_icon] || pattern[compact_icon].length < compact_regex.length
          pattern[compact_icon] = compact_regex
        end
      elsif !pattern[icon]
        pattern[icon] = Regexp.escape(icon)
      end
    end

    lookaround = emoticon_lookaround
    @emoticon_pattern = "(?<=#{ lookaround[:behind] })(?:#{ pattern.values.join('|') })(?=#{ lookaround[:ahead] })"
    @emoticon_regex = Regexp.new("(#{@emoticon_pattern})")
  end

  # Generates a macro regex for matching one or more symbol sets.
  # Regex uses various formats, based on symbol sets. Yields match as $1 OR $2
  # T/EU:        (token-$1)|(emoticon-unicode-$2)
  # T/E or T/U:  (token-$1)|(emoticon/unicode-$2)
  # EU:          (emoticon/unicode-$1)
  # - Options: unicode:boolean, tokens:boolean, emoticons:boolean
  def macro_regex(opts={})
    opts = { unicode: true, tokens: true, emoticons: true }.merge(opts)
    unicode_regex if opts[:unicode]
    token_regex if opts[:tokens]
    emoticon_regex if opts[:emoticons]
    pattern = []

    if opts[:emoticons] && opts[:unicode]
      pattern << "(?:#{ @emoticon_pattern })"
      pattern << @unicode_pattern
    else
      pattern << @emoticon_pattern if opts[:emoticons]
      pattern << @unicode_pattern if opts[:unicode]
    end

    pattern = pattern.any? ? "(#{ pattern.join('|') })" : ""

    if opts[:tokens]
      if pattern.empty?
        pattern = @token_pattern
      else
        pattern = "(?:#{ @token_pattern })|#{ pattern }"
      end
    end

    Regexp.new(pattern)
  end

  # Parses all unicode symbols within a string.
  # - Block: performs all symbol transformations.
  def parse_unicode(text)
    text.gsub(unicode_regex) do |match|
      emoji = Emoji.find_by_unicode($1)
      block_given? && emoji ? yield(emoji) : match
    end
  end

  # Parses all token symbols within a string.
  # - Block: performs all symbol transformations.
  def parse_tokens(text)
    text.gsub(token_regex) do |match|
      emoji = Emoji.find_by_alias($1)
      block_given? && emoji ? yield(emoji) : match
    end
  end

  # Parses all emoticon symbols within a string.
  # - Block: performs all symbol transformations.
  def parse_emoticons(text)
    text.gsub(emoticon_regex) do |match|
      if emoticons.has_key?($1)
        emoji = Emoji.find_by_alias(emoticons[$1].to_s)
        block_given? && emoji ? yield(emoji) : match
      else
        match
      end
    end
  end

  # Parses all emoji unicode, tokens, and emoticons within a string.
  # - Block: performs all symbol transformations.
  # - Options: unicode:boolean, tokens:boolean, emoticons:boolean
  def parse(text, opts={})
    opts = { unicode: true, tokens: true, emoticons: true }.merge(opts)
    if opts.one?
      return parse_unicode(text)   { |e| yield e } if opts[:unicode]
      return parse_tokens(text)    { |e| yield e } if opts[:tokens]
      return parse_emoticons(text) { |e| yield e } if opts[:emoticons]
    end
    text.gsub(macro_regex(opts)) do |match|
      a = defined?($1) ? $1 : nil
      b = defined?($2) ? $2 : nil
      emoji = find(a || b)
      block_given? && emoji ? yield(emoji) : match
    end
  end

  # Transforms all unicode emoji into token strings.
  def self.tokenize(text)
    text = text.gsub(color_emoji_regex, '')
    parse_unicode(text) { |emoji| ":#{emoji.name}:" }
  end

  # Transforms all token strings into unicode emoji.
  def detokenize(text)
    parse_tokens(text) { |emoji| emoji.raw }
  end

  # Finds an Emoji::Character instance for an unknown symbol type.
  # - symbol: an <Emoji::Character>, or a unicode/token/emoticon string.
  def find(symbol)
    return symbol if (symbol.is_a?(Emoji::Character))
    symbol = emoticons[symbol].to_s if emoticons.has_key?(symbol)
    Emoji.find_by_alias(symbol) || Emoji.find_by_unicode(symbol) || nil
  end

  # Gets the image file reference for a symbol; optionally with a custom path.
  # - symbol: an <Emoji::Character>, or a unicode/token/emoticon string.
  # - path: a file path to sub into symbol's filename.
  def image_path(symbol, path=nil)
    emoji = find(symbol)
    return nil unless emoji
    return emoji.image_filename unless path
    "#{ path.sub(/\/$/, '') }/#{ emoji.image_filename.split('/').pop }"
  end

  private

  def self.color_emoji_regex
    reg = /((?:\u{1f3fb}|\u{1f3fc}|\u{1f3fd}|\u{1f3fe}|\u{1f3ff}?))/
  end
  
  U_FE0F_SUFFIX = Regexp.new(Regexp.escape(U_FE0F)+'$')

  # Compiles an optimized unicode pattern for fast matching.
  def unicode_matcher(patterns)
    # Strip off all trailing U_FE0F characters:
    patterns.map! { |p| p.gsub(U_FE0F_SUFFIX, '') }.uniq!

    # Return a single pattern directly:
    return patterns.first if patterns.length == 1

    # Sort patterns, longest to shortest:
    patterns.sort! { |a, b| b.length - a.length }

    # Use the longest pattern with U_FE0F optionalized, if possible:
    if patterns.all? { |p| p.gsub(U_FE0F, '') == patterns.last }
      patterns.first.gsub(U_FE0F, U_FE0F+'?')
    else
      patterns.join('|')
    end
  end
end
