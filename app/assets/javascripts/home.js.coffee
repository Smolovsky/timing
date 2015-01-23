$(document).on('ready', ()=>
  @app_config = {
    id_button_start: 'button_start'
    id_time_view: 'time_view'
    id_task_info : 'task_properties'
    id_table_view_days: 'days_view'
    id_total_time: 'total_time'

    class_button_pressed: 'button_start_pressed'
  }

  t = new Timer(@app_config)
  t.init_data()
)

class Timer
  constructor: (@app_config)->
    @button_start=''
    @time_view = ''
    @start_date =''
    @table_view_days=''
    @timer_updater =''
    @total_time_view = ''
    @is_start_pressed = false
    @local_starage_key_is_started ='is_timer_started'
    @local_starage_key_start_date ='timer_start_date'
    @task_id=''

  #TODO: КУКИ при загрузке страницы
  #$(window).bind('onload', ->
    #if localStorage.getItem('current_started_timer')
   #   @stop_timer()
  #)

  init_data: ()=>
    @time_view = $('#'+@app_config.id_time_view)[0]
    @button_start = $('#'+@app_config.id_button_start)
    @time_view.innerHTML = "00:00:00"
    @task_id = $('#'+@app_config.id_task_info)[0].getAttribute('task_id')
    @table_view_days=$('#'+@app_config.id_table_view_days)[0]
    @total_time_view = $('#'+@app_config.id_total_time)[0]

    @button_start.on('click', () =>
      if @is_start_pressed
        @save_time_to_server( (response)=>
          @update_view_from_server_response(response)
          @stop_timer()
        )
      else
        @start_timer()
    )

    @load_start_date_from_local_storage()

  start_timer: ()=>
    if @start_date is undefined
      @start_date = new Date

    @save_to_local_storage(@local_starage_key_is_started, 'true')
    @save_to_local_storage(@local_starage_key_start_date, @start_date)

    @is_start_pressed = true
    @button_start.addClass(@app_config.class_button_pressed)

    @timer_updater = setInterval(@set_time_view, 500)

  stop_timer:()=>
    localStorage.removeItem(@local_starage_key_is_started)
    localStorage.removeItem(@local_starage_key_start_date)

    #document.cookie = "start_date=; expires=Thu, 01 Jan 1970 00:00:00 UTC"

    @is_start_pressed = false
    @start_date = undefined

    @button_start.removeClass(@app_config.class_button_pressed)
    clearInterval(@timer_updater)

  restart_timer:(is_new_day)=>
    @save_time_to_server( (response)=>
      @update_view_from_server_response(response,)
      @stop_timer()
      @start_timer()
    ,is_new_day)

  save_to_local_storage: (key, value)=>
    if typeof(Storage) != undefined
      localStorage.setItem(key, value)

  save_time_to_server: (on_success, is_new_day)=>
    is_new_day = false if not is_new_day

    params ={
      task_id: @task_id
      time: @get_int_from_time( @get_time_from_start())
      is_new_day: is_new_day
    }

    $.ajax(
      type: "POST",
      url: "ajax",
      data: params,
      success: (response)=>
        on_success(response)
    )

  update_view_from_server_response:(response)=>
    @table_view_days.innerHTML = response.table
    @total_time_view.innerHTML = response.total_time

  get_int_from_time:(time)=>
    h = time.getHours()
    m = time.getMinutes()
    s = time.getSeconds()

    h*3600+m*60+s

  load_start_date_from_local_storage: ()=>
    if localStorage.getItem(@local_starage_key_start_date) and localStorage.getItem(@local_starage_key_is_started)
      @start_date = new Date(localStorage.getItem(@local_starage_key_start_date))
      @start_timer()
    else
      @start_date = new Date

 #TODO: если наступает следующий день то время разбивается на два дня: закончившийся и наступивший.
  set_time_view: =>
    time = @get_time_from_start()
    @restart_timer(true) if @check_new_day()

    h = time.getHours()
    m = time.getMinutes()
    s = time.getSeconds()

    h = '0' + h if h < 10
    m = '0' + m if m < 10
    s = '0' + s if s < 10

    @time_view.innerHTML = h + ":" + m + ":" + s

  check_new_day:()=>
    d = new Date()
    if d.getDay() isnt @start_date.getDay()
      true
    else
      false

  get_time_from_start: ()=>
    date = new Date()
    date.setHours(date.getHours() -  @start_date.getHours())
    date.setMinutes(date.getMinutes() - @start_date.getMinutes())
    date.setSeconds(date.getSeconds() - @start_date.getSeconds())

    date

  #TODO: настроить нормально закрытие окна при запущенно таймере
