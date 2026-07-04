// Draw a border around focused panes that are probably part of a split layout.
// Ghostty shaders cannot see the tab's full layout, so this uses pane size as
// a heuristic: split panes are usually narrower or shorter than single panes.

const float BORDER_WIDTH = 3.0;
const vec3 BORDER_COLOR = vec3(0.86, 0.91, 0.93);

// Tune these if the border appears on single-pane tabs, or fails to appear on
// split panes. Values are physical pixels, not terminal cells.
const float SPLIT_WIDTH_THRESHOLD = 1800.0;
const float SPLIT_HEIGHT_THRESHOLD = 1000.0;

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord.xy / iResolution.xy;
    vec4 color = texture(iChannel0, uv);

    bool probablySplit = iResolution.x < SPLIT_WIDTH_THRESHOLD ||
                         iResolution.y < SPLIT_HEIGHT_THRESHOLD;

    bool isBorder = fragCoord.x < BORDER_WIDTH ||
                    fragCoord.x > iResolution.x - BORDER_WIDTH ||
                    fragCoord.y < BORDER_WIDTH ||
                    fragCoord.y > iResolution.y - BORDER_WIDTH;

    if (iFocus > 0 && probablySplit && isBorder) {
        color.rgb = BORDER_COLOR;
        color.a = 1.0;
    }

    fragColor = color;
}
