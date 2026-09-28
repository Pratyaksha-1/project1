require 'tk'

class UserHubApp
	 def initialize
    		@root = TkRoot.new { title "UserHub System" }
    		@root.minsize(450, 400)
    
    		create_login_screen
  	end

  	def clear_window
    		@root.winfo_children.each(&:destroy)
  	end

#LOGIN SCREEN

	def create_login_screen
    		clear_window

    		@login_title = TkLabel.new(@root)
    		@login_title.text = "UserHub System - Login"
    		@login_title.font = "{Helvetica} 16 bold"
    		@login_title.pack(padx: 15, pady: 15)

    		@form_frame = TkFrame.new(@root)
    		@form_frame.pack(padx: 20, pady: 10, fill: 'x')

    		@email_label = TkLabel.new(@form_frame)
    		@email_label.text = "Email:"
    		@email_label.pack(side: 'top', anchor: 'w')

    		@email_var = TkVariable.new
    		@email_entry = TkEntry.new(@form_frame)
    		@email_entry.textvariable = @email_var
    		@email_entry.width = 35
    		@email_entry.pack(side: 'top', pady: 5)

    		@pass_label = TkLabel.new(@form_frame)
    		@pass_label.text = "Password (min 6 chars):"
    		@pass_label.pack(side: 'top', anchor: 'w')

    		@pass_var = TkVariable.new
    		@pass_entry = TkEntry.new(@form_frame)
    		@pass_entry.textvariable = @pass_var
    		@pass_entry.show = '*'
    		@pass_entry.width = 35
    		@pass_entry.pack(side: 'top', pady: 5)

    		@btn_frame = TkFrame.new(@root)
    		@btn_frame.pack(pady: 20)

    		@login_btn = TkButton.new(@btn_frame)
    		@login_btn.text = "Login"
    		@login_btn.command = proc { handle_login(@email_var.value, @pass_var.value) }
    		@login_btn.pack(side: 'left', padx: 10)

    		@reg_btn = TkButton.new(@btn_frame)
    		@reg_btn.text = "Create Account"
    		@reg_btn.command = proc { create_registration_screen }
    		@reg_btn.pack(side: 'left', padx: 10)
		
		@admin_test_btn = TkButton.new(@btn_frame)
		@admin_test_btn.text = "Admin Login"
		@admin_test_btn.command = proc { show_admin_dashboard("admin@email.com") }
		@admin_test_btn.pack(side: 'left', padx: 5)
  	end

  	def handle_login(email, password)
		email_str = email.to_s.strip
		pass_str = password.to_s.strip

   		if email_str.empty? || pass_str.empty?
      			@status_lbl.text = "Error: Fields cannot be blank!" if defined?(@status_lbl)
    		else
			if email_str == "admin@email.com"
      				show_admin_dashboard(email_str)
			else
      				show_user_dashboard(email_str)
			end				
    		end
  	end

#REGISTRATION SCREEN

 	 def create_registration_screen
    		clear_window

    		@reg_title = TkLabel.new(@root)
    		@reg_title.text = "User Registration"
    		@reg_title.font = "{Helvetica} 16 bold"
    		@reg_title.pack(padx: 15, pady: 10)

    		@reg_form = TkFrame.new(@root)
    		@reg_form.pack(padx: 20, pady: 5, fill: 'x')

    		@r_user_lbl = TkLabel.new(@reg_form)
    		@r_user_lbl.text = "Username (min 3 chars):"
    		@r_user_lbl.pack(side: 'top', anchor: 'w')

    		@r_user_var = TkVariable.new
    		@r_user_entry = TkEntry.new(@reg_form)
    		@r_user_entry.textvariable = @r_user_var
    		@r_user_entry.width = 30
    		@r_user_entry.pack(side: 'top', pady: 2)

    		@r_email_lbl = TkLabel.new(@reg_form)
    		@r_email_lbl.text = "Email:"
    		@r_email_lbl.pack(side: 'top', anchor: 'w')

    		@r_email_var = TkVariable.new
    		@r_email_entry = TkEntry.new(@reg_form)
    		@r_email_entry.textvariable = @r_email_var
    		@r_email_entry.width = 30
    		@r_email_entry.pack(side: 'top', pady: 2)

    		@r_pass_lbl = TkLabel.new(@reg_form)
    		@r_pass_lbl.text = "Password:"
    		@r_pass_lbl.pack(side: 'top', anchor: 'w')

    		@r_pass_var = TkVariable.new
    		@r_pass_entry = TkEntry.new(@reg_form)
    		@r_pass_entry.textvariable = @r_pass_var
    		@r_pass_entry.show = '*'
    		@r_pass_entry.width = 30
    		@r_pass_entry.pack(side: 'top', pady: 2)

    		@r_btn_frame = TkFrame.new(@root)
    		@r_btn_frame.pack(pady: 15)

    		@submit_reg = TkButton.new(@r_btn_frame)
    		@submit_reg.text = "Register"
    		@submit_reg.command = proc { 
			Tk.messageBox(type: "ok", title: "Success", message: "Account created successfully!")
			create_login_screen 
    		}
    		@submit_reg.pack(side: 'left', padx: 5)

    		@back_btn = TkButton.new(@r_btn_frame)
    		@back_btn.text = "Back to Login"
    		@back_btn.command = proc { create_login_screen }
    		@back_btn.pack(side: 'left', padx: 5)
  	end

