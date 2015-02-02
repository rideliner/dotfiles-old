class YAMLDotfilePath
  def initialize path
    @path = path
  end

  def to_path
    to_s
  end

  def to_s
    File.expand_path File.join(File.dirname(__dir__), @path)
  end
end
