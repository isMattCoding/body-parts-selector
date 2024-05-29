class Body < ApplicationRecord
  validate :parts_must_be_valid

  POSSIBLE_PARTS = %w(
    back-knee-right back-shoulder-left back-elbow-left back-head back-upper-arm-left back-forearm-left
    back-shoulder-right back-elbow-right back-upper-arm-right back-forearm-right back-foot-right back-calf-right
    back-knee-left back-buttock-left back-foot-left back-calf-left back-thigh-left back-buttock-right
    back-thigh-right back-torso back-neck back-hand-left back-hand-right front-knee-right front-shoulder-left
    front-elbow-left front-head front-upper-arm-left front-lower-arm-left front-shoulder-right front-elbow-right
    front-upper-arm-right front-lower-arm-right front-foot-right front-calf-right front-knee-left front-hip-left
    front-foot-left front-calf-left front-thigh-left front-hip-right front-thigh-right front-torso front-neck
    front-hand-left front-hand-right
  )

  def parse_parts(parts_to_parse)
    parts_to_parse.split(", ").reject { |part| part.empty? || !POSSIBLE_PARTS.include?(part) }.join(", ")
  end

  private

  def parts_must_be_valid
    unless parts.is_a?(String) && parts.match(/\A[^0-9]*\z/)
      errors.add(:parts, "must be a string and not contain numbers")
    end

    parsed_parts = parse_parts(parts)
    if parsed_parts.empty?
      errors.add(:parts, "contains invalid parts")
    else
      self.parts = parsed_parts
    end
  end
end
