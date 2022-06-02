#include <iostream>
#include <semaphore>
#include <thread>

std::counting_semaphore<1> A(0);  // (1)
std::counting_semaphore<1> B(0);  // (2)

std::atomic<int> counter{};
constexpr int countlimit = 1'000'000;

void ping() {
    while (counter < countlimit) {
        A.acquire();  // (5)
        ++counter;
        B.release();
    }
}

void pong() {
    while (counter < countlimit) {
        B.acquire();
        ++counter;
        A.release();  // (3)
    }
}

int main() {
    auto start = std::chrono::system_clock::now();

    A.release();  // (4)
    std::thread t1(ping);
    std::thread t2(pong);

    t1.join();
    t2.join();

    std::chrono::duration<double> dur =
        std::chrono::system_clock::now() - start;
    std::cout << "Duration: " << dur.count() << " seconds" << '\n';
}