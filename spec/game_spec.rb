require 'game'

describe Game do
  describe 'bowl' do
    context 'where the rolls are neither a strike or a spare' do
      it 'returns the score for the game' do
        game = Game.new
        
        10.times do 
          game.bowl(3, 4)
        end

        expect(game.total).to eq(70)
      end
    end

    context 'where the rolls always result in a spare' do
      it 'returns the score for the game' do
        game = Game.new
        
        9.times do 
          game.bowl(9, 1)
        end

        game.bowl(9, 1, 9)

        expect(game.total).to eq(70)
      end
    end

    context 'where the rolls always result in a strike' do
      it 'returns the score for the game' do
        game = Game.new
        
        9.times do 
          game.bowl(10)
        end
        
        game.bowl(10, 10, 10)

        expect(game.total).to eq(70)
      end
    end
  end
end
