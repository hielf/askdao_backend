class Message < ActiveRecord::Base
  belongs_to :user

  state_machine :status, :initial => :'待处理' do
    event :received do
      transition [:'待处理'] => :'已处理'
    end
  end

  def send_query(open_id, key_word)
    href = "http://139.162.101.250/api/spyders/search?openid=#{open_id}&keyword=#{key_word}"
    HTTParty.get URI.encode(href)
  end

  def video_download(ids)
    url = "http://139.162.101.250/api/spyders/download_videos"
    res = HTTParty.post(url,
            :body => { :ids => ids
                     }.to_json,
            :headers => { 'Content-Type' => 'application/json' } )
  end

end
