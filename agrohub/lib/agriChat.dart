import 'package:agrohub/const/ColorWillBe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AgriChat extends StatefulWidget {
  @override
  _AgriChatState createState() => _AgriChatState();
}

class _AgriChatState extends State<AgriChat> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> chatHistory = [];
  bool loading = false;

  // Fetch the API Key using String.fromEnvironment
  final String apiKey = const String.fromEnvironment('API_KEY');

  // Function to get a response from the Gemini API
  Future<String> _getBotResponse(String userInput) async {
    // Create the GenerativeModel instance for Gemini
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
    );

    try {
      // Send the user's input to the API and get a response
      final response = await model.generateContent([Content.text(userInput)]);

      // Return the generated response from Gemini
      return response.text ?? 'No response from Gemini';
    } catch (error) {
      // Handle any errors that occur during the API request
      return 'Error: $error';
    }
  }

  // Function to handle sending a message
  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    String userMessage = _controller.text;
    setState(() {
      chatHistory.add({'role': 'user', 'message': userMessage});
      loading = true;
    });

    _controller.clear();

    // Get bot response
    String botMessage = await _getBotResponse(userMessage);
    setState(() {
      chatHistory.add({'role': 'bot', 'message': botMessage});
      loading = false;
    });
  }

  // Function to refresh the chat
  void _refreshChat() {
    setState(() {
      chatHistory.clear();
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(50.h), // Set the desired height for the AppBar
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            bottomRight: Radius.circular(15.r),
          ),
          child: AppBar(
            backgroundColor: colorWillBe.secondaryColor,
            toolbarHeight: 50.h, // Adjust the height of the toolbar here
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            title: const Text('AgroBot'),
            titleTextStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: colorWillBe.whiteColor,
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: chatHistory.isEmpty
                ? _buildIntroMessage()
                : _buildChatHistory(),
          ),
          if (loading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          _buildInputField(),
        ],
      ),
    );
  }

  // Introduction message when there is no chat history
  Widget _buildIntroMessage() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            'https://i.ibb.co.com/R2r65jS/Chat-Bot-Avatar-bg-less.png',
            height: 150,
          ),
          const Text(
            "Hello! I'm AgroBot",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              "This is an Agriculture Chatbot designed to assist farmers with valuable information. Feel free to ask questions related to agriculture!",
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  // Builds the chat history
  Widget _buildChatHistory() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: chatHistory.length,
      itemBuilder: (context, index) {
        final message = chatHistory[index];
        final bool isUserMessage = message['role'] == 'user';
        return Align(
          alignment:
              isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isUserMessage ? Colors.blue : Colors.green,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(
              message['message']!,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  // Input field for sending messages
  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Ask about agriculture...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send_rounded),
            color: Colors.green,
            onPressed: _sendMessage,
          ),
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            color: Colors.grey,
            onPressed: _refreshChat,
          ),
        ],
      ),
    );
  }
}
