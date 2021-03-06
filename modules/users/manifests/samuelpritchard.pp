# Creates samuelpritchard user
class users::samuelpritchard {
  govuk_user { 'samuelpritchard':
    ensure   => absent,
    fullname => 'Samuel Pritchard',
    email    => 'samuel.pritchard@digital.cabinet-office.gov.uk',
    ssh_key  => 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDNNsdJTe3Z6n+Qa2i8bVAnT7Db/23tOCKnBmeSBtqkU1EyVL2ByV22qm6SqvOqPCokuXFeY+0llkDWps9K/ZOEAlhGIZ6iRZQVeuc4O37g1Jd5Pe+ITAorqhSXpEzefr2rbR4zfKqI2eQs1LxT+RRrx+e4JqTucGBqIxJofuz2Wka06dXzFtUYv/3wPs5KAdGnLGawnQRhE0LibeSP5ut2NJ0xTkbWBoBgyWMKrzR0+iyqFNR9RghcJLvcmFK/J6KpGrc+FcJQKbQGBkMyR6+Tfs9rwnoOW4JyIpM5XkkhXFrBxVckM1vR6Wt0cNJPlNBBngw9TytnIgijbyjixru3rJd2RU1yjvC5a1SMwhyfYaZAJlNCuJmNDTwKTXeoi5hi7nqmNP7EoywWz+y1Z6BHu02waclYvkMMozU7/Nn6j6EIltbghsNiFL4I2amQDcfRMjjhYqV7wzhPsGV4OSlOwvziEO9kbyl2nPJtYAMKQd5Ox8e8Y6Xu7qFnOJGLKLMr2FZm+xCh8IO5428YbziIqo8JUSQknFaTW+wQYPxbNys7oyeOd5OH8pkvzwyyQYEu83AiMcwzbqLwBdNxoQ0Q17pQw+jnFuPq4EgMrGupI8hwYRVzR9AkQtOABZ0hi9sSDT4VAxQvbcymnCed3MGMi4urnASOXWcHQXgfaxPK2w==',
  }
}
