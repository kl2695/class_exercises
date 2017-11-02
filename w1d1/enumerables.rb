class Array

  def my_each(&prc)

    i=0
    while i < self.length
      prc.call(self[i])

      i+=1
    end

    return self
  end


  def my_select(&prc)

    result = []

    self.my_each do |el|
      if prc.call(el)
        result.push(el)
      end

    end

    return result
  end


  def my_reject(&prc)
    result = []

    self.my_each do |el|
      result.push(el) unless prc.call(el)
    end

    return result
  end


  def my_any?(&prc)

    self.my_each do |el|
      if prc.call(el)
        return true
      end
    end

    return false
  end

  def my_flatten

    result = []

    if not self.has_array?
        self.my_each do |el|
          result.push(el)
        end

    else
      self.my_each do |el|
        if el.is_a? Integer
          result.push(el)
        elsif el.is_a? Array
           result += el.my_flatten
        end
      end
    end

    return result
  end

  def has_array?

    self.my_each do |el|
      if el.is_a? Array
        return true
      end
    end

    return false
  end

 def my_zip(*arg)     #TODO need to make this able to accept any number of args
   result = []
   i = 0
   
     self.my_each do |el|
       result2 = []
       result2.push(el)

       arg.my_each do |ar|

         result2.push(ar[i])

       end

       result.push(result2)
       i += 1

      end

   return result

 end




end
