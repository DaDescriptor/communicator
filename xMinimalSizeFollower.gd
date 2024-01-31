# xMinimalSizeFollower.gd
# uses another node's x size as minimal size because i have no fucking clue
# how to make it extend to the entire container
extends Control

@export var node_to_follow: Control

func _process(delta):
	custom_minimum_size.x = node_to_follow.size.x
