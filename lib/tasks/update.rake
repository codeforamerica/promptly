# Created by: Andy Hull
# Last modified: 03/17/14
# A simple script to update legacy data to new data structures

desc "Add an organization, a super admin and an organization role to the site."
  task :add_orgs => :environment do
  password = "administrator"

  o = Organization.first_or_create(
    name: "Default Organization"
  )
  puts "Created the organization #{o.name}"

  u = User.first_or_create(
    name: "Admin",
    email: "admin@example.com",
    password: password,
    password_confirmation: password,
    roles_mask: 8)
  u.roles << :super
  u.save!

  # Send admin login details to console
  puts "SuperAdmin user successfully created:"
  puts "    email: admin@example.com"
  puts "    password: #{password}" 


  ou = OrganizationsUser.first_or_create(
    user_id: u.id,
    organization_id: o.id,
    roles_mask: 8) 

  # Send org user details to console
  puts "Organization user successfully created:"
  puts "    user_id: #{ou.user_id}"
  puts "    organization_id: #{ou.organization_id}" 
end

desc "Adds an organization id to all existing entities. These include Messages, Groups and Reminders"
  task :add_org_id => :environment do
    @organization = Organization.first
    Message.all.each do |message|
      unless message.organization
        message.organization = @organization
        puts "Added org id to message: #{message.message_text}"
      end
    end

    Group.all.each do |group|
      unless group.organization
        group.organization = @organization
        puts "Added org id to group: #{group.name}"
      end
    end

    Reminder.all.each do |reminder|
      unless reminder.organization
        reminder.organization = @organization
        puts "Added org id to reminder: #{reminder.id}"
      end
    end
  end




