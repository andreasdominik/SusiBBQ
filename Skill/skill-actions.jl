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
    publish_say(:skill_echo, get_intent(payload))

    if ask_yes_or_no(:ask_echo_slots)

        slot_value = extract_slot_value(SLOT_BBQ_TIME, payload, default=:no_slot)
        publish_say(:slot_echo_1, SLOT_BBQ_TIME, :slot_echo_2, slot_value)
    else   # ask returns false
        # do nothing
    end

    publish_end_session(:end_say)
    return true
end
