Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097063A4517;
	Thu,  5 Mar 2026 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723276; cv=none; b=ctASKV/SQw7y8d+ENx2HA9ldPp6PSD1x8dOv+KKre8K4/tYp1qtVEBx6Jq5u0tmpYbizjolibtiNRtU1H5wBOnpqBcGBftnR8jKI2bLlQO1vvY5dco5Yy7btOx91W2+mbSP+wDZK9SXGMUUsDhOkBpcdTB20wkuURbLm/C/FL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723276; c=relaxed/simple;
	bh=uj0hf6+fr6DEOaLpxTg6qLjj2ccr9cMUFjrNTp6VOMU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rp1cHoWaXGfvMv2i9TACI/BEz6Yy9EMCvSwf6Nk9Ej15z5lAn6D6QbUlASg7qoajLEcF5BObwVLSdmLuJUDgRJuNXGzJKo7zsaMscEfdb5bLxyF2MVzjYzoj6l1QibGlPz9MV+iFPtGqoplIz1TQVm4JCQC+F+GDLMP7KzxXXH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 1D38D1B6DD3;
	Thu,  5 Mar 2026 15:07:47 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 436ED2002A;
	Thu,  5 Mar 2026 15:07:44 +0000 (UTC)
Date: Thu, 5 Mar 2026 10:08:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <elver@google.com>, <kees@kernel.org>, <lorenzo.stoakes@oracle.com>,
 <brauner@kernel.org>, <schuster.simon@siemens-energy.com>,
 <david@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <guohua.yan@unisoc.com>,
 <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>
Subject: Re: [RFC PATCH] tracing: Revert "tracing: Remove pid in task_rename
 tracing output"
Message-ID: <20260305100822.142677b3@gandalf.local.home>
In-Reply-To: <20260305080809.3245-1-xuewen.yan@unisoc.com>
References: <20260305080809.3245-1-xuewen.yan@unisoc.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 436ED2002A
X-Rspamd-Server: rspamout06
X-Stat-Signature: 7yxrzi6kw5yiih74zsmqk74ekudxrpo5
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/OqfQv9JaufBXjaLb6Ch90N1QFVJyZII8=
X-HE-Tag: 1772723264-596677
X-HE-Meta: U2FsdGVkX1/I8bxCqBTVj9rBb2KMBlyRNWro/v5Ntmrndi0KyqbTEN1QgddNScqGqXZ060Ogl3Gqvh8PtarfC/nRqi19Czm41thbobnj6CGewDue0r6nPLXrFtFOSrSHEH4lg83gal52NSkzHSbNlcLvxF1X+1B6zBU230ABqRmcjrhUPlKtLUf9KXNMZYEps7w1d9F/6A2184fq4Z7tTQ3fvqp30MC09NlW6UPHZqyFT+wn96V2ONrWfo1Qe6VGLeuACxFNJgtzxKLHcroh/yl+OOuRmmFa2NrVDciLJrKMlxWjav57fek12dvEH5FD3y2BQvILbu7hvlVhW02Qwa6WeJo1TOV+Hp7vEz2olk8OLPaEubK2YjiTNzeugKseyf7yUVKIW/Ef9AVZAJReWmnStQcWFKA1+pW/btNGGnqCps/16CtVRdfS8CKwkkwR

On Thu, 5 Mar 2026 16:08:09 +0800
Xuewen Yan <xuewen.yan@unisoc.com> wrote:

> This reverts commit e3f6a42272e028c46695acc83fc7d7c42f2750ad.
> 
> The commit says that the tracepoint only deals with the current task,
> however the following case is not current task:
> 
> comm_write
> set_task_comm
> __set_task_comm
> trace_task_rename

I'm fine with the patch, but the change log can use a bit of work:

  comm_write() {
	p = get_proc_task(inode);
	if (!p)
		return -ESRCH;

	if (same_thread_group(current, p)) {
		set_task_comm(p, buffer);

  where set_task_comm() calls __set_task_comm() which records the update of
  p and not current.

The above states exactly why current isn't the pid that should be recorded.

Other than that.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve


> 
> So revert the patch to show pid.
> 
> Fixes: e3f6a42272e0 ("tracing: Remove pid in task_rename tracing output")
> Reported-by: Guohua Yan <guohua.yan@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> ---
>  include/trace/events/task.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> index 4f0759634306..b9a129eb54d9 100644
> --- a/include/trace/events/task.h
> +++ b/include/trace/events/task.h
> @@ -38,19 +38,22 @@ TRACE_EVENT(task_rename,
>  	TP_ARGS(task, comm),
>  
>  	TP_STRUCT__entry(
> +		__field(	pid_t,	pid)
>  		__array(	char, oldcomm,  TASK_COMM_LEN)
>  		__array(	char, newcomm,  TASK_COMM_LEN)
>  		__field(	short,	oom_score_adj)
>  	),
>  
>  	TP_fast_assign(
> +		__entry->pid = task->pid;
>  		memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
>  		strscpy(entry->newcomm, comm, TASK_COMM_LEN);
>  		__entry->oom_score_adj = task->signal->oom_score_adj;
>  	),
>  
> -	TP_printk("oldcomm=%s newcomm=%s oom_score_adj=%hd",
> -		  __entry->oldcomm, __entry->newcomm, __entry->oom_score_adj)
> +	TP_printk("pid=%d oldcomm=%s newcomm=%s oom_score_adj=%hd",
> +		__entry->pid, __entry->oldcomm,
> +		__entry->newcomm, __entry->oom_score_adj)
>  );
>  
>  /**

