// TODO: this is basically all terrible

boolean mouse_is_tracking, mouse_tracking_is_a;

float alpha;
float beta;
float r_1;
float r_2;
int depth;

float INITIAL_SCALE_FACTOR = 0.2;

void whomp(float r_1, float r_2, float alpha, float beta, int depth) {
    if (depth > 0) {
        line(0, 0, 0, 1);
        pushMatrix();
        translate(0, 1);
        pushMatrix();
        scale(r_1);
        rotate(alpha);
        whomp(r_1, r_2, alpha, beta, depth - 1);
        popMatrix();
        scale(r_2);
        rotate(beta);
        whomp(r_1, r_2, alpha, beta, depth - 1);
        popMatrix();
    }
}

void setup() {
    size(1000, 1000);
    noFill();
    stroke(255);
    mouse_is_tracking = false;
    alpha = -0.5;
    beta = 0.7;
    r_1 = 0.8;
    r_2 = 0.6;
    depth = 10;
}

void draw() {
    background(0);
    translate(0.5 * width, 0);
    strokeWeight(5.0 / (INITIAL_SCALE_FACTOR * width));
    scale(INITIAL_SCALE_FACTOR * width);
    whomp(r_1, r_2, alpha, beta, depth);
}

void keyPressed() {
    switch (keyCode) {
        case ' ':
            mouseClicked();
            break;
        default:
            break;
    }
}

float calc_dist(float r, float angle) {
    return dist(width * (0.5 - INITIAL_SCALE_FACTOR * r * sin(angle)),
                width * (INITIAL_SCALE_FACTOR * (1 + r * cos(angle))),
                mouseX, mouseY);
}

void mouseClicked() {
    float a_dist, b_dist;
    mouse_is_tracking = !mouse_is_tracking;
    if (mouse_is_tracking) {
        mouse_tracking_is_a = calc_dist(r_1, alpha) <= calc_dist(r_2, beta);
        mouseMoved();
    }
}

void mouseMoved() {
    float angle, r;
    if (mouse_is_tracking) {
        angle = atan2(0.5 * width - mouseX,
                      mouseY - width * INITIAL_SCALE_FACTOR);
        r = dist(mouseX, mouseY, 0.5 * width, width * INITIAL_SCALE_FACTOR) /
                (width * INITIAL_SCALE_FACTOR);
        if (mouse_tracking_is_a) {
            alpha = angle;
            r_1 = r;
        } else {
            beta = angle;
            r_2 = r;
        }
    }
}
