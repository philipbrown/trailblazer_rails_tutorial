require "test_helper"

class UserCreateTest < ActiveSupport::TestCase
  test "require presence of email and password" do
    res, op = User::Create.run(user: {})

    assert_not(res)
    assert_includes(op.errors[:email],    "can't be blank")
    assert_includes(op.errors[:password], "can't be blank")
  end

  test "require valid email" do
    res, op = User::Create.run(user: {email: "invalid email"})

    assert_not(res)
    assert_includes(op.errors[:email], "is invalid")
  end

  test "require unique email" do
    User::Create.(user: {email: "name@domain.com", password: "password"})

    res, op = User::Create.run(user: {email: "name@domain.com", password: "password"})

    assert_not(res)
    assert_includes(op.errors[:email], "has already been taken")
  end

  test "create user" do
    res, op = User::Create.run(user: {email: "name@domain.com", password: "password"})

    assert(res)
    assert_instance_of(User, op.model)
  end
end
