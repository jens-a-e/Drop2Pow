property type_list : {} -- e.g.: {"PICT", "JPEG", "TIFF", "GIFf"} 
property extension_list : {} -- e.g.: {"txt", "text", "jpg", "jpeg"}, NOT: {".txt", ".text", ".jpg", ".jpeg"}
property typeIDs_list : {} -- e.g.: {"public.jpeg", "public.tiff", "public.png"}

on open these_items
	repeat with i from 1 to the count of these_items
		set this_item to item i of these_items
		set the item_info to info for this_item
		if folder of the item_info is true then
			link_to_pow(this_item)
		end if
	end repeat
end open

-- subroutine to make a symlink into the pow directory
on link_to_pow(the_folder)
	set the item_info to info for the_folder
	set n to name of item_info
	set p to POSIX path of (the_folder as string)
	try
		do shell script "mkdir -p ~/.pow"
		do shell script "ln -s \"" & p & "\" ~/.pow/\"" & n & "\""
	on error
		display dialog "Could not link folder to pow"
		do shell script "open ~/.pow"
	end try
end link_to_pow
