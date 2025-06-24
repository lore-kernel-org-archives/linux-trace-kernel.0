Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729F518C00;
	Tue, 24 Jun 2025 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750751096; cv=none; b=IsevDdLp9Aa3S4YD2WagVZvzaQsQQN82VqIlapLQjRp0Hp6lhcHYuGNFvphIR0XPuGV6xMi7TeXRN4mQf6wkLan3Gwc2ETlWgS8w8FmyI3rDB1DYp5wsmzbk4Oh4O25TvJRAE9lwJxri7XVELDUO8SMqOc/6qewbrirfY8bRjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750751096; c=relaxed/simple;
	bh=JPANF/AZaxCFtSECm0DM907Szo/dW1rQ1TnKB5Hs2Tc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=a9Ikw2YPi1O2u/MyqFP2obA/jdrGoqWIhYjLKFSeuXMa5tgF97t3Ys/oROiAQI8LrLrjXAZqHBqxEvv6hkA6rBA+bQqY7OYiOr108awklBky1bhjssiGBh6urw/9MtSPaG7Wv70IayPGW61MVjn5/CReOlGacR1091QB5+NdOe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aX5Eal8A; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aX5Eal8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BEBC4CEE3;
	Tue, 24 Jun 2025 07:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750751095;
	bh=JPANF/AZaxCFtSECm0DM907Szo/dW1rQ1TnKB5Hs2Tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aX5Eal8A9ri4vis/Clh7HnU804P1NqMwrBwHRDpDG+s9uBRIAE58EEe+pWPQImXH4
	 HgpdYThd/9W/D7IqlWs5IPBDuyezgWfw9Ls7NbrV/7lXeWC4cMSWyl7dsDDkmQQ/N2
	 1GDdcdv6NIimV8CgKm0QakpTsaxJSdvgEPXRb6WrnxcrVlevL4HWznHrTb5aDE6LOb
	 /bFUgTlQ3bi9o0ZwUTDYdjxvmb9AoltgDVbmBCYATHrNe6W3kGKGOJGGIYq22mQker
	 lW6jptqSg9ysv86rBmkWV3lVfG2pZ4ZnvTyNQRoyaslTcFUbHTVEsuFM6rGBNwNWs1
	 EA3gXnlWiVDZA==
Date: Tue, 24 Jun 2025 16:44:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Edward Adam Davis <eadavis@qq.com>
Cc: syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org,
 syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] tracing: Fix filter logic error
Message-Id: <20250624164453.e982cae14fbf3b53d477e2be@kernel.org>
In-Reply-To: <tencent_4EF87A626D702F816CD0951CE956EC32CD0A@qq.com>
References: <6859ea24.a00a0220.2e5631.0044.GAE@google.com>
	<tencent_4EF87A626D702F816CD0951CE956EC32CD0A@qq.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Jun 2025 14:38:46 +0800
Edward Adam Davis <eadavis@qq.com> wrote:

> If the processing of the tr->events loop fails, the filter that has been
> added to filter_head will be released twice in free_filter_list(&head->rcu)
> and __free_filter(filter).
> 
> After adding the filter of tr->events, add the filter to the filter_head
> process to avoid triggering uaf.

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Fixes: a9d0aab5eb33 ("tracing: Fix regression of filter waiting a long time on RCU synchronization")
> Reported-by: syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=daba72c4af9915e9c894
> Tested-by: syzbot+daba72c4af9915e9c894@syzkaller.appspotmail.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>  kernel/trace/trace_events_filter.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> index 08141f105c95..3885aadc434d 100644
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1436,13 +1436,6 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
>  
>  	INIT_LIST_HEAD(&head->list);
>  
> -	item = kmalloc(sizeof(*item), GFP_KERNEL);
> -	if (!item)
> -		goto free_now;
> -
> -	item->filter = filter;
> -	list_add_tail(&item->list, &head->list);
> -
>  	list_for_each_entry(file, &tr->events, list) {
>  		if (file->system != dir)
>  			continue;
> @@ -1454,6 +1447,13 @@ static void filter_free_subsystem_filters(struct trace_subsystem_dir *dir,
>  		event_clear_filter(file);
>  	}
>  
> +	item = kmalloc(sizeof(*item), GFP_KERNEL);
> +	if (!item)
> +		goto free_now;
> +
> +	item->filter = filter;
> +	list_add_tail(&item->list, &head->list);
> +
>  	delay_free_filter(head);
>  	return;
>   free_now:
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
