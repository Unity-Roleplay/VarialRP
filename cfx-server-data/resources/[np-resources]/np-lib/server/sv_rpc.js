// S Y D R E S
const Functions = new Map(), Promises = new Map(), Resource = GetCurrentResourceName();
let CallIdentifier = 0;

function TriggerCallbackEvent(pSource, pEvent, ...params) {
  const payload = msgpack_pack(params);
  if (payload.length < 5000) {
    TriggerClientEventInternal(pEvent, pSource, payload, payload.length);
  } else {
    TriggerLatentClientEventInternal(pEvent, pSource, payload, payload.length, 128000);
  }
}

function AddEventHandler(pEventName, pFunction) {
  onNet(pEventName, pFunction);
}

function ParamPacker(...params) {
  const pack = [];
  for (let idx = 0; idx < params.length; idx += 1) {
    pack[idx] = {
      param: params[idx]
    };
  }
  return pack;
}

function ParamUnpacker(params) {
  const unpacked = [];
  params.forEach(tbl => unpacked.push(tbl.param));
  return unpacked;
}

async function register(pName, pFunction) {
  Functions.set(pName, pFunction);
}

async function execute(pName, ...params) {
  let src = source
  const callID = CallIdentifier;
  CallIdentifier++;
  const pCall = new Promise((_0x9586c8, _0x2d44d4) => {
    Promises.set(callID, {
      resolve: _0x9586c8,
      reject: _0x2d44d4
    });
  });
  TriggerCallbackEvent('rpc:request', src, Resource, pName, callID, params, false);
  const clearPromise = new Promise(_0xb6b80d => {
    setTimeout(() => {
      if (Promises.has(callID)) {
        Promises["delete"](callID);
      }
      return _0xb6b80d([]);
    }, 20000);
  });
  return await Promise.race([pCall, clearPromise]);
}

function response(pOrigin, pCallId, pResponse, pPacked) {
  if (Resource === pOrigin && Promises.has(pCallId)) {
    if (pPacked) {
      pResponse = ParamUnpacker(pResponse);
    }
    Promises.get(pCallId).resolve(pResponse);
    Promises["delete"](pCallId);
  }
}

async function request(pOrigin, pName, pCallId, params, pPacked) {
  if (!Functions.has(pName)) {
    return;
  }
  const getFunction = Functions.get(pName);
  let response;
  if (pPacked) {
    params = ParamUnpacker(params);
  }
  try {
    response = await getFunction(...params);
  } catch (error) {
    emit('rpc:client:error', Resource, pOrigin, pName, error.message);
  }
  if (typeof response === "undefined") {
    response = [];
  } else {
    if (pPacked) {
      response = ParamPacker(response);
    }
  }
  TriggerCallbackEvent("rpc:response", src, pOrigin, pCallId, response, pPacked);
}

const RPC = {
  register: register,
  execute: execute
};

AddEventHandler('rpc:response', response);
AddEventHandler('rpc:request', request);
