require "rails_helper"
require "ostruct"

RSpec.describe TodoController, type: :controller do
  let(:user) { create(:user) }
  let!(:todo) { create(:todo, user: user, title: "Sample Todo", done: false) }

  describe "GET #index" do
    context("ユーザーが認証済みの場合") do
      before do
        allow(controller).to(receive(:authenticated?).and_return(true))
        # Current.session.user にテスト用ユーザーを設定
        Current.session = OpenStruct.new(user: user)
      end

      it "Current.session.user の todos を取得する" do
        get(:index)
        expect(assigns(:todos)).to(eq(user.todos))
      end
    end

    context("認証されていない場合") do
      before do
        allow(controller).to(receive(:authenticated?).and_return(false))
      end

      it "全ての Todo を取得する" do
        get(:index)
        expect(assigns(:todos)).to(eq(Todo.all))
      end
    end
  end

  describe "GET #show" do
    it "指定した id の Todo を取得する" do
      get(:show, params: { id: todo.id })
      expect(assigns(:todo)).to(eq(todo))
    end
  end

  describe "GET #new" do
    it "パラメーターから新しい Todo インスタンスを構築する" do
      # new アクションでは build_todo(params) を呼んでインスタンスを作成している
      get(:new, params: { title: "New Todo", done: true })
      new_todo = assigns(:todo)
      expect(new_todo).to(be_a_new(Todo))
      expect(new_todo.title).to(eq("New Todo"))
      expect(new_todo.done).to(eq(true))
    end
  end

  describe "POST #create" do
    before do
      allow(controller).to(receive(:authenticated?).and_return(true))
      Current.session = OpenStruct.new(user: user)
    end

    context("パラメーターが有効な場合") do
      it "新しい Todo を作成する" do
        expect {
          post(:create, params: { todo: { title: "Created Todo", done: false } })
        }
          .to(change(user.todos, :count).by(1))
      end

      it "ルートパスにリダイレクトし、成功のフラッシュメッセージを表示する" do
        post(:create, params: { todo: { title: "Created Todo", done: false } })
        expect(response).to(redirect_to(root_path))
        expect(flash[:notice]).to(eq("Todo created successfully."))
      end
    end

    context("パラメーターが無効な場合") do
      # 例えば title の空文字は無効と仮定
      it "new テンプレートを再表示し、422 Unprocessable Entity を返す" do
        post(:create, params: { todo: { title: "", done: false } })
        expect(response).to(have_http_status(:unprocessable_entity))
        expect(response).to(render_template(:new))
      end
    end
  end

  describe "GET #edit" do
    it(
      "指定した Todo を取得し、パラメーターで上書きした新しいインスタンスを割り当てる"
    ) do
      # ※現状のコードでは、edit 内でまず Todo を検索後、build_todo(params) で再生成しているため、params の値で上書きされる
      get(:edit, params: { id: todo.id, title: "Edited Title", done: true })
      edited_todo = assigns(:todo)
      expect(edited_todo.title).to(eq("Edited Title"))
      expect(edited_todo.done).to(eq(true))
    end
  end

  describe "PATCH #update" do
    let(:existing_todo) { create(:todo, user: user, title: "Old Title", done: false) }
    before do
      allow(controller).to(receive(:authenticated?).and_return(true))
      Current.session = OpenStruct.new(user: user)
    end

    context("パラメーターが有効な場合") do
      it "Todo を更新する" do
        patch(:update, params: { id: existing_todo.id, todo: { title: "Updated Title", done: true } })
        # update アクション内で build_todo(params) を呼んでいるため、期待どおりに更新されるかテストする
        existing_todo.reload
        expect(existing_todo.title).to(eq("Updated Title"))
        expect(existing_todo.done).to(eq(true))
      end

      it "show ページにリダイレクトし、成功のフラッシュメッセージを表示する" do
        patch(:update, params: { id: existing_todo.id, todo: { title: "Updated Title", done: true } })
        expect(response).to(redirect_to(assigns(:todo)))
        expect(flash[:notice]).to(eq("Todo was successfully updated."))
      end
    end

    context("パラメーターが無効な場合") do
      it "edit テンプレートを再表示する" do
        patch(:update, params: { id: existing_todo.id, todo: { title: "", done: true } })
        expect(response).to(render_template(:edit))
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:todo_to_destroy) { create(:todo, user: user) }
    before do
      allow(controller).to(receive(:authenticated?).and_return(true))
      Current.session = OpenStruct.new(user: user)
    end

    it "指定した Todo を削除する" do
      expect {
        delete(:destroy, params: { id: todo_to_destroy.id })
      }
        .to(change(Todo, :count).by(-1))
    end

    it "ルートパスにリダイレクトし、削除成功のフラッシュメッセージを表示する" do
      delete(:destroy, params: { id: todo_to_destroy.id })
      expect(response).to(redirect_to(root_path))
      expect(flash[:notice]).to(eq("Todo was successfully destroyed."))
    end
  end
end
