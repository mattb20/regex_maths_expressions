class String
  def objectify
    if /frac{-?[0-9]+}{-?[0-9]+}/.match(self)
      args = self.scan(/-?[0-9]+/).map(&:to_i)
      div(args)
    elsif /frac{-?[0-9]*[a-zA-Z]+}{-?[0-9]*[a-zA-Z]+}/.match(self)
      args = self.scan(/-?[0-9]*[a-zA-Z]+/) - ['frac']
      div(args)

    end
  end
end
