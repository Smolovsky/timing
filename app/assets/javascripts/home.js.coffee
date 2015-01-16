$(document).on('ready', ()=>
  @app_config = {
    id_button_start: 'button_start'
    id_time_view: 'time_view'
    #id_table_view : 'button_nonpressed'
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
    @timer_updater =''
    @is_start_pressed = false
    @local_starage_key_is_started ='is_timer_started'
    @local_starage_key_start_date ='timer_start_date'

  #TODO: КУКИ при загрузке страницы
  #$(window).bind('onload', ->
    #if localStorage.getItem('current_started_timer')
   #   @stop_timer()
  #)

  init_data: ()=>
    @time_view = $('#'+@app_config.id_time_view)
    @button_start = $('#'+@app_config.id_button_start)
    @time_view.innerHTML = "00:00:00"

    @button_start.on('click', () =>
      if @is_start_pressed
        @save_time_to_server()
      else
        @start_timer()
    )

  start_timer: ()=>
    if localStorage.getItem(@local_starage_key_is_started) == 'true'
      alert('Таймер запущен на другой странице')
    else
      @load_start_date_from_local_storage()
      @save_to_local_storage(@local_starage_key_is_started, 'true')
      @save_to_local_storage(@local_starage_key_start_date, @start_date)

      @is_start_pressed = true
      @button_start.addClass(@app_config.class_button_pressed)

      #@timer_updater = setInterval(@set_time_view, 500) #//-----------------------------------------

  stop_timer:()=>
    @save_to_local_storage(@local_starage_key_is_started, 'false')
    @save_to_local_storage(@local_starage_key_start_date, undefined )
    #document.cookie = "start_date=; expires=Thu, 01 Jan 1970 00:00:00 UTC"

    @is_start_pressed = false
    @button_start.removeClass(@app_config.class_button_pressed)
    clearInterval(@timer_updater)

  save_to_local_storage: (key, value)=>
    if typeof(Storage) != undefined
      localStorage.setItem(key, value)

  save_time_to_server: ()=>
    $.ajax(
      type: "POST",
      url: "ajax",
      data: "time=" + @get_time_from_start(),
      success: ()=>
        @stop_timer()
    )

 #TODO: если наступает следующий день то время разбивается на два дня: закончившийся и наступивший.
  set_time_view: =>
    time = @get_time_from_start()

    h = time.getHours()
    m = time.getMinutes()
    s = time.getSeconds()

    h = '0' + h if h < 10
    m = '0' + m if m < 10
    s = '0' + s if s < 10

    @time_view.innerHTML = h + ":" + m + ":" + s

  get_time_from_start: ()=>
    date = new Date()
    date.setHours(date.getHours() -  @start_date.getHours())
    date.setMinutes(date.getMinutes() - @start_date.getMinutes())
    date.setSeconds(date.getSeconds() - @start_date.getSeconds())

    date

  load_start_date_from_local_storage: ()=>
    if localStorage.getItem(@local_starage_key_start_date)
      @start_date = new Date(localStorage.getItem(@local_starage_key_start_date))
    else
      @start_date = new Date


  #TODO: настроить нормально закрытие окна при запущенно таймере
