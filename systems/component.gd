@abstract
class_name Component extends Node

## Take the current object and return a dictionary that represents the current state
@abstract
func serialize(data: Dictionary) -> Dictionary;

## Takes a serialized dict of an object and loads that data
@abstract
func deserialize(dict: Dictionary, data: Dictionary);
