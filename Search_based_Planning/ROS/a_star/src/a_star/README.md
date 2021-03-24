# a_star

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

两种模式：</br>
- 用 ros自带的 map_server包，然后0-1 邻接矩阵表示障碍物和自由区域。直接在程序里写地图。

对于简单的框架还是可以用 0-1 邻接矩阵表示。

http://wiki.ros.org/map_server

launch里： 

    <node name="map_server" pkg="map_server" type="map_server" args="$(find hybrid_astar)/maps/map.yaml" />

package.xml里：

    <run_depend>map_server</run_depend>


- 用grid_map

对于后续复杂的，可以用gridmap来实现，从而直接通过设定的图像。

https://github.com/ANYbotics/grid_map

2. 思路

规划器类：</br>
①构造函数：订阅话题：地图map (nav_msgs/OccupancyGrid) 、起点/initialpose、终点/move_base_simple/goal

②处理地图：

    nav_msgs::OccupancyGrid::Ptr grid;

③碰撞检测.cpp：</br>
二维下直接根据地图的是否为障碍物即可。

    if (t == 99) {
      return !grid->data[node->getIdx()];
    }

④A star框架：</br>
优先级队列</br>

<div align=left>
<table>
  <tr>
    <td><img src="./images/general_forward_search.jpg"  width = "500" align=left></a></td>
    </tr>
</table>
</div>

其中，Q是指优先级队列(搜索算法中的唯一显著区别就是对Q进行排序的特定函数)，xI是起点，XG是终点集合。</br>
这只是总的框架，有很多小细节，比如
1. 1.  如何判断x ∈XG; 
2. 2. 如何输出plan结果，即动作action序列; 
3. 3. 如何判断x'已经访问过visited (比如邻接矩阵，邻接表等); 
4. 4. 如何定义排序方式等。</br>

* 典型的forward search methods前向搜索算法：</br>

1. Breadth first广度优先搜索【不包含路径权重】
2. Depth first深度优先搜索【不包含路径权重】
3. Dijkstra’s algorithm【包含路径权重】
4. A-star【包含路径权重】
5. Best first【包含路径权重】
6. 

