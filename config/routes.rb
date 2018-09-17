Rails.application.routes.draw do
  root 'work#index'

  get   '/dashboard', to: 'dashboard#index'
  get    '/dashboard/new',   to: 'dashboard#new'
  put    '/dashboard/update',   to: 'dashboard#update'
  post    '/dashboard/create',   to: 'dashboard#create'
  get    '/dashboard/edit/:id',   to: 'dashboard#edit'
  delete    '/dashboard/destroy/:id',   to: 'dashboard#destroy'

  get    '/dashboard/:group_id/tasks',   to: 'tasks#index'
  get    '/dashboard/:group_id/work',   to: 'work#tasks'
  get    '/dashboard/:group_id/work/task/:id',   to: 'work#task'
  get    '/dashboard/:group_id/tasks/new',   to: 'tasks#new'
  post    '/dashboard/:group_id/tasks/create',   to: 'tasks#create'
  get   '/dashboard/:group_id/tasks/edit/:id', to: 'tasks#edit'
  put    '/dashboard/:group_id/tasks/:id/update',   to: 'tasks#update'
  put    '/dashboard/:group_id/work/:id/submit',   to: 'work#submit_task'
  delete    '/dashboard/:group_id/tasks/destroy/:id',   to: 'tasks#destroy'

  get    '/dashboard/:group_id/schedulings',   to: 'schedulings#index'
  get    '/dashboard/:group_id/schedulings/new',   to: 'schedulings#new'
  post    '/dashboard/:group_id/schedulings/create',   to: 'schedulings#create'
  get   '/dashboard/:group_id/schedulings/edit/:id', to: 'schedulings#edit'
  put    '/dashboard/:group_id/schedulings/:id/update',   to: 'schedulings#update'
  delete    '/dashboard/:group_id/schedulings/destroy/:id',   to: 'schedulings#destroy'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get    '/signup',   to: 'sessions#signup'
  post   '/signup',   to: 'sessions#register'
end
