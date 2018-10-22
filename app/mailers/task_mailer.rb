class TaskMailer < ApplicationMailer
  default from: 'todoro@example.com'

  def creation_email(task)
    @task = task
    mail(
      subject: 'タスク作成完了メール',
      to: 'user@example.com',
      from: 'todoro@example.com'
    )
  end
end
