Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F70155CBD;
	Wed, 16 Jul 2025 13:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752673521; cv=none; b=R2UQ2IC39WBK8pv0/gQRBX2zBd8RRK7TBTDngZqLlKwn5es8dungO4+PDWnkFPP3aAcuH4FpE1TiiycxaYKJGK58fkCi1AOwWx6w5kf5hw/JT9b4HqSLNNowIl4PMQEmEqf/CU4tQP0j7jVs1rxKZtp5gfR4qurxeqVndjyDbXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752673521; c=relaxed/simple;
	bh=/fhY2mr9rCtNT+Dc2rIHE1tnqAiex4w1FyQCldl1eVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=enHXFV+zDzPLulKD6TyJA4Td0Y5nG03YQs5flVWFAYQiuQix+r6tqmsZt2osuLfOqTQnRwhtfrews2GvWLjgnpr7DZ6NtNVFAMXX8h2XcyfBfeF3WaIlyYWUmdhgo/37n2u5ZmwSiOtzG2Uh7EODPLxdLIV3hYtpRfezQVBXfHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UOCvjifu; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UOCvjifu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=2hKr4Litf8hrYxMl13Xopyifaathf/LPdXEtZz538Uo=; b=UOCvjifumgz+AJ9QaHKv4h48j0
	/w9uOVUqJ0rv1CXtrTUi8+I7TXZnKinscRf8d6WJXAeNOzpAMy9aUCa3Z1mZUZRJv8r5pTtTrWyTa
	h/QpDyeKNrFJZ5EzwRnoeNjwFi6Uss8Cns82YL2u1sSylN5tfEl8J6T8b+8SAqDeHIfiiNb7Iy+/c
	sIN0QWtADPmaNF9IST2fX8IWR8HY7zljKjs6zR5tfyiUytKZjwjltxczyhfRr9A3uoYpP5I8wIbZi
	P2IYKapXcPpf/H2U76MgWZb9oXl84vIJubE+a/3jBC7azQh/3jQge3Zoek5oh0mo4YS9CSURuu4b4
	75IShtWA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2Re-0000000A6dY-0Ude;
	Wed, 16 Jul 2025 13:45:14 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 422D9300186; Wed, 16 Jul 2025 15:45:13 +0200 (CEST)
Date: Wed, 16 Jul 2025 15:45:13 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>,
	Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,
	Clark Williams <williams@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task model
Message-ID: <20250716134513.GB905792@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-13-gmonaco@redhat.com>
 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
 <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>

On Wed, Jul 16, 2025 at 03:40:13PM +0200, Gabriele Monaco wrote:
> On Wed, 2025-07-16 at 14:38 +0200, Peter Zijlstra wrote:

> > > @@ -6786,6 +6793,7 @@ static void __sched notrace __schedule(int
> > > sched_mode)
> > >  		rq = context_switch(rq, prev, next, &rf);
> > >  	} else {
> > >  		rq_unpin_lock(rq, &rf);
> > > +		trace_sched_switch_vain_tp(preempt, prev,
> > > prev_state);
> > >  		__balance_callbacks(rq);
> > >  		raw_spin_rq_unlock_irq(rq);
> > >  	}
> > 
> > Hurmph... don't you already have this covered by:
> > trace_sched_exit_tp() ?
> > 
> > Specifically, the only case where is_switch := false, is this case.
> 
> Mostly, it may work in some cases, but sched_exit happens with
> interrupt enabled while all types of switches (including the vain ones)
> must occur with interrupt disabled.
> 
> Some assumptions don't stand without this tracepoint, but I guess I
> could adapt monitors to live without this if you believe it's not worth
> adding a new tracepoint there.

I'm not sure I understand the importance of IRQ state when describing
task transitions.

You know both:

 - schedule() invocations for any one task are in-order;
 - schedule() invocations for any one CPU are in-order.


