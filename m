Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37A74502A;
	Thu, 24 Apr 2025 03:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745466017; cv=none; b=nNY+m4Zh8XZ8jUpNZH/q+6X78mPXLqGGtxCkDcBF0YJi+H66FVVy4ZHf7qR2eT4cQQAmdvLGDERWtQCbkhYbK6WomIkSLu+Emhm3moArPbVYJLbElz9+fkk/NNK1u3F6v4f12WJb035B28DK64E8igyBBGHZ9fFfGQUk0WLHB3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745466017; c=relaxed/simple;
	bh=6icgpZdGcWlboN2DJNnyWWX7QHAnCuuYddJOZ97/UT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PaUpwzRX/cfZyfu6Rp3gdiaTCRc9tm/QqSo8EWLVRjtH3wqXD4ytvi61yQ0i7zk9QvASsiP/UoFjJpGWV7bB7h1XYPikr21szYS+mJulKaf4Blzu2MpQ1SKfdLvBCbHw5tV5/pIRbD8PREj/AW2DmQC2RO0BBkstuSjgTiRndWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ENHorwOV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lALwUOpm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ENHorwOV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lALwUOpm"
Date: Thu, 24 Apr 2025 05:40:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745466012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g7+JExGyxtXs6oqgZqsr3z5pcidzbXH+UNdAKPpxih0=;
	b=ENHorwOVuFtzXolnqH0gz5Hz7j/PKYI19iSUuvCXy3cgWfbeXTjl0SmwwgL48jim0MWAW1
	RrFsfb2AmGaNbdF3Ur46rE7wC4Nc4VUkdnwlck5KrJg6+Ab++lnDSBNEbqtl2a/HgVyFpS
	OZvHED18afY0nvZSvO1XE2bqPXJ4YXZQ5QZRS/Eaxy2+HMrV+7foLcW4RljNcT37iHxgLt
	3nq+FkXA2DqzCC+r1G4leXONRtpdXVsZQnwUfy47/m5aSbLh05dWYl7gS4D2mqpETqw3Pw
	9yrZRU2tiOcCW0ufqxqEfDpjsF4YvUQ/mHeUJH21CeIX4notzlyP2/kWmYCkXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745466012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g7+JExGyxtXs6oqgZqsr3z5pcidzbXH+UNdAKPpxih0=;
	b=lALwUOpmLRzG0tfkMzHA3n99cfXduD6H4WV/ZU8Or/Z0qj07tVHVX4EfbX9m13hag9l5Qj
	CDpOpkoeX0BvQCBg==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de
Subject: Re: [PATCH v4 19/22] rv: Add rtapp_pagefault monitor
Message-ID: <20250424034005.B71HTlCE@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
 <2eff7190ba245eb157f95ae461fef54183d07665.1745390829.git.namcao@linutronix.de>
 <02f047788f369cd0387d2934fa99fe3e8e1913c2.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02f047788f369cd0387d2934fa99fe3e8e1913c2.camel@redhat.com>

On Wed, Apr 23, 2025 at 12:37:53PM +0200, Gabriele Monaco wrote:
> On Wed, 2025-04-23 at 08:50 +0200, Nam Cao wrote:
> > +static void ltl_atoms_fetch(struct task_struct *task, struct
> > ltl_monitor *mon)
> > +{
> > +	ltl_atom_set(mon, LTL_RT, rt_or_dl_task(task));
> > +}
> 
> Mmh, you probably already considered that, so ignore my comment in that case.
> 
> I just realised this function would tell you a PI boosted task is an RT task,
> is that acceptable in your model?

Yes, that is intentional. A task being PI boosted means an "actual"
real-time task is waiting for it. Therefore the PI boosted task shouldn't
be delayed, otherwise the "actual" real-time task is delayed.

> It's probably a configuration mistake on its own if an RT task following those
> rules shares resources with non-RT tasks not following them,

non-RT tasks do not have to follow the rules all the time. But while
accessing resources shared with RT tasks, then yes the rules should be
obeyed.

> but if that's something allowed, you may see this atom change more often
> than you'd like, not sure if that can be something worth noting.
>
> Perhaps you could add a comment saying that this is not a problem and why (e.g.
> instead of using rt_or_dl_task_policy for the job).

Sure, a comment doesn't hurt.

> What do you think?
> 
> Besides this detail, the monitor looks good to me
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Thanks so much for the review!

Nam
