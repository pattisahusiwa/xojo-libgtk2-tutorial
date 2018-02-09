#tag Class
Protected Class App
Inherits ConsoleApplication
	#tag Event
		Function Run(args() as String) As Integer
		  dim argc as Integer = args.Ubound
		  dim argv as CString = Join(args, " ")
		  
		  gtk_init(argc, argv)
		  
		  dim window as Ptr = gtk_window_new(GTK_WINDOW_TOPLEVEL)
		  gtk_window_set_title(window, "Tooltip")
		  
		  // mimick Xojo default window size, 600x400
		  gtk_window_set_default_size(window, 600, 400)
		  gtk_container_set_border_width(window, 15)
		  
		  dim button as Ptr = gtk_button_new_with_mnemonic("_Button")
		  g_signal_connect(button, "clicked", WeakAddressOf print_msg, Nil)
		  
		  dim halign as Ptr = gtk_alignment_new(0, 0, 0, 0)
		  gtk_container_add(halign, button)
		  gtk_container_add(window, halign)
		  
		  gtk_widget_show_all(window)
		  
		  g_signal_connect(window, "destroy", WeakAddressOf GtkMainQuit, Nil)
		  gtk_main()
		  Return 0
		End Function
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub GtkMainQuit()
		  gtk_main_quit()
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub print_msg(widget as Ptr, window as Ptr)
		  Print "Button clicked"
		End Sub
	#tag EndMethod


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
