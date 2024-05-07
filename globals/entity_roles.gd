# EntityRoles.gd

extends Node

enum Roles { ROCK, PAPER, SCISSOR }
enum Team {Blue, Red}

const ROCK = 1
const PAPER = 2
const SCISSOR = 3

var role : Roles = Roles.PAPER

var team : Team = Team.Blue
