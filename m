Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A82F85D8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764404; cv=none; b=qtBeKp0FC676J2GnGm84ID0n97LK+ucmYJwFAd4ZU/X2Cg3BygxieSx0ORwDVTw5nwshfMli95xgo6Ai2OMZfeg13Ftq3TAj0DHo1BzlySTxS0tUnwHRcEmXYPxtWRXpll63gtMI7mKh0zN3nvkeUcxYJDzphcjFD2pjM6kkoJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764404; c=relaxed/simple;
	bh=alFmrX2niIpELecY6o6fRXPwmSK4XtsQ3q0IloewM8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uB0s9H9DUYjMLzzo+6tB0zQfLHZryb0gmlCODTNxeM9Reu151xXA9AaNVYGH2r1sVeHtew1WjbuhRORYWUCaXuK0z7STCyybzDPTq3iZiojQiZfk/pUM36tgOw47HI8gNZpqU6Kl7Pt7A+SrBPBXhKuP31bzreInxRpI8XcHcxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 35B5B1D0F36;
	Thu, 17 Jul 2025 15:00:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 7FA682F;
	Thu, 17 Jul 2025 14:59:59 +0000 (UTC)
Date: Thu, 17 Jul 2025 10:59:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Fusheng =?UTF-8?B?SHVhbmc=?=(=?UTF-8?B?6buE5a+M55Sf?=)"
 <Fusheng.Huang@luxshare-ict.com>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>, "GuoJin Dai(
 =?UTF-8?B?5oi05Zu96YeR?=)" <GuoJin.Dai@luxshare-ict.com>,
 "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>
Subject: Re: =?UTF-8?B?44CQZnRyYWNlX2V2ZW50cyBsaXN044CRcmFjZQ==?= between
 trace_event_eval_update and __register_event discuss
Message-ID: <20250717105958.7e8c51b6@batman.local.home>
In-Reply-To: <20250717105007.46ccd18f@batman.local.home>
References: <3c1259275c784bbd9e2f33e1b2d846c1@luxshare-ict.com>
	<20250717105007.46ccd18f@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3d15gykzx8u9wi1thenm6ztt8bp1fw3r
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7FA682F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18C8BNr1UYOgwP0Szi2ne+RV6WNiXVf4Js=
X-HE-Tag: 1752764399-547844
X-HE-Meta: U2FsdGVkX1/NfE07zO0eGc7VSsIPvg0jTv+cQllMlCHeWtR4DI91dQ6Bn+Iv3vh6+dE/cgxOhEJXZ0lQJWX8fULrttM2nkxOL3bsW7vonccvwQN+tqPYVw4EZTqLn10GJ1SQQzMqkiYIVkNnRL4ZApC9pSa1AyAopcY8ylqVkj0x6dLCE98kkgBlN8IOpRzgDQtxuidLMfxUp1hugudFkPmTIPs6XMgDgA0XONG/fi30K/K/U3G8rr1EZIHPHrYTuGQbRURQYPifqguD6Z1ceevARS/318ZgE4wLY7vNGl3CmZuYHH/nXf3/h+RnuVv3/5/RLRyMLX7Ok6qLjdRwDcX5oUyirxugLewGtDCseizSJpNIrfBsPp2Peq5e1BMHpRQqKkIwc1tDGwy2UJOmmw==

On Thu, 17 Jul 2025 10:50:07 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> >       __register_event(inline)
> >                 |...
> >                 |+++down_write(&trace_event_sem);
> >                 |
> >                 |---list_add(&call->list, &ftrace_events);
> >                 |
> >                 |+++down_up(&trace_event_sem);
> >               |...

Yeah, I think this may need to be the patch, as __register_event() also
calls event_init() that eventually takes the semaphore :-p

I think there may need to be other places that need that protection, so
I'll go and see if I can find and add them all.

-- Steve
