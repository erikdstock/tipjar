import * as types from '../actions/actionTypes';  
import initialState from './initialState';

export default function catReducer(state = initialState, action) {  
  switch(action.type) {
    case types.LOAD_CATS_SUCCESS:
      return action.cats
    default: 
      return state;
  }
}