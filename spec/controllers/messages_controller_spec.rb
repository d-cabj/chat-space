require 'rails_helper'

describe MessagesController do
  let(:group) { create(:group) }
  let(:user) { create(:user) }
  let(:group_user) { create(:group_user) }

  describe '#index' do

    context 'log in' do
      before do
        login user
        get :index, params: { group_id: group.id }
      end

      it 'assigns @message' do
        #  引数に指定したクラスのインスタンスを生成し、テスト対象が引数で指定したクラスのインスタンスかつ未保存のレコードであるかどうか確かめることができる
        expect(assigns(:message)).to be_a_new(Message)
      end

      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end

      it 'renders index' do
        expect(response).to render_template :index
      end
    end

    context 'not log in' do
      before do
        get :index, params: { group_id: group.id }
      end

      it 'redirects to new_user_session_path' do
        # redirect_toは引数にとったプレフィックスにリダイレクトした際の情報を返すマッチャ
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
describe '#create' do
    # attributes_forはcreate、build同様FactoryGirlによって定義されるメソッドで、オブジェクトを生成せずにハッシュを生成する
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    context 'log in' do
      before do
        login user
      end

      context 'can save' do
        subject {
          post :create,
          params: params
        }

        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)
        end

        it 'redirects to group_messages_path' do
          subject
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      context 'can not save' do
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, body: nil, message_img: nil) } }

        subject {
          post :create,
          params: invalid_params
        }

        it 'does not count up' do
          # changeマッチャは引数が変化したかどうかを確かめるために利用できるマッチャです。change(Message, :count).by(1)と記述することによって、Messageモデルのレコードの総数が1個増えたかどうかを確かめることができます。
          # postメソッドでcreateアクションを擬似的にリクエストをした結果
          expect{ subject }.not_to change(Message, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    context 'not log in' do

      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
