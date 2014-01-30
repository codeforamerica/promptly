# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

User.create(
  name: "Admin",
  email: "admin@example.com",
  password: "administrator",
  password_confirmation: "administrator",
  roles_mask: 1)

# Send admin login details to console
puts "Admin user successfully created:"
puts "    email: admin@example.com"
puts "    password: administrator" 

# Message.create([
#   {   name: "Example Message", message_text: "Demo message to be sent to group.", description: "This is merely a test message." },
#   {   name: "Alert Late Form", message_text: "This is a dummy message to alert you that your form is late.", description: "Late form reminder notification for dummy accounts." }
# ])

# Recipient.create([
#   {   name: "John Apple", phone: "4159876543" },
#   {   name: "Bob Smith", phone: "8882229999"  },
#   {   name: "another recipient", phone: "4159999999"  }
# ])

# Group.create(name: "Test Group", description: "Dummy group for tests and other fun.")

# Reminder must be created last; it refers to earlier Mesage.id and Recipient.id
Reminder.create([
  {   name: "First reminder for group", message_id: 1, recipient_id: 1, batch_id: "1", send_date: Date.today, send_time: "12:00pm" }  
])

