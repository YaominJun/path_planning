function heap = heapFuns
heap.pushHeap = @pushHeap;
heap.popHeap = @popHeap;
heap.updateHeap = @updateHeap;
end

function newHeap = pushHeap(oldHeap, newValue)
%将后来的值找到合适的位置插入，要满足最小堆原理
    len = length(oldHeap);
    newHeap = [];
    for i = 1:len
        if newValue.Q <= oldHeap(i).Q
            newHeap = [newHeap, oldHeap(1:i-1)];
            newHeap = [newHeap, newValue];
            newHeap = [newHeap, oldHeap(i:end)];
            return;
        end        
    end
    newHeap = [newHeap, oldHeap];
	newHeap = [newHeap, newValue];
end

function [newHeap,popedValue] = popHeap(oldHeap)
%判断堆栈是否为空
    [~, c] = size(oldHeap);
    if c < 1
        popedValue = [];
        newHeap = oldHeap;
        return;
    end
    popedValue = oldHeap(1);
    newHeap = oldHeap(2:end);
end

function newHeap = updateHeap(oldHeap, newValue)
    %不能存在重复的元素，需要更新旧的代价值
    %能进入到这个函数，说明该Value尚未从队列中出去过，因为出去的肯定都是最小代价的了
    len = length(oldHeap);
    newHeap = oldHeap;
    for i = 1:len
        if newValue.x == oldHeap(i).x && newValue.y == oldHeap(i).y
            newHeap(i) = newValue;
            return;
        end        
    end
end