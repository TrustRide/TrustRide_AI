
import { cn } from "@/lib/utils";
import { Avatar, AvatarFallback, AvatarImage } from "@/components/ui/avatar";
import { BotIcon, User } from "lucide-react";

interface ChatMessageProps {
  message: string;
  isBot?: boolean;
  timestamp?: string;
}

export const ChatMessage = ({ message, isBot = false, timestamp }: ChatMessageProps) => {
  return (
    <div
      className={cn(
        "flex w-full mb-4 animate-fade-in",
        isBot ? "justify-start" : "justify-end"
      )}
    >
      {isBot && (
        <Avatar className="h-8 w-8 mr-2 mt-1">
          <AvatarFallback className="bg-chatbot-primary text-white">
            <BotIcon className="h-4 w-4" />
          </AvatarFallback>
        </Avatar>
      )}
      <div className="flex flex-col max-w-[80%]">
        <div
          className={cn(
            "px-4 py-3 rounded-2xl",
            isBot 
              ? "bg-chatbot-bot text-gray-800 rounded-tl-none" 
              : "bg-chatbot-user text-gray-800 rounded-tr-none"
          )}
        >
          {message}
        </div>
        {timestamp && (
          <span className="text-xs text-gray-500 mt-1 px-1">
            {timestamp}
          </span>
        )}
      </div>
      {!isBot && (
        <Avatar className="h-8 w-8 ml-2 mt-1">
          <AvatarFallback className="bg-gray-400 text-white">
            <User className="h-4 w-4" />
          </AvatarFallback>
        </Avatar>
      )}
    </div>
  );
};
