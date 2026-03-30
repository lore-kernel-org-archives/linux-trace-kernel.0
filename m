Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCF2BE642;
	Mon, 30 Mar 2026 20:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774902213; cv=none; b=ak7SDQxvdl7U1n7H6mDIeUywsRvUlrtEF6MeFomXVZ5fUCNY3b5blnv/QrF4/5fwYcYu2vPlX2nUDPbBKJKMGaBVgpD9IUzIE8ZeaxXr3W7c6KiuFbCYw+yG9woCCrwGylWPWTX4KzFQ7ql8HwEwqMNxNzNGlMWBjC1/izutXDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774902213; c=relaxed/simple;
	bh=Ro+zXtlqeaqB6nSrniJgvAxu/w9hupshiNZu46jMvIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4ooO/EgZ5ZjXzINC6l+9Hs/j+z/doH8PqIx8xytPIcib4miv5EhvthLpKKt0eokz3Aq8jNqQFu5p7we+koXCgxYI8lVGZcfbuTRD0bGGozvvUnLIDAYWtHwJfSVPNW3KMUB+wBJoIoGQ+C+KJQ75JIFC0L/0ppEVGi+hVauZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E8A811408EE;
	Mon, 30 Mar 2026 20:23:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 3AE3A2000D;
	Mon, 30 Mar 2026 20:23:23 +0000 (UTC)
Date: Mon, 30 Mar 2026 16:24:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v14 5/5] ring-buffer: Add persistent ring buffer
 selftest
Message-ID: <20260330162419.5e4708fb@gandalf.local.home>
In-Reply-To: <177487502763.3463592.7901517545360137050.stgit@mhiramat.tok.corp.google.com>
References: <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
	<177487502763.3463592.7901517545360137050.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 3AE3A2000D
X-Stat-Signature: k4t7fkjtaff6b7re8uiq3mezcfjfriwj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18fxsvhnYv3jXi42emoyn6vKiE16KVlzYQ=
X-HE-Tag: 1774902203-623798
X-HE-Meta: U2FsdGVkX1+qBpZD5hn3RBQynQHdA0cnxII0hdn3iiwL6oLEPuwFFxphc6M0fn9ItNgxVKkGaxRfa/H0Pwznq+IaIArqLZ0/LBhKfGJO3Iu5S4E/x39SmG+gypQflyUoPfxYEqabqWFljOvNUkr/BkwrJ2KerOiqbirsf3hW8AKfBOnxyrd1bycy3kEwODORanq935wPi87TAK+kM2+o+loDr5bpQez5AcRl2Hou/omu7LHYU4ZCmGr3MegFDeUIZ2yebl5cKsriqZPBMAJJJGwi77z21rWcq3DC1PcB9+8c5QRRAZbm/0YteUer+/oIEFCYy7XKWwJDqporUGADkN+V27nxPyKI

On Mon, 30 Mar 2026 21:50:27 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -2558,12 +2577,64 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
>  	kfree(cpu_buffer);
>  }
>  
> +#ifdef CONFIG_RING_BUFFER_PERSISTENT_INJECT
> +static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +	struct ring_buffer_cpu_meta *meta;
> +	struct buffer_data_page *dpage;
> +	u32 entry_bytes = 0;
> +	unsigned long ptr;
> +	int subbuf_size;
> +	int invalid = 0;
> +	int cpu;
> +	int i;
> +
> +	if (!(buffer->flags & RB_FL_TESTING))
> +		return;
> +
> +	guard(preempt)();
> +	cpu = smp_processor_id();
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +	meta = cpu_buffer->ring_meta;
> +	ptr = (unsigned long)rb_subbufs_from_meta(meta);
> +	subbuf_size = meta->subbuf_size;
> +
> +	for (i = 0; i < meta->nr_subbufs; i++) {
> +		int idx = meta->buffers[i];
> +
> +		dpage = (void *)(ptr + idx * subbuf_size);
> +		/* Skip unused pages */
> +		if (!local_read(&dpage->commit))
> +			continue;
> +
> +		/* Invalidate even pages. */
> +		if (!(i & 0x1)) {
> +			local_add(subbuf_size + 1, &dpage->commit);
> +			invalid++;
> +		} else {
> +			/* Count total commit bytes. */
> +			entry_bytes += local_read(&dpage->commit);
> +		}
> +	}
> +
> +	pr_info("Inject invalidated %d pages on CPU%d, total size: %ld\n",
> +		invalid, cpu, (long)entry_bytes);

This is only enabled when testing. Let's make that a pr_warn() as we really
do want to be able to see it. And it should warn that it is invalidating pages!
(warn as in pr_warn, it doesn't need a warn as in WARN()).

-- Steve


> +	meta->nr_invalid = invalid;
> +	meta->entry_bytes = entry_bytes;
> +}
> +#else /* !CONFIG_RING_BUFFER_PERSISTENT_INJECT */
> +#define rb_test_inject_invalid_pages(buffer)	do { } while (0)
> +#endif
> +
>  /* Stop recording on a persistent buffer and flush cache if needed. */
>  static int rb_flush_buffer_cb(struct notifier_block *nb, unsigned long event, void *data)
>  {
>  	struct trace_buffer *buffer = container_of(nb, struct trace_buffer, flush_nb);
>  
>  	ring_buffer_record_off(buffer);
> +	rb_test_inject_invalid_pages(buffer);
>  	arch_ring_buffer_flush_range(buffer->range_addr_start, buffer->range_addr_end);
>  	return NOTIFY_DONE;
>  }
