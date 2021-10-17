class Cell
 def initialize(status)
   @status = !!status
   @will_change = true
 end

 def alive?
   @status
 end
 
 def live!
   @status = true
 end

 def die!
   @status = false
 end

 def to_s
   alive? ? '*' : ' ' 
 end

 def will_change=(value)
   @will_change = value
 end

  def change!
    @alive = !@alive if @will_change
  end

 def inspect
   "#{self.class}: #{alive? ? 'alive' : 'dead'}"
 end
end
