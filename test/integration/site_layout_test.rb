require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    get signup_path
    assert_select "title", full_title("Sign up")
  end


  test "layout users link works properly" do
    get users_path
    assert_redirected_to login_url
    follow_redirect!
    assert_template 'new'
    assert_not flash.empty?
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert_redirected_to users_path
    follow_redirect!
    assert_template 'index'
  end

end
