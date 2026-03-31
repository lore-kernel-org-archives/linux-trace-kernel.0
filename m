Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C611F09A5;
	Tue, 31 Mar 2026 04:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774930381; cv=none; b=MsVd4EyAxfYGK29ZSnW1GJeZMLIfB6R5NoeUH/TUc8MWOwVIc7msASojQh/j/TQDPPJJZpzfq+wsXixi+s6pUz2yw8cn9R+ABMZ0pilQkJZ1SrDyzMmik2htJwvZlBJo/eqHgXmIMCtZCcQtNHs4zPrLXGkMG65rZQqlHOfXtnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774930381; c=relaxed/simple;
	bh=/IwEcDIshM8coHtoFeWIgutLPxTLpoonLaL6/3BBcss=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=NA/LR0Qyjw2fpiKuhf1LiQgj/mcl9N8Wc7phgQCviTIoNUG3wn01SoCF+HgivwJ1G28RXRh6QCZxF4iC86LcAJBaI5r622Dr+06FjatHv+LwjPmLMyw+BjCih8ICPVIk23A7Aq7O8QIF8QHrW5TpyD9GMCWK8gB33XYF0kXifsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tak5dAjK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tak5dAjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE9EC19423;
	Tue, 31 Mar 2026 04:12:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774930380;
	bh=/IwEcDIshM8coHtoFeWIgutLPxTLpoonLaL6/3BBcss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tak5dAjKGldZaApWO6cejvXK68rqDF1llQJgd4m46djvWNQt7ev1FamJSpV9jrVK7
	 cHundjD7GQ470LRVTRevDnaP2ALP/sVwjzD1Fb9RlN7vJylPoukWw8qJaHTDMW6G17
	 zg40xbfKVXbRHlJXRazzbhCuSV5F/VttsY8tMs8uUjkPgydGoMJ00yBeNfLvTwgome
	 9l/Zh15RMtrj/Ce4VKMCIfJcodCdh+ipcF/yEEkh+IhaMN5VYm9VUs/zhDdg0KrT6m
	 dd+MOqQVlV/xJvS2lIn5fj02YKkN0q6QsVFwM2elTX37hhDAWXvIfTBHrmtkE42n2n
	 MoOmT54oB/gqA==
Date: Tue, 31 Mar 2026 13:12:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v14 5/5] ring-buffer: Add persistent ring buffer
 selftest
Message-Id: <20260331131257.f525a6c348507935ca25bd69@kernel.org>
In-Reply-To: <20260330162419.5e4708fb@gandalf.local.home>
References: <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
	<177487502763.3463592.7901517545360137050.stgit@mhiramat.tok.corp.google.com>
	<20260330162419.5e4708fb@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 16:24:19 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Mar 2026 21:50:27 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -2558,12 +2577,64 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
> >  	kfree(cpu_buffer);
> >  }
> >  
> > +#ifdef CONFIG_RING_BUFFER_PERSISTENT_INJECT
> > +static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +	struct ring_buffer_cpu_meta *meta;
> > +	struct buffer_data_page *dpage;
> > +	u32 entry_bytes = 0;
> > +	unsigned long ptr;
> > +	int subbuf_size;
> > +	int invalid = 0;
> > +	int cpu;
> > +	int i;
> > +
> > +	if (!(buffer->flags & RB_FL_TESTING))
> > +		return;
> > +
> > +	guard(preempt)();
> > +	cpu = smp_processor_id();
> > +
> > +	cpu_buffer = buffer->buffers[cpu];
> > +	meta = cpu_buffer->ring_meta;
> > +	ptr = (unsigned long)rb_subbufs_from_meta(meta);
> > +	subbuf_size = meta->subbuf_size;
> > +
> > +	for (i = 0; i < meta->nr_subbufs; i++) {
> > +		int idx = meta->buffers[i];
> > +
> > +		dpage = (void *)(ptr + idx * subbuf_size);
> > +		/* Skip unused pages */
> > +		if (!local_read(&dpage->commit))
> > +			continue;
> > +
> > +		/* Invalidate even pages. */
> > +		if (!(i & 0x1)) {
> > +			local_add(subbuf_size + 1, &dpage->commit);
> > +			invalid++;
> > +		} else {
> > +			/* Count total commit bytes. */
> > +			entry_bytes += local_read(&dpage->commit);
> > +		}
> > +	}
> > +
> > +	pr_info("Inject invalidated %d pages on CPU%d, total size: %ld\n",
> > +		invalid, cpu, (long)entry_bytes);
> 
> This is only enabled when testing. Let's make that a pr_warn() as we really
> do want to be able to see it. And it should warn that it is invalidating pages!
> (warn as in pr_warn, it doesn't need a warn as in WARN()).

OK. Let me update it.

Thanks!

> 
> -- Steve
> 
> 
> > +	meta->nr_invalid = invalid;
> > +	meta->entry_bytes = entry_bytes;
> > +}
> > +#else /* !CONFIG_RING_BUFFER_PERSISTENT_INJECT */
> > +#define rb_test_inject_invalid_pages(buffer)	do { } while (0)
> > +#endif
> > +
> >  /* Stop recording on a persistent buffer and flush cache if needed. */
> >  static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
> >  {
> >  	struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
> >  
> >  	ring_buffer_record_off(buffer);
> > +	rb_test_inject_invalid_pages(buffer);
> >  	arch_ring_buffer_flush_range(buffer->range_addr_start, buffer->range_addr_end);
> >  	return NOTIFY_DONE;
> >  }


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
