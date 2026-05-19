Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB30D31F9BC;
	Tue, 19 May 2026 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214272; cv=none; b=qdtQDtDi2xUVDyEkK+wsSHUnhkj2QU9plxzd5RKjDMXeU56spuNxzipFagg9xdHAuDsIV2dPHzIS3scs8Pl5O9n87FGDr/VmSe6QMtNvALO8EQ94oh29rcEsHjihKsxje5V8WdeahQkBt2PCt+HTxueTw70pi0VRRNwpc+o6LH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214272; c=relaxed/simple;
	bh=JzQwf96uMmsVwEgkPAHiiVgbsti/Ucve70FpeHK2mBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+DGkK2Msi0+h02XrNsI7fKZkN3fleMxnBpCVwwCbeNWzRVt/E4OHvGsXfqFAg7gnsFm4wtMfoloC1JD34RDYWgOKfk7WzKniPJVIG3cMIhx00hkI30omR2Cymh/DEjSjMGCeEcfbon5L55KScWZBzFY9zuZaHB7oXeyK9cPRwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 14E01A0817;
	Tue, 19 May 2026 18:11:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id C50FE80011;
	Tue, 19 May 2026 18:11:00 +0000 (UTC)
Date: Tue, 19 May 2026 14:10:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Artur Kowalski <arturkow2000@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Thierry
 Reding <thierry.reding@kernel.org>, Mikko Perttunen
 <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH] gpu: host1x: trace: fix string fields in host1x traces
Message-ID: <20260519141059.77435501@fedora>
In-Reply-To: <20260519-host1x-tracing-v1-1-55afb8cbd186@gmail.com>
References: <20260519-host1x-tracing-v1-1-55afb8cbd186@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: C50FE80011
X-Stat-Signature: xpqcsbqo78gty1mpegkwoku973y7mr1h
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/W3c424qVsGyfVgXyV2tsCvJap8oBrAyI=
X-HE-Tag: 1779214260-996226
X-HE-Meta: U2FsdGVkX19Qk5MP3D1yA12AY63lGkW9bVcsE3UjuzhkbvObzIv/XXvjSZiLZYe/r/eoxFZCiWBKSUPiTosSq9qucfNUOQq3P388mMt6wvGFKkpxDV/CmNS9ykP2MNrhPchDAZFoGAyxdurxjrIp25KxqRwYx/UO4Tgvr5ufr07G41oTmat36nK+LT+D5P60cO5EJP9ff6lNv1OPgH4ahtMSzJUMdVE79WCpvnWuk0HsbpiY/WC1qTH0Y+D+LGx/8agi8k5LJI4lutJDpQs5yFTYP69DS82S9ilZU0LsUJMAUElzvxkRaTJRUtNcjDzlRV0FHBww6LJWWZot6RXzKozddZwo/tYjgpXefYMS9XmoMJpbLcUsqfEqZ51VROcgACS2b6BKyZQJo7VU/39Kdw==

On Tue, 19 May 2026 12:16:43 +0200
Artur Kowalski <arturkow2000@gmail.com> wrote:

> Use __assign_str and __get_str as required by tracing subsystem. Fixes
> string fields being rejected by the verifier and unreadable from
> userspace.

Does anyone use these tracepoints? The fact that they have been broken
for 5 years and nobody noticed makes me think they are useless.

I rather remove them than fix them, but if someone thinks that these
are still useful then by all means apply this patch.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve


