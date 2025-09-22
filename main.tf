resource "aws_s3_bucket" "this" {
  bucket = "this-is-my-bucket-name-12345" # Change to a unique bucket name
  lifecycle {
    prevent_destroy = true   # Terraform will never try to delete this bucket
  }
}