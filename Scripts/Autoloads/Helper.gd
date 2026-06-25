extends Node

func IsInThreshold(value : float, target: float, threshold: float) -> bool:
	return abs(value - target) <= threshold