> 
> Tested on v6.18.21.
> 
> Signed-off-by: Artur Kowalski <arturkow2000@gmail.com>
> ---
>  include/trace/events/host1x.h | 50 ++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
> 
> diff --git a/include/trace/events/host1x.h b/include/trace/events/host1x.h
> index 1ba84b738e46..1b6aeb7b177b 100644
> --- a/include/trace/events/host1x.h
> +++ b/include/trace/events/host1x.h
> @@ -21,9 +21,11 @@ struct host1x_bo;
>  DECLARE_EVENT_CLASS(host1x,
>  	TP_PROTO(const char *name),
>  	TP_ARGS(name),
> -	TP_STRUCT__entry(__field(const char *, name)),
> -	TP_fast_assign(__entry->name = name;),
> -	TP_printk("name=%s", __entry->name)
> +	TP_STRUCT__entry(__string(name, name)),
> +	TP_fast_assign(
> +		__assign_str(name);
> +	),
> +	TP_printk("name=%s", __get_str(name))
>  );
>  
>  DEFINE_EVENT(host1x, host1x_channel_open,
> @@ -52,19 +54,19 @@ TRACE_EVENT(host1x_cdma_push,
>  	TP_ARGS(name, op1, op2),
>  
>  	TP_STRUCT__entry(
> -		__field(const char *, name)
> +		__string(name, name)
>  		__field(u32, op1)
>  		__field(u32, op2)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->name = name;
> +		__assign_str(name);
>  		__entry->op1 = op1;
>  		__entry->op2 = op2;
>  	),
>  
>  	TP_printk("name=%s, op1=%08x, op2=%08x",
> -		__entry->name, __entry->op1, __entry->op2)
> +		__get_str(name), __entry->op1, __entry->op2)
>  );
>  
>  TRACE_EVENT(host1x_cdma_push_wide,
> @@ -73,7 +75,7 @@ TRACE_EVENT(host1x_cdma_push_wide,
>  	TP_ARGS(name, op1, op2, op3, op4),
>  
>  	TP_STRUCT__entry(
> -		__field(const char *, name)
> +		__string(name, name)
>  		__field(u32, op1)
>  		__field(u32, op2)
>  		__field(u32, op3)
> @@ -81,7 +83,7 @@ TRACE_EVENT(host1x_cdma_push_wide,
>  	),
>  
>  	TP_fast_assign(
> -		__entry->name = name;
> +		__assign_str(name);
>  		__entry->op1 = op1;
>  		__entry->op2 = op2;
>  		__entry->op3 = op3;
> @@ -89,7 +91,7 @@ TRACE_EVENT(host1x_cdma_push_wide,
>  	),
>  
>  	TP_printk("name=%s, op1=%08x, op2=%08x, op3=%08x op4=%08x",
> -		__entry->name, __entry->op1, __entry->op2, __entry->op3,
> +		__get_str(name), __entry->op1, __entry->op2, __entry->op3,
>  		__entry->op4)
>  );
>  
> @@ -100,7 +102,7 @@ TRACE_EVENT(host1x_cdma_push_gather,
>  	TP_ARGS(name, bo, words, offset, cmdbuf),
>  
>  	TP_STRUCT__entry(
> -		__field(const char *, name)
> +		__string(name, name)
>  		__field(struct host1x_bo *, bo)
>  		__field(u32, words)
>  		__field(u32, offset)
> @@ -114,14 +116,14 @@ TRACE_EVENT(host1x_cdma_push_gather,
>  					words * sizeof(u32));
>  		}
>  		__entry->cmdbuf = cmdbuf;
> -		__entry->name = name;
> +		__assign_str(name);
>  		__entry->bo = bo;
>  		__entry->words = words;
>  		__entry->offset = offset;
>  	),
>  
>  	TP_printk("name=%s, bo=%p, words=%u, offset=%d, contents=[%s]",
> -	  __entry->name, __entry->bo,
> +	  __get_str(name), __entry->bo,
>  	  __entry->words, __entry->offset,
>  	  __print_hex(__get_dynamic_array(cmdbuf),
>  		  __entry->cmdbuf ? __entry->words * 4 : 0))
> @@ -134,7 +136,7 @@ TRACE_EVENT(host1x_channel_submit,
>  	TP_ARGS(name, cmdbufs, relocs, syncpt_id, syncpt_incrs),
>  
>  	TP_STRUCT__entry(
> -		__field(const char *, name)
> +		__string(name, name)
>  		__field(u32, cmdbufs)
>  		__field(u32, relocs)
>  		__field(u32, syncpt_id)
> @@ -142,7 +144,7 @@ TRACE_EVENT(host1x_channel_submit,
>  	),
>  
>  	TP_fast_assign(
> -		__entry->name = name;
> +		__assign_str(name);
>  		__entry->cmdbufs = cmdbufs;
>  		__entry->relocs = relocs;
>  		__entry->syncpt_id = syncpt_id;
> @@ -151,7 +153,7 @@ TRACE_EVENT(host1x_channel_submit,
>  
>  	TP_printk("name=%s, cmdbufs=%u, relocs=%u, syncpt_id=%u, "
>  		  "syncpt_incrs=%u",
> -		  __entry->name, __entry->cmdbufs, __entry->relocs,
> +		  __get_str(name), __entry->cmdbufs, __entry->relocs,
>  		  __entry->syncpt_id, __entry->syncpt_incrs)
>  );
>  
> @@ -161,19 +163,19 @@ TRACE_EVENT(host1x_channel_submitted,
>  	TP_ARGS(name, syncpt_base, syncpt_max),
>  
>  	TP_STRUCT__entry(
> -		__field(const char *, name)
> +		__string(name, name)
>  		__field(u32, syncpt_base)
>  		__field(u32, syncpt_max)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->name = name;
> +		__assign_str(name);
>  		__entry->syncpt_base = syncpt_base;
>  		__entry->syncpt_max = syncpt_max;
>  	),
>  
>  	TP_printk("name=%s, syncpt_base=%d, syncpt_max=%d",
> -		__entry->name, __entry->syncpt_base, __entry->syncpt_max)
> +		__get_str(name), __entry->syncpt_base, __entry->syncpt_max)
>  );
>  
>  TRACE_EVENT(host1x_channel_submit_complete,
> @@ -182,19 +184,19 @@ TRACE_EVENT(host1x_channel_submit_complete,
>  	TP_ARGS(name, count, thresh),
>  
>  	TP_STRUCT__entry(
> -		__field(const char *, name)
> +		__string(name, name)
>  		__field(int, count)
>  		__field(u32, thresh)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->name = name;
> +		__assign_str(name);
>  		__entry->count = count;
>  		__entry->thresh = thresh;
>  	),
>  
>  	TP_printk("name=%s, count=%d, thresh=%d",
> -		__entry->name, __entry->count, __entry->thresh)
> +		__get_str(name), __entry->count, __entry->thresh)
>  );
>  
>  TRACE_EVENT(host1x_wait_cdma,
> @@ -203,16 +205,16 @@ TRACE_EVENT(host1x_wait_cdma,
>  	TP_ARGS(name, eventid),
>  
>  	TP_STRUCT__entry(
> -		__field(const char *, name)
> +		__string(name, name)
>  		__field(u32, eventid)
>  	),
>  
>  	TP_fast_assign(
> -		__entry->name = name;
> +		__assign_str(name);
>  		__entry->eventid = eventid;
>  	),
>  
> -	TP_printk("name=%s, event=%d", __entry->name, __entry->eventid)
> +	TP_printk("name=%s, event=%d", __get_str(name), __entry->eventid)
>  );
>  
>  TRACE_EVENT(host1x_syncpt_load_min,
> 
> ---
> base-commit: ab5fce87a778cb780a05984a2ca448f2b41aafbf
> change-id: 20260519-host1x-tracing-e2d608ec5e37
> 
> Best regards,
> --  
> Artur Kowalski <arturkow2000@gmail.com>

