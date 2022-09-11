class ScoreController < ApplicationController
  def list
    @all_subjects = Subject.all
    calculate
  end

  def calculate
    if !@all_subjects.blank? 
      scores = @all_subjects.map { |subject| subject.score.to_f }
      @total_score = scores.sum
      names = @all_subjects.map { |subject| subject.name }
      @max_score = names[scores.index(scores.max)]
    else
      @total_score = 0
      @max_score = '-'
    end
  end

  def check
    @id = params[:id]
    @name = params[:name]
    @score = params[:score]
    if @name.blank? || @score.blank?
      redirect_to :controller => 'score', :action => "edit", id: @id, :score => @score, :name => @name, :error => "Please Fill in the blank"
    else
      update
    end
  end

  def delete
    subject = Subject.find_by(id: params[:id])
    subject.destroy
    redirect_to '/score/list'
  end

  def edit
    @id = params[:id]
    @error = params[:error]
    @name = params[:name]
    @score = params[:score]
  end

  def update
    subject = Subject.find_by(id: @id)
    subject.update(name: @name, score: @score)
    redirect_to '/score/list'
  end

end
