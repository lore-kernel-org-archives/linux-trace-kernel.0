Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD29267B9F;
	Mon, 19 May 2025 08:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644235; cv=none; b=YnjDiz9N+8DjIC6l+qFEVk7ZYiD4lygn0hn6sSpihSSmI1JREHIpoxXRXvgt1c34BbXZGPRxIfbu9TOATP8CrL4/f0dwIEvxUx9wyj66UzsEellZIkam35JoI2t6vin2kU9GMOX+FIOQMZK29hoaqtmenaxETVSf/uflGNoo44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644235; c=relaxed/simple;
	bh=dqKLQkwE+HSzkETy8HB5QZi8xPZkODyaa/E6EaUD93E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBrzp9kvvxi0/oRjrsLGOU2zIdObs5yzcdh+LsyZV2jWWswzelmVnxMgbZmZhU+goXWoR5YZn2Rn0Mgq6tBzMx9aPzHLJL61chKSB8Grp3xufZwMm76mpHMIC2+mKcoAT5EDf0xsHSrGpvbSGuqxzr4CprOqC0ukVM8Ynv42jKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SpsL6fum; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=27abn4HN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SpsL6fum";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="27abn4HN"
Date: Mon, 19 May 2025 10:43:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747644231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/Yjnite8yXzKtcevUDc34pxEoRJ3ARYULxEcUzo4dQ=;
	b=SpsL6fumkK9laJ6CPBZUwrA6616C7fZazHO7nnH+aySwjC/Gm4F4LGywVHMA1suFrCYU8R
	+Pb1+jUEHEv9+pAnav92ZXRfJH5i8Zd1WV/4MHhu50ChBH39TJxqbPfNHE0IPLOEOEEav2
	rJ2+8zpRzHhWJ2mxLN1UbLbp49l/kpU7/HR9hUPVX4wINagwJEZRR1FBApJ/TocPFKnXf9
	ZgJhNdYlL4GVGtEEHA1+7qDovVQrMxgcOqkFT8/lBTkKHDLWE4tBD78nNGYQ1DiAM3JFsI
	+vta6OZYVu+xU0kPdjp3eYvzxFNEiusKvp9f+i0wCg+xZmitPYFs3A4xZMcK7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747644231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K/Yjnite8yXzKtcevUDc34pxEoRJ3ARYULxEcUzo4dQ=;
	b=27abn4HNkIPeyAkf+cueeqEN5Gv69RRqcxYbQCSZKoE/vHFFzVEMqm896CuDWRAmTWbsdf
	FLciCTvVXbf+ClDw==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>
Subject: Re: [RFC PATCH v2 06/12] sched: Adapt sched tracepoints for RV task
 model
Message-ID: <20250519084349.si1pN7sA@linutronix.de>
References: <20250514084314.57976-1-gmonaco@redhat.com>
 <20250514084314.57976-7-gmonaco@redhat.com>
 <20250519082908.Nak_YDaO@linutronix.de>
 <5385360f8f01a213ec3918dbc341f48339d7b8e5.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5385360f8f01a213ec3918dbc341f48339d7b8e5.camel@redhat.com>

On Mon, May 19, 2025 at 10:41:47AM +0200, Gabriele Monaco wrote:
> On Mon, 2025-05-19 at 10:29 +0200, Nam Cao wrote:
> > On Wed, May 14, 2025 at 10:43:08AM +0200, Gabriele Monaco wrote:
> > >  DECLARE_TRACE_CONDITION(sched_set_state_tp,
> > > -	TP_PROTO(struct task_struct *tsk, int state),
> > > -	TP_ARGS(tsk, state),
> > > +	TP_PROTO(struct task_struct *tsk, int state, bool
> > > from_signal),
> > > +	TP_ARGS(tsk, state, from_signal),
> > >  	TP_CONDITION(!!(tsk->__state) != !!state));
> > 
> > Doesn't this break the build? Because the monitors still use the old
> > signatures?
> > 
> > I understand you adapt the monitor to this new signature in a follow-
> > up
> > patch. But every commits in the series should be buildable, otherwise
> > you
> > break "git bisect".
> > 
> 
> Yeah good point, do you suggest at least fixing signatures in monitors
> inside this commit?

Yes.

> I can keep the other commits to actually fix/adapt monitors but at
> least allow building from here.

 Also yes, I would only change the signature in this commit.

Best regards,
Nam
