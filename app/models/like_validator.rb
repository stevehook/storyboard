class LikeValidator < ActiveModel::EachValidator
  def initialize(options)
    @in = options[:in].collect { |sym| sym.to_s }
    super
  end
  
  def validate_each(record, attribute, value)
    unless @in.any? { |s| s == value.to_s }
      record.errors.add attribute, "is not on the list of allowed values"
    end
  end
end
