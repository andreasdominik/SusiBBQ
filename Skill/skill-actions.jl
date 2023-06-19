#
# actions called by the main callback()
# provide one function for each intent, defined in the Snips/Rhasspy
# console.
#
# ... and link the function with the intent name as shown in config.jl
#
# The functions will be called by the main callback function with
# 2 arguments:
# + MQTT-Topic as String
# + MQTT-Payload (The JSON part) as a nested dictionary, with all keys
#   as Symbols (Julia-style).
#




"""
    Susi_BBQtimer_action(topic, payload)

Generated dummy action for the intent Susi:BBQtimer.
This function will be executed when the intent is recognized.
"""
function Susi_BBQtimer_action(topic, payload)

    print_log("action Susi_BBQtimer_action() started.")

    @show default_time = get_config_skill(CONFIG_BBQ_TIME, default=90, cast_to=Int)
    @show round_time = extract_slot_value(SLOT_BBQ_TIME, payload, 
                    default=default_time, as=Int)
    info_delay = 10
    @show wait_time = round_time -info_delay

    @show sound_wav = get_config_skill(CONFIG_BBQ_SIGNAL, default="bing.wav")
    @show sound_wav = joinpath(get_appdir(), "assets", sound_wav)

    publish_say(:bbq_info_1, round_time, :bbq_info_2, :bbq_info_3)

    # run beep sequence:
    #
    sleep(2)
    # intro:
    #
    publish_say(:bbq_1, wait=false)
    sleep(5)

    publish_play(sound_wav, wait=false)

    sleep(info_delay)
    publish_say(:bbq_2, wait=false)
    sleep(wait_time)
    
    publish_play(sound_wav, wait=false)
    sleep(info_delay)
    publish_say(:bbq_3, wait=false)
    sleep(wait_time)
    
    publish_play(sound_wav, wait=false)
    sleep(info_delay)
    publish_say(:bbq_4, wait=false)
    sleep(wait_time)
    
    publish_play(sound_wav, wait=false)
    sleep(info_delay)
    publish_say(:bbq_5, wait=false)
    sleep(wait_time)
    
    publish_play(sound_wav, wait=true)
    sleep(1)
    publish_play(sound_wav, wait=true)

    publish_say(:bbq_6, wait=true)
    sleep(5)
    publish_say(:bbq_stop)

    publish_end_session(" ")
    return true
end