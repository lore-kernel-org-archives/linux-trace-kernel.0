Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247721E990E;
	Fri,  1 Aug 2025 06:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754029575; cv=none; b=qmDVr2diELilavN85Lijamu9NHfomiIJmIkYmdDFX0VJSTlu002FDZfLvAjGw5tm34rMb32+1wVo2iSwZomNtaf2vGRxd6syIWKD6jWgTCamuto9wfm4kUkBJap/kgMzZzAkxgphcz+ycll4hogaiX2VZDKhB1Itt85Yn5BT/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754029575; c=relaxed/simple;
	bh=Iyuos2WuMUuHbuCKML4q7MLBu7sUFymL6NohcPoiDeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfD8VJnwS9PXfiAqaqYSaPWRDB3iJHsdoQQiAwnYZ6G7GZRsrckbRljVcPMqBUy+SKUPCU9kdrwutzqh8/o/NMrR4jUilBrnWn3MYeyidZrHOR4njX714oatQJMyYNgooJii00dwsGFtGgJObT1IA//VssAs2ZQRbEWeCLIWFt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XqxOq+ZH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BsOa2VH2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XqxOq+ZH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BsOa2VH2"
Date: Fri, 1 Aug 2025 08:26:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754029565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hv4ZCOwdnfJ/J4InRvz3xUjn19Zuy/e34BlQyBxdsyA=;
	b=XqxOq+ZHQeuO09wR4/5YFQQ9lFc2XKiXcOlPHJ+NLPJtrO2bSn2J9wRdmE/x76eV51tUYQ
	xZ18f5W+d3WgQUg8BTgJFwICf154gmczm4pfeustRMP1cM8VPeL47TKr4CXnf29toKZtz8
	RjVOhmXAyi3EV40FcO7X9KbYD6DwGdKSj2NPPCpyLehVc8D7KWsz+0AFrYmxzf930IbhiR
	1YJHycZcGe1t+guDcPxYfZblU4mVz5Aaz/1ouRtXSUEQH6wW1bt67Ew7DC5F6JMFBAf58y
	YbrQO856mhB4CfUnTkShkopvLTFA5awnP4W1ghVcZfZmujWLr5grcYY0sQ/+eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754029565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Hv4ZCOwdnfJ/J4InRvz3xUjn19Zuy/e34BlQyBxdsyA=;
	b=BsOa2VH2SGayPn7tLXVzDtxAJJiecj3v8TSSnrrXn2IK33nEbpQur8YrcVmItF+GQ4vCQP
	L794yl5VBjezxQDQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] rv/ltl: Support per-cpu monitors
Message-ID: <20250801062602.u-m4BDbt@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
 <da946aaf40a8d1a320dc62673013ceceef1c93b3.1753879295.git.namcao@linutronix.de>
 <0fb442dc58bd36345b60f4bb8f6be73db74900ac.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0fb442dc58bd36345b60f4bb8f6be73db74900ac.camel@redhat.com>

On Thu, Jul 31, 2025 at 10:02:19AM +0200, Gabriele Monaco wrote:
> You don't really need to follow to the ID/IMPLICIT convention here.
> 
> These LTL per-cpu monitors are, in fact, not implicit since they do
> have an id (the CPU), implicit makes sense with the current
> implementation of da_get_monitor that uses the current CPU (doesn't
> have to stay that way, but there was no need to change so far).
> 
> If you don't want to get rid of the task's comm in the tracepoint (and
> unify both with an integer id, like with DA), I'd suggest you use
> different names like CONFIG_LTL_MON_EVENTS_TASK (in fact that doesn't
> just have an ID) and CONFIG_LTL_MON_EVENTS_CPU (or even
> CONFIG_LTL_MON_EVENTS_ID, for this it actually makes sense).
> 
> I'd prefer it as general as possible to ease new monitor types, but to
> be real picky the LTLs per-task are not ID and the per-cpu are not
> IMPLICIT.
> 
> The id field is what the rv userspace tool uses to differentiate
> monitor types, by the way.

Ah, these names didn't make sense to me. But DA use them, so I was
"whatever".

Thanks for the explanation, let's use the _CPU names instead.

> > +#endif /* CONFIG_LTL_MON_EVENTS_IMPLICIT */
> > +
> >  #endif /* CONFIG_LTL_MON_EVENTS_ID */
> 
> Also, I'm not sure if that was intended, but
> CONFIG_LTL_MON_EVENTS_IMPLICIT gets compiled only with
> CONFIG_LTL_MON_EVENTS_ID.

That was certainly not intended.

Nam
