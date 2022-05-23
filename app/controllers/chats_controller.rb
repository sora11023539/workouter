class ChatsController < ApplicationController
  # A==current_user
  def show
    # BのUser情報取得
    @user = User.find(params[:id])
    # pluck 市営したカラムのレコードの配列取得
    # user_roomsテーブルのuser_idがAのレコードのroom_idを配列で取得
    rooms = current_user.user_rooms.pluck(:room_id)
    # user_idがB(@user)で、room_idがAの属するroom_id(配列)となるuser_roomsテーブルのレコードを取得して、user_roomに格納
    # これにより、AとBに共通のroom_idが存在していれば、その共通のroom_idとBのuser_idがuser_room変数に格納される(1レコード).
    # 存在しなければnil
    user_room = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    # user_roomでルームを取得出来なかった(AとBのチャットがまだ存在しない)
    room = nil
    if user_room.nil?
      # roomのidを採番
      room = Room.new
      room.save
      # 採番したroomのidを使って、user_roomのレコードを2人分(A,B)を作る(AとBに共通のroom_idを作る)
      # Bの@user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのカラムに保存(1レコード)
      UserRoom.create(user_id: @user.id, room_id: room.id)
      # Aのcurrent_user.idをuser_idとして、room.idをroom_idとして、UserRoomモデルのカラムに保存(1レコード)
      UserRoom.create(user_id: current_user.id, room_id: room.id)
    else
      # user_roomに紐づくroomsテーブルのレコードをroomに格納
      room = user_room.room
    end

    # roomに紐づくchatsテーブルのレコードを@chatsに格納
    @chats = room.chats
    # form_withでチャットを送信するのに必要な空のインスタンス
    # ここでroom.idを@chatに代入しておかないと、form_withで記述するroom_idに値が渡らない
    @chat = Chat.new(room_id: room.id)
  end

  def create
    @chat = current_user.chats.new(chat_params)
    @chat.save
  end

  private

    def chat_params
      params.require(:chat).permit(:message, :room_id)
    end

end
