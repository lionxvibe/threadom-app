import { Controller } from "stimulus"

export default class extends Controller {

    static targets = [ "editTextArea", "newTextArea", "list", "submitButton", "addErrorMessages" ]

    initialize() {
        this.editedID = "";
        this.newTweet = false;
    }

    disconnect() {
        this.editedID = "";
        this.newTweet = false;
    }


    resize() {
        this.editTextAreaTarget.style.height = (this.editTextAreaTarget.scrollHeight)+"px";
    }

    addResize() {
        this.newTextAreaTarget.style.height = (this.newTextAreaTarget.scrollHeight)+"px";
    }

    save(event) {
        if (!event.target.closest('.tweet-editor') && this.editedID !== "") {
            this.submitButtonTarget.click();
        }
    }

    onEditSuccess(event) {
        let [data, status, xhr] = event.detail;
        document.querySelectorAll('[data-id="'+this.editedID+'"]')[0].innerHTML = xhr.response;
        this.quitEditionMode();
    }

    onEditError(event) {
        let [data, status, xhr] = event.detail;
        alert(xhr.response);
    }

    onAddSuccess(event) {
        let [data, status, xhr] = event.detail;
        this.listTarget.innerHTML += xhr.response;
        this.newTextAreaTarget.value = "";
        this.addErrorMessagesTarget.value = "";
    }

    onAddError(event) {
        let [data, status, xhr] = event.detail;
        alert(xhr.response);
    }

    quitEditionMode() {
        this.editedID = "";
    }

    edit(event) {
        if (this.editedID === "") {
            let url = event.target.getAttribute('data-url');
            fetch(url)
                .then(response => response.text())
                .then(html => {
                    this.editedID = event.target.getAttribute('data-id');
                    event.target.innerHTML = html;
                    this.editTextAreaTarget.focus();
                    this.resize();
                })
        }

    }

    new(event) {
        if (!this.newTweet) {
            let url = event.target.getAttribute('data-url');
            fetch(url)
                .then(response => response.text())
                .then(html => {
                    this.newTweet = true;
                    event.target.innerHTML = html;
                    this.newTextAreaTarget.focus();
                })
        }
    }
}
