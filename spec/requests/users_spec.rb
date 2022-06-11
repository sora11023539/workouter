require 'rails_helper'

RSpec.describe "Users", type: :request do
  user = FactoryBot.create(:user)

  describe "GET /edit" do
    let(:get_path) { get edit_user_path(user.id) }

    xcontext "When logged in" do
      before { sign_in(user) }

      it('returns http success') { expect(get_path).to eq 200}
      # it('returns http success') { expect(edit_user_path(user.id)).to eq edit_user_path(user.id)}
    end

    context "When not logged in" do
      it('returns http found') { expect(get_path).to eq 302 }

      it('redirect to the sign_in page') { expect(get_path).to redirect_to('/login') }
    end

  end
end
