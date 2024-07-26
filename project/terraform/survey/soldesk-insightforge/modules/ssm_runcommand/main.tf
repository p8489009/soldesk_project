resource "aws_ssm_document" "run_shell_script" {
  name          = "RunShellScriptDocument"
  document_type = "Command"

  content = jsonencode({
    schemaVersion = "2.2",
    description   = "Run a shell script",
    mainSteps     = [
      {
        action = "aws:runShellScript",
        name   = "runShellScript",
        inputs = {
          runCommand = [
            "#!/bin/bash",
            "",
            "# S3 버킷 이름",
            "export BUCKET_NAME=\"aws-ssm-managed-bucket\"",
            "",
            "# 파일 다운로드 경로",
            "export DEST_DIR=\"/home/ec2-user\"",
            "",
            "# S3에서 파일 다운로드",
            "aws s3 cp s3://$BUCKET_NAME/ansible.cfg $DEST_DIR/ansible.cfg",
            "",
            "aws s3 cp s3://$BUCKET_NAME/aws_ec2.yml $DEST_DIR/aws_ec2.yml",
            "",
            "aws s3 cp s3://$BUCKET_NAME/dynamodb-deploy.yml $DEST_DIR/dynamodb-deploy.yml",
            "",
            "aws s3 cp s3://$BUCKET_NAME/nginx-deploy.yml $DEST_DIR/nginx-deploy.yml",
            "",
            "aws s3 cp s3://$BUCKET_NAME/soldesk.pem.pem $DEST_DIR/soldesk.pem.pem",
            "",
            "aws s3 cp s3://$BUCKET_NAME/tomcat-deploy.yml $DEST_DIR/tomcat-deploy.yml",
            "",
            "aws s3 cp s3://$BUCKET_NAME/html/create-survey.html $DEST_DIR/html/create-survey.html",
            "",
            "aws s3 cp s3://$BUCKET_NAME/html/list-survey.html $DEST_DIR/html/list-survey.html",
            "",
            "aws s3 cp s3://$BUCKET_NAME/html/start-survey.html $DEST_DIR/html/start-survey.html",
            "",
            "aws s3 cp s3://$BUCKET_NAME/html/take-survey.html $DEST_DIR/html/take-survey.html",
            "",
            "aws s3 cp s3://$BUCKET_NAME/html/view-survey.html $DEST_DIR/html/view-survey.html",
            "",
            "cd /home/ec2-user",
            "",
            "chmod 400 /home/ec2-user/soldesk.pem.pem",
            "",
            "cp /home/ec2-user/soldesk.pem.pem ~/.ssh/soldesk.pem.pem",
            "",
            "ansible-playbook -i /home/ec2-user/aws_ec2.yml /home/ec2-user/nginx-deploy.yml /home/ec2-user/tomcat-deploy.yml /home/ec2-user/dynamodb-deploy.yml",
            "echo \"Script completed successfully.\""
          ]
        }
      }
    ]
  })

}

resource "aws_ssm_association" "run_command_association" {
  name = aws_ssm_document.run_shell_script.name

  targets {
    key    = "tag:Name"
    values = [var.tag_value]
  }
}
