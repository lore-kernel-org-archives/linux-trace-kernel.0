Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809CC3254A2;
	Thu, 29 Jan 2026 20:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769717624; cv=none; b=SjAgj8Fhl/w/lIbrd0co/vUM/bHZE1FY5a6rQIdSx7kgdOZ778k1S5Fdz3GiZEfqmylrRYxBG4zo3Ds0+O3g2ILGOmflwFtKZffhp3HyWqVDxS7cB8xyCsSjboQtYjY6OWUe4UeH1ogAkffTW5PyzHxJ129u/A2WO2bvVWQX1Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769717624; c=relaxed/simple;
	bh=AM2MGrCh8VlPLRJ3nXE2Ga3KXdNKeezSFKlK1f84VZE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tn8u/FpFmG96pc0D69Tlw14ehBEo6+GsldIZ2p7pWj0JQsWggSMm1ztS6kVIj0TYn4rlP4djhoeYALVRyVDVfbhFJlORm5m2jXRaJ2fO82rmYwc4iqccDIol7f4WQ59OnORylMzbaG3ZikHWoUWXQoUsNjs9apY1iJj+5bdKDLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 590BCD3AEB;
	Thu, 29 Jan 2026 20:13:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 7EFBE1D;
	Thu, 29 Jan 2026 20:13:39 +0000 (UTC)
Date: Thu, 29 Jan 2026 15:13:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] tracing: Remove the backup instance
 automatically after read
Message-ID: <20260129151352.12e2be72@gandalf.local.home>
In-Reply-To: <176955900407.2786091.16663650848612163366.stgit@mhiramat.tok.corp.google.com>
References: <176955897718.2786091.11948759407196200082.stgit@mhiramat.tok.corp.google.com>
	<176955900407.2786091.16663650848612163366.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 7EFBE1D
X-Stat-Signature: 6h3efjjnccr96qm8i3nty56gkzxd3das
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18u+ERautUVdrXM1oQsjmzCcdZsL/7i3fg=
X-HE-Tag: 1769717619-466352
X-HE-Meta: U2FsdGVkX19xmdZxRiYLkXZvS5ligMIApHcsdrTFN7zKvNrS/FEXZHjuAjA37jvOw8lcwDvsmBqutvmgnD8rLp6AU87Klqm2eHPQqd0iKYG6d6RMo43mKi9PUFrsymsvDJk46vGLMpwAr9WGjh0s8USuJAPkWC33oL4Evdmd5P0heO9BvHIOqf9oRlGvDvb+CAIbbNXqtLIcVHOCvhN+XEPL/3zWBfiTj7qNdPLlZS7c0LFOyLs/jOWVOAv2khPRIgQJHq7y9w+HxI0z/kRRzU+65UUPjZAhcz2htK62LGtZU67XsVCI0lO7kUCJWPXZLiyDqNJLHK5HTJdCBYBTCwEXBwapLf5D

On Wed, 28 Jan 2026 09:10:04 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the backup instance is readonly, after reading all data
> via pipe, no data is left on the instance. Thus it can be
> removed safely after closing all files.
> This also removes it if user resets the ring buffer manually
> via 'trace' file.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v4:
>    - Update description.
> ---
>  kernel/trace/trace.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++-
>  kernel/trace/trace.h |    6 +++++
>  2 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d39f6509c12a..7d615a74f915 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -590,6 +590,55 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
>  	tr->ring_buffer_expanded = true;
>  }
>  
> +static int __remove_instance(struct trace_array *tr);
> +
> +static void trace_array_autoremove(struct work_struct *work)
> +{
> +	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);
> +
> +	guard(mutex)(&event_mutex);
> +	guard(mutex)(&trace_types_lock);
> +
> +	/*
> +	 * This can be fail if someone gets @tr before starting this
> +	 * function, but in that case, this will be kicked again when
> +	 * putting it. So we don't care the result.

			"So we don't care about the result."

> +	 */
> +	__remove_instance(tr);
> +}
> +
> +static struct workqueue_struct *autoremove_wq;
> +
> +static void trace_array_init_autoremove(struct trace_array *tr)
> +{
> +	INIT_WORK(&tr->autoremove_work, trace_array_autoremove);
> +}
> +
> +static void trace_array_kick_autoremove(struct trace_array *tr)
> +{
> +	if (!work_pending(&tr->autoremove_work) && autoremove_wq)
> +		queue_work(autoremove_wq, &tr->autoremove_work);
> +}
> +
> +static void trace_array_cancel_autoremove(struct trace_array *tr)
> +{
> +	if (work_pending(&tr->autoremove_work))
> +		cancel_work(&tr->autoremove_work);
> +}
> +
> +__init static int trace_array_init_autoremove_wq(void)
> +{

This isn't needed if there's no backup trace_array right?

Instead of creating a work queue when its not needed, just exit out if
there's no backup trace_array.

Oh, and the above functions should always test autoremove_wq for NULL.

> +	autoremove_wq = alloc_workqueue("tr_autoremove_wq",
> +					WQ_UNBOUND | WQ_HIGHPRI, 0);
> +	if (!autoremove_wq) {
> +		pr_err("Unable to allocate tr_autoremove_wq\n");
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}
> +
> +late_initcall_sync(trace_array_init_autoremove_wq);
> +
>  LIST_HEAD(ftrace_trace_arrays);
>  
>  int trace_array_get(struct trace_array *this_tr)
> @@ -598,7 +647,7 @@ int trace_array_get(struct trace_array *this_tr)
>  
>  	guard(mutex)(&trace_types_lock);
>  	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> -		if (tr == this_tr) {
> +		if (tr == this_tr && !tr->free_on_close) {
>  			tr->ref++;
>  			return 0;
>  		}

Break the above into:

		if (tr == this_tr) {
			if (tr->free_on_close)
				break;
			tr->ref++;
			return 0;
		}

Why continue the loop if we found the trace_array but it's in the process
of closing?

-- Steve