#USER DASHBOARD

  	def show_user_dashboard(email)
    		clear_window

    		@dash_title = TkLabel.new(@root)
   		@dash_title.text = "Welcome, #{email}!"
   		@dash_title.font = "{Helvetica} 14 bold"
   		@dash_title.pack(padx: 15, pady: 20)

   		@prof_btn = TkButton.new(@root)
   		@prof_btn.text = "Manage Profile & Address"
   		@prof_btn.command = proc { show_profile_screen }
   		@prof_btn.pack(pady: 5, ipadx: 10)

   		@posts_btn = TkButton.new(@root)
   		@posts_btn.text = "View Posts & Attachments"
   		@posts_btn.command = proc { show_post_list  }
   		@posts_btn.pack(pady: 5, ipadx: 10)

		@posts_c_btn = TkButton.new(@root)
		@posts_c_btn.text = "Create Post & Attchments"
		@posts_c_btn.command = proc { create_post_screen }
		@posts_c_btn.pack(pady: 5, ipadx: 10)

		@admin_btn = TkButton.new(@root)
		@admin_btn.text = "View Admin Reports"
		@admin_btn.command = proc { show_admin_reports }
		@admin_btn.pack(pady: 5, ipadx: 10)

   		@logout_btn = TkButton.new(@root)
   		@logout_btn.text = "Log Out"
   		@logout_btn.command = proc { create_login_screen }
   		@logout_btn.pack(pady: 20)
  	end

  	def run
    		Tk.mainloop
  	end

#POST CREATION SCREEN

	def create_post_screen
		clear_window

		@post_title_lbl = TkLabel.new(@root)
		@post_title_lbl.text = "Create New Post & Attachments"
		@post_title_lbl.font = "{Helvitica} 14 bold"
		@post_title_lbl.pack(padx: 15, pady: 10)

		@post_form = TkFrame.new(@root)
		@post_form.pack(padx: 20, pady: 5, fill: 'x')

		TkLabel.new(@post_form) { text "Post Title:"; pack(side: 'top', anchor: 'w') }
		@title_entry = TkEntry.new(@post_form)
		@title_entry.width = 40
		@title_entry.pack(side: 'top', pady: 2)

		@content_entry = TkEntry.new(@post_form)

		TkLabel.new(@post_form) { text "Content:"; pack(side: 'top', anchor: 'w') }
		@content_entry = TkEntry.new(@post_form)
		@content_entry.width = 40
		@content_entry.pack(side: 'top', pady: 2)

		@att_lbl = TkLabel.new(@post_form)
		@att_lbl.text = "Attachment File Path (Max 5):"
		@att_lbl.pack(side: 'top', anchor: 'w', pady: 10)

		@att_entry = TkEntry.new(@post_from)
		@att_entry.width = 40
		@att_entry.pack(side: 'top', pady: 2)

		@status_lbl = TkLabel.new(@root)
		@status_lbl.text = ""
		@status_lbl.font = "{Helvetica} 10"
		@status_lbl.pack(pady: 5)

		@btn_frame = TkFrame.new(@root)
		@btn_frame.pack(pady: 15)

		@save_post_btn = TkButton.new(@btn_frame)
		@save_post_btn.text = "Save Post"
		@save_post_btn.command = proc {
			title = @title_entry.get.to_s.strip
			content = @content_entry.get.to_s.strip

			if title.empty? || content.empty?
				@status_lbl.text = "Error: Post title and content cannot be blank!"
			else
				@status_lbl.text = "Success! Post created"
				show_user_dashboard("user@email.com")
			end
		}
		@save_post_btn.pack(side: 'left', padx: 5)

		@back_dash_btn = TkButton.new(@btn_frame)
		@back_dash_btn.text = "Back to Dashboard"
		@back_dash_btn.command = proc { show_user_dashboard("user@email.com") }
		@back_dash_btn.pack(side: 'left', padx: 5)
	end

