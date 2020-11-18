#create bucket
resource "aws_s3_bucket" "b1"{
bucket = "s3-email-template-bucket"
acl = "private"
tags = {
name = "email-template-bucket"
Environment = "Dev"
}
}
module "github_repo_correspondence" {
  source = "git::https://github.com/vertexinc/vcd-ecm-correspondence.git"
}

#upload an object
resource "aws_s3_bucket_object" "object1" {
  bucket = aws_s3_bucket.b1.id
  key    = "Vertex_Approval_Template.html"
  acl    = "private"  # or can be "public-read"
  source = module.github_repo_correspondence.approval
  etag = filemd5(module.github_repo_correspondence.approval)
  content_type = "text/html"
  
  metadata = {
    "author": "Vertex Inc"
    "status": "ACTIVE"
  }
}

# Upload an object
resource "aws_s3_bucket_object" "object2" {
  bucket = aws_s3_bucket.b1.id
  key    = "Vertex_Rejection_Template.html"
  acl    = "private"  # or can be "public-read"
  source = module.github_repo_correspondence.rejection
  etag = filemd5(module.github_repo_correspondence.rejection)
  content_type = "text/html"
  
  metadata = {
    "author": "Vertex Inc"
    "status": "ACTIVE"
  }
}