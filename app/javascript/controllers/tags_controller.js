import { Controller } from "@hotwired/stimulus"
import TomSelect from "tom-select"

// Connects to data-controller="tags"
export default class extends Controller {
  connect() {
    this.tomSelect = new TomSelect(this.element, {
      plugins: ['remove_button'],
      create: true,
      onItemAdd: function(){
        this.setTextboxValue('');
        this.refreshOptions();
      },
      render: {
        option_create: function(data,escape){
          return'<div class="create">Add<strong>' + escape(data.input) + '</strong>&hellip;</div>';
        },
        no_results: function(data,escape){
          return'<div class="no-results">NO results found for "' + escape(data.input) + '"</div>';
        },
      }
    })
  }

  disconnect(){
    if (this.tomSelect) {
      this.tomSelect.destroy()
    }
  }
}
