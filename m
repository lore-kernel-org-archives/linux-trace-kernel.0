Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25B014601C;
	Wed, 12 Mar 2025 14:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789811; cv=none; b=Zqtt4Qnzg8M2LgxX+Ke06zMYB16zLaJidmj3VRKHR9ZvI1NFHRqfQRngk8qH+4siUqoJmqXDs2QPCBBprkhrJgoD79xg51cQJEh+OSfnYk2fz1QQIREY76AK0syVysavyrqY6h2Qc+2wkOw+fClg2dqZ61xBKFSsJi5KLrx+IXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789811; c=relaxed/simple;
	bh=GQKAh8R75GVvR8R2whfiTQXIfTseWfrivangFdcK4M0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NwTu9KUZHmrV7EYiBmrsOJTtCP0JUcx3K0CF/8T04+DnwuqEqIt93NHMjTeoIOpeLINPwu9owKVRyb8MiTyht+NUa4zpg4ZDq+FDARvNmatY9qCtvt1Zq2Fn62h+XyT3iEDEeSNfdDDgEKpnp2VrOHTuzaVadTVOx/CBg0Rjt4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nFD/DX7C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TR64dDLe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nFD/DX7C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TR64dDLe"
Date: Wed, 12 Mar 2025 15:29:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741789806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1HiEZwZxKQ6XE42vmoWjv0gE0PlXKvQiI/miQHXoTA=;
	b=nFD/DX7CTZwPBrMpVu8DxnWFVDQLKVgyf5E3fkAlId1EThyeLWmUk62yAy00aWcauR4rhz
	W5WfgYkD71jHT2QB+0eEwcZTwvBKrc3HxCFa5HltgPpLPTOFyKBGH9bwov+jYu0lAiv2St
	W48gMADM9ypEVN0+brxEceezSFrG0eRMbXUpQDhzGVV/yKjP6gDIRAoHQmzWQnWMX3qSkm
	HkgFO/3RRQLBVz9t5+Blt6EIlIm4LK33rKGJEhKKveWGIGEdkkg+MddJrqhcaannu+BX/D
	nusC61IZJG4RMbyLgDJJnP/6vJnSGiR9Q9a4ad2SOQkl+0Hw9IHn2BlUNFlbGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741789806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d1HiEZwZxKQ6XE42vmoWjv0gE0PlXKvQiI/miQHXoTA=;
	b=TR64dDLeaRdUUpf6iny9CEMDld4vHGbE49qPVJTSWrPFioraY539sEUzPKBJVQ/i7eKKTe
	/5g9M8RXywRwOoCw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, john.ogness@linutronix.de,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/10] rv: Add infrastructure for linear temporal logic
 monitor
Message-ID: <20250312142953.HsobQDBG@linutronix.de>
References: <cover.1741708239.git.namcao@linutronix.de>
 <0b03a7d779707c598068d6ec00f3e5a19de336d8.1741708239.git.namcao@linutronix.de>
 <035d1f1a92f15bfa60d2d133131dd8a25b3c78e4.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <035d1f1a92f15bfa60d2d133131dd8a25b3c78e4.camel@redhat.com>

On Wed, Mar 12, 2025 at 07:47:50AM +0100, Gabriele Monaco wrote:
> On Tue, 2025-03-11 at 18:05 +0100, Nam Cao wrote:
> > -/*
> > - * Futher monitor types are expected, so make this a union.
> > - */
> >  union rv_task_monitor {
> > -	struct da_monitor da_mon;
> > +	struct da_monitor	da_mon;
> > +	struct ltl_monitor	ltl_mon;
> >  };
> 
> This adds quite some memory overhead if we have multiple per-task
> monitors (we might in the future) and we don't use this ltl monitors.
> What about keeping it conditionally compiled out?
> You could define the struct only if e.g. CONFIG_RV_LTL_MONITORS is set,
> select it with any LTL monitor via Kconfig, then glue it somehow to
> have it readable.

Good point.

> > diff --git a/tools/verification/ltl2ba/generate.py
> > b/tools/verification/ltl2ba/generate.py
> > new file mode 100755
> > index 000000000000..52d5b3618e64
> > --- /dev/null
> > +++ b/tools/verification/ltl2ba/generate.py
> 
> You may want to rename this script to something more unique, just in
> case one day we decide to make it possible to install this generator on
> the system (like dot2k/dot2c).

Acked. Inspired by the dot2k name, maybe something like ltl2k.

> > + * rv_%%MODEL_NAME%%_get_data - get the custom data of this monitor.
> > + * @mon: the monitor
> > + *
> > + * If this function is used, rv_%%MODEL_NAME%%_init() must have been
> > called with a positive
> > + * data_size.
> > + */
> > +static inline void *rv_%%MODEL_NAME%%_get_data(struct ltl_monitor
> > *mon)
> > +{
> > +	return &mon->data;
> > +}
> 
> Do we need all those functions defined here? We could have them
> generated by the pre-processor just like with DA monitors.
> 
> Having a ltl_monitor.h defining all common utility functions and
> variables (here I'm assuming most are, indeed, common) may save a lot
> of maintenance.

I avoided macros like with DA monitors, they are hard to grep. But your
point on maintenance is true from my experience working on this series..

Pre-processor it is then.

> Also I would rearrange monitors sources a bit differently, like putting
> everything that doesn't need manual intervention (states and atoms
> lists) in the header, remaining functions that may need tracepoint
> wiring or more complex stuff can stay in a single c file, a bit like
> current da monitors.
> 
> I see there seems to be more manual work in the main C file (e.g.
> rtapp_block.c), but I think it would look cleaner if all other code was
> generated by the preprocessor in a common header and all lists/inlined
> functions created by the script stay in a separate header (why not call
> it rtapp_block.h?).
> 
> What do you think?

Sounds better, let me give me a try.

Thanks so much for the suggestions,
Nam
