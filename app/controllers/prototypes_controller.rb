class PrototypesController < ApplicationController

  before_action :set_prototype, except: [:index, :new, :create]
# except: [:index, :new, :create]以外のリクエストはset_prototypeメソッドを動かす 
  before_action :authenticate_user!, except: [:index, :show]
   # except: [:index, :show]以外のリクエストは、ログアウト中のユーザーがリクエストを送った場合は自動的にログインページを表示させる
  #  showは詳細！
  before_action :author_confirm, only: [:edit]
  

  # プロトタイプの一覧を表示するアクション
  def index
    @prototypes = Prototype.all
  end

  def edit
    # @prototype = Prototype.find(params[:id])
  end

  def update 
    # 投稿したものを編集するアクション
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else  
      render :edit ,status: :unprocessable_entity
    end
  end  
  
  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end
  # 新しいプロトタイプを作成するフォームを表示するアクション
  def new
    @prototype = Prototype.new
  end

  # フォームから送信されたデータで新しいプロトタイプを作成するアクション
  def create  
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end  
  end

  # 特定のプロトタイプの詳細ページを表示するアクション
  def show
    @comment = Comment.new
    @comments = @prototype.comments
    # アソシエーションにおいていて１対多の関係だから
    # @prototypeに紐づいたcomments全てを取得
  end

  private
  # ストロングパラメーターを定義するメソッド
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
    # フォームから送信されたデータの取得と、誰が投稿したかの情報を統合する
  end

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end


  def author_confirm
    redirect_to root_path unless current_user == @prototype.user
    # 「投稿者とログインしているユーザーが等しくなければ」メソッド名は自分で決める
  end  
end