//
// Created by lym on 21-2-16
//

#ifndef DATA_STRUCT_HPP_
#define DATA_STRUCT_HPP_

#include <limits>
#include <stdexcept>
#include <unordered_set>

namespace a_star {
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
    inline double f() const {
        return g + h;
    }
    APoint *parent{nullptr};
    APoint(double x, double y, double g, double h, APoint* parent)
        : x(x), y(y), g(g), h(h), parent(parent) {}
    APoint() = default;
    APoint(const APoint& apoint) {
        x = apoint.x;
        y = apoint.y;
        g = apoint.g;
        h = apoint.h;
        parent = apoint.parent;
    }
    bool operator<(const APoint& apoint) const {
        return f() > apoint.f();
    }
    bool operator==(const APoint& apoint) const {
        return (x == apoint.x) && (y == apoint.y);
    }

    // // Layer denotes the index of the longitudinal layer that the point lies on.
    // bool is_in_open_set{false};
};

struct APointHash
{
	size_t operator()(const APoint& apoint)const {
        //重载hash
		return std::hash<double>()(apoint.x) ^ std::hash<double>()(apoint.y);
	}
};

struct PointCmp
{
    bool operator()(const APoint* apoint_a, const APoint* apoint_b) const {
        return apoint_a->f() > apoint_b->f();
    }
};

}  // namespace a_star

#endif  // DATA_STRUCT_HPP_