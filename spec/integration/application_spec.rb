require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  before(:each) do
    reset_albums_table
    reset_artists_table
  end

  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context 'GET /albums' do
    it 'should return the list of albums' do
      response = get('/albums')

      # <br />
  
      expect(response.status).to eq(200)
      expect(response.body).to include('<a href="/albums/2">Surfer Rosa</a><br />')
      expect(response.body).to include('<a href="/albums/3">Waterloo</a><br />')
      expect(response.body).to include('<a href="/albums/4">Super Trouper</a><br />')
      expect(response.body).to include('<a href="/albums/5">Bossanova</a><br />')
      end
    end

  context 'GET /albums/id' do
    it 'should return info about album 1' do
      response = get ('/albums/1')

      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Doolittle</h1>')
      expect(response.body).to include('Release year: 1989')
      expect(response.body).to include('Artist: Pixies')
    end
  end


    context 'POST /albums' do
      it 'should create a new album' do
        response = post(
          '/albums',
          title: 'Voyage',
          release_year: '2002',
          artist_id: '2'
          )

        expect(response.status).to eq(200)
        expect(response.body).to eq('')

        response = get('/albums')

        expect(response.body).to include('Voyage')
      end
    end

    context 'GET /artists' do
      it 'should return the list of artists' do
        response = get('/artists')
    
        expect(response.status).to eq(200)
        expect(response.body).to include('<a href="/artists/1">Pixies</a><br />')
        expect(response.body).to include('<a href="/artists/2">ABBA</a><br />')
        expect(response.body).to include('<a href="/artists/3">Taylor Swift</a><br />')
        expect(response.body).to include('<a href="/artists/4">Nina Simone</a><br />')
        end
      end

    context 'GET /artists/id' do
      it 'should return info about first artist' do
        response = get ('/artists/1')
  
        expect(response.status).to eq(200)
        expect(response.body).to include('<h1>Pixies</h1>')
        expect(response.body).to include('Genre: Rock')
      end
    end

    context 'GET /artists' do
      it 'should return the list of artists' do
        response = get('/artists')

        expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone'

        expect(response.status).to eq(200)
        expect(response.body).to eq(expected_response)
      end
    end

    context 'POST /artists' do
      it 'should create a new artist' do
        response = post(
          '/artists',
          name: 'Wild nothing',
          genre: 'Indie'
          )

        expect(response.status).to eq(200)
        expect(response.body).to eq('')

        response = get('/artists')

        expect(response.body).to include('Wild nothing')
      end
    end
end
