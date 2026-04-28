resource "local_file" "favorite_food" {
  content  = "Sushi is my favorite food."
  filename = "${path.module}/favorite_food.txt"
}