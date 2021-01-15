require_relative '../../../../spec_helper'

describe 'govuk::app::envvar::redis', :type => :define do
  let(:title) { 'giraffe' }

  context 'with empty parameters' do
    let(:params) { {} }

    it 'sets the Redis host to 127.0.0.1 by default' do
      is_expected.to contain_govuk__app__envvar("#{title}-redis_host")
                       .with_app(title)
                       .with_varname('REDIS_HOST')
                       .with_value('127.0.0.1')
    end

    it 'sets the Redis port to 6379 by default' do
      is_expected.to contain_govuk__app__envvar("#{title}-redis_port")
                       .with_app(title)
                       .with_varname('REDIS_PORT')
                       .with_value('6379')
    end

    it 'sets a Redis URL with the default values' do
      is_expected.to contain_govuk__app__envvar("#{title}-redis_url")
                       .with_app(title)
                       .with_varname('REDIS_URL')
                       .with_value('redis://127.0.0.1:6379')
    end
  end

  context 'with some good parameters' do
    let(:host) { 'redis.backend' }
    let(:port) { '1234' }
    let(:params) { { host: host, port: port } }

    it 'sets the Redis host' do
      is_expected.to contain_govuk__app__envvar("#{title}-redis_host")
                       .with_app(title)
                       .with_varname('REDIS_HOST')
                       .with_value(host)
    end

    it 'sets the Redis port' do
      is_expected.to contain_govuk__app__envvar("#{title}-redis_port")
                       .with_app(title)
                       .with_varname('REDIS_PORT')
                       .with_value(port)
    end

    it 'sets a Redis URL' do
      is_expected.to contain_govuk__app__envvar("#{title}-redis_url")
                       .with_app(title)
                       .with_varname('REDIS_URL')
                       .with_value('redis://redis.backend:1234')
    end
  end

  context 'with a specific app' do
    let(:app) { 'enclosure' }
    let(:params) { { app: app } }

    it 'uses that app when setting the host variable' do
      is_expected.to contain_govuk__app__envvar("#{title}-redis_host")
                       .with_app(app)
    end

    it 'uses that app when setting the port variable' do
      is_expected.to contain_govuk__app__envvar("#{title}-redis_port")
                       .with_app(app)
    end

    it 'uses that app when setting the url variable' do
      is_expected.to contain_govuk__app__envvar("#{title}-redis_url")
                       .with_app(app)
    end
  end

  context 'white a prefix' do
    let(:params) { { prefix: 'zoo' } }

    it 'adds a prefix to the host variable' do
      is_expected.to contain_govuk__app__envvar("#{title}-zoo_redis_host")
                       .with_app(title)
                       .with_varname('ZOO_REDIS_HOST')
    end

    it 'adds a prefix to the port variable' do
      is_expected.to contain_govuk__app__envvar("#{title}-zoo_redis_port")
                       .with_app(title)
                       .with_varname('ZOO_REDIS_PORT')
    end

    it 'adds a prefix to the url variable' do
      is_expected.to contain_govuk__app__envvar("#{title}-zoo_redis_url")
                       .with_app(title)
                       .with_varname('ZOO_REDIS_URL')
    end
  end
end
