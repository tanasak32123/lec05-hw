class MainController < ApplicationController
  def home
  end

  def test
    @subjN = params[:subjN]
    @names = params[:names]
    @scores = params[:scores]
    @not_fill = params[:not_fill]
  end

  def check
    @names = params[:subject][:names]
    @scores = params[:subject][:scores]
    @not_fill = Array.new()
    idx = 0
    @names.zip(@scores).each do |name, score| 
      if name.blank? || score.blank?
        @not_fill.push(idx)
      end
      idx += 1
    end
    if !@not_fill.empty?
      redirect_to :action => "test", :not_fill => @not_fill, :scores => @scores, :names => @names, :subjN => params[:subjN]
    else
      calculate 
      validate
      render "result"
    end
  end

  def calculate
    score_i = @scores.map{ |score| score.to_f }
    @max_score = @names[score_i.index(score_i.max)]
    @total_score = score_i.sum
  end

  def validate
    @names.zip(@scores).each do |subject|
      @name = subject[0]
      @score = subject[1]
      if Subject.where(name: @name).length > 0
        update
      else
        create
      end
    end
  end

  def create
    Subject.create(name: @name, score: @score)
  end

  def update
    subject = Subject.where(name: @name)
    subject.update(score: @score)      
  end
end
