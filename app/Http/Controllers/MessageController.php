<?php

namespace App\Http\Controllers;

use App\Message;
use App\User;
use Illuminate\Http\Request;
use Auth;
use App\Events\MessageSend;

class MessageController extends Controller
{

    

    public function user_list()
    {
        $user = Auth::user();
        $user_list = User::orderBy('id', 'DESC')->where('id', '!=', $user->id)->get();

        if (\Request::ajax()) {
            return response()->json($user_list, 200);
        }
        return abort(404);
        
    }


    public function user_message($id=null)
    {
        $user = User::find($id);

        $message = Message::where(function($q) use($id){
            $q->where('from', auth()->user()->id);
            $q->where('to', $id);
            $q->where('type', 0);
        })
        ->orWhere(function($q) use($id){
            $q->where('from', $id);
            $q->where('to', auth()->user()->id);
            $q->where('type', 1);
        })
        ->with('user')
        ->get();

    if (\Request::ajax()) {
        return response()->json([
            'message' => $message,
            'user' => $user
        ]);
    }

    return abort(404);

    }

    public function send_message(Request $request)
    {
        if ($request->ajax()) {

             $message = Message::create([
            'message' => $request->message,
            'from' => auth()->user()->id,
            'to' => $request->user_id,
            'type' => 0
        ]);

        $message = Message::create([
            'message' => $request->message,
            'from' => auth()->user()->id,
            'to' => $request->user_id,
            'type' => 1
        ]);

       /* broadcast(new MessageSend($message));*/

        return response()->json($message, 201);
            
        }

        else{
            return abort(404);
        }

        
       
       
          
    }
        

    
}
