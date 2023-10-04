User.destroy_all

# Create dummy users
user1 = User.create(email: 'user1@example.com', full_name: "Yonas Tesfu", password: 'password')
user2 = User.create(email: 'user2@example.com', full_name: "Selam Tesfu", password: 'password')
user3 = User.create(email: 'user3@example.com', full_name: "Marvin Olsen", password: 'password')
user4 = User.create(email: 'user4@example.com', full_name: "Naruto Uzumaki", password: 'password')

user1_project1 = Project.create(title: 'Figsy', description: 'Figsy is a platform that aims to connect clinical patients or any user to a clinical nutritionist', start_date: Date.current - 2, due_date: Date.current + 7)
user1_project2 = Project.create(title: "Travler's Hub", description: 'This is an application that provides a convenient way of booking a flight to any country.', start_date: Date.yesterday, due_date: Date.current + 6)
user1_project3 = Project.create(title: "Elegami", description: 'Elegami is a project managment app that uses turbo and Hotwire to deliver SPA to a Rails application', start_date: Date.today, due_date: Date.current + 10)

project1_user1 = ProjectUser.create(project_id: user1_project1.id, user_id: user1.id, role: 'owner')
project1_user2 = ProjectUser.create(project_id: user1_project1.id, user_id: user2.id, role: 'admin')
project1_user3 = ProjectUser.create(project_id: user1_project1.id, user_id: user3.id)

project2_user1 = ProjectUser.create(project_id: user1_project2.id, user_id: user1.id, role: 'owner')
project2_user2 = ProjectUser.create(project_id: user1_project2.id, user_id: user2.id)
project2_user3 = ProjectUser.create(project_id: user1_project2.id, user_id: user3.id)

project3_user1 = ProjectUser.create(project_id: user1_project3.id, user_id: user1.id, role: 'owner')

# Project 1 milestones
milestone1_project1 = Milestone.create(project_id: user1_project1.id, title: 'Signup page', start_date: Date.current, due_date: Date.tomorrow)
milestone2_project1 = Milestone.create(project_id: user1_project1.id, title: 'Landing page', start_date: Date.tomorrow, due_date: Date.current + 3)
milestone3_project1 = Milestone.create(project_id: user1_project1.id, title: 'Admin dashboard', start_date: Date.current + 1, due_date: Date.current + 5)

# Project 1 tasks
task1_mileston1 = Task.create(milestone_id: milestone1_project1.id, description: 'Setup the app configuration with the required dependancies', status: 'Completed', completed_at: Time.now)
task2_mileston1 = Task.create(milestone_id: milestone1_project1.id, description: 'Create the sign up and login forms', status: 'In_progress', priority: 'Medium')
task3_mileston1 = Task.create(milestone_id: milestone1_project1.id, description: 'Update the user authentication logic for collaborators', status: 'In_progress')

# Task_users for project 1 tasks
task_user1 = TaskUser.create(task_id: task1_mileston1.id, user_id: user1.id)
task_user2 = TaskUser.create(task_id: task1_mileston1.id, user_id: user2.id)
task_user3 = TaskUser.create(task_id: task2_mileston1.id, user_id: user2.id)
task_user4 = TaskUser.create(task_id: task2_mileston1.id, user_id: user3.id)
task_user5 = TaskUser.create(task_id: task3_mileston1.id, user_id: user2.id)

# Run seeds
puts 'Seeding completed.'