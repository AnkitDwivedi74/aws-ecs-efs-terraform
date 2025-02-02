terraform {
  backend "http" {
    address="http://gitlab.example.com/api/v4/projects/3/terraform/state/dev" 
    lock_address="http://gitlab.example.com/api/v4/projects/3/terraform/state/dev" 
    unlock_address="http://gitlab.example.com/api/v4/projects/3/terraform/state/dev" 
    username="ankitd" 
    password="glpat-WPg4styT2cyfn8sEVUcN" 
    lock_method="POST" 
    unlock_method="DELETE" 
    retry_wait_min="5"

  }
}
