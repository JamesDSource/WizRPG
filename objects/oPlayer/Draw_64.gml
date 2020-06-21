if(surface_exists(global.gui_surface)) { 
	switch(state) {
		case states.free:
			surface_set_target(global.gui_surface);
			if(toolbar_alpha > 0) {
				var toolbar_draw_x = VIEWWIDTH/2 - storage_get_width(toolbar)/2;
				var toolbar_draw_y = VIEWHEIGHT - storage_get_height(toolbar);
	
				var channel = animcurve_get_channel(acUI, "fade");
				var curve = animcurve_channel_evaluate(channel, toolbar_alpha);
				
				var item_text = "";
				if(is_struct(equipt_item.index)) item_text = equipt_item.index.name;
				
				draw_set_alpha(curve);
				draw_storage(toolbar, toolbar_draw_x, toolbar_draw_y, toolbar_equipt);
				if(item_text != "") {
					draw_set_align(fa_left, fa_bottom);
					draw_set_font(fRune);
					draw_text(toolbar_draw_x, toolbar_draw_y, item_text);
				}
				draw_set_alpha(1);
			}
			else if(spells_alpha > 0) {
				var spells_draw_x = VIEWWIDTH/2 - storage_get_width(spells)/2;
				var spells_draw_y = VIEWHEIGHT - storage_get_height(spells);
	
				var channel = animcurve_get_channel(acUI, "fade");
				var curve = animcurve_channel_evaluate(channel, spells_alpha);
				
				var spell_text = "";
				if(is_struct(equipt_spell)) spell_text = equipt_spell.name;
				
				draw_set_alpha(curve);
				draw_storage(spells, spells_draw_x, spells_draw_y, spells_equipt);
				if(spell_text != "") {
					draw_set_align(fa_left, fa_bottom);
					draw_set_font(fRune);
					draw_text(spells_draw_x, spells_draw_y, spell_text);
				}
				draw_set_alpha(1);
			}
			
			surface_reset_target();
			break;
	}
}