# EntityRoles.gd

extends Node


# Roles Enum
enum Roles {
	UNKNOWN,
	ROCK,
	PAPER,
	SCISSOR
}

# Team Enum
enum Team {
	UNKNOWN,
	Blue,
	Red
}

# Constants
const ROCK: int = Roles.ROCK
const PAPER: int = Roles.PAPER
const SCISSOR: int = Roles.SCISSOR

var role = EntityRoles.Roles.UNKNOWN
var team = EntityRoles.Team.UNKNOWN
