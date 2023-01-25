output "bucket_site" {
    value = aws_s3_bucket.bucket_site.arn
}

output "bucket_terraform_backend" {
    value = aws_s3_bucket.bucket_tfstate.arn
}

output "bucket_url" {
    value = aws_s3_bucket_website_configuration.bucket_site_config.*.website_endpoint
}