bind(player_join, null, null, @e,
@array = get_value(friend.@e[player].list)
foreach(@value in @array){
if(ponline(@value) == true) {
tmsg(@value, colorize('&c'.@e[player].'&a 친구가 접속하였습니다!'))
}
   }
)
bind(player_quit, null, null, @e,
@array = get_value(friend.@e[player].list)
foreach(@value in @array){
if(ponline(@value) == true) {
tmsg(@value, colorize('&c'.@e[player].'&a 친구가 나가셨습니다!'))
}
   }
)
bind(async_player_chat, null, null, @e,
if(get_value(friend.@e[player].chatmode) == true) {
cancel()
_friend_chat(@e[player], @e[message])
}
)
