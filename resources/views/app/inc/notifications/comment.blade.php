@php($sender = $notification->data['sender'] )
@php($name=$sender['name'] ." ".$sender['surname'])

<li><a href="{{ route( 'user.profile', [ 'username' => $sender['username'] ] ) }}">{{ $name }} a commenté une publication</a></li>