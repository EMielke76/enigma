module Keyable

  def random_key
    rand(99999).to_s.rjust(5, "0")
  end
end
