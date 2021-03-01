class ConversationsController < ApplicationController
  def show
    @user = User.find(params[:id]) #ログインしたが､ユーザーリストからクリックしたチャット相手のユーザーのidを取得
    rooms = current_user.user_rooms.pluck(:room_id) #ログインしているユーザーに紐づく､room_idをuser_roomsから取得
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms) #チャット相手のidと､ログインしているユーザーの持つroom_idの両方ともを持ったデータをuser_roomから取得｡ つまり､current_userがいるチャットroomに､チャット相手（@user）のidがあれば､すでにチャットroomは存在していることになる｡

    unless user_rooms.nil? #user_roomがあるとき､
      @room = user_rooms.room #変数roomに､current_userと@userのいるroomのインスタンスを入れる
    else #もし､一致するroomがないとき､
      @room = Room.new #新しいroomのインスタンスを作成・保存｡ そして､
      @room.save  
      UserRoom.create(user_id: current_user.id, room_id: @room.id) #チャット相手とログイン中のユーザーのuser_idと､今作った@roomのidをuser_room model にセーブする｡
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end

    @conversations = @room.conversations
    @conversation = Conversation.new(room_id: @room.id)

    #1. 自分と相手のuser_idとuser_roomのレコードから､お互いの居るroomを探す､なければ作成（chat.newする場所の特定）
    #2. 1. で得たroomをもとに､chatを読み込み､新しいchatを作成する（chat.new をしてレコード作成）
  end

  def create
    @conversation = current_user.conversations.new(conversation_params)
    @conversation.save
    redirect_to request.referer
    # @user = User.find(params[:id])
    # redirect_to conversation_path(@user.id)
  end

  private
  def conversation_params
    params.require(:conversation).permit(:message, :room_id)
  end
end
