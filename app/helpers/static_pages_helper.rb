module StaticPagesHelper
  def gradyear_short(gradyear)
    gradyear.nil? ? "" : "'#{gradyear.inspect[2..3]}"
  end
end
