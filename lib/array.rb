class Array
  def digits_to_integers
    self.each_with_index do |arg, i|
      if /[0-9]+/.match(arg)
        self[i] = arg.to_i
      else
        self[i] = arg
      end
    end
    self
  end
end
