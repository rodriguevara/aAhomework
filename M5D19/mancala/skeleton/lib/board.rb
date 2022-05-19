class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @name1 = name1
    @name2 = name2
    @cups = Array.new(14) { Array.new }
    place_stones
  end

  def place_stones
     # helper method to #initialize every non-store cup with four stones each
    @cups.each.with_index do |cup,idx|
        next if idx == 6 || idx == 13
        @cups[idx] = Array.new(4,:stone)
    end
  end

  def valid_move?(start_pos)
    valid_poss = (0..5).to_a + (7..13).to_a
    raise "Invalid starting cup" if !valid_poss.include?(start_pos)
    raise "Starting cup is empty" if @cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    current_rocks = @cups[start_pos].length
    @cups[start_pos] = []
    pos = start_pos
    
    if current_player_name == @name1
      current_rocks.times do
        pos += 1
        pos = 0 if pos >= 13
        @cups[pos] << :stone
      end
    elsif current_player_name == @name2
      current_rocks.times do
        pos += 1
        pos = 0 if pos > 13
        pos += 1 if pos == 6
        @cups[pos] << :stone
      end
    end
    render
    if current_player_name == @name1
      next_turn(pos)
    elsif current_player_name == @name2
      next_turn(pos)
    end

  end

  def next_turn(ending_cup_idx)
    pos = ending_cup_idx
    # helper method to determine whether #make_move returns :switch, :prompt, or ending_cup_idx
    if pos == 6 || pos == 13
      return :prompt
    elsif @cups[pos].length > 1
      return pos
    else
      return :switch
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    flag1 = false
    flag2 = false
    (0..5).each do |idx| 
      flag1 = true if @cups[idx] != []
    end
    (7..12).each do |idx| 
      flag2 = true if @cups[idx] != []
    end
    return true if flag1 == false || flag2 == false
    return false if flag1 == true && flag2 == true
    
  end

  def winner
    return :draw if @cups[6].length == @cups[13].length
    return @name1 if @cups[6].length > @cups[13].length
    return @name2 if @cups[6].length < @cups[13].length
  end
end
