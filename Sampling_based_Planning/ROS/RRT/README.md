# RRT

## design
(1) 整体框架

完整的规划都需要：</br>
输入：
- 地图
- 起点
- 终点

输出：
- 最终路径

(2) 关键步骤

1. 地图处理

- 用grid_map

对于后续复杂的，可以用gridmap来实现，从而直接通过设定的图像。

https://github.com/ANYbotics/grid_map

2. 思路

规划器类：</br>
①构造函数：订阅话题：起点/initialpose、终点/move_base_simple/goal；地图用grid_map处理。

②处理地图：

    grid_map::GridMap map

③碰撞检测.cpp：</br>
二维下直接根据地图的是否为障碍物即可。</br>
但是RRT这里需要考虑的是一小段路径是否有碰撞，而A Star是每次执行一步，判断当前步是否有碰撞即可。</br>
因此，这里需要对路径进行判断是否碰撞。

    bool AStar::isCollision(const Eigen::Vector2d& pos) const {
        // grid_map::Position is the another name of Eigen::Vector2d
        // check if it's collision
        // 0 - 255, 0 is black, 255 is white
        if (map_.isInside(pos)) {
            return map_.atPosition("obstacle", pos, grid_map::InterpolationMethods::INTER_LINEAR) < FLAGS_collision_epsilon;
        } else {
        return true;
        }
    }

④RRT框架：</br>
RRT属于基于采样的方法，A Star属于基于搜索的方法。
而基于采样的方法和基于搜索的方法不同的是：</br>
①第三步中，</br>
基于搜索的方法：apply an action, u。施加一个动作。</br>
基于采样的方法：generating a path segment, τs。生成一个路径段。</br>
②第四步中，</br>
基于搜索的方法：insert a directed edge into the graph。添加有向边到graph中。因为基于搜索的方法是运动序列，而运动是有方向的，比如只能前进不能倒车等，所以这里说是有向边。</br>
基于采样的方法：insert an undirected edge into the graph。添加无向边到graph中。基于采样的方法加入的是edge，而edge都有两点和线段组成，只是没有方向的概念。</br>
当然，基于采样的方法不仅仅可以是状态空间采样(path segment)，还可以添加有运动空间集(action space)来实现运动空间采样，这个能够与基于搜索的方法更类似。这个在书的第14章有说明(Sampling-Based Planning Under Differential Constraints)。</br>

这只是总的框架，有很多小细节，比如
1. 1.  如何判断x ∈XG; 

            (isEqual(current_node, &end_state_)

2. 2. 如何输出plan结果，即动作action序列; 

            extractPath(current_node, final_path);

3. 3. 如何判断x'已经访问过visited (利用unordered_set); 

            checkExistenceInClosedSet(*child)
            !checkExistenceInOpenSet(*child)

4. 4. 如何生成随机的节点</br>

5. 5. 如何从vertex集合中找到距离随机节点最近的点。

* 典型的forward search methods前向搜索算法：</br>

1. Breadth first广度优先搜索【不包含路径权重】
2. Depth first深度优先搜索【不包含路径权重】
3. Dijkstra’s algorithm【包含路径权重】
4. A-star【包含路径权重】
5. Best first【包含路径权重】
6. 