#POST LIST SCREEN

	def show_post_list
		clear_window

		@list_title = TkLabel.new(@root)
		@list_title.text = "Your Posts & Attachments"
		@list_title.font = "{Helvetica} 14 bold"
		@list_title.pack(padx: 15, pady: 15)

		@list_frame = TkFrame.new(@root)
		@list_frame.pack(padx: 20, pady: 5, fill: 'both', expand: true)

		#sample
		posts = [
			"Title: My First Ruby Project\nContent: Building UserHub in Ruby.\nAttachments: project.zip, class_diagram.png (2)",
			"Title: Learning OOP Concepts\nContent: Practicing inheritance and encapsulation.\nAttachments: None (0)"
		]

		posts.each do |post_info|
			lbl = TkLabel.new(@list_frame)
			lbl.text = post_info
			lbl.font = "{Courier} 10"
			lbl.pack(anchor: 'w', pady: 5)
		end

		@btn_frame = TkFrame.new(@root)
		@btn_frame.pack(pady: 15)

		@new_post_btn = TkButton.new(@btn_frame)
		@new_post_btn.text = "Create New Post"
		@new_post_btn.command = proc { create_post_screen }
		@new_post_btn.pack(side: 'left', padx: 5)

		@back_dash_btn = TkButton.new(@btn_frame)
		@back_dash_btn.text = "Back to Dashboard"
		@back_dash_btn.command = proc { show_user_dashboard("admin@gmail.com") }
		@back_dash_btn.pack(side: 'left', padx: 5)
	end

#EDIT/DELETE & ATTACHMENTS SCREEN

	def show_edit_post_screen(post_title = "Sample Post")
		clear_window
		
		@edit_title_lbl = TkLabel.new(@root)
		@edit_title_lbl.text = "Edit / Delete Post"
		@edit_title_lbl.font = "{Helvetica} 14 bold"
		@edit_title_lbl.pack(padx: 15, pady: 10)

		@edit_form = TkFrame.new(@root)
		@edit_form.pack(padx: 20, pady: 5, fill: 'x')

		TkLabel.new(@edit_form) { text "Edit Post Title:"; pack(side: 'top', anchor: 'w') }
		@edit_title_entry = TkEntry.new(@edit_form)
		@edit_title_entry.width = 40
		@edit_title_entry.insert(0, post_title)
		@edit_title_entry.pack(side: 'top', pady: 2)

		TkLabel.new(@edit_form) { text "Manage Attachments (Max 5):"; pack(side: 'top', anchor: 'w', pady: 10) }
		@att_list_lbl = TkLabel.new(@edit_form)
		@att_list_lbl.text = "Current: project.zip (Click Remove to delete)"
		@att_list_lbl.font = "{Helvetica} 9"
		@att_list_lbl.pack(side: 'top', anchor: 'w', pady: 2)

                @edit_status = TkLabel.new(@root)
                @edit_status.text = ""
                @edit_status.font = "{Helvetica} 10"
                @edit_status.pack(pady: 5)

		@edit_btn_frame = TkFrame.new(@root)
		@edit_btn_frame.pack(pady: 15)

		@update_btn = TkButton.new(@edit_btn_frame)
		@update_btn.text = "Update Post"
		@update_btn.command = proc {
			@edit_status.text = "Post updated successfully!!"
		}
		@update_btn.pack(side: 'left', padx: 5)

                @delete_btn = TkButton.new(@edit_btn_frame)
                @delete_btn.text = "Delete Post"
                @delete_btn.command = proc {
                        @edit_status.text = "Post deleted!"
                        show_post_list
                }
                @delete_btn.pack(side: 'left', padx: 5)

		@back_list_btn = TkButton.new(@edit_btn_frame)
		@back_list_btn.text = "Back to Posts"
		@back_list_btn.command = proc { show_post_list }
		@back_list_btn.pack(side: 'left', padx: 5)
	end

