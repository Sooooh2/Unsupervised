extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var server: Button = $VBoxContainer/Server
@onready var client: Button = $VBoxContainer/Client

func _on_server_pressed() -> void:
	print("server pressed")
	NetworkHandler.start_server()
	v_box_container.visible = false
	
	

func _on_client_pressed() -> void:
	print("client pressed")
	NetworkHandler.start_client()
	v_box_container.visible = false
