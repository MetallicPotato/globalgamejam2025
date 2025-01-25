class_name HealthComponent
extends Node

signal HealthChanged(newhealth: float)
signal OutOfHealth

@export var MaxHealth: float = 100.0

var CurrentHealth: float
var Dead: bool = false

func _ready():
	CurrentHealth = MaxHealth

func damage(amount: float):
	if !Dead:
		CurrentHealth -= amount
		CurrentHealth = clamp(CurrentHealth, 0, MaxHealth)
		HealthChanged.emit(CurrentHealth)
		
		if CurrentHealth <= 0.0:
			OutOfHealth.emit()
			Dead = true
