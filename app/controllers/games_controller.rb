class GamesController < ApplicationController
  def new
    @form = GameForm.build(current_user)
  end

  def create
    @form = GameForm.build(current_user)
    if @form.save(game_params)
      redirect_to history_path, notice: "Game logged successfully"
    else
      print @form.errors.full_messages.to_sentence
      flash[:error] = @form.errors.full_messages.to_sentence
      render :new
    end
  end

  private

  def game_params
    params.require(:game_form).permit(
        :score,
        game: [:played_on],
        opponent: [:score, :user_id],
    )
  end
end