require 'rails_helper'
describe Message, type: :model do
  describe '#create' do
    def set_data
      create(:user)
      create(:group)
      create(:group_user)
    end

    context 'can save' do
      it 'is valid with body' do
        set_data
        expect(build(:message, message_img: nil)).to be_valid
      end

      it 'is valid with message_img' do
        set_data
        expect(build(:message, body: nil)).to be_valid
      end

      it 'is valid with body and message_img' do
        set_data
        expect(build(:message)).to be_valid
      end
    end

    context 'can not save' do
      it 'is invalid without body and message_img' do
        set_data
        message = build(:message, body: nil, message_img: nil)
        message.valid?
        expect(message.errors[:body]).to include('を入力してください')
      end

      it 'is invalid without group_id' do
        set_data
        message = build(:message, group_id: nil)
        message.valid?
        expect(message.errors[:group]).to include('を入力してください')
      end

      it 'is invaid without user_id' do
        set_data
        message = build(:message, user_id: nil)
        message.valid?
        expect(message.errors[:user]).to include('を入力してください')
      end
    end
  end
end
