class String
  def objectify
    if /frac{-?[0-9]+}{-?[0-9]+}/.match(self)
      args = self.scan(/-?[0-9]+/).map(&:to_i)
      div(args)
    elsif /frac{-?[0-9]*[a-zA-Z]*}{-?[0-9]*[a-zA-Z]*}/.match(self)
      string_args = (self.scan(/-?[0-9]*[a-zA-Z]*/) - ['frac']).reject do |args_with_blank|
        args_with_blank.empty?
      end
      string_args.each_with_index do |arg, i|
        if /[0-9]+/.match(arg)
          string_args[i] = arg.to_i
        else
          string_args[i] = arg
        end
      end
      div(string_args)

    end
  end
end
