import {combineReducers} from 'redux';  
import cats from './exampleReducer';

const rootReducer = combineReducers({  
  // short hand property names
  cats
})

export default rootReducer;
