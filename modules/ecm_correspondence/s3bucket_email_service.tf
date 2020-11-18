#create bucket
resource "aws_s3_bucket" "tempalte_bucket"{
bucket = "vertexinc-correspondence-templates-region1"
acl = "private"
tags = {
name = "email-template-bucket"
Environment = "Dev"
}
}
module "git-repo-correspondence" {
  source = "git::https://github.com/Ankita-Argade/git-repo-correspondence.git"
}

#upload an object
resource "aws_s3_bucket_object" "approval" {
  bucket = aws_s3_bucket.tempalte_bucket.id
  key    = "Vertex_Approval_Template.html"
  acl    = "private"  # or can be "public-read"
  source = module.git-repo-correspondence.approval
  content_type = "text/html"
  
  metadata = {
    "author": "Vertex Inc"
    "status": "ACTIVE"
	"uuid":uuid()
  }
}

# Upload an object
resource "aws_s3_bucket_object" "rejection" {
  bucket = aws_s3_bucket.tempalte_bucket.id
  key    = "Vertex_Rejection_Template.html"
  acl    = "private"  # or can be "public-read"
  source = module.git-repo-correspondence.rejection
  content_type = "text/html"
  
  metadata = {
    "author": "Vertex Inc"
    "status": "ACTIVE"
	"uuid":uuid()
  }
}
