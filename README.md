# content_aware_seam_carving<br />
# Vertical Seam removal<br />
Original image<br />
![](Images/Castle.jpg)<br />
Process in action<br />
![](Code/output/Reduction/Output_ver_castle.gif)<br />
Final image<br />
![](Code/output/Reduction/castle_ver.svg)<br />

# Horizontal Seam removal<br />
Original image<br />
![](Images/Beach.png)<br />
Process in action<br />
![](Code/output/Reduction/Output_hor.gif)<br />
Final image<br />
![](Code/output/Reduction/beach_hor.svg)<br />

# Seam insertion<br />
Original image<br />
![](Images/Dolpin.png)<br />

Energy function 1 (absolute sum of gradient in x and y)<br />
Seam to be inserted<br />
![](Code/output/insert/Dolphin_seams.svg)<br />
Process in action<br />
![](Code/output/insert/insert_output_ver_dol.gif)<br />
Final image<br />
![](Code/output/insert/Dolphin_ver.svg)<br />

Energy function 3 (Entropy filter)<br />
Process in action<br />
![](Code/output/insert/insert_output_ver_entropy.gif)<br />
Final image<br />
![](Code/output/insert/Dolphin_ver_entropy.svg)<br />

# Object removal<br />
Original image<br />
![](Images/balloon.png)<br />
Using vertical seams<br />
![](Code/output/object_remove/object_remove_balloon_ver.gif)<br />
Using horizontal seams<br />
![](Code/output/object_remove/remove_hor_balloon.gif)<br />

Prevent one object from distortion while removing other nearby object<br />
-Without priortizing the object<br />
![](Code/output/object_remove/couple_final.svg)<br />
-With high value assigned in energy function<br />
![](Code/output/object_remove/couple_double_mask.svg)<br />
-process in action<br />
![](Code/output/object_remove/object_remove_couple_double_mask.gif)<br />

# Comparing optimal seam removal with sub-optimal methods<br />
Original image<br />
![](Images/butterfly_1.jpg)<br />
-Vertical seam then horizontal<br />
![](Code/output/Opt_sub/butterfly_1_sub_optimal_ver_hor.svg)<br />
-Horizontal seam then vertical<br />
![](Code/output/Opt_sub/butterfly_1_sub_optimal_hor_ver.svg)<br />
-Alternating vertical and horizontal<br />
![](Code/output/Opt_sub/butterfly_1_sub_optimal_alternate.svg)<br />
-Optimal method<br />
![](Code/output/Opt_sub/butterfly_1_optimal.svg)<br />
