Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155BC26AD9;
	Fri, 11 Apr 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744380926; cv=none; b=kggN3Ni/HaK3VtAbliVPQwc3bcOIOXb91HQQxzfQJwDefhqoCpjK9R4z3jqTWC+mDzOudICNiHi/3WokaKDFe0yiExF8/L7yr2s4TY243v1nQrYh2cvpFKwIEDSsDL0iUschzyE2lRaSDaI+J6e6cKF0t8St4VPid9UM0i/7OQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744380926; c=relaxed/simple;
	bh=yKn+5SF3Dpgrv0+A7PseJ1UZlNnllcUAY/s/idgnMtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dchv2nheNO8hRHxCoyVnuOG+UUS+9o3AeJLYddLvQzShfBEhiNlCaoN2vBBgEdTpI354YXRs8VEbAjoS2uHAUBNzQjT4v6XP7OlEExvDca8+bfQ7chuIkFEOGIJJoZ7fWEr/mQJ8MWPv7mpjMpxGZpmRczUXi4H+rJOnZdpgd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vgbJMh/l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ixnTbgW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vgbJMh/l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ixnTbgW"
Date: Fri, 11 Apr 2025 16:15:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744380923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxO+YChvuje2MP0BYtkRHXq4kPQhbbBFk2Mh1TGHe2Q=;
	b=vgbJMh/lwXQuVgee5QjyEPZ5BWev+nDayzQ7/OyZz0sU/gVEU2VLKWnyfGExek2aZwf1Yi
	0p7GrX3otiSwLlvp+MbQKCHYKAwmjI/CW5ms8eGrriuoZO7Lm3hpiq4HEF85QTe/UCBSKd
	T8boPsW/li5t3WtjU3rnD1yLaU30+uG1XnlUjaGcXQi55ug1vZgPLiNaUVtoVjTA5FmMRL
	zPmzUR+s0kCW/PpTEfw7t8grlnxTxUn/9aFi+Vaupkv4apisCu2QxwfQqjN9FRp3H9JDiz
	FFRHPdlurY48EDX3OWl6/p8aJFmsriY52rDJ5m2rP6IZ0E2LMODW1MYesCyiIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744380923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hxO+YChvuje2MP0BYtkRHXq4kPQhbbBFk2Mh1TGHe2Q=;
	b=4ixnTbgWR0rqxsqOKcMXOg9Rzl/maCEmIWgKmxq8UgS94eODhcoDnvZRfSYuG+Bk3DTx8J
	L/KhU0XKtaye2QCQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v2 13/22] rv: Add support for LTL monitors
Message-ID: <20250411141521.eCdcbw70@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
 <5dbd62940b252ee49777e9c4298eadd644bf6526.1744355018.git.namcao@linutronix.de>
 <ce9ef5e41c17953010bd31d19e7d2840cd533066.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce9ef5e41c17953010bd31d19e7d2840cd533066.camel@redhat.com>

On Fri, Apr 11, 2025 at 01:17:30PM +0200, Gabriele Monaco wrote:
> On Fri, 2025-04-11 at 09:37 +0200, Nam Cao wrote:
> > +struct ltl_monitor {
> > +#ifdef CONFIG_RV_LTL_MONITOR
> > +	DECLARE_BITMAP(states, RV_MAX_BA_STATES);
> > +	DECLARE_BITMAP(atoms, RV_MAX_LTL_ATOM);
> > +	DECLARE_BITMAP(unknown_atoms, RV_MAX_LTL_ATOM);
> > +#endif
> > +};
> 
> Mmh, we have a lot of those ifdefs in quite inappropriate places, but I
> think we can do better than this.
> 
> What about something like:
> 
> #ifdef CONFIG_RV_LTL_MONITOR
> 
> struct ltl_monitor {
> 	DECLARE_BITMAP(states, RV_MAX_BA_STATES);
> 	DECLARE_BITMAP(atoms, RV_MAX_LTL_ATOM);
> 	DECLARE_BITMAP(unknown_atoms, RV_MAX_LTL_ATOM);
> };
> 
> static inline bool rv_ltl_valid_state(struct ltl_monitor *mon)
> {
> 	...
> }
> 
> static inline bool rv_ltl_all_atoms_known(struct ltl_monitor *mon)
> {
> 	...
> }
> 
> #else
> 
> /*
>  * Leave the struct empty not to use up space
>  * In a later patch we could do the same for DAs..
>  */
> struct ltl_monitor { };
> 
> #endif

I have no preference for either, so sure!

> > diff --git a/include/rv/ltl_monitor.h b/include/rv/ltl_monitor.h
> > new file mode 100644
> > index 000000000000..78f5a1197665
> > --- /dev/null
> > +++ b/include/rv/ltl_monitor.h
> 
> You hate macros don't you? :)

YES!

> Anyway I really like your approach, very neat.

Thank you! I'm very happy to have found a way to escape the macros.

> > +static struct ltl_monitor *ltl_get_monitor(struct task_struct *task)
> > +{
> > +	return &task->rv[ltl_monitor_slot].ltl_mon;
> > +}
> 
> This means ltl monitors only support per-task, right?

Yes.

> It shouldn't take much effort putting an ifdef chain here and defining e.g.
> PER_CPU in the header file to choose a different get_monitor.
> Or directly an ltl_monitor_implicit.h

Yes, either can work.

> I think this patch is ready without it, just trying to brainstorm how we could
> potentially extend this.
> 
> I need more time to play with these, but it looks promising.

Thank you,
Nam
