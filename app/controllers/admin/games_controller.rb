class Admin::GamesController < ApplicationController
  def index
  end

  # def new
  # end

  def show
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end
  
  def new

    #ここで空の配列を作ります
    @books = []
    @title = params[:title]
    if @title.present?
  #この部分でresultsに楽天APIから取得したデータ（jsonデータ）を格納します。
  #今回は書籍のタイトルを検索して、一致するデータを格納するように設定しています。
    results = RakutenWebService::Books::Game.search({
    title: @title,
    })
  #この部分で「@books」にAPIからの取得したJSONデータを格納していきます。
  #read(result)については、privateメソッドとして、設定しております。
      results.each do |result|
    #下位置
       book = Game.new(read(result))
       @books << book  #<<何？ハッシュを取り出す
      end
    end
  end
  
  private
#「楽天APIのデータから必要なデータを絞り込む」、且つ「対応するカラムにデータを格納する」メソッドを設定していきます。
  def read(result)
    title = result["title"]
    # author = result["author"]
    # url = result["itemUrl"]
    # isbn = result["isbn"]
    # image_url = result["mediumImageUrl"].gsub('?_ex=120x120', '')
    # book_genre_id = result["booksGenreId"]
    # item_caption = result["itemCaption"]
    {
    title: title,
    # author: author,
    # url: url,
    # isbn: isbn,
    # image_url: image_url,
    # book_genre_id: book_genre_id,
    # item_caption: item_caption
    }
  end

  # def book_params
  # params.require(:book).permit(:title)
  # end
end
