import sync

const (
	queue_len = 1000
	queue_fill = 763
)

fn do_send(ch chan int, fin sync.Semaphore) {
	for i in 0 .. queue_fill {
		ch <- i
	}
	fin.post()
}

fn test_channel_len_cap() {
	ch := chan int{cap: queue_len}
	sem := sync.new_semaphore()
	go do_send(ch, sem)
	sem.wait()
	assert ch.cap == queue_len
	assert ch.len == queue_fill
}
