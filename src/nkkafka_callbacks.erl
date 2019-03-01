%% -------------------------------------------------------------------
%%
%% Copyright (c) 2019 Carlos Gonzalez Florido.  All Rights Reserved.
%%
%% This file is provided to you under the Apache License,
%% Version 2.0 (the "License"); you may not use this file
%% except in compliance with the License.  You may obtain
%% a copy of the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing,
%% software distributed under the License is distributed on an
%% "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
%% KIND, either express or implied.  See the License for the
%% specific language governing permissions and limitations
%% under the License.
%%
%% -------------------------------------------------------------------

%% @doc NkKAFKA callbacks

-module(nkkafka_callbacks).
-author('Carlos Gonzalez <carlosj.gf@gmail.com>').

-export([kafka_message/6]).
-export([srv_master_init/2, srv_master_handle_call/4,
         srv_master_handle_info/3, srv_master_timed_check/3]).


%% ===================================================================
%% Types
%% ===================================================================



%% ===================================================================
%% Offered callbacks
%% ===================================================================

%% @doc Called when a new message is received in a processor
%% This function is blocking for the partition
-spec kafka_message(Topic::binary(), Partition::integer(), Key::binary(),
                    Offset::integer(), TS::nklib_date:epoch(msecs), binary()) ->
    ok.

kafka_message(Topic, Partition, Key, Offset, TS, Value) ->
    lager:warning("Unhandled Kafka message ~s:~p ~s (~p, ~p): ~p",
                  [Topic, Partition, Key, Offset, TS, Value]),
    ok.




%% ===================================================================
%% Implemented callbacks
%% ===================================================================


%% @doc
srv_master_init(SrvId, State) ->
    nkkafka_master:init(SrvId, State).


srv_master_handle_call(Msg, From, SrvId, State) ->
    nkkafka_master:handle_call(Msg, From, SrvId, State).


srv_master_handle_info(Msg, SrvId, State) ->
    nkkafka_master:handle_info(Msg, SrvId, State).


%% @doc
srv_master_timed_check(IsLeader, SrvId, State) ->
    nkkafka_master:timed_check(IsLeader, SrvId, State).

