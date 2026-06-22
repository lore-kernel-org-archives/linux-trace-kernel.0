Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C2E3451C8;
	Mon, 22 Jun 2026 03:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782100752; cv=none; b=NsNTUeM7e3H9HuYDZyO7iL2ixLnRUnP6IGYEKA9vm/Ndrm17RLI3og4HjYawPUS+KQQGWXz9UyLcaqsjDETY7VxOxJGYMhAPvjxxMOJHeMUnH71ZuRnpcOZZEw8WBb4cFxB8WpZCYlvfNbq9FWGNRkfGzWRApQsFWaCMyeuOdC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782100752; c=relaxed/simple;
	bh=kB6QFowOyGZvRR6S465cpWDZhqa5nrSt8U4Ordw1wzY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IjzxoiWi4ycVLrsLIuZf1mwTvoohxLwG21CSpKGxbLyyMiQ2OriqlF9LL+XHiJpAN6ybboEJA48HfuvrxLdWykP2C13vZvumzSCWcAOs0lZWPLeBjfknUZuh4aBz4fU9vFalzo1i5hREDQSWMCfcln9pveR2OkT7iYrbOCLKgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3zd2fbD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3zd2fbD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FCD1F000E9;
	Mon, 22 Jun 2026 03:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782100750;
	bh=w5m8O+NPja5s16yXb+EGXUVGCTi5ADiUilH0E9bcCEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z3zd2fbD7WPyACQiA3E2DG2r3L7nKgKfjDhVFJBreccTNe6Pkn6GN08RLLMJU836D
	 Y4xBG1Ss0EWQMHEYunrc0lLtoefgB15eJmtxGPTZQ6yuUHxBUOexyOJlUoCgvrs3y+
	 uFRphMnzycPb7t+HhWJ86aP4qgvO711PscaFBOiS29x18gAZp+kAXIdy1NY5GwNSRh
	 D0nl9G7nD7CjruvCzONWLusB2OoXcQ3+nTMfWwC4M1WU8lmS46JNnRQeljgR9Fc6WN
	 9DI/BWXEppXqFR4tmArHi75hNboaL4VSZxInIavxPytFtmfjy2HsNae9K4MHhWAzKG
	 lC87/O9mXUwTw==
Date: Mon, 22 Jun 2026 12:59:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-Id: <20260622125908.edfca672f28208ecac97091f@kernel.org>
In-Reply-To: <20260620145339.3234726-1-martin@kaiser.cx>
References: <20260620145339.3234726-1-martin@kaiser.cx>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Jun 2026 16:48:59 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> For a char * element in an event, the FILTER_PTR_STRING filter type is
> used. When the event occurs, a pointer is stored in the ringbuffer.
> 
> If an eprobe references such a char * element of a "base event", the
> stored pointer is truncated when it's read from the ringbuffer.
> 
> $ cd /sys/kernel/tracing
> $ echo 'e rcu.rcu_utilization $s:x64 $s:string' > dynamic_events
> $ echo 1 > tracing_on
> $ echo 1 > events/eprobes/enable
> $ sleep 1
> $ echo 0 > events/eprobes/enable
> $ cat trace
>    <idle>-0  ...: (rcu.rcu_utilization) arg1=0x4f arg2=(fault)
>    <idle>-0  ...: (rcu.rcu_utilization) arg1=0x2 arg2=(fault)
> 
> The problem is in get_event_field
> 
> 	val = (unsigned long)(*(char *)addr);
> 
> addr points to the position in the ringbuffer where the pointer was
> stored. The assignment reads only the lowest byte of the pointer.
> 
> Fix the cast to read the whole pointer. The output of the test above
> is now
> 
> <idle>-0 ... arg1=0xffffffff81c7d3f3 arg2="Start scheduler-tick"
> <idle>-0 ... arg1=0xffffffff81c57340 arg2="End scheduler-tick"

This looks good to me. Let me pick it.

Thanks!

> 
> Fixes: f04dec93466a ("tracing/eprobes: Fix reading of string fields")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
> v2
>  - use rcu event as an example, don't dereference a user pointer
>  - add Fixes tag
> 
>  kernel/trace/trace_eprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index b66d6196338d..50518b071414 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -315,7 +315,7 @@ get_event_field(struct fetch_insn *code, void *rec)
>  			val = (unsigned long)addr;
>  			break;
>  		case FILTER_PTR_STRING:
> -			val = (unsigned long)(*(char *)addr);
> +			val = *(unsigned long *)addr;
>  			break;
>  		default:
>  			WARN_ON_ONCE(1);
> -- 
> 2.43.7
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
