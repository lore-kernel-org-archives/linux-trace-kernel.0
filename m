Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFFC3AB48F;
	Mon, 10 Aug 2026 22:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786401748; cv=none; b=aL3T03bGF2miVfjftCa3C8yAkn8waH8DjAlo+dhzENaVFWEsWIqmVt3do93p1jH6mEdCAU5G5T+i1f9QfLvuaHLMSv/H3wjtf5nBAhrdH25cIAGikYitvpjBAIK7XUeA9YXnaHzKPYNBTFaKqhMIMyKnzxm6U8NKUDF/0lptlwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786401748; c=relaxed/simple;
	bh=7RoINJE4dbmabMMBpH1OQxD33IndvQyZfXs/LTop7vE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p263tMP8Kk6WJWbs2vsKKq6HHfyJUMiKzAMy1JKbt0xhYMbFmFv7e/VcSphDhDdMwLJc0sDMqyAs3g2TKr/G+pf0hd64YP9FFw1UtJx5uKPvuNfB8TKS4Ght0p/ok1h8+58rhaJgu71+dLsVo3vFo10Wkn/H1W8EvyDY11+jDJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 13A4214029E;
	Mon, 10 Aug 2026 22:42:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 0F44C20025;
	Mon, 10 Aug 2026 22:42:22 +0000 (UTC)
Date: Mon, 10 Aug 2026 18:42:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/18] tracing/remotes: Add dmesg tracefs file
Message-ID: <20260810184216.3484cfd6@robin>
In-Reply-To: <20260804140333.797210-7-vdonnefort@google.com>
References: <20260804140333.797210-1-vdonnefort@google.com>
	<20260804140333.797210-7-vdonnefort@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0F44C20025
X-Stat-Signature: tp5cghu49t5i784h5iq8kq356q65cd8q
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//PoLAJORmJuh/4Sn43dzA1QgdKWLWnZo=
X-HE-Tag: 1786401742-889997
X-HE-Meta: U2FsdGVkX1887pcpfHh0VeRjLffvaiXV57p/7Jrdlw2ZCak81yUqhCVs71BZufMMDJhZGv46IQ4S63xQA/shRfGFfV1uSECN+NHJz2ztjH7kjS7eeMGKSIJ4GSgiQUCK05MUoQNy+cBy9p+4YKYE8Lm0R7YR4BaanBkxk6Yz6RSKERFRI4vYOBXBzVwRXYkBGVzM6sbyisx98F/OR3XlspKCeLpepZk/xEnCrsJD0M49mHKBftNHhp+2kgQ8pn0c/PA3VR+RV6XEFBivpMrC1QqqwBciedkbXMVvCfbkSVFihY+XgcB8w3fEgjPVTstUpGq87OqU3Liu3SPWSh4bv9ZXqzg1ZMiKIBV7BxOT4lkR3tl7Xvzic3FesybuwkMvTZsha3fJuRz9KAzAxoo8+w==

Adding Sashiko review: https://sashiko.dev/#/patchset/20260804140333.797210-2-vdonnefort%40google.com

> --- Patch [6]: [PATCH v4 06/18] tracing/remotes: Add dmesg tracefs file ---
> commit b6a4c19257d91807c612baa19691b2d602bb0670
> Author: Vincent Donnefort <vdonnefort@google.com>
> 
> tracing/remotes: Add dmesg tracefs file
> 
> When enabled, the dmesg tracefs file enables the redirection of all
> events to dmesg. This is similar to tp_printk.
> 
> > diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> > index 1fbe2f3f20e99..58a38f3d49024 100644
> > --- a/kernel/trace/trace_remote.c
> > +++ b/kernel/trace/trace_remote.c
> 
> > [ ... ]
> 
> > @@ -882,6 +908,87 @@ static const struct file_operations trace_fops = {
> >  	.release	= trace_release,
> >  };
> >  
> > +static bool trace_remote_do_dmesg(struct trace_remote *remote)
> > +{
> > +	struct trace_remote_iterator *iter = smp_load_acquire(&remote->dmesg);
> > +	unsigned int max_events = 1000;
> > +
> > +	if (!iter)
> > +		return false;
> > +
> > +	trace_remote_iter_read_start(iter);
> > +
> > +	while (trace_remote_iter_read_event(iter)) {
> > +		trace_seq_init(&iter->seq);
> > +
> > +		trace_remote_iter_print_event(iter);
> > +		trace_seq_putc(&iter->seq, 0);
> > +		if (!pr_info("%s", iter->seq.buffer))
> 
> If the remote trace event exceeds the PAGE_SIZE sequence buffer, does
> trace_seq_putc() in trace_remote_do_dmesg() fail to append the null byte?
> 
> Since iter->seq.buffer might not be null-terminated in this case, could this
> lead to an out-of-bounds read when pr_info() prints the string?

Yeah, we may want to have it be:

		if (!pr_info("%s", seq_buf_str(&iter->seq))

Which will make sure the buffer is nul terminated.


> 
> This isn't a bug introduced by this patch, but the same pattern appears
> to exist in the pre-existing trace_remote_panic_handler() with pr_emerg().
> 
> If the kernel is built with CONFIG_PRINTK disabled, pr_info() evaluates to 0.
> 
> Will this cause the loop in trace_remote_do_dmesg() to break without calling
> trace_remote_iter_move(), leaving the event unconsumed and permanently
> stalling the workqueue?
> 
> > +			break;
> > +
> > +		trace_remote_iter_move(iter);
> > +
> > +		if (!(--max_events))
> > +			break;
> > +	}
> > +
> > +	trace_remote_iter_read_finished(iter);
> > +
> > +	return !max_events;
> > +}
> 
> While reviewing this, I also noticed a pre-existing issue in trace_pipe_read()
> when handling oversized events:
> 
> kernel/trace/trace_remote.c:trace_pipe_read() {
>         ...
>         if (trace_remote_iter_print_event(iter)) {
>                 iter->seq.seq.len = prev_len;
>                 break;
>         }
>         ...
> }
> 
> This is a pre-existing issue, but if an oversized event causes
> trace_remote_iter_print_event() to return -EOVERFLOW, will this break
> the loop without calling trace_remote_iter_move()?
> 
> Since the event is left unconsumed in the buffer, could this lead to an
> uninterruptible infinite loop (hard lockup) when reading the trace pipe?

I'll let you answer the above.

-- Steve