#ADMIN REPORTS SCREEN

	def show_admin_reports
		clear_window

		@rep_title = TkLabel.new(@root)
		@rep_title.text = "Administrator Master Report"
		@rep_title.font = "{Helvetica} 14 bold"
		@rep_title.pack(padx: 15, pady: 10)

		@table_frame = TkFrame.new(@root)
		@table_frame.pack(padx: 10, pady: 5, fill: 'both', expand: true)

		lbl_header = TkLabel.new(@table_frame)
		lbl_header.text = "User ID | Username	| Email			| Posts"
		lbl_header.font = "{Courier} 10 bold"
		lbl_header.pack(anchor: 'w')

		lbl_line = TkLabel.new(@table_frame)
		lbl_line.text = "-" * 55
		lbl_line.font = "{Courier} 10"
		lbl_line.pack(anchor: 'w')

		#sample
		rows = [
			" 1 | john_smith	| john@email.com	| 5 ",	
			" 2 | sara_ali		| sara@email.com	| 3 ",	
			" 3 | mike2026		| mike@email.com	| 0 "	
		]

		rows.each do |r_data|
			row_lbl = TkLabel.new(@table_frame)
			row_lbl.text = r_data
			row_lbl.font = "{Courier} 10"
			row_lbl.pack(anchor: 'w', pady: 2)
		end

		@back_admin_btn = TkButton.new(@root)
		@back_admin_btn.text = "Back"
		@back_admin_btn.command = proc { show_user_dashboard("admin@email.com") }
		@back_admin_btn.pack(pady: 15)
	end

#ADMIN DASHBOARD

	def show_admin_dashboard(email)
		clear_window

		@admin_title = TkLabel.new(@root)
		@admin_title.text = "Administrator Dashboard - Welcome #{email}"
		@admin_title.font = "{Helvetica} 14 bold"
		@admin_title.pack(padx: 15, pady: 10)

		@stats_frame = TkFrame.new(@root)
		@stats_frame.pack(padx: 20, pady: 5, fill: 'x')

		stats = [
			"Total Users: 3",
			"Total Posts: 8",
			"Total Attachments: 5",
			"Recently Registered Users: john_smith, sara_ali",
			"Recently Created Posts: My First Ruby Project, Learning OOP"
		]

		stats.each do |stat_text|
			lbl = TkLabel.new(@stats_frame)
			lbl.text = stat_text
			lbl.font = "{Helvetica} 10"
			lbl.pack(anchor: 'w', pady: 2)
		end
		
		@admin_btn_frame = TkFrame.new(@root)	
		@admin_btn_frame.pack(pady: 15)

		@manage_users_btn = TkButton.new(@admin_btn_frame)	
		@manage_users_btn.text = "Manage Users"
		@manage_users_btn.command = proc { show_manage_users }
		@manage_users_btn.pack(side: 'left', padx: 5)

                @view_reports_btn = TkButton.new(@admin_btn_frame)
                @view_reports_btn.text = "View Reports"
                @view_reports_btn.command = proc { show_admin_reports }
                @view_reports_btn.pack(side: 'left', padx: 5)

                @admin_logout_btn = TkButton.new(@root)
                @admin_logout_btn.text = "Log Out"
                @admin_logout_btn.command = proc { create_login_screen }                
                @admin_logout_btn.pack(pady: 10)
	end

