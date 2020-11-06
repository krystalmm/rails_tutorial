module UsersHelper
  # 引数で与えられたユーザーのGravatar画像を返す
  # GravatarのURLはユーザーのメアドをＭＤ５という仕組みでハッシュ化しているので、Digestライブラリのhexdigestメソッドを使うとMD5のハッシュ化が実現できる！
  def gravatar_for(user)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
