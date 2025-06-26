Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5690D8632C;
	Thu, 26 Jun 2025 16:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750953904; cv=none; b=OX1nks2DN2MPLsyXRI1jNtWA0uMXlF31bxSo7D/5QuNj+JcxvviKz5Xk00Qj6WRZHYMq1T6cTp/OI5UnZp9JKmRbPF0faTFR9mNiFXBbH5l7raF319waVrO94uAaDmgwXv+RJJ8UIpvnHDZSNZibJ+VMZhpsZGAe2ruF/MLEyFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750953904; c=relaxed/simple;
	bh=9PmHmcHy9eS+jHEx5bX+xBvU5X8RFlCe4CEn2nr7ZM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GefSJVPzTFs9RgwkmXevqdrTIPPB1ipWj70wI7am0iLqA0K4RXygFI1tKtVF9MolVVxofAFEYmrzYl3OkKjnZF4EFesBrlUxq+maB6HMnOa22uWN+yyBTQpk9rn98PBNClHHayPneWNHH6BUOGnrzxtml1C3wXaVcs3EC5112yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yqoftNTm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bxu30B48; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yqoftNTm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bxu30B48"
Date: Thu, 26 Jun 2025 18:04:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750953901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL5oCUpY8O6HsAvUPjtA+7B0CN116b1jmnRtEOT4Bgw=;
	b=yqoftNTmIWO8w20LOgqlPpXchx2n7q6CMc3o1+6zM7cjgOZhwidtRtiQ4/4wCP5gAJeq3m
	XjmBLBn36CwgtCF/9387O8uyHuIMBVIT7zN+VNY1Ey1DkHlbHHxXyQE4GB7+CM+/NfJZwY
	ZgpBnizlTxfUi9osLfBJbw+zkSnFVqM+srVvOPk7GyjMpE7gjdx6iw3YXOo+Qq52TAMA4L
	Z4lMFFSGBN+DIetneD7rn04bv0dRdumQxACmZNbeqafdaM0RiNtJA82eAi69rISH55ipSs
	0D46uhv8rVYBizXdV4SURoerQooSII2oM/BvIhiSiiAhXWMu1sFvhsJ7QVy5zA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750953901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mL5oCUpY8O6HsAvUPjtA+7B0CN116b1jmnRtEOT4Bgw=;
	b=bxu30B48B3rzCsnORaoes91Sd97VtxLtgubqiJmmhfEcqZ+ZtFo8pai2/KOmwJqSOgNwH3
	6MQUCvbDwzpWGzBQ==
From: Nam Cao <namcao@linutronix.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>, john.ogness@linutronix.de
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250626160459.soHxOROG@linutronix.de>
References: <20250626151940.1756398-1-namcao@linutronix.de>
 <20250626113520.315db641@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626113520.315db641@gandalf.local.home>

On Thu, Jun 26, 2025 at 11:35:20AM -0400, Steven Rostedt wrote:
> On Thu, 26 Jun 2025 17:19:40 +0200
> Nam Cao <namcao@linutronix.de> wrote:
> >  static void turn_monitoring_on_with_reset(void)
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 95ae7c4e58357..0dff4298fc0e5 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -936,7 +936,6 @@ int tracing_is_enabled(void)
> >  	 * return the mirror variable of the state of the ring buffer.
> >  	 * It's a little racy, but we don't really care.
> >  	 */
> > -	smp_rmb();
> >  	return !global_trace.buffer_disabled;
> >  }
> >  
> > @@ -1107,8 +1106,6 @@ void tracer_tracing_on(struct trace_array *tr)
> >  	 * important to be fast than accurate.
> >  	 */
> >  	tr->buffer_disabled = 0;
> > -	/* Make the flag seen by readers */
> > -	smp_wmb();
> >  }
> >  
> >  /**
> > @@ -1640,8 +1637,6 @@ void tracer_tracing_off(struct trace_array *tr)
> >  	 * important to be fast than accurate.
> >  	 */
> >  	tr->buffer_disabled = 1;
> > -	/* Make the flag seen by readers */
> > -	smp_wmb();
> >  }
> 
> The above three interact with each other. Without the barriers, the
> tr->buffer_disabled = 0, can be set on one CPU, and the other CPU can think
> the buffer is still enabled and do work that will end up doing nothing. Or
> it can be set to 1, and the other CPU still sees it disabled and will not
> do work when it can.

(I'm not that experienced with memory barrier, so I may be writing nonsense
here)

I think you have it inverted? I assume you meant:

"Without the barriers, the tr->buffer_disabled = 1 can be set on one CPU,
and the other CPU can think the buffer is still enabled and do work that
will end up doing nothing."

Your scenario can still happen despite the memory barrier:

CPU1                          CPU2
                              smp_rb()
                              read buffer_disabled, see 0 --> let's do work!
buffer_disabled=1
smp_wb()
                              do work -> end up doing nothing

From my understanding, smp_wb()'s purpose is ensuring the ordering of one
write and another write, e.g.:
    write(a)
    smp_wb()
    write(b)

For our case, there is only a single write. Therefore I don't think
smp_wb() is useful.

Best regards,
Nam
