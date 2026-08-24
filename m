Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68582385D87;
	Mon, 24 Aug 2026 18:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787597000; cv=none; b=Iwh0eeSW8xmABbEiXt1oWHHkfQu4MY2/U3nQ+NEqtuunhEVhkOjuCpBKvJvxik4B4yfy+Iw22oHFpvtEh2xYwSrziuhmae8UxfJ5ZtncL2KouLA2Z2SMge21CsCDeGpOg7ij4JAxV7PZMTxdsm4/pqSSNdgpTeuSqCRH7r2g13s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787597000; c=relaxed/simple;
	bh=FSuQmUo0iqWhtDwWqUYUBJz/HdaOD2VoEDo0486UoSA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qW2/p/Hvy1oublNOzh5oxUQdAwX93Tyb9+6P2Aqzkp18ZoqgXSUrxlfA9D788VT2e0Q35UavdOAOAqsk3weGFcwN0r+23k18VDIgWFKfFaFDWX7BlN+rQ8MvIZEOQmLsEK+gcdVS16ae1Yvc7mkIyxFVygamJZDtphw88dKstBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=i6EONYa7; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="i6EONYa7"
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id E4694120230;
	Mon, 24 Aug 2026 18:43:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 30BFF20025;
	Mon, 24 Aug 2026 18:43:15 +0000 (UTC)
Date: Mon, 24 Aug 2026 14:43:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix use-after-free on field name/type of
 dynamic probe events
Message-ID: <20260824144356.1f61aea2@gandalf.local.home>
In-Reply-To: <20260824071011.3507735-1-bsdhenrymartin@gmail.com>
References: <20260824071011.3507735-1-bsdhenrymartin@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 30BFF20025
X-Stat-Signature: y5qcrnjnqpnfw6peo16sjeb4d36f5wrt
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+SS6+Jwfb6k89p5Y7Nx0LYUTYU9mJEKfc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=uW9DFvO3H72yL8XxwGWr/EmkKfDWmi/pR8xOkgXavno=; b=i6EONYa79Gi/C+8e6Pgh5Iw7SSywjb5BXfRepTgccfpIDBiaw2rAFoZX4Vs7XErPFK4UCVbraB5jkoyDrubgc0L2L7eFMYoTARU9HjjQrT32zrmI2c5jz7bfPNFcDNAuAlaTVEXBkGWRrLvwJv4Plp2184/7iaSIqfHXrmd4dtU=
X-HE-Tag: 1787596995-587064
X-HE-Meta: U2FsdGVkX1+bfwFaEJqAfp09NEKE8WyILDnogooxRpMGBGMxMkcxwV1KjOzorT4GrgBU61G51haFKIhCS9fnVlTIoeCFezToRclkWrUZxl9SDEZpQmkWGdM5ydmhA7FAIOTiQow8nO3PMzLyuBfFE0Bu3A1f7YUCYqDw8A9IosJggIjx6ns0Cu+QxNbz8b6wgE4StKRlfum9UQZBm29xiUDlFs+EZJu09Hu5ZXob5Dob3niwCFL4pij3AHFuDlj1FbAXrg9ES8xWsWG5TOd+QLFXZEFCp50wEscaYvtOPrbYzG0nacJPGYi4dNWK1HL6hUUoxqOk1+VQPpBZsFrDNrwCUn8zXIyu

On Mon, 24 Aug 2026 15:10:11 +0800
Henry Martin <bsdhenrymartin@gmail.com> wrote:

> Fields of a probe-based dynamic event (kprobe, uprobe and eprobe
> events) are created from the argument name and type strings of the
> trace_probe that first registers the event, as plain pointer
> references without copying.
> 
> When several probes are appended to the same event, they share the
> trace_event_call and its field list, which stays the one defined by
> the primary probe. Deleting just the primary probe with

What do you mean by "appended to the same event"? Do you mean eprobes?

Can you post a reproducer for this?

> "-:group/event symbol" frees the trace_probe and its argument
> strings, while the event call is kept registered by the remaining
> sibling probes. field->name and field->type are left dangling, and
> any field lookup - e.g. writing to events/<grp>/<ev>/filter - reads
> freed memory:
> 
>   BUG: KASAN: slab-use-after-free in strcmp+0xa7/0xb0
>   Call trace:
>    trace_find_event_field+0xd6/0x220
>    parse_pred
>    process_preds
>    create_filter
>    apply_event_filter
>    event_filter_write
> 
> Make the field own its strings: duplicate name and type with
> kstrdup_const() in __trace_define_field() and release them with
> kfree_const() in trace_destroy_fields(). Fields of static trace
> events still reference their kernel/module rodata string literals
> directly, as kstrdup_const()/kfree_const() only touch memory that
> was actually allocated.

Wrong fix.

> 
> The issue was found by the autokbug dynamic kernel fuzzer at Tencent
> Yunding Lab.
> 
> Fixes: ca89bc071d5e4 ("tracing/kprobe: Add multi-probe per event support")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  kernel/trace/trace_events.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index c01b10b99f67e..ee3b93fa09ee8 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c

This is a bug with trace_probes.c and not trace_events.c. This should be
fixed without touching trace_events.c. That is, the trace_probes.c code (or
trace_eprobes.c if it's only affects eprobes) should handle this issue.

If you had an example, I could have figured out exactly where to place the
fix.

-- Steve

> @@ -123,8 +123,18 @@ static int __trace_define_field(struct list_head *head, const char *type,
>  	if (!field)
>  		return -ENOMEM;
>  
> -	field->name = name;
> -	field->type = type;
> +	field->name = kstrdup_const(name, GFP_TRACE);
> +	if (!field->name) {
> +		kmem_cache_free(field_cachep, field);
> +		return -ENOMEM;
> +	}
> +
> +	field->type = kstrdup_const(type, GFP_TRACE);
> +	if (!field->type) {
> +		kfree_const(field->name);
> +		kmem_cache_free(field_cachep, field);
> +		return -ENOMEM;
> +	}
>  
>  	if (filter_type == FILTER_OTHER)
>  		field->filter_type = filter_assign_type(type);
> @@ -225,6 +235,8 @@ static void trace_destroy_fields(struct trace_event_call *call)
>  	head = trace_get_fields(call);
>  	list_for_each_entry_safe(field, next, head, link) {
>  		list_del(&field->link);
> +		kfree_const(field->name);
> +		kfree_const(field->type);
>  		kmem_cache_free(field_cachep, field);
>  	}
>  }

