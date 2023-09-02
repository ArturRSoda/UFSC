#ifndef STRUCTURES_ARRAY_LIST_H
#define STRUCTURES_ARRAY_LIST_H

#include <algorithm>
#include <cstdint>
#include <stdexcept>


namespace structures {

template<typename T>
class ArrayList {
public:
    ArrayList();
    explicit ArrayList(std::size_t max_size);
    ~ArrayList();

    void clear();
    void push_back(const T& data);
    void push_front(const T& data);
    void insert(const T& data, std::size_t index);
    void insert_sorted(const T& data);
    T pop(std::size_t index);
    T pop_back();
    T pop_front();
    void remove(const T& data);
    bool full() const;
    bool empty() const;
    bool contains(const T& data) const;
    std::size_t find(const T& data) const;
    std::size_t size() const;
    std::size_t max_size() const;
    T& at(std::size_t index);
    T& operator[](std::size_t index);
    const T& at(std::size_t index) const;
    const T& operator[](std::size_t index) const;
    // descricao do 'operator []' na FAQ da disciplina

private:
    T* contents;
    std::size_t size_;
    std::size_t max_size_;

    static const auto DEFAULT_MAX = 10u;
};

}

template<typename T>
structures::ArrayList<T>::ArrayList() {
	contents = new T[DEFAULT_MAX];
	size_ = 0;
	max_size_ = DEFAULT_MAX;
}

template<typename T>
structures::ArrayList<T>::ArrayList(std::size_t max_size) {
	contents = new T[max_size];
	size_ = 0;
	max_size_ = max_size;
}

template<typename T>
structures::ArrayList<T>::~ArrayList() {
	delete [] contents;
} 

template<typename T>
void structures::ArrayList<T>::clear() {
	while (size_ > 0) {
		contents.pop_back();
		size_--;
	}
}

template<typename T>
void structures::ArrayList<T>::push_back(const T& data) {
	if (contents.full()) {
		throw std::out_of_range("Lista cheia");
	} else {
		size_++;
		contents[size_] = data;
	}
}

template<typename T>
void structures::ArrayList<T>::push_front(const T& data) {
	if (contents.full()) {
		throw std::out_of_range("Lista cheia");
	} else {
		T temp[size_];
		for (size_t i = 0; i < size_; i++) {
			temp[i] = contents[i];
		}

		size_++;

		for (size_t i = 1; i < size_; i++) {
			contents[i] = temp[i-1];
		}
	}
}

template<typename T>
bool structures::ArrayList<T>::full() const{
	if (size_ == max_size_) {
		return true;
	} else {
		return false;
	}
}

    
#endif

