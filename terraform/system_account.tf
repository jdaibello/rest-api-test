# #############
# ### ROLES ###
# #############

# resource "aws_iam_role" "s3_backend_role" {
#   name = "test-joao-daibello-s3-backend-role"

#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect = "Allow",
#         Principal = {
#           Service = "s3.amazonaws.com"
#         },
#         Action = "sts:AssumeRole"
#       }
#     ]
#   })
# }

# ################
# ### POLICIES ###
# ################

# resource "aws_iam_policy" "s3_backend_policy" {
#   name        = "test-joao-daibello-s3-backend-policy"
#   description = "Policy to allow creating S3 buckets"

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Effect   = "Allow",
#         Action   = "s3:CreateBucket",
#         Resource = "*"
#       }
#     ]
#   })
# }

# #############################
# ### POLICIES ATTACHEMENTS ###
# #############################

# resource "aws_iam_role_policy_attachment" "s3_create_bucket_attachment" {
#   role       = aws_iam_role.s3_backend_role.name
#   policy_arn = aws_iam_policy.s3_backend_policy.arn
# }