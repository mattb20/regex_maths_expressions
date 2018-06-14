class String
  def objectify
    if /frac{-?[0-9]+}{-?[0-9]+}/.match(self)
      args = self.scan(/-?[0-9]+/).map(&:to_i)
      div(args)
    end
  end
end
