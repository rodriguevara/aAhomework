class Stack
    def initialize
        @stack = []
    end

    def push(el)
        @stack << el
    end

    def pop
        @stack.pop
    end

    def peek
        return @stack[-1]
    end

end

class Queue
    def initialize
        @queue = []
    end

    def enqueue(el)
        @queue << el
    end

    def dequeue
        @queue.shift
    end

    def peek
        @queue[-1]
    end
end

class Map
    def initialize
        @map = []
    end

    def set(key,value)
        flag = false
        @map.each do |sub|
            if sub[0] == key
                flag = true
                sub[1] = value
                return "key value pair modified"
            end
        end
        @map << [key,value] if flag == false
        flag = false
        return "key value pair added"
    end

    def get(key)
        @map.each do |sub|
            if sub[0] == key
                return sub
            end
        end
        return "No key value pair was found with that key"
    end

    def delete(key)
        @map.each.with_index do |sub,i|
            if sub[0] == key
                @map.delete_at(i)
                return "Deleted #{sub} key value pair"
            end
        end
        return "No key value pair was found with that key"
    end

    def show
        return @map
    end
end
