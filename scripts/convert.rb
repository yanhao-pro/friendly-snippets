TMPL = <<-TXT
    "%s": {
        "prefix": "%s",
        "body": "%s",
        "description": "Snippet for %s"
    },
TXT

def create(prefix, desc, lines)
  if lines[0] =~ /^(\s+)/
    indent = $1
  end
  ss = []
  lines.each do |sl|
    sl = sl.gsub(/^#{indent}/, "")
    sl = sl.gsub(/"/, "\"")
    ss << sl.inspect[1..-2]
  end
  puts TMPL % [desc, prefix, ss.join.gsub(/(\\n)\1+$/, ""), desc]
end

prefix = ""
desc = ""
lines = []
File.open('s.txt').each do |ln|
  if ln =~ /snippet (\w+) "(.+)"/
    if lines.size > 0
      create(prefix, desc, lines)
    end

    lines = []
    prefix = $1
    desc = $2
    next
  end

  lines << ln
end

if lines.size > 0
  create(prefix, desc, lines)
end
