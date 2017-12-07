create_macro ro_probe

update_macro -absolute_grid ro_probe {ctl X0Y0 inv1 X0Y0 inv2 X0Y0 inv3 X0Y0 inv4 X0Y0 inv5 X0Y0 inv6 X0Y0}

get_cells -of_objects [get_macro ro_probe]

write_xdc -cell [get_cells u0] ro_placement.xdc

read_xdc -cell [get_cells {u1 u2}] ro_placement.xdc


