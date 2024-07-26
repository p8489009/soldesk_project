resource "aws_s3_bucket" "lambda_bucket" {
  bucket = var.bucket_name
}

resource "aws_s3_bucket_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = var.object_key

}

output "bucket_name" {
  value = aws_s3_bucket.lambda_bucket.bucket
}

output "object_key" {
  value = aws_s3_bucket_object.lambda_zip.key
}