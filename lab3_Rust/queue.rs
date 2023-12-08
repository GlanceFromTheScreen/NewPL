use std::sync::{Mutex, Arc};
use std::thread;

// Определяем структуру потокобезопасной очереди
struct ThreadSafeQueue {
    data: Mutex<Vec<i32>>,
}

impl ThreadSafeQueue {
    // Создаем новую очередь
    fn new() -> Self {
        ThreadSafeQueue {
            data: Mutex::new(Vec::new()),
        }
    }

    // Добавляем элемент в очередь
    fn enqueue(&self, element: i32) {
        let mut data = self.data.lock().unwrap();
        println!("Mutex closed");
        data.push(element);
        println!("Added: {}", element);
        println!("Mutex opened\n");
    }

    // Удаляем последний элемент из очереди
    fn dequeue(&self) -> Option<i32> {
        let mut data = self.data.lock().unwrap();
        println!("Mutex closed");
        let result = data.pop();
        if let Some(element) = result {
            println!("Removed: {}", element);
        }
        println!("Mutex opened\n");
        result
    }
}

fn main() {
    // Создаем потокобезопасную очередь и оборачиваем её в Arc для многопоточности
    let queue = Arc::new(ThreadSafeQueue::new());

    // Создаем вектор для хранения идентификаторов потоков
    let mut handles = vec![];

    // Запускаем несколько потоков для добавления элементов в очередь
    for i in 0..5 {
        let queue_ref = Arc::clone(&queue);
        let handle = thread::spawn(move || {
            queue_ref.enqueue(i);
        });
        handles.push(handle);
    }

    // Ждем завершения всех потоков
    for handle in handles {
        handle.join().unwrap();
    }

    // Запускаем поток для удаления элементов из очереди
    let dequeue_handle = thread::spawn(move || {
        while let Some(_) = queue.dequeue() {}
    });

    // Ждем завершения потока удаления
    dequeue_handle.join().unwrap();
}
