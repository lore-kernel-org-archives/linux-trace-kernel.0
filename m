Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455F443C071;
	Tue, 31 Mar 2026 21:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991922; cv=none; b=NunKELJc49Plaz2ErR0HFuiPMzMZFTm150jQiR5/e97zBu+mpnUzP1AwUtTDdEkQh7XMdPHUNsgFYxBXYLfLeAj4sLSmUs51KWQw+qgaqrvDTnXE8V8cKV6aq+ZpTyNi8eRJWn85yQA0MYAQ3rGd+9O0nCBflK3ruxI0zCmRzHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991922; c=relaxed/simple;
	bh=tu01tDk69d6xxvEtpiR+y1xvLyA34DeprrZopdFYdLI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AcgT1JtJ0KUEOyMtxuJ8fk4vGs6/6enveOmI7Vwf9DbtFB2hEgKPIS1gRCvMIu/aRb//Avi4EtziBODoaBthPjuxwnOQ+Ed7hdwjxXL6cvBC8xswJPpdX4f9XLlSOINRtkOKwjZr+Eb/p/7UlGNhZhauJR+87UNuDtl486aMhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id F37AD13AA51;
	Tue, 31 Mar 2026 21:18:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 5D32D6000D;
	Tue, 31 Mar 2026 21:18:38 +0000 (UTC)
Date: Tue, 31 Mar 2026 17:19:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] tracing: Remove the backup instance
 automatically after read
Message-ID: <20260331171936.6f84e357@gandalf.local.home>
In-Reply-To: <177497475349.569199.11513916633426967730.stgit@mhiramat.tok.corp.google.com>
References: <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
	<177497475349.569199.11513916633426967730.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1wd7gsbfhxgs4daia7ftj9abyps7c7e3
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 5D32D6000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/9oWUuvICP6NahY4hR2MQSMvJyhb++T0c=
X-HE-Tag: 1774991918-772976
X-HE-Meta: U2FsdGVkX1/MNrca7Mjt/RKCVpheCF9ZsECweKo+bbl9oq4mbQSmbeVQD+q+f/0SPC4+JjOFANc40v3C+LDEFUabifKbvqULyngmxLAyLZljPMPFSfSVXy5uDnBz9qTkGJ10qivf1quC0nm+Hk5t0kTyDcu0fU+WmuAFNBQ79aFlLIAfbPM9wRadJOfrPTPFR0waYSEf0u3biV5wHP4d+FrRUds80Y0rqEkEIWNkqg5RUYx1DWghCtNlicXN/rR6XOcglvg04ceMwzArAGtI8avyN8Bew0j/LtAUxSgabXED27iyABZi0ch5eUFZxx39gv6iddJ+gf/5dMhAl0qfRIpWiF4tCnQq

On Wed,  1 Apr 2026 01:32:33 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 8cec7bd70438..1d73400a01c7 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -539,8 +539,65 @@ void trace_set_ring_buffer_expanded(struct trace_array *tr)
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

Hmm, should we do a check if the tr still exists? Couldn't the user delete
this via a rmdir after the last file closed and this was kicked?

  CPU 0							CPU 1
  -----							-----
  open(trace_pipe);
  read(..);
  close(trace_pipe);
     kick the work queue to delete it....
						rmdir();
							[instance deleted]

  __remove_instance();

   [ now the tr is freed, and the remove will crash!]


What would prevent this is this is to use trace_array_destroy() that checks
this and also adds the proper locking:

static void trace_array_autoremove(struct work_struct *work)
{
	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);

	trace_array_destroy(tr);
}


> +
> +	/*
> +	 * This can be fail if someone gets @tr before starting this
> +	 * function, but in that case, this will be kicked again when
> +	 * putting it. So we don't care about the result.
> +	 */
> +	__remove_instance(tr);
> +}
> +
> +static struct workqueue_struct *autoremove_wq;
> +
> +static void trace_array_kick_autoremove(struct trace_array *tr)
> +{
> +	if (autoremove_wq && !work_pending(&tr->autoremove_work))
> +		queue_work(autoremove_wq, &tr->autoremove_work);

Doesn't queue_work() check if it's pending? Do we really need to check it
twice?

> +}
> +
> +static void trace_array_cancel_autoremove(struct trace_array *tr)
> +{
> +	if (autoremove_wq && work_pending(&tr->autoremove_work))
> +		cancel_work(&tr->autoremove_work);

Same here, as can't this be racy?

> +}
> +
> +static void trace_array_init_autoremove(struct trace_array *tr)
> +{
> +	INIT_WORK(&tr->autoremove_work, trace_array_autoremove);
> +}
> +
> +static void trace_array_start_autoremove(void)
> +{
> +	if (autoremove_wq)
> +		return;
> +
> +	autoremove_wq = alloc_workqueue("tr_autoremove_wq",
> +					WQ_UNBOUND | WQ_HIGHPRI, 0);
> +	if (!autoremove_wq)
> +		pr_warn("Unable to allocate tr_autoremove_wq. autoremove
> disabled.\n"); +}
> +
>  LIST_HEAD(ftrace_trace_arrays);

-- Steve
