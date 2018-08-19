# pingt
This is ping tool which returns output with timestamp.

## Usage 

You can use this command as same as default ping command. As you can see, there appears processing date and time with ping result.

```shell
$ pingt 192.168.10.1
[2018/08/19 23:45:52] PING 192.168.10.1 (192.168.10.1) 56(84) bytes of data.
[2018/08/19 23:45:52] 64 bytes from 192.168.10.1: icmp_seq=1 ttl=255 time=1.38 ms
[2018/08/19 23:45:53] 64 bytes from 192.168.10.1: icmp_seq=2 ttl=255 time=1.91 ms
[2018/08/19 23:45:54] 64 bytes from 192.168.10.1: icmp_seq=3 ttl=255 time=1.80 ms
[2018/08/19 23:45:55] 64 bytes from 192.168.10.1: icmp_seq=4 ttl=255 time=2.03 ms
```

`-c` count option. And this generate Cisco-like ping result. If the ICMPp echo is succeeded you can see "!" mark, if not you can see "." mark. Ping repeated the specified number of times.

```shell
$ pingt -c 300 192.168.10.1
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!.!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!.!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

OK: 300 NG: 0
```

`-t` is loop option. Using this option will ping the target until you force it to stop by using Ctrl-C.

```shell
$ pingt -t 192.168.10.1
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
!!!!!!!^C
OK: 107 NG: 0
```
