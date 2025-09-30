Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C582F5327;
	Tue, 30 Sep 2025 08:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759222016; cv=none; b=g7XXqd9Bv6/nx5b5M5wJaEByReCbqTibydjXEeclxSpaxzOhwI/dlI/QRTpbbOCIYlGTKCqP5xiDqGa64V9KVJuQEbPNkkTOSrjgYJAPXMyfR28FSI0rfdqgRlX7iMMg4RRZ80Il17/KyktD5/WPS1oBUPMY4fPpos6Ma8Rq6yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759222016; c=relaxed/simple;
	bh=0DfkBTX/ScMUW1EKpUS2pL3Z8wV7aPfbw2MYFdWUmnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTbQISjvPb/sS+Ml9BZcdC97/lhtjdcGHiC7oDzHXzastc4xkroSQD+lYLuavam9tgwVY8emJ80396l7K5gwrKTeYCb1mxfTnuWue0DGw6HpqEyvj97xycsqOsHc0DQ/KW+AgM+Hb5UopYtNsBzGUPJJ1B6GKKEPJOUyBZpbN4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oIs81YVe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oIs81YVe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M9baVUaGiSQn+xhubk+uI2UMgl/PNt3FnuA96175AqM=; b=oIs81YVeXNUdDZjRzzbwtsQ9VU
	TXGjnludJQkNX52qorTAdShVc2ID6n/GY8XxuWbOUxpR6SE+tsrFttIeLUzaw7hMpbJNHbjbvUOfO
	lmR7qfoUPu1FpmET2yd2vgAXqiPSNyTXV6Trd/TZMkixz9zEWKv1DdCfxhyfDYynC6YMRttG4Ej0A
	0mkcSFmFJg8WOqoQiguT+CCOEoZuikMODY+WErjPWMBerHKEoxAH7R47fxI2VD96+Y24GlC4sn3wH
	IoTaKeUIBQt3R7olkz5eCPCc+1sBlifXNXgeMHtZnmSjmX3LmTLnrBc1HikW6zFPndZYvMoaKdO8W
	eBx9HvAg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3W0S-000000084aP-1hHA;
	Tue, 30 Sep 2025 08:46:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 33066300328; Tue, 30 Sep 2025 10:46:45 +0200 (CEST)
Date: Tue, 30 Sep 2025 10:46:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: chenyuan_fl@163.com
Cc: john.ogness@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de,
	chenyuan@kylinos.cn, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org
Subject: Re: [PATH v3] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
Message-ID: <20250930084645.GJ3245006@noisy.programming.kicks-ass.net>
References: <84seg5d2p3.fsf@jogness.linutronix.de>
 <20250930081848.433648-1-chenyuan_fl@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250930081848.433648-1-chenyuan_fl@163.com>

On Tue, Sep 30, 2025 at 09:18:48AM +0100, chenyuan_fl@163.com wrote:

> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 842383fbc03b..98b838591edc 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -274,19 +274,19 @@ struct event_file_link {
>  static inline bool trace_probe_test_flag(struct trace_probe *tp,
>  					 unsigned int flag)
>  {
> -	return !!(tp->event->flags & flag);
> +	return !!(smp_load_acquire(&tp->event->flags) & flag);
>  }
>  
>  static inline void trace_probe_set_flag(struct trace_probe *tp,
>  					unsigned int flag)
>  {
> -	tp->event->flags |= flag;
> +	smp_store_release(&tp->event->flags, tp->event->flags | flag);
>  }
>  
>  static inline void trace_probe_clear_flag(struct trace_probe *tp,
>  					  unsigned int flag)
>  {
> -	tp->event->flags &= ~flag;
> +	smp_store_release(&tp->event->flags, tp->event->flags & ~flag);
>  }


I _think_ the clear one is superfluous. Is there anything that cares
about stores done before the clear when the flag is found not set?

Also, code like:

static int fentry_dispatcher(struct fprobe *fp, unsigned long entry_ip,
			     unsigned long ret_ip, struct ftrace_regs *fregs,
			     void *entry_data)
{
	struct trace_fprobe *tf = container_of(fp, struct trace_fprobe, fp);
	int ret = 0;

	if (trace_probe_test_flag(&tf->tp, TP_FLAG_TRACE))
		fentry_trace_func(tf, entry_ip, fregs);

#ifdef CONFIG_PERF_EVENTS
	if (trace_probe_test_flag(&tf->tp, TP_FLAG_PROFILE))
		ret = fentry_perf_func(tf, entry_ip, fregs);
#endif
	return ret;
}


Will now have two barriers; where one would suffice, eg.

	flags = smp_load_acquire(&tp->event->flags);

	if (flags & TP_FLAG_TRACE)
		fentry_trace_func(...);

	if (flags & TP_FLAG_PROFILE)
		fentry_perf_func(...);

Should be just fine afaict.


Is this something anybody cares about?
