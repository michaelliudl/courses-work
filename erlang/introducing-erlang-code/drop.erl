-module(drop).
-export([fall_velocity/1, mps_to_mph/1, mps_to_kph/1]).


fall_velocity(Distance) ->
	GRAVITY_CONSTANT = 9.8,
	math:sqrt(2 * GRAVITY_CONSTANT * Distance).
mps_to_mph(Mps) ->
	MPS_TO_MPH = 2.23693629,
	MPS_TO_MPH * Mps.
mps_to_kph(Mps) ->
	MPS_TO_KPH = 3.6,
	MPS_TO_KPH * Mps.