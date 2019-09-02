<?php

namespace App\Http\Controllers;

use App\Message;
use App\User;
use Illuminate\Http\Request;
use Auth;

class MessageController extends Controller
{

    public function __construct()
    {
        $this->middleware('auth');
    }


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
        })
        ->orWhere(function($q) use($id){
            $q->where('from', $id);
            $q->where('to', auth()->user()->id);
        })
        ->with('user')
        ->get();

        return response()->json([
            'message' => $message,
            'user' => $user
        ]);
    }

    
}
