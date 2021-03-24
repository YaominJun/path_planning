//
// Created by lym on 21-2-16
//

#ifndef DATA_STRUCT_HPP_
#define DATA_STRUCT_HPP_

namespace astar {
// Standard point struct.
struct State {
    State() = default;
    State(double x, double y, double z = 0, double k = 0, double s = 0, double v = 0, double a = 0) :
        x(x),
        y(y),
        z(z),
        k(k),
        s(s),
        v(v),
        a(a) {}
    double x{};
    double y{};
    double z{}; // Heading.
    double k{}; // Curvature.
    double s{};
    double v{};
    double a{};
};

// Point for A* search.
struct APoint {
    double x{};
    double y{};
    double g{};
    double h{};
    // Layer denotes the index of the longitudinal layer that the point lies on.
    bool is_in_open_set{false};
    APoint *parent{nullptr};
    inline double f() {
        return g + h;
    }
};

class PointComparator {
 public:
    bool operator()(APoint *a, APoint *b) {
        return a->f() > b->f();
    }
};

}  // namespace astar

#endif  // DATA_STRUCT_HPP_