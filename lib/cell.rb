class Cell
 def initialize(alive = false)
   @alive = !!alive
   @will_change = true
 end

 def alive?
   @alive
 end

 def live!
   @alive = true
 end

 def die!
   @alive = false
 end

 def to_s
   alive? ? '*' : ' '
   #alive? ? '█' : '▒'
 end

 def will_change?
   @will_change
 end

  def change!
    @alive = !@alive if @will_change
  end

  def check(life_neightbours)
    if alive?
      @will_change = !(2..3).include?(life_neightbours)
    else
      @will_change = life_neightbours == 3
    end
  end

  def inspect
    "#{self.class}: #{alive? ? 'alive' : 'dead'}"
  end
end
