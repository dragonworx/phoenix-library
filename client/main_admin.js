import React from 'react';
import App from './common/app';
import MemberApp from './member/memberApp';
// import { user } from './member/session';

App.render(() => <MemberApp isSuper={true} isAdmin={true} isDesigner={true} />);