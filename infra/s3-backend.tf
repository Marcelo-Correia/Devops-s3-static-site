resource "aws_s3_bucket" "bucket_tfstate" {
  bucket     = "tfstateterraforcalculadora"
  depends_on = [aws_s3_bucket.bucket_site]
  tags       = var.tags_terraform
}

resource "aws_s3_bucket_acl" "acl_configuration" {
  bucket = aws_s3_bucket.bucket_tfstate.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_bucket" {
  bucket = aws_s3_bucket.bucket_tfstate.id
  versioning_configuration {
    status = "Enabled"
  }
}

data "aws_iam_policy_document" "s3_bucket_policy_terraform" {
  statement {
    actions = [
      "s3:DeleteObjectVersion",
      "s3:DeleteObject"
    ]
    resources = [
      "${aws_s3_bucket.bucket_tfstate.arn}",
      "${aws_s3_bucket.bucket_tfstate.arn}/*",
    ]
    principals {
      type = "AWS"
      identifiers = [
        "*",
      ]
    }
    effect = "Deny"
  }
}

resource "aws_s3_bucket_policy" "attach_s3_policy_terraform" {
  bucket = "${aws_s3_bucket.bucket_tfstate.id}"
  policy = "${data.aws_iam_policy_document.s3_bucket_policy_terraform.json}"
}