function loadWaInstance(showAssistant, userName) {


    if (!showAssistant && window.WebChatInstance) {
        console.log('destroying')
        window.WebChatInstance.destroySession();
        window.WebChatInstance.destroy();
        return;
    }

    window.watsonAssistantChatOptions = {
        integrationID: "e7c442dd-15f3-4020-b54b-3b1bf6e1864c", // The ID of this integration.
        region: "us-south", // The region your integration is hosted in.
        serviceInstanceID: "33c5b784-0bec-40b7-9de1-3aa20c01dade", // The ID of your service instance.
        onLoad: function (instance) {
            instance.render();
            window.WebChatInstance = instance;
            instance.on({ type: 'pre:send', handler: preSendHandler });

            // https://cloud.ibm.com/docs/watson-assistant?topic=watson-assistant-web-chat-develop-set-context
            function preSendHandler(event) {
                if (event.data.input && event.data.input.text === '') {
                  event.data.context.skills['actions skill'] = event.data.context.skills['actions skill'] || {};
                  event.data.context.skills['actions skill'].skill_variables = event.data.context.skills['actions skill'].skill_variables || {};
                  event.data.context.skills['actions skill'].skill_variables.user_name = userName;
                }
              }
        },
        showLauncher: true, // Hide the web chat launcher, you will open the WebView from your mobile application
        openChatByDefault: false, // When the web chat WebView is opened, the web chat will already be open and ready to go.
        hideCloseButton: false // And the web chat will not show a close button, instead relying on the controls to close the WebView
    };
    setTimeout(function () {
        const t = document.createElement('script');
        t.src = "https://web-chat.global.assistant.watson.appdomain.cloud/versions/" + (window.watsonAssistantChatOptions.clientVersion || 'latest') + "/WatsonAssistantChatEntry.js";
        document.head.appendChild(t);
    });
}

