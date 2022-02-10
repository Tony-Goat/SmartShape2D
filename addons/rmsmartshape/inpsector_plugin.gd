extends EditorInspectorPlugin

var properties = []
var control = null

func can_handle(object):
    #if object is SS2D_NormalRange:
    #	return true
    if object is SS2D_NormalRange:
        #Connect
        var parms = [object]
        if object.is_connected("changed", Callable(self,"_changed"))==false:
            object.connect("changed", Callable(self,"_changed"),parms)
        return true
    else:
        #Disconnect
        if control != null:
            control = null

        if object.has_signal("changed"):
            if object.is_connected("changed", Callable(self,"_changed")):
                object.disconnect("changed", Callable(self,"_changed"))

    return false

# Called when the node enters the scene tree for the first time.
func _ready():
    print("loaded...")

func _changed(object):
    control._value_changed()

func parse_property(object, type, path, hint, hint_text, usage):
    if path=="edgeRendering":
        control = SS2D_NormalRangeEditorProperty.new()
        add_property_editor(" ", control)
        return true
    return false
