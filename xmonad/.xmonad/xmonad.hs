import XMonad

main = xmonad def
    { 
--		terminal = "gnome-terminal",
		terminal = "alacritty",
		modMask = mod4Mask,
		borderWidth = 3
    }
