#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  dim args(-1) as String = Array(App.ExecutableFile.NativePath)
		  dim argc as Integer = args.Ubound
		  dim argv as CString = Join(args, " ")
		  
		  gtk_init(argc, argv)
		  
		  dim window as Ptr = gtk_window_new(GTK_WINDOW_TOPLEVEL)
		  gtk_window_set_title(window, "Tooltip")
		  
		  // mimick Xojo default window size, 600x400
		  gtk_window_set_default_size(window, 600, 400)
		  gtk_container_set_border_width(window, 15)
		  
		  dim button as Ptr = gtk_button_new_with_label("Button")
		  gtk_widget_set_tooltip_text(button, "Button widget")
		  
		  dim halign as Ptr = gtk_alignment_new(0, 0, 0, 0)
		  gtk_container_add(halign, button)
		  gtk_container_add(window, halign)
		  
		  gtk_widget_show_all(window)
		  
		  g_signal_connect(window, "destroy", WeakAddressOf GtkMainQuit, Nil)
		  gtk_main()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub GtkMainQuit()
		  gtk_main_quit()
		End Sub
	#tag EndMethod


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
