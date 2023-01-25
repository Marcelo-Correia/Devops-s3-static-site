#Website.
resource "aws_s3_bucket" "bucket_site"{
  bucket = var.app_name
  tags = var.tags_app
}
resource "aws_s3_bucket_website_configuration" "bucket_site_config" {
  bucket = aws_s3_bucket.bucket_site.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
  depends_on = [aws_s3_bucket.bucket_site]
}
resource "aws_s3_bucket_acl" "acl_configuration_site" {
  bucket = aws_s3_bucket.bucket_site.id
  acl    = "public-read"
  depends_on = [aws_s3_bucket_website_configuration.bucket_site_config]
}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${aws_s3_bucket.bucket_site.arn}",
      "${aws_s3_bucket.bucket_site.arn}/*",
    ]
    principals {
      type = "AWS"
      identifiers = [
        "*",
      ]
    }
    effect = "Allow"
  }
}

resource "aws_s3_bucket_policy" "attach_s3_policy" {
  bucket = "${aws_s3_bucket.bucket_site.id}"
  policy = "${data.aws_iam_policy_document.s3_bucket_policy.json}"
}