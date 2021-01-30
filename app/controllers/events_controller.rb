class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]

  before_action :set_event, only: [:edit, :update, :destroy, :show]

  # Предохранитель от потери авторизации в нужных экшенах
  after_action :verify_authorized, only: [:edit, :update, :destroy, :show]

  # Проверка пинкода перед отображением события
  before_action :password_guard!, only: [:show]

  # GET /events
  def index
    @events = Event.all
  end

  # GET /events/1
  def show
    authorize @event

    # Болванки моделей для форм добавления
    @new_comment = @event.comments.build(params[:comment])

    @new_subscription = @event.subscriptions.build(params[:subscription])

    @new_photo = @event.photos.build(params[:photo])
  end

  # GET /events/new
  def new
    @event = current_user.events.build

    authorize @event
  end

  # GET /events/1/edit
  def edit
    authorize @event
  end

  # POST /events
  def create
    @event = current_user.events.build(event_params)

    authorize @event

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  # PATCH/PUT /events/1
  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  # DELETE /events/1
  def destroy
    authorize @event

    message = {notice: I18n.t('controllers.events.destroyed')}

    if current_user_can_edit?(@event)
      @event.destroy!
    else
      message = {alert: I18n.t('controllers.events.error')}
    end
    redirect_to root_path, message
  end

  private

  # задать значение для  secret_key_base
  #
  # И оно работает
  #
  # Тогда куки в рельсах 4 и старше по умолчанию шифруются и хранить там пинкод
  # для данной задачи достаточно безопасно.
  #
  # http://api.rubyonrails.org/classes/ActionDispatch/Session/CookieStore.html
  #
  def password_guard!
    # return true if @event.pincode.blank?
    # return true if signed_in? && current_user == @event.user

    # Юзер на чужом событии (или не залогинен). Проверяем, правильно ли передал
    # пинкод. Если правильно, запоминаем в куках этого юзера этот пинкод для данного события.
    # Так юзеру не нужно будет вводить пин-код каждый раз
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end

    unless policy(@event).show?
      if params[:pincode].present?
        flash.now[:alert] = I18n.t('controllers.events.wrong_pincode')
      end

      render 'password_form'
    end

    # Проверяем — верный ли в куках пинкод, если нет — ругаемся и рендерим форму
    # pincode = cookies.permanent["events_#{@event.id}_pincode"]

    # unless @event.pincode_valid?(pincode)
    #   if params[:pincode].present?
    #     flash.now[:alert] = I18n.t('controllers.events.wrong_pincode')
    #   end
    #   render 'password_form'
    # end
  end

  def set_event
    @event = Event.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end
end