#USER MANAGEMENT SCREEN
	def show_manage_users
		clear_window

  		@um_title = TkLabel.new(@root)
  		@um_title.text = "Administrator - User Management"
  		@um_title.font = "{Helvetica} 14 bold"
  		@um_title.pack(padx: 15, pady: 10)

  		@um_frame = TkFrame.new(@root)
  		@um_frame.pack(padx: 20, pady: 5, fill: 'both', expand: true)

  		lbl_header = TkLabel.new(@um_frame)
  		lbl_header.text = "ID  | Username        | Email               | Status"
  		lbl_header.font = "{Courier} 10 bold"
  		lbl_header.pack(anchor: 'w')

  		lbl_line = TkLabel.new(@um_frame)
  		lbl_line.text = "-" * 55
  		lbl_line.font = "{Courier} 10"
  		lbl_line.pack(anchor: 'w')

  		#Sample
  		users = [
    			" 1  | john_smith      | john@email.com      | Active",
    			" 2  | sara_ali        | sara@email.com      | Active",
    			" 3  | mike2026        | mike@email.com      | Suspended"
  		]

  		users.each do |user_info|
    			u_lbl = TkLabel.new(@um_frame)
    			u_lbl.text = user_info
    			u_lbl.font = "{Courier} 10"
    			u_lbl.pack(anchor: 'w', pady: 2)
		end

  		@um_btn_frame = TkFrame.new(@root)
  		@um_btn_frame.pack(pady: 15)

  		@status_msg = TkLabel.new(@root)
  		@status_msg.text = ""
  		@status_msg.font = "{Helvetica} 10"
  		@status_msg.pack(pady: 2)

  		@action_user_btn = TkButton.new(@um_btn_frame)
  		@action_user_btn.text = "Toggle User Status"
  		@action_user_btn.command = proc {
    			@status_msg.text = "Selected user status successfully updated."
  		}
  		@action_user_btn.pack(side: 'left', padx: 5)

  		@back_admin_btn = TkButton.new(@um_btn_frame)
  		@back_admin_btn.text = "Back to Admin Dashboard"
  		@back_admin_btn.command = proc { show_admin_dashboard("admin@email.com") }
  		@back_admin_btn.pack(side: 'left', padx: 5)
	end

#PROFILE AND ADDRESS SCREEN
	
	def show_profile_screen
		clear_window

		@prof_title = TkLabel.new(@root)
		@prof_title.text = "Manage Profile & Address"
		@prof_title.font = "{Helvetica} 14 bold"
		@prof_title.pack(padx: 15, pady: 10)

		@prof_form = TkFrame.new(@root)
		@prof_form.pack(padx: 20, pady: 5, fill: 'x')

		TkLabel.new(@prof_form) { text "Username:"; pack(side: 'top', anchor: 'w') }
		@p_user_entry = TkEntry.new(@prof_form)
		@p_user_entry.width = 35
		@p_user_entry.pack(side: 'top', pady: 2)

		TkLabel.new(@prof_form) { text "Email:"; pack(side: 'top', anchor: 'w') }
		@p_email_entry = TkEntry.new(@prof_form)
		@p_email_entry.width = 35
		@p_email_entry.pack(side: 'top', pady: 2)

		TkLabel.new(@prof_form) { text "Street:"; pack(side: 'top', anchor: 'w') }
		@p_street_entry = TkEntry.new(@prof_form)
		@p_street_entry.width = 35
		@p_street_entry.pack(side: 'top', pady: 2)

                TkLabel.new(@prof_form) { text "City:"; pack(side: 'top', anchor: 'w') }
                @p_city_entry = TkEntry.new(@prof_form)
                @p_city_entry.width = 35
                @p_city_entry.pack(side: 'top', pady: 2)

                TkLabel.new(@prof_form) { text "State:"; pack(side: 'top', anchor: 'w') }
                @p_state_entry = TkEntry.new(@prof_form)
                @p_state_entry.width = 35
                @p_state_entry.pack(side: 'top', pady: 2)

                TkLabel.new(@prof_form) { text "Zip Code:"; pack(side: 'top', anchor: 'w') }
                @p_zip_entry = TkEntry.new(@prof_form)
                @p_zip_entry.width = 35
                @p_zip_entry.pack(side: 'top', pady: 2)

		@prof_status = TkLabel.new(@root)
		@prof_status.text = ""
		@prof_status.font = "{Helvetica} 10"
		@prof_status.pack(pady: 5)

		@btn_frame = TkFrame.new(@root)
		@btn_frame.pack(pady: 10)

		@save_prof_btn = TkButton.new(@btn_frame)
		@save_prof_btn.text = "Save Profile"
		@save_prof_btn.command = proc {
			@prof_status.text = "Profile and Address updated successfully!"
		}
		@save_prof_btn.pack(side: 'left', padx: 5)

		@back_dash_btn = TkButton.new(@btn_frame)
		@back_dash_btn.text = "Back to Dashboard"
		@back_dash_btn.command = proc { show_user_dashboard("admin@gmail.com") }
		@back_dash_btn.pack(side: 'left', padx: 5)
	end
end

app = UserHubApp.new
app.run
