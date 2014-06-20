proc(_friend_help, @cmd, @player,
@cmdform = colorize('&e/'.@cmd)
@aliasform = colorize('&7단축 - /'.@cmd)
tmsg(@player, colorize('&a-----&c[&eAstia Friend System&c]&a-----'))
tmsg(@player, colorize(@cmdform'add <플레이어> &a- 친구 추가 요청을 합니다.'))
tmsg(@player, colorize(@aliasform'add'))
tmsg(@player, colorize(@cmdform'remove <플레이어> &a-친구 리스트에서 친구를 삭제합니다.'))
tmsg(@player, colorize(@aliasform'remove'))
tmsg(@player, colorize(@cmdform'cancel <플레이어> &a-<플레이어> 에게 보낸 친구 추가 요청을 취소합니다.'))
tmsg(@player, colorize(@aliasform'cancel'))
tmsg(@player, colorize(@cmdfornm'accept <플레이어> &a-친구 수락 요청을 받습니다.'))
tmsg(@player, colorize(@aliasform'accept'))
tmsg(@player, colorize(@cmdform'deny <플레이어> &a-친구 수락 요청을 받지 않습니다.'))
tmsg(@player, colorize(@aliasfrom'deny'))
tmsg(@player, colorize(@cmdform'list &a-친구 목록을 봅니다.(온라인 여부,월드,서버)'))
tmsg(@player, colorize(@aliasform'list'))
tmsg(@player, colorize(@cmdform'chat [메세지] &a-친구들과 채팅을 합니다.([메세지] 부분에 메세지를 입력할시 1회만 채팅, 입력하지 않을시 토글)'))
tmsg(@player, colorize(@aliasform'chat'))
)
proc(_friend_add, @fromplayer, @toplayer,
if(phas_played(@toplayer) == true) {
tmsg(@fromplayer, colorize('&a'.@toplayer.'님에게 친구 추가 요청을 보냈습니다.'))
    if(ponline(@toplayer) == true) {
    tmsg(@toplayer, colorize('&a'.@fromplayer.'님께서 당신을 친구로 추가하고 싶어 하십니다, 수락하실려면 &b/friend accept'@fromplayer'&a를 입력해 주십시오.'))
    }
    if(get_value(friend.@toplayer.reqlist) == null) {
    store_value(friend.@toplayer.reqlist, array(@fromplayer))
        } else {
        store_value(friend.@toplayer.reqlist, array_push(get_value(friend.@toplayer.reqlist), @fromplayer))
    }
} else {
tmsg(@fromplayer, colorize('&c그 플레이어는 존재하지 않습니다!'))
}
)
proc(_friend_remove, @fromplayer, @toplayer,
if(array_contains(get_value(friend.@fromplayer.list), @toplayer) == true && array_contains(get_value(friend.@toplayer.list), @fromplayer) == true) {
store_value(friend.@fromplayer.list, array_remove_values(get_value(friend.@fromplayer.list), @toplayer))
store_value(friend.@toplayer.list, array_remove_values(get_value(friend.@toplayer.list), @fromplayer))
tmsg(@fromplayer, colorize('&a플레이어를 친구 목록에서 제거하였습니다.'))
tmsg(@toplayer, colorize('&a'.@fromplayer.'님이 당신을 친구 목록에서 제거하였습니다.'))
} else {
tmsg(@fromplayer, colorize('&c당신은 그 사람과 친구가 된 적이 없습니다!'))
}
)
proc(_friend_cancel, @fromplayer, @toplayer,
if(get_value(friend.@toplayer.reqlist) !== null && array_contains(get_value(friend.@toplayer.reqlist), @fromplayer) == true) {
tmsg(@fromplayer, colorize('&a친구 추가 요청을 취소하였습니다.'))
store_value(friend.@toplayer.reqlist, array_remove_values(get_value(friend.@toplayer.reqlist), @fromplayer))
} else {
tmsg(@fromplayer, colorize('&c그 플레이어에게 친구 추가 요청을 한 적이 없습니다!'))
}
)
proc(_friend_accept, @fromplayer, @toplayer,
if(get_value(friend.@fromplayer.reqlist) !== null && array_contains(get_value(friend.@fromplayer.reqlist), @toplayer) == true) {
store_value(friend.@fromplayer.reqlist, array_remove(get_value(friend.@fromplayer.reqlist), @toplayer))
if(get_value(friend.@fromplayer.list) !== null) {
store_value(friend.@fromplayer.list, array_push(get_value(friend.@fromplayer.list), @toplayer))
} else {
store_value(friend.@fromplayer.list, array(@toplayer))
}
if(get_value(friend.@toplayer.list) !== null) {
store_value(friend.@toplayer.list, array_push(get_value(friend.@toplayer.list), @fromplayer))
} else {
store_value(friend.@toplayer.list, array(@fromplayer))
}
tmsg(@fromplayer, colorize('&a'.@toplayer.'님의 친구 추가 요청을 성공적으로 수락하셨습니다!'))
tmsg(@toplayer, colorize('&a'.@fromplayer.'님이 친구 추가 요청을 수락하셨습니다!'))
}
)
proc(_friend_accept, @fromplayer, @toplayer,
if(get_value(friend.@fromplayer.reqlist) !== null && array_contains(get_value(friend.@fromplayer.reqlist), @toplayer) == true) {
store_value(friend.@fromplayer.reqlist, array_remove(get_value(friend.@fromplayer.reqlist), @toplayer))
tmsg(@fromplayer, colorize('&a'.@toplayer.'님의 친구 추가 요청을 거절하셨습니다!'))
tmsg(@toplayer, colorize('&a'.@fromplayer.'님이 친구 추가 요청을 거절하셨습니다!'))
}
)
proc(_friend_ponline, @player,
if(ponline(@player) == true) {
return('&a온라인')
} else {
return('&c오프라인')
}
)
proc(_friend_list, @player,
if(get_value(friend.@player.list) !== null) {
@array = get_value(friend.@player.list)
foreach(@value in @array){
      tmsg(@player, colorize('&c'.@value.' &e- '._friend_ponline(@value));
   }
} else {
tmsg(@player, colorize('&c친구가 없습니다...'))
}
)
proc(_friend_chat, @player, @message,
if(get_value(friend.@player.list) !== null) {
@array = get_value(friend.@player.list)
tmsg(@player, colorize('&a[&c친구&a]&e'@player)@message)
foreach(@value in @array){
if(ponline(@value) == true) {
      tmsg(@value, colorize('&a[&c친구&a]&e'@player)@message)
}
   }
} else {
msg(colorize('&c대화할 친구가 없습니다!'))
}
)
