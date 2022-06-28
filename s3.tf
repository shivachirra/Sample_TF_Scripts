resource "aws_s3_bucket" "demos3" {
  bucket     = "sample-tf-scripts"
}

resource "aws_s3_access_point" "demos3" {
  bucket = aws_s3_bucket.demos3.id
  name   = "demos3"
}