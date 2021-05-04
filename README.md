# content_aware_seam_carving
# Vertical Seam removal
Original image
![](Images/Castle.jpg)
Process in action
![](Code/output/Reduction/Output_ver_castle.gif)
Final image
![](Code/output/Reduction/castle_ver.svg)

# Horizontal Seam removal
Original image
![](Images/Beach.png)
Process in action
![](Code/output/Reduction/Output_hor.gif)
Final image
![](Code/output/Reduction/beach_hor.svg)

# Seam insertion
Original image
![](Images/Dolpin.png)
- Energy function 1 (absolute sum of gradient in x and y)
Seam to be inserted
![](Code/output/insert/Dolphin_seams.svg)
Process in action
![](Code/output/insert/insert_output_ver_dol.gif)
Final image
![](Code/output/insert/Dolphin_ver.svg)

- Energy function 3 (Entropy filter)
Process in action
![](Code/output/insert/insert_output_ver_entropy.gif)
Final image
![](Code/output/insert/Dolphin_ver_entropy.svg)

# Object removal
Original image
![](Images/balloon.png)
Using vertical seams
![](Code/output/object_remove/object_remove_balloon_ver.gif)
Using horizontal seams
![](Code/output/object_remove/remove_hor_balloon.gif)

Prevent one object from distortion while removing other nearby object
-Without priortizing the object
![](Code/output/object_remove/couple_final.svg)
-With high value assigned in energy function
![](Code/output/object_remove/couple_double_mask.svg)
-process in action
![](Code/output/object_remove/object_remove_couple_double_mask.gif)

# Comparing optimal seam removal with sub-optimal methods
Original image
![](Images/butterfly_1.jpg)
-Vertical seam then horizontal
![](Code/output/Opt_sub/butterfly_1_sub_optimal_ver_hor.svg)
-Horizontal seam then vertical
![](Code/output/Opt_sub/butterfly_1_sub_optimal_hor_ver.svg)
-Alternating vertical and horizontal
![](Code/output/Opt_sub/butterfly_1_sub_optimal_alternate.svg)
-Optimal method
![](Code/output/Opt_sub/butterfly_1_optimal.svg)
