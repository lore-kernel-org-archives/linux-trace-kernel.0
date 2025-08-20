Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3E263F28;
	Wed, 20 Aug 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699059; cv=none; b=MZySz4vQljZAP45omtOku0qjH65q3yg53Yozng3wSCgdLg2ebqEQszlZ6Hd4/F4v4oQyNYY9y0C1w6x1n03XeHXgLbtdJO1NcGZj1s1khrGiEweqzZ/Ng/31L7M7Hg7Qz0E9wilFMjmKxCL7GqFuiSRL4J8mNORpHLU1mXt/pfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699059; c=relaxed/simple;
	bh=ceT2xDjftxR1DXzson3ITsC1kc6sKAtswR32ja+a7MM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCXLxuBK3q8fFSu70GGykaLxJfKsVn1fY7jDOa7bYGecSADqIayv7zZZWqaPOnuVvnXyfgRXilQ4RAWWxab3bUShcUwNFEdrDkBndFzvxhgNnnHLca45247/QMcPkWflZrsyHdJFWr1e/DAqL3pyEyY+pmxQRPPkvfOWjMZdjng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E8315595B9;
	Wed, 20 Aug 2025 14:10:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 0C0842E;
	Wed, 20 Aug 2025 14:10:52 +0000 (UTC)
Date: Wed, 20 Aug 2025 10:10:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tengda Wu <wutengda@huaweicloud.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@elte.hu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ftrace: Fix potential warning in trace_printk_seq
 during ftrace_dump
Message-ID: <20250820101054.50c0b8b8@gandalf.local.home>
In-Reply-To: <20250820090017.2978279-1-wutengda@huaweicloud.com>
References: <20250820090017.2978279-1-wutengda@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 79rsjb6kmiiojht787om5ay5cr5uraj8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0C0842E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19fkZlAFyDNV9O438qIiE1GPTYFnoY/Mro=
X-HE-Tag: 1755699052-662697
X-HE-Meta: U2FsdGVkX191jqmPxZ5bL1PaVGpVBhcGZFUqDAtMHpn8X65p3h7GiyqZjOpcs7lQ8ALANz018Tk7UlBn7iCY21/7ofwu31MBHVL5hWXYROUtzZ+KBXA6itx0X7HMNJc7AEwgAQTKadtiG3aAwHlmlkWlh9M4xnw/pqYPpSVTFSN+GtPlhzE+rwEd8TzeHEFoQ4t089Wde8XZX2fk23pcsj/T0lO5pMoS3tTjvTxjhnDsCvi9ntkc3S2us1hKKyhkYgOJsNcBXJCCmI871AnivFYvR1z/C8crFnq2KUWx/eRhyjyVbeI3z2X9bMCrKULr7Bhw5kWM0P9rDZRrzTFW+0mXq20VHyo/k5o2y//rQRFpOUIafGm663xALSeaqT9L

On Wed, 20 Aug 2025 09:00:17 +0000
Tengda Wu <wutengda@huaweicloud.com> wrote:

Hi Tengda!

> When calling ftrace_dump_one() concurrently with reading trace_pipe,
> a WARN_ON_ONCE() in trace_printk_seq() can be triggered due to a race
> condition.
> 
> The issue occurs because:
> 
> CPU0 (ftrace_dump)                              CPU1 (reader)
> echo z > /proc/sysrq-trigger
> 
> !trace_empty(&iter)
> trace_iterator_reset(&iter) <- len = size = 0
>                                                 cat /sys/kernel/tracing/trace_pipe
> trace_find_next_entry_inc(&iter)
>   __find_next_entry
>     ring_buffer_empty_cpu <- all empty
>   return NULL
> 
> trace_printk_seq(&iter.seq)
>   WARN_ON_ONCE(s->seq.len >= s->seq.size)

Thanks for debugging this code. I do appreciate it.

> 
> In the context between trace_empty() and trace_find_next_entry_inc()
> during ftrace_dump, the ring buffer data was consumed by other readers.
> This caused trace_find_next_entry_inc to return NULL, failing to populate
> `iter.seq`. At this point, due to the prior trace_iterator_reset, both
> `iter.seq.len` and `iter.seq.size` were set to 0. Since they are equal,
> the WARN_ON_ONCE condition is triggered.
> 
> Add a non-NULL check on the return value of trace_find_next_entry_inc
> prior to invoking trace_printk_seq, ensuring the `iter.seq` is properly
> populated before subsequent operations.
> 


> Furthermore, per the seq_buf specification, the condition len == size
> indicates a full buffer, which constitutes a valid state. Consequently,
> the equality check and size - 1 adjustment in WARN_ON_ONCE() are redundant
> and should be eliminated.
> 
> Fixes: d769041f8653 ("ring_buffer: implement new locking")
> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
> ---
>  kernel/trace/trace.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 4283ed4e8f59..61c5d389dbd3 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -10521,8 +10521,8 @@ trace_printk_seq(struct trace_seq *s)
>  	 * PAGE_SIZE, and TRACE_MAX_PRINT is 1000, this is just
>  	 * an extra layer of protection.
>  	 */
> -	if (WARN_ON_ONCE(s->seq.len >= s->seq.size))
> -		s->seq.len = s->seq.size - 1;
> +	if (WARN_ON_ONCE(s->seq.len > s->seq.size))
> +		s->seq.len = s->seq.size;
>  

This should be a separate patch as it has nothing to do with the other
changes. It's also incorrect, which is why you want to make it a separate
patch, as now this delays the changes below from being accepted.

Yes, the seq_buf specification states this, but this is not using the
seq_buf interface. It's adding on to it. The code below that change has:

	/* should be zero ended, but we are paranoid. */
	s->buffer[s->seq.len] = 0;

You see, it is updating the buffer. Which means it needs its own check.
If we don't set len to size - 1, the above write will overflow the buffer.

-- Steve



>  	/* should be zero ended, but we are paranoid. */
>  	s->buffer[s->seq.len] = 0;
> @@ -10617,6 +10617,7 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  	 */
>  
>  	while (!trace_empty(&iter)) {
> +		void *ent;
>  
>  		if (!cnt)
>  			printk(KERN_TRACE "---------------------------------\n");
> @@ -10625,17 +10626,18 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>  
>  		trace_iterator_reset(&iter);
>  		iter.iter_flags |= TRACE_FILE_LAT_FMT;
> +		ent = trace_find_next_entry_inc(&iter);
>  
> -		if (trace_find_next_entry_inc(&iter) != NULL) {
> +		if (ent) {
>  			int ret;
>  
>  			ret = print_trace_line(&iter);
>  			if (ret != TRACE_TYPE_NO_CONSUME)
>  				trace_consume(&iter);
> +
> +			trace_printk_seq(&iter.seq);
>  		}
>  		touch_nmi_watchdog();
> -
> -		trace_printk_seq(&iter.seq);
>  	}
>  
>  	if (!cnt)

