class BooksController < ApplicationController

 before_action :authenticate_user!
 before_action :ensure_correct_user, only: [:update, :edit]

def show
    @book = Book.find(params[:id])
    @user = @book.user
    @books = Book.new
end

def edit
    @book= Book.find(params[:id])
end

def update
    @book = Book.find(params[:id])
    if @book.update(book_paramas)
    redirect_to book_path(@book), notice: 'You have updated book successfully.'
    else
        render :edit
    end
end

def create
    @book = Book.new(book_paramas)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book), notice: 'You have created book successfully.'
    else
        @books = Book.all
        @user = current_user
        render :index
    end
end

def  index
    @books = Book.all
    @user = current_user
    @book = Book.new
end

def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to action: "index"
end

private
def book_paramas
    params.require(:book).permit(:title, :body)
end

 def ensure_correct_user
    @book = Book.find_by(id:params[:id])
    if @book.user_id != current_user.id
      redirect_to books_path
    end
 end
 

end
