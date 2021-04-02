class Game 

  attr_reader :total, :frames, :frames_total

  def initialize
    @total = 0
    @frames = []
    @frames_total = []
  end

  def bowl(bowl_one, bowl_two = 0, bowl_three = 0)
    @frames << [bowl_one, bowl_two, bowl_three]
    update_frames_total
    find_total
  end

  def update_frames_total
    if @frames.count == 10
      @frames_total << tenth_frame
    else
      prev_id = 0
      prev_prev_id = -1
      @frames_total = []
      @frames.each do |frame|
        if frame[0] == 10  # strike
          if @frames[prev_id][0] == 10
            if @frames[prev_prev_id][0] == 10
              @frames_total << 30
            else

            end

          else

          end
        elsif frame[0] + frame[1] == 10 # spare
          ft = 0
        else # open frame
          @frames_total << frame[0] + frame[1]
        end
        prev_id += 1
        prev_prev_id += 1
      end
    end
  end

  def tenth_frame
    ften = 0 
    if @frames[9][0] == 10 || @frames[9][0] + @frames[9][1] == 10
      @frames[9].each { |bowl| ften += bowl }
    elsif ften = @frames[9][0] + @frames[9][1] 
    end
    ften
  end

  def find_total
    @total = 0
    
    @frames_total.each do |frame_total|
      @total += frame_total
    end
  end
end
