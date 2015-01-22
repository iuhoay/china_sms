# encoding: utf-8
require 'spec_helper'

describe "Jianzhou" do
  describe "#to" do
    let(:username) { 'username' }
    let(:password) { 'password' }
    let(:url) { 'http://www.jianzhou.sh.cn/JianzhouSMSWSServer/http/sendBatchMessage' }
    let(:content) { '你的验证码是: 1234 ［JIANZHOU］' }

    subject { ChinaSMS::Service::Jianzhou.to phone, content, username: username, password: password }

    describe 'single phone' do
      let(:phone) { '13928452841' }

      before do
        stub_request(:post, url).
          with(body: { account: username, password: password, destmobile: phone, msgText: content}).
          to_return(body: '1')
      end

      its([:success]) { should eql true }
      its([:code]) { should eql '1' }
      its([:message]) { should eql nil }
    end
  end
end
