function queue = queueFuns
queue.enQueue = @enQueue;
queue.deQueue = @deQueue;
end

function newQueue = enQueue(oldQueue, newValue)
%将后来的值插入到数组后面（队列），然后取出的时候，先取前面的（先进先出原则）
    newQueue = [oldQueue, newValue];
end

function [newQueue,popedValue] = deQueue(oldQueue)
%判断堆栈是否为空
    [~, c] = size(oldQueue);
    if c < 1
        popedValue = [];
        newQueue = oldQueue;
        return;
    end
    popedValue = oldQueue(1);
    newQueue = oldQueue(2:end);
end