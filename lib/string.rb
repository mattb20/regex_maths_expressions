class String
  def objectify
    if /frac{-?[0-9]+}{-?[0-9]+}/.match(self)
      args = self.scan(/-?[0-9]+/).map(&:to_i)
      div(args)
    elsif /-?[0-9a-zA-Z]\([0-9a-zA-Z]\+\\frac{[0-9a-zA-Z]}{[0-9a-zA-Z]}\)[0-9a-zA-Z]/.match(self)
      nested_multiplication = self.split('(')
      division = (nested_multiplication[1].scan(/-?[0-9a-zA-Z]*[0-9a-zA-Z]*/) - ['frac']).reject do |args_with_blank|
        args_with_blank.empty?
      end
      mtp(nested_multiplication[0].to_i, add(nested_multiplication[1].split('+').chars.delete("frac"),div(division)), nested_multiplication[1].chars[-1])
    elsif /frac{-?[0-9a-zA-Z]*[0-9a-zA-Z]*}{-?[0-9a-zA-Z]*[0-9a-zA-Z]*}/.match(self)
      string_args = (self.scan(/-?[0-9a-zA-Z]*[0-9a-zA-Z]*/) - ['frac']).reject do |args_with_blank|
        args_with_blank.empty?
      end
      div(string_args.strings_to_integers)
    elsif /frac{-?[0-9a-zA-Z]*\+[0-9a-zA-Z]*}{-?[0-9a-zA-Z]+}/.match(self)
      numerator_addition = self.scan(/-?[0-9a-zA-Z]\+[0-9a-zA-Z]/)[0].split(/\+/).strings_to_integers
      denominator_multiplication = (self.scan(/{-?[0-9a-zA-Z]*}/) - ["{","}"]).join('')
      div(add(numerator_addition), denominator_multiplication.decompose_multiplication)
    elsif /frac{-?[0-9]*[a-zA-Z]*}{-?[0-9a-zA-Z]*\+[0-9a-zA-Z]*}/.match(self)
      numerator_multiplication = self.scan(/-?[0-9]+[a-zA-Z]/)[0].split(/(?<=\d)(?=[A-Za-z])/).strings_to_integers
      denominator_addition = self.scan(/-?[0-9]\+[a-zA-Z]/)[0].split(/\+/).strings_to_integers
      div(mtp(numerator_multiplication), add(denominator_addition))
    elsif /frac{-?[0-9]*[a-zA-Z]*}{-?[0-9a-zA-Z]*\+[0-9a-zA-Z]*}/.match(self)
      numerator_multiplication = self.scan(/-?[0-9]+[a-zA-Z]/)[0].split(/(?<=\d)(?=[A-Za-z])/).strings_to_integers
      denominator_subtraction = self.scan(/-?[0-9]\+[a-zA-Z]/)[0].split(/\-/).strings_to_integers
      div(mtp(numerator_multiplication), sbt(denominator_subtraction))
    elsif /-?[0-9a-zA-Z]+\([0-9a-zA-Z]+\+[0-9a-zA-Z]+\)\+[0-9a-zA-Z]+/.match(self)
      multiplication = self.scan(/-?[0-9A-Za-z]\([0-9A-Za-z]+\+[0-9A-Za-z]+/)[0].split('(').map{|x| x.split('+')}
      addition = [self.scan(/\)\+[0-9a-zA-Z]+\+?[0-9a-zA-Z]?/)[0].delete(')+')].strings_to_integers[0]

      add(mtp(multiplication[0].strings_to_integers[0], add(multiplication[1].strings_to_integers)), addition)

      # nested_multiplication = self.scan(/\([0-9a-zA-Z]\+\\frac{[0-9a-zA-Z]}{[0-9a-zA-Z]}\)/).concat(self.split(/\([0-9a-zA-Z]\+\\frac{[0-9a-zA-Z]}{[0-9a-zA-Z]}\)/))


    elsif /-?[0-9a-zA-Z]*/.match(self) #matches any expression with a negative real number followed by a sequence of algebraic terms
      decompose_multiplication


      # add((self.scan(/-?[0-9A-Za-z]\(/)[0].chars - ['(']).strings_to_integers.decompose_multiplcation)
    end

  end

  def multiplication_negative_one_coeff
    coefficient = [self.scan(/-/)[0] += '1'].strings_to_integers
    algebraic_terms = self.scan(/[a-zA-Z]+/)
    algebraic_terms = algebraic_terms.length > 1 ? algebraic_terms[0].split(//) : [algebraic_terms[0]]
    mtp(coefficient.concat(algebraic_terms))
  end
  def multiplication_other_coeff
    multiplication_elements = self.scan(/-?\d+|[a-zA-Z]/).strings_to_integers
    mtp(multiplication_elements)
  end
  def has_coefficient_negativeone?
    self.scan(/-?\d+/).length == 0 ? true : nil
  end
  def decompose_multiplication
    if has_coefficient_negativeone?
      multiplication_negative_one_coeff
    else
      multiplication_other_coeff
    end
  end
end
