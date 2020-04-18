mkfifo /tmp/fifo$1
nc -l -u -p $1 < /tmp/fifo | nc localhost 6667 > /tmp/fifo
