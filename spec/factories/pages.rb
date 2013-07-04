FactoryGirl.define do
  sequence(:slug_uid) { |n| "#{n}"}

  factory :page_translation, :class => Page::Translation do
    locale { I18n.locale }
    content { Faker::HipsterIpsum.paragraphs(3).join(' ') }
    name { Faker::HipsterIpsum.word }
  end

  factory :page do
    translations {[
      FactoryGirl.build(:page_translation, locale: :ru),
      FactoryGirl.build(:page_translation, locale: :en)
    ]}

    slug { "#{name.parameterize}-#{generate(:slug_uid)}" }
  end
end
