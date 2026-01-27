Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25172347C6;
	Tue, 27 Jan 2026 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524447; cv=none; b=Gy2y37vx59HBkhWTGei94g47WSR3L0eWK07dqR35sIc+G58kPGZL1LeuLJw9zXCtao8fsre+yU6Vu/FNjQy1xoxz85WVGBtKvA3q9UHwVRwuhp0HkhweCkz1Vw2+1aH73sgUCK765qScfAkEZXFu51iRyjWvoJ1Pm+K37/a43vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524447; c=relaxed/simple;
	bh=jVm9kVspMw/JDfTeT5ktoNDS6VSyf9NT73Jj3vTP1+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yb9lVXfkyExjX1cxjnGMO738NHfLsXP3ztGJ2gvENWuID/d14LTkTJhlAuqy5OSfNJMQ+lBEscpgUo4dAUpFd1HOxeyJYpI1yD7e6MF2NAQOaZ66OA5iR+avayvRXonzbVK4kazFIZ1vMndB7nVgSYW2K8aF+E5+W+0qZuVtGoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3EE1214017B;
	Tue, 27 Jan 2026 14:33:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 550826000D;
	Tue, 27 Jan 2026 14:33:56 +0000 (UTC)
Date: Tue, 27 Jan 2026 09:34:01 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: sunliming@linux.dev
Cc: ostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, sunliming
 <sunliming@kylinos.cn>
Subject: Re: [PATCH] tracing: kprobe-event: Return directly when trace
 kprobes is empty
Message-ID: <20260127093401.2c2aaf18@gandalf.local.home>
In-Reply-To: <20260127020137.90205-1-sunliming@linux.dev>
References: <20260127020137.90205-1-sunliming@linux.dev>
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
X-Rspamd-Queue-Id: 550826000D
X-Stat-Signature: u7um1ju47wjs3kat893q4tpro44gjfq6
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xwLJng+qgr05KBD58k4iHHWgMv0Yu5+k=
X-HE-Tag: 1769524436-668206
X-HE-Meta: U2FsdGVkX1/w7IdpycVn+KsSZwX5Odhq6JGuP2Knon7z1oS6KvOVOSWCkBpOhfYYXfzemRETKiIOGwDs4vrG9SDTUbu0AFpl8WVm7Rod5F/zRV3spofhiua6jw9mvTS2V3zY9U0jaQbgq+nS5XK2i5C0zIA9CydxR3fegvdrVZPUKlwHqsW/zXlKIa0b3XdaXQKnaImYpIuIo2Q4/emjCD8v21lGglmiAstxdlb0fzmA6oAHgedM+d9uBGqowbFN9haKiaGs4zkgSimoSAUgM83hRiFXJPVzMs96hc8saibN8qkpAwypRR9fSOdznepvg0T1U/fJa42sGPEO29MrTU6iBUyRgnBh2xpzB1F624NNHI3UzrykSxJwvujSR7Jm

On Tue, 27 Jan 2026 10:01:37 +0800
sunliming@linux.dev wrote:

> From: sunliming <sunliming@kylinos.cn>
> 
> In enable_boot_kprobe_events(), it returns directly when trace kprobes is
> empty, thereby reducing the function's execution time. This function may
> otherwise wait for the event_mutex lock for tens of milliseconds on certain
> machines, which is unnecessary when trace kprobes is empty.
> 
> Signed-off-by: sunliming <sunliming@kylinos.cn>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Thanks,

-- Steve

> ---
>  kernel/trace/trace_kprobe.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 9953506370a5..95f2c42603d5 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -82,6 +82,7 @@ static struct trace_kprobe *to_trace_kprobe(struct dyn_event *ev)
>  #define for_each_trace_kprobe(pos, dpos)	\
>  	for_each_dyn_event(dpos)		\
>  		if (is_trace_kprobe(dpos) && (pos = to_trace_kprobe(dpos)))
> +#define trace_kprobe_list_empty() list_empty(&dyn_event_list)
>  
>  static nokprobe_inline bool trace_kprobe_is_return(struct trace_kprobe *tk)
>  {
> @@ -1982,6 +1983,9 @@ static __init void enable_boot_kprobe_events(void)
>  	struct trace_kprobe *tk;
>  	struct dyn_event *pos;
>  
> +	if (trace_kprobe_list_empty())
> +		return;
> +
>  	guard(mutex)(&event_mutex);
>  	for_each_trace_kprobe(tk, pos) {
>  		list_for_each_entry(file, &tr->events, list)

