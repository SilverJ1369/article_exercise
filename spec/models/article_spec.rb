require 'rails_helper'
require 'faker'

RSpec.describe Article, type: :model do
  context 'validation tests' do
    it 'ensures the title is present' do
      article = Article.create(content: Faker::Lorem.paragraphs(number: 1))
      expect(article).to be_invalid
      expect(article.errors[:title]).to include("can't be blank")
    end
    it 'ensures the content is present' do
      article = Article.create(title: 'title')
      expect(article).to be_invalid
      expect(article.errors[:content]).to include("can't be blank")
    end
    it 'ensures the title is at least 5 chars' do
      article = Article.create(title: 'four', content: Faker::Lorem.paragraphs(number: 1))
      expect(article).to be_invalid
      expect(article.errors[:title]).to include('is too short (minimum is 5 characters)')
    end
    it 'ensures the content is at least 50 chars' do
      article = Article.create(title: 'long title', content: "short content")
      expect(article).to be_invalid
      expect(article.errors[:content]).to include('is too short (minimum is 50 characters)')
    end
    it 'ensures the article is valid' do
      article = Article.create(title: 'long title', content: Faker::Lorem.paragraphs(number: 1))
      expect(article).to be_valid
    end
  end
end
