resource "aws_dynamodb_table" "terraform_state_locking_table" {
  name                        = "test-joao-daibello-terraform-state-locking-table"
  hash_key                    = "LockID"
  read_capacity               = 20
  write_capacity              = 20
  deletion_protection_enabled = true

  attribute {
    name = "LockID"
    type = "S"
  }
}