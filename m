Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A633AE715;
	Fri,  6 Mar 2026 15:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809594; cv=none; b=fsVCOBiFItQr77+ypRK7d0+W7eJSp8BwkZW05A0rWjmotRhKsf7IhgV66XOUSpm4134GK2842fovn4KOpw80zvMPRy7cNiW+gmLrLiyqR/uSf/ZI9CVs4DtiZZLGTQaBWwZqNXCgWcwQxs8zUwlndlLMVBmL+EaiNcZLHXs77Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809594; c=relaxed/simple;
	bh=9NlxtT6RRSYyASeSI3wMKEdo54KCooDZx3wfhBDz6DE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soXJPPH3bJHD706KpweUC7Yg74vW9XazEsrW9rbczXvFt9mToXEhxllSUcD3V/jihJBPNENokFQlLHgoUVXF+CsQhzmolEDPi5AN68G4p4W3vP0c4gb20RR60/sky287sHKMNRY5Nc+6esnBccwpMhN4hU8VYl4g5n20JS8x09Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id ED4AE13B095;
	Fri,  6 Mar 2026 15:06:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id D0C0560009;
	Fri,  6 Mar 2026 15:06:24 +0000 (UTC)
Date: Fri, 6 Mar 2026 10:06:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Xuewen Yan <xuewen.yan@unisoc.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <elver@google.com>, <kees@kernel.org>, <lorenzo.stoakes@oracle.com>,
 <brauner@kernel.org>, <schuster.simon@siemens-energy.com>,
 <david@kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <guohua.yan@unisoc.com>,
 <ke.wang@unisoc.com>, <xuewen.yan94@gmail.com>, <jing.xia@unisoc.com>
Subject: Re: [PATCH V2] tracing: Revert "tracing: Remove pid in task_rename
 tracing output"
Message-ID: <20260306100625.2211675a@gandalf.local.home>
In-Reply-To: <20260306075954.4533-1-xuewen.yan@unisoc.com>
References: <20260306075954.4533-1-xuewen.yan@unisoc.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nc1woaw96amw3ycub97p8jsqk9eoscuz
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: D0C0560009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19hMMpPQFO51SuFqS6c/Z/9oA0S0C4HhOY=
X-HE-Tag: 1772809584-41282
X-HE-Meta: U2FsdGVkX1+B4lvep6R74YnQocltpBpvw9LTjGTKLku4oHvT95ThXxhCuxZRmf2Kvgs5gEuy35ZUiAYoVe1u/GZ3ph6+q7QcLPvPdIQ2BV9u3/wBJZUxF0u/tgAvJoU1eDx45R54uQrhP7LabodY8yjn5teQZyCx0G/1Bg8ft7EbCAFNDaAp1SvayXXBlYQM9SmDfycw015qlXWq0jKbs5ohhUeNCuSFqNICndIcP4pD7kqdtmOY9jg9UTUjOBjTwDkmO2pAr81Ul7ZE6fGrfNqti4Q1eZQuBVBCEWazP05YfwMrUTPOXNbDERJVRLZy7DiV5GK6F99BR/kEqvZtvtQd4E5vfnKmbuFPq9WoBL3XJgOK1CWnAWlIW/C4f7n9VIBbNcnT6v+cHcmY9TDK69PmEBULlDo8ZGZscu64hAJybyXaxgP5AwagYhzb5DdE

On Fri, 6 Mar 2026 15:59:54 +0800
Xuewen Yan <xuewen.yan@unisoc.com> wrote:

> This reverts commit e3f6a42272e028c46695acc83fc7d7c42f2750ad.
> 
> The commit says that the tracepoint only deals with the current task,
> however the following case is not current task:
> 
> comm_write() {
>     p = get_proc_task(inode);
>     if (!p)
>         return -ESRCH;
> 
>     if (same_thread_group(current, p))
>         set_task_comm(p, buffer);
> }
> where set_task_comm() calls __set_task_comm() which records
> the update of p and not current.
> 
> So revert the patch to show pid.
> 
> Fixes: e3f6a42272e0 ("tracing: Remove pid in task_rename tracing output")
> Reported-by: Guohua Yan <guohua.yan@unisoc.com>
> Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
> v2:
> - update commit message (Steven)
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

