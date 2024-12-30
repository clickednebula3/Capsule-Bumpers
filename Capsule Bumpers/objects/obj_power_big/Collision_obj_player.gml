other.image_xscale *= 3;
other.image_yscale *= 3;
other.image_xscale = clamp(other.image_xscale, 1, 5);
other.image_yscale = clamp(other.image_yscale, 1, 5);
instance_destroy();