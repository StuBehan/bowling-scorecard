require 'game'

describe Game do
  describe 'frame' do
    it 'sets the state to spare when conditions are met' do
      game = Game.new
      game.frame(4, 6)

      expect(game.state[0]).to eq('spare')
    end

    it 'sets the state to strike when conditions are met' do
      game = Game.new
      game.frame(10, 0)

      expect(game.state[0]).to eq('strike')
    end

    it 'sets the state to open frame when conditions are met' do
      game = Game.new
      game.frame(4, 3)

      expect(game.state[0]).to eq('open frame')
    end
  end

  describe 'frame_ends' do
    it 'increments the frame counter by 1 after each frame is processed' do
      game = Game.new
      game.frame(4, 3)

      expect { game.frame(4, 3) }.to change { game.frame_counter }.by(1)
    end

    it 'acts on the state, calling the appropriate method (open_frame)' do
      game = Game.new
      game.frame(4, 3)

      expect(game).to receive(:open_frame)
      game.frame_ends
    end

    it 'acts on the state, calling the appropriate method (strike)' do
      game = Game.new
      game.frame(10, 0)

      expect(game).to receive(:strike)
      game.frame_ends
    end

    it 'acts on the state, calling the appropriate method (spare)' do
      game = Game.new
      game.frame(9, 1)

      expect(game).to receive(:spare)
      game.frame_ends
    end

    it 'records an entire game, when each bowling frame is a strike' do
      game = Game.new

      9.times do
        game.frame(10, 0)
      end

      p 'this test needs to be elsewhere'

      expect(game.frame_counter).to eq(9)
      expect(game.frames_total.length).to eq(7)
      expect(game.total).to eq(210)
    end
  end

  describe 'strike' do
    it 'alocates points based on previous frames, if x2_strike' do
      game = Game.new
      allow(game).to receive(:prev_condition) { 'x2_strike' }

      expect { game.strike }.to change { game.frames_total.count }.by(1)
    end

    it 'alocates points based on previous frames, if spare' do
      game = Game.new
      allow(game).to receive(:prev_condition) { 'spare' }

      expect { game.strike }.to change { game.frames_total.count }.by(1)
    end
  end

  describe 'spare' do
    it 'alocates points based on previous frames, if x2_strike' do
      game = Game.new
      allow(game).to receive(:prev_condition) { 'x2_strike' }
      allow(game).to receive(:current_frame) { 7 }

      expect { game.spare }.to change { game.frames_total.count }.by(2)
    end

    it 'alocates points based on previous frames, if x1_strike' do
      game = Game.new
      allow(game).to receive(:prev_condition) { 'x1_strike' }

      expect { game.spare }.to change { game.frames_total.count }.by(1)
    end

    it 'alocates points based on previous frames, if spare' do
      game = Game.new
      allow(game).to receive(:prev_condition) { 'spare' }
      allow(game).to receive(:current_frame) { 7 }

      expect { game.spare }.to change { game.frames_total.count }.by(1)
    end
  end

  describe 'open_frame' do
    it 'alocates points based on previous frames, if x2_strike' do
      game = Game.new
      allow(game).to receive(:prev_condition) { 'x2_strike' }
      allow(game).to receive(:current_frame) { 7 }
      allow(game).to receive(:current_open_frame) { 9 }

      expect { game.open_frame }.to change { game.frames_total.count }.by(3)
    end

    it 'alocates points based on previous frames, if x1_strike' do
      game = Game.new
      allow(game).to receive(:prev_condition) { 'x1_strike' }
      allow(game).to receive(:current_open_frame) { 9 }

      expect { game.open_frame }.to change { game.frames_total.count }.by(2)
    end

    it 'alocates points based on previous frames, if spare' do
      game = Game.new
      allow(game).to receive(:prev_condition) { 'spare' }
      allow(game).to receive(:current_frame) { 7 }
      allow(game).to receive(:current_open_frame) { 9 }

      expect { game.open_frame }.to change { game.frames_total.count }.by(2)
    end

    it 'alocates points based on previous frames, if open_frame' do
      game = Game.new
      allow(game).to receive(:prev_condition) { 'open_frame' }
      allow(game).to receive(:current_open_frame) { 7 }

      expect { game.open_frame }.to change { game.frames_total.count }.by(1)
    end
  end
end
