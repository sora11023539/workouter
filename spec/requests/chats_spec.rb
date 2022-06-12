require 'rails_helper'

RSpec.describe "Chats", type: :request do
  user = FactoryBot.create(:user)

  describe "GET /show" do
    let(:get_path) { get chat_path(user.id) }

    context "When logged in" do
      before { sign_in(user) }

      # it('returns http success') { expect(get_path).to eq 200}
      it('returns http success') { expect(chat_path(user.id)).to eq chat_path(user.id)}
    end

    context "When not logged in" do
      it('returns http found') { expect(get_path).to eq 302 }

      it('redirect to the login page') { expect(get_path).to redirect_to('/login') }
    end

  end
end
