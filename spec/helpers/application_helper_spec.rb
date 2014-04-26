require 'spec_helper'

describe ApplicationHelper do
  describe '#nav_link_to' do
    it 'should add active class to link if link goes to current page' do
      controller.request.path = '/some/path'

      link_html = helper.nav_link_to 'Some page', '/some/path'
      link_html.should include('class="active"')
    end

    it 'shouldnt add active class to link if it doesnt goe to current page' do
      controller.request.path = '/some/other/path'

      link_html = helper.nav_link_to 'Some page', '/some/path'
      link_html.should_not include('class="active"')
    end

    it 'should preserve other css classes' do
      controller.request.path = '/some/path'

      link_html = helper.nav_link_to 'Some page', '/some/path', class: 'trueclass'
      link_html.should include('active')
      link_html.should include('trueclass')
    end
  end
end