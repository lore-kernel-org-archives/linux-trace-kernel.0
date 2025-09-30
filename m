Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1E8155C82;
	Tue, 30 Sep 2025 15:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759246635; cv=none; b=CjIMHKrU/3xMz4seT5sjRII16kSeBgxoJBzJBRmHWi28lqlgVAsSFotO3Mm9fWc22t8IWk/SWBhz0tc84WIuLkNFfcSmBBGFlj1tWG2MssAGjcSL3svTP/LJeAqNPbYRvDena3nW1TVsmInh/eZ0VaM1p58kmE3ieY+m0M6j/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759246635; c=relaxed/simple;
	bh=5DuPgpFSR3GAaGmfZh+tB5vtmwFDS1xeVJTwvCEB07g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oQlPI7V4LOzpQaePz0EBWHy9O+TfCpiGyRtqdXkQeIPQpHKRT4V9p3pql6DMbJJ4Mddz9aoY8DWXLaevBy0NDKfFxcIF0j+brGV9BLQi6RC3SzRbPdoUYkhW5buS3Su23bCQHGPNhUSXMBL5DUh/w2WM5V6SjE5l28/dqBKn1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5uJtS84; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5uJtS84"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BD7C4CEF0;
	Tue, 30 Sep 2025 15:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759246633;
	bh=5DuPgpFSR3GAaGmfZh+tB5vtmwFDS1xeVJTwvCEB07g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B5uJtS84NykHnYCJNaUW1fXs55P1U2DN1k8p3BjH/PGHPfOJP8mvIpFjPsvm7kckJ
	 hdxkoiY3pzv56L765SeHGvFXskjyrPQ/kIJZhesmtNWoAvOKAvX545dBlrWt16KEsF
	 N6dGJDMXgIwBKou2UIHY7gXSWzRKF0rmEMK+4GBpT3v6WbizQd/hqIu0wEWUNM7An/
	 GgCs/6QsWTV4yFaOpoqAaEnX2Ize6HWIEolvbhw/2o6u1pJR5NtjCwscCiCZ9LLIFN
	 fE7974C14/J4iProCbSPgLUKfGVuy+fHJwegpSeeyXdT7mfdlLWnMief+iv/RlzTM2
	 YZ2gDvC25tyzg==
Date: Wed, 1 Oct 2025 00:37:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: chenyuan_fl@163.com, john.ogness@linutronix.de, rostedt@goodmis.org,
 bigeasy@linutronix.de, chenyuan@kylinos.cn, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
 mhiramat@kernel.org
Subject: Re: [PATH v3] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-Id: <20251001003707.3eaf9ad062d5cad96f49b9ba@kernel.org>
In-Reply-To: <20250930084645.GJ3245006@noisy.programming.kicks-ass.net>
References: <84seg5d2p3.fsf@jogness.linutronix.de>
	<20250930081848.433648-1-chenyuan_fl@163.com>
	<20250930084645.GJ3245006@noisy.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 10:46:45 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Sep 30, 2025 at 09:18:48AM +0100, chenyuan_fl@163.com wrote:
> 
> > diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> > index 842383fbc03b..98b838591edc 100644
> > --- a/kernel/trace/trace_probe.h
> > +++ b/kernel/trace/trace_probe.h
> > @@ -274,19 +274,19 @@ struct event_file_link {
> >  static inline bool trace_probe_test_flag(struct trace_probe *tp,
> >  					 unsigned int flag)
> >  {
> > -	return !!(tp->event->flags & flag);
> > +	return !!(smp_load_acquire(&tp->event->flags) & flag);
> >  }
> >  
> >  static inline void trace_probe_set_flag(struct trace_probe *tp,
> >  					unsigned int flag)
> >  {
> > -	tp->event->flags |= flag;
> > +	smp_store_release(&tp->event->flags, tp->event->flags | flag);
> >  }
> >  
> >  static inline void trace_probe_clear_flag(struct trace_probe *tp,
> >  					  unsigned int flag)
> >  {
> > -	tp->event->flags &= ~flag;
> > +	smp_store_release(&tp->event->flags, tp->event->flags & ~flag);
> >  }
> 
> 
> I _think_ the clear one is superfluous. Is there anything that cares
> about stores done before the clear when the flag is found not set?
> 
> Also, code like:
> 
> static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
> 			     unsigned long ret_ip, struct ftrace_regs *fregs,
> 			     void *entry_data)
> {
> 	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
> 	int ret = 0;
> 
> 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
> 		fentry_trace_func(tf, entry_ip, fregs);
> 
> #ifdef CONFIG_PERF_EVENTS
> 	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
> 		ret = fentry_perf_func(tf, entry_ip, fregs);
> #endif
> 	return ret;
> }
> 
> 
> Will now have two barriers; where one would suffice, eg.
> 
> 	flags = smp_load_acquire(&tp->event->flags);
> 
> 	if (flags & TP_FLAG_TRACE)
> 		fentry_trace_func(...);
> 
> 	if (flags & TP_FLAG_PROFILE)
> 		fentry_perf_func(...);
> 
> Should be just fine afaict.

Looks good to me. We should replace trace_probe_test_flag()
with trace_probe_load_flag().

Thanks,

> 
> 
> Is this something anybody cares about?


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
