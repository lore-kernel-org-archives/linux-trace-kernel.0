Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52092EA732;
	Thu, 23 Jul 2026 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842399; cv=none; b=KmDaBP6TJLfSQZPR6mye0mwfH7t0M7sxOoClVzq7JmQhCNqG1SiDYxfIgWs97KmHP4W4I/uQWorxHlyzPTNDp4xZ2c6ld481mOAkjMzGXUNF01MANuJGrVxgCt3eXK52NA5D+Uwg7trfZgns1nCRCxMIph8xKcSZPIIf8pr9yws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842399; c=relaxed/simple;
	bh=XaDNRLjYwCK+tn3+UWU4Gc2rHSUWBZaSi4llDs+EWPo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g47BDnJJ2zxpfNkl1Yo74rqQW/I0Okt0JINs76zC7oz39mBzHtCEM6ElpYlGPs2TE4RM69PLepVKo6uFbbyp+3eoz97q55A004jWD9EGdfqSXM4MmACGdvOiljIun7VxzPOGblUy4346nWsKKKdnQTseY/43P2WHU5KYit+hZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB9U78n5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB9U78n5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643D21F000E9;
	Thu, 23 Jul 2026 21:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784842398;
	bh=Q+/dGfsl+8WV+jjjuXy5AIteLaMiC7aLzoVrAVtVS90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dB9U78n5WvACrMUHbKZhUKldiHJ3E/9Fvdsb08QvyTfE7N18wA2gmd//EG9b5rke2
	 N1hMv60ffSam/zK6euodWKccFF11Di6Fefwxbp2j36vwb+VGKRtOFNYAt3Wm22O49v
	 J5AHN+p4mKc7bDiS3hu2iJBdPsxCMDQxEaKiI2dc74/w+3fu8tF/65F7MNllavp+Id
	 lyBQn6dDrzR35Nh+fHP7IWVctw+MNKMbVy+fvjKm7cE2w9otk4PJkt09cWhCuJ9Rab
	 ZopT1diXB7M7mMJgzi8Rk9xmcGYeFDfNfBC5w5EzRoUl5rgS3GkayetX95qwipRQCp
	 1kv7rdON69jZw==
Date: Fri, 24 Jul 2026 06:33:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Restore synchronize_rcu() before freeing
 trigger private data
Message-Id: <20260724063315.b5ab5f8519c1555fa0d49756@kernel.org>
In-Reply-To: <20260723170212.55325-1-devnexen@gmail.com>
References: <20260723170212.55325-1-devnexen@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 18:02:12 +0100
David Carlier <devnexen@gmail.com> wrote:

> Commit 61d445af0a7c ("tracing: Add bulk garbage collection of freeing
> event_trigger_data") moved the kfree() of event_trigger_data to a kthread
> that runs tracepoint_synchronize_unregister() before freeing. That removed
> the synchronize_rcu() the trigger .free callbacks used to get implicitly and
> inline from trigger_data_free().
> 
> event_hist_trigger_free(), event_hist_trigger_named_free() and
> event_enable_trigger_free() free their satellite data (hist_data, cmd_ops,
> enable_data) right after trigger_data_free() returns. With the synchronize
> now deferred to the kthread, a concurrent tracepoint handler can still reach
> that data through the list_del_rcu()'d trigger, causing a use-after-free.
> 
> The teardown must also stay synchronous for correctness: the histogram
> cleanup (remove_hist_vars(), unregister_field_var_hists()) has to detach a
> synthetic event from the histogram before the trigger-removal write returns.
> Deferring it lets a following command race in and fail the synthetic-event
> removal with -EBUSY, as caught by
> tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-eprobe.tc.
> 
> Call synchronize_rcu() directly before freeing the satellite data instead.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Fixes: 61d445af0a7c ("tracing: Add bulk garbage collection of freeing event_trigger_data")
> Signed-off-by: David Carlier <devnexen@gmail.com>

Hi David,

Instead of adding just a synchronize_rcu(), can you reconsider to introduce
.private_data_free() to event_trigger_data? I hit the same issue on wprobe
and fixed it with ".private_free()" (I think private_data_free() is better
naming)

https://patchwork.kernel.org/project/linux-trace-kernel/patch/178476144141.26117.8004746214529353062.stgit@devnote2/

Thank you,

> ---
>  kernel/trace/trace_events_hist.c    | 3 +++
>  kernel/trace/trace_events_trigger.c | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index 82ce492ab268..ddd2f70dac4f 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -6349,6 +6349,8 @@ static void event_hist_trigger_free(struct event_trigger_data *data)
>  
>  		trigger_data_free(data);
>  
> +		synchronize_rcu();
> +
>  		remove_hist_vars(hist_data);
>  
>  		unregister_field_var_hists(hist_data);
> @@ -6388,6 +6390,7 @@ static void event_hist_trigger_named_free(struct event_trigger_data *data)
>  
>  		del_named_trigger(data);
>  		trigger_data_free(data);
> +		synchronize_rcu();
>  		kfree(cmd_ops);
>  	}
>  }
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index 655db2e82513..c3f54f2540b6 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -1730,6 +1730,7 @@ void event_enable_trigger_free(struct event_trigger_data *data)
>  		trace_event_enable_disable(enable_data->file, 0, 1);
>  		trace_event_put_ref(enable_data->file->event_call);
>  		trigger_data_free(data);
> +		synchronize_rcu();
>  		kfree(enable_data);
>  	}
>  }
> -- 
> 2.53.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
