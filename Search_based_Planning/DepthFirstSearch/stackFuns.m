function stack = stackFuns
stack.pushStack = @pushStack;
stack.popStack = @popStack;
end

function newStack = pushStack(oldStack, newValue)
%将后来的值插入到数组前面（堆栈），然后取出的时候，先取前面的（后进先出原则）
    newStack = [newValue,oldStack];
end

function [newStack,popedValue] = popStack(oldStack)
%判断堆栈是否为空
    [~, c] = size(oldStack);
    if c < 1
        popedValue = [];
        newStack = oldStack;
        return;
    end
    popedValue = oldStack(1);
    newStack = oldStack(2:end);
end