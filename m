Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E42199FA8;
	Sat, 22 Mar 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742634186; cv=none; b=VagXmDqUTmBoFdvMD1qX9uZ/QdERYCONPpyx93LEQAJPUZSU6+eLMir2Wjav45aOutecONFLPcextUv2y2TzOdOnJqfzlNukm9Zg+hiqcdskGs4oMfxWM9mqYc1BQdnQ046F1K/8F8Vl0QeKrYsHsbQHG7B7P/JRuBYj4aMJTag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742634186; c=relaxed/simple;
	bh=Jsw3ITARuCPViYmaZEDXSUbjem35YyRrAqGXhw8UeOE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAvio4KcAYU2daXInnEzyeceGW91k6ElJvMxAPW6pwR+shQNzqzABtYrkvyqQIc3kMoJGkVC9/eLXCFwChkhsn4OpqbLSMF3IFEz6bSUSPH11w2Gl4DNeIGm+S250fzjLO+X6PpE+5kmyddJbBMfp7Ks+M4+cEEaXWmsJiO6MVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7BDC4CEDD;
	Sat, 22 Mar 2025 09:03:04 +0000 (UTC)
Date: Sat, 22 Mar 2025 05:03:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Liu <liumartin@google.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/3] mm/page_alloc: Add trace event for per-zone
 lowmem reserve setup
Message-ID: <20250322050300.3c470f61@batman.local.home>
In-Reply-To: <20250308034606.2036033-3-liumartin@google.com>
References: <20250308034606.2036033-1-liumartin@google.com>
	<20250308034606.2036033-3-liumartin@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  8 Mar 2025 03:46:01 +0000
Martin Liu <liumartin@google.com> wrote:

> ---
>  include/trace/events/kmem.h | 27 +++++++++++++++++++++++++++
>  mm/page_alloc.c             |  2 ++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/include/trace/events/kmem.h b/include/trace/events/kmem.h
> index 5fd392dae503..9623e68d4d26 100644
> --- a/include/trace/events/kmem.h
> +++ b/include/trace/events/kmem.h
> @@ -375,6 +375,33 @@ TRACE_EVENT(mm_setup_per_zone_wmarks,
>  		  __entry->watermark_promo)
>  );
>  
> +TRACE_EVENT(mm_setup_per_zone_lowmem_reserve,
> +
> +	TP_PROTO(struct zone *zone, struct zone *upper_zone, long lowmem_reserve),
> +
> +	TP_ARGS(zone, upper_zone, lowmem_reserve),
> +
> +	TP_STRUCT__entry(
> +		__field(int, node_id)
> +		__string(name, zone->name)
> +		__string(upper_name, upper_zone->name)
> +		__field(long, lowmem_reserve)

Nit, but may be useful. If you want to remove "holes" from the trace
event, I would move the lowmem_reserve to the top. The __string() macro
adds a 4 byte meta data into the structure (that defines the size and
offset of where the string is). That means you can think of __string()
as the same as "int".

The above has three int's followed by a long which on 64bit, would
leave a 4 byte hole just before lowmem_reserve.

-- Steve


> +	),
> +
> +	TP_fast_assign(
> +		__entry->node_id = zone->zone_pgdat->node_id;
> +		__assign_str(name);
> +		__assign_str(upper_name);
> +		__entry->lowmem_reserve = lowmem_reserve;
> +	),
> +
> +	TP_printk("node_id=%d zone name=%s upper_zone name=%s lowmem_reserve_pages=%ld",
> +		  __entry->node_id,
> +		  __get_str(name),
> +		  __get_str(upper_name),
> +		  __entry->lowmem_reserve)
> +);
> +
