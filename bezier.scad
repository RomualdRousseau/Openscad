function build_path_bezier2(A, dt = 0.05) = [
    for (t = [0:dt:1]) let(
        r = 1 - t,
        w = t / r,
        a = r * r,
        b = a * w, 
        c = b * w, 
        M = [a, 2 * b, c]
        ) M * A
];

function build_path_bezier3(A, dt = 0.05) = [ 
    for (t = [0:dt:1]) let(
        r = 1 - t,
        w = t / r,
        a = r * r * r,
        b = a * w, 
        c = b * w, 
        d = c * w,
        M = [a, 3 * b, 3 * c, d]
        ) M * A
];

module follow_path(path) {
    for(i = [0:len(path) - 4]) {
        p = [ path[i], path[i + 1], path[i + 2] ];
        v1 = p[1] - p[0];
        v2 = p[2] - p[1];
        n1 = v1 / norm(v1);
        n2 = v2 / norm(v2);
        a1 = [acos(n1.z), 0, acos(n1.x)];
        a2 = n2 ? [acos(n2.z), 0, acos(n2.x) ] : a1;
        hull() {
            translate(p[0]) rotate(a1) children();
            translate(p[1]) rotate(a2) children();
        }
    }
}

l = 20;
h = 2 + abs(cos(360 * $t)) * (l - 2);

path = build_path_bezier3([
    [-20, 0, 1],
    [0, 0, 1],
    [sqrt(l * l - h * h), h / 2, 0],
    [0, h, 0]
], 0.1);
rotate([90, 0, 0]) {
    follow_path(path) rotate([0, 90, 0]) cylinder(r = 0.2, h = 0.01, $fn = 10);
    translate([-0.5, h, -0.5]) cube([1, 2, 1]);
}
