Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF971DF271;
	Wed, 16 Jul 2025 14:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675607; cv=none; b=lYAILjcbB7tBbF2yR4W+WPqCccf5FdINI0IrO4f91h7onQb32zmNZzi++LLBbqAPW2hmq9AWiyo2sE70vxtVy6csRrhKzABFvURX9RKH0xQKeIcc0CC8V+PwWoTHANVmYhGkCMzy70Gzp4nkkBQqxvY+Ftk0KCS7V+HeaZRscLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675607; c=relaxed/simple;
	bh=OvZ5BErKCdmwnkDV5xV0U+j804OKL6bizCUeSoxqRuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7y/BHQNsha/dROr0fkf9jvHFSMY1ptgKUvXFiSdcZL+wYDsYmPtX7h7w42Ad3ynQGizfNUuUs57zxDFBaG26KfD83s407V0HnIVcQ92poxjH9xmqLK6kJGhdNK1XM6IjhtkAPoNiR0QglU55sai0Ww/ASAHFZkMiXrAUVIsnjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IFeHH611; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IFeHH611"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=3jOeFTRphQghqc9Eu7aDKK1LbzjamOXDIc4YXPM/jjw=; b=IFeHH611ymNyrNEv/Kod7/BNUV
	cwLY9DjJcPX9lHqfV3tCnNSPnRkX5H/ynJ82KFLx83xwddflBHSGsBbUIVkrAB98Dvyxl5xmUJuq9
	rzZl53jpGrc4t5Xuhmz6Qz6wPhTA0qGfYSEg3HqPSw8lXgo1Jgybw5pzuI0csIJEYa+ibY0AiyK6C
	XEIaOS81yH/yiXf3UlkplX+zU8/sa4q6kwP4o314EIfc8JVj1iDyrQs7aRZl293gVomni9gMsJeV8
	bIIlchOmvkMP6POWUffWmCMogoBc/B+P/Z0xjH49vtj9ek8wpIUNIS1OaLH+pTA7rMG1SX9ZbmvMH
	ZtIzfChQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc2zH-0000000A6nk-3xjA;
	Wed, 16 Jul 2025 14:20:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 01C38300186; Wed, 16 Jul 2025 16:19:59 +0200 (CEST)
Date: Wed, 16 Jul 2025 16:19:58 +0200
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
Message-ID: <20250716141958.GC905792@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
 <20250715071434.22508-13-gmonaco@redhat.com>
 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
 <122cfd4ba6b0805e91ff09526d5d159ff3871964.camel@redhat.com>
 <20250716134513.GB905792@noisy.programming.kicks-ass.net>
 <fe38ba0b9da0209bcc97c2f348f5a6b266991073.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fe38ba0b9da0209bcc97c2f348f5a6b266991073.camel@redhat.com>

On Wed, Jul 16, 2025 at 04:07:16PM +0200, Gabriele Monaco wrote:
> On Wed, 2025-07-16 at 15:45 +0200, Peter Zijlstra wrote:
> > 
> > I'm not sure I understand the importance of IRQ state when describing
> > task transitions.
> > 
> > You know both:
> > 
> >  - schedule() invocations for any one task are in-order;
> >  - schedule() invocations for any one CPU are in-order.
> > 
> 
> It's to describe latencies, which is the original purpose of the
> scheduler model: if the event supposed to wake up an RT task occurs
> with interrupts disabled while scheduling, we'd need to wait for that
> run to complete.
> Now to be fair, it doesn't really matter whether that call to
> __schedule switches or not, but always having a switch event simplifies
> things while modelling.

So in general I'm a minimalist; less is more etc. 

Even if you care about latencies, I don't see what that tracepoint
adds. In fact, I don't even see the point of the .is_switch argument to
trace_sched_exit_tp(). That state can be fully reconstructed from having
seen trace_sched_switch() between trace_sched_{enter,exit}_tp().

As for the IRQ state, if you see:

 trace_sched_enter_tp();
 trace_irq_disable();
 trace_irq_enable();

You already know all you need to know; there was no switch, otherwise it
would'be been:

 trace_sched_enter_tp();
 trace_irq_disable();
 trace_sched_switch();
 trace_irq_enable();

Also, can we get rid of that CALLER_ADDR0 argument as well?
