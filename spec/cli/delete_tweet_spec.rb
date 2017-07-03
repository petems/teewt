require 'spec_helper'

describe Teewt::CLI do
  include_context 'spec'

  describe 'delete tweet' do
    context 'tweet id exists' do
      context 'tweet id not ours' do
        it 'gives error' do
          VCR.use_cassette 'cli/delete/exists/not_ours' do
            expect($stdin).to receive(:gets).and_return('y')

            cli.options = cli.options.merge(id: 805618539985940483)

            expect{ cli.delete_tweet }.to raise_error(SystemExit).and output(/Error was: You may not delete another user's status./).to_stdout
          end
        end
      end
      context 'tweet is ours and confirm with y' do
        it 'is succesful' do
          VCR.use_cassette 'cli/delete/exists/ours' do
            expect($stdin).to receive(:gets).and_return('y')

            cli.options = cli.options.merge(id: 881964291406090240)

            expect{ cli.delete_tweet }.to output(/Deleted 881964291406090240/).to_stdout
          end
        end
      end
    end
    context 'tweet id doesnt exist' do
      it 'gives error' do
        VCR.use_cassette 'cli/delete/doesnt_exist' do
          cli.options = cli.options.merge(id: 89995618539985940483)

          expect{ cli.delete_tweet }.to raise_error(SystemExit).and output(/Error was: Sorry, that page does not exist/).to_stdout
        end
      end
    end
  end
end

