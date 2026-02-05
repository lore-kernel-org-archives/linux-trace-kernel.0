Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31AE45C0B;
	Thu,  5 Feb 2026 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770252551; cv=none; b=OmHP8IrK6AlOEHq38yV+IkC7MSU89PJfT6JWg42F+oiE1G2QDWeOvdICJqGGBjG1Ldb6O7ixaLiQtBawFgt/PhScVXv/5mOfc2yCkutSY+QtqolyNjQwLQFTV+iyA94mC2mmVJUd3FRQSJfn9hf3ZklQLqpCyn0MLGhzHeWNYOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770252551; c=relaxed/simple;
	bh=f4DxYSCFK47ZZbbZ+11ZpPYwGbj7gm1yM2VT06/yQnE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CKfwxpghnzxkoOdRd3/XLAJ6LJU4/e4Do/nJnNG0XnplYpl6/Dh34n3OmerMn89cLssoV8HgtoxXwJLRib/yW9fLjUrbppK+jZl6RCTzNcDAqVlQdN3BYIpujkF/B8DGwyzcxeNl3OCIpaRb6xLaUG9SOH1YZ12JJxx5/BroGq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AfdONPiQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AfdONPiQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A418C4CEF7;
	Thu,  5 Feb 2026 00:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770252551;
	bh=f4DxYSCFK47ZZbbZ+11ZpPYwGbj7gm1yM2VT06/yQnE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AfdONPiQbCjTXrEYW48kcg6iUt/tqKUpC36XpE+vZo0yja/7QT/ZCNTRS7sIrGgW8
	 Knn7bGo404L7Hpxgjb8EaCoVfmCxKhGHCg+/BZUgMDRqcbL1qaxYATn8nzsjznW72w
	 aMvqd7ojZmISDhqX0b8FO3HlgxUH5lnVcX47JIQdVbpGZFRS68Gk0GQM+rEbnWEzlR
	 kZuUQmfKQEAKPOTqK69wy3ZruZSV8fmlJaNNTQ8HAjAviJTuTJLXRxA9zQF0QW5+3u
	 8mSsYaYYd3spErMZcCxu++wqUY5wmbd9p9/xnBIfw76o1foNhuamcpyJQhtw0RwPP5
	 ovgMbx58K6A0Q==
Date: Thu, 5 Feb 2026 09:49:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, "jempty.liang" <imntjempty@163.com>
Subject: Re: [PATCH v2] tracing: Fix ftrace event field alignments
Message-Id: <20260205094906.d0146fa92b5a8060d65a7055@kernel.org>
In-Reply-To: <20260204113628.53faec78@gandalf.local.home>
References: <20260204113628.53faec78@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Feb 2026 11:36:28 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The fields of ftrace specific events (events used to save ftrace internal
> events like function traces and trace_printk) are generated similarly to
> how normal trace event fields are generated. That is, the fields are added
> to a trace_events_fields array that saves the name, offset, size,
> alignment and signness of the field. It is used to produce the output in
> the format file in tracefs so that tooling knows how to parse the binary
> data of the trace events.
> 
> The issue is that some of the ftrace event structures are packed. The
> function graph exit event structures are one of them. The 64 bit calltime
> and rettime fields end up 4 byte aligned, but the algorithm to show to
> userspace shows them as 8 byte aligned.
> 
> The macros that create the ftrace events has one for embedded structure
> fields. There's two macros for theses fields:
> 
>   __field_desc() and __field_packed()
> 
> The difference of the latter macro is that it treats the field as packed.
> 
> Rename that field to __field_desc_packed() and create replace the
> __field_packed() to be a normal field that is packed and have the calltime
> and rettime use those.
> 
> This showed up on 32bit architectures for function graph time fields. It
> had:
> 
>  ~# cat /sys/kernel/tracing/events/ftrace/funcgraph_exit/format
> [..]
>         field:unsigned long func;       offset:8;       size:4; signed:0;
>         field:unsigned int depth;       offset:12;      size:4; signed:0;
>         field:unsigned int overrun;     offset:16;      size:4; signed:0;
>         field:unsigned long long calltime;      offset:24;      size:8; signed:0;
>         field:unsigned long long rettime;       offset:32;      size:8; signed:0;
> 
> Notice that overrun is at offset 16 with size 4, where in the structure
> calltime is at offset 20 (16 + 4), but it shows the offset at 24. That's
> because it used the alignment of unsigned long long when used as a
> declaration and not as a member of a structure where it would be aligned
> by word size (in this case 4).
> 
> By using the proper structure alignment, the format has it at the correct
> offset:
> 
>  ~# cat /sys/kernel/tracing/events/ftrace/funcgraph_exit/format
> [..]
>         field:unsigned long func;       offset:8;       size:4; signed:0;
>         field:unsigned int depth;       offset:12;      size:4; signed:0;
>         field:unsigned int overrun;     offset:16;      size:4; signed:0;
>         field:unsigned long long calltime;      offset:20;      size:8; signed:0;
>         field:unsigned long long rettime;       offset:28;      size:8; signed:0;
> 
> Cc: stable@vger.kernel.org
> Fixes: 04ae87a52074e ("ftrace: Rework event_create_dir()")
> Reported-by: "jempty.liang" <imntjempty@163.com>
> Closes: https://lore.kernel.org/all/20260130015740.212343-1-imntjempty@163.com/
> Closes: https://lore.kernel.org/all/20260202123342.2544795-1-imntjempty@163.com/
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> Changes since v1: https://patch.msgid.link/20260202113024.61d5c1fd@gandalf.local.home
> 
> - Instead of using an alignment for structures, create a new macro
>   called __field_desc_packed() to use for packed structure fields
>   and have __field_packed() be used for normal packed fields.
> 
>  kernel/trace/trace.h         |  7 +++++--
>  kernel/trace/trace_entries.h | 32 ++++++++++++++++----------------
>  kernel/trace/trace_export.c  | 21 +++++++++++++++------
>  3 files changed, 36 insertions(+), 24 deletions(-)
> 
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index b6d42fe06115..c11edec5d8f5 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -68,14 +68,17 @@ enum trace_type {
>  #undef __field_fn
>  #define __field_fn(type, item)		type	item;
>  
> +#undef __field_packed
> +#define __field_packed(type, item)	type	item;
> +
>  #undef __field_struct
>  #define __field_struct(type, item)	__field(type, item)
>  
>  #undef __field_desc
>  #define __field_desc(type, container, item)
>  
> -#undef __field_packed
> -#define __field_packed(type, container, item)
> +#undef __field_desc_packed
> +#define __field_desc_packed(type, container, item)
>  
>  #undef __array
>  #define __array(type, item, size)	type	item[size];
> diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> index f6a8d29c0d76..54417468fdeb 100644
> --- a/kernel/trace/trace_entries.h
> +++ b/kernel/trace/trace_entries.h
> @@ -79,8 +79,8 @@ FTRACE_ENTRY(funcgraph_entry, ftrace_graph_ent_entry,
>  
>  	F_STRUCT(
>  		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
> -		__field_packed(	unsigned long,	graph_ent,	func		)
> -		__field_packed(	unsigned long,	graph_ent,	depth		)
> +		__field_desc_packed(unsigned long,	graph_ent,	func	)
> +		__field_desc_packed(unsigned long,	graph_ent,	depth	)
>  		__dynamic_array(unsigned long,	args				)
>  	),
>  
> @@ -96,9 +96,9 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
>  
>  	F_STRUCT(
>  		__field_struct(	struct fgraph_retaddr_ent,	graph_rent	)
> -		__field_packed(	unsigned long,	graph_rent.ent,	func		)
> -		__field_packed(	unsigned long,	graph_rent.ent,	depth		)
> -		__field_packed(	unsigned long,	graph_rent,	retaddr		)
> +		__field_desc_packed(	unsigned long,	graph_rent.ent,	func	)
> +		__field_desc_packed(	unsigned long,	graph_rent.ent,	depth	)
> +		__field_desc_packed(	unsigned long,	graph_rent,	retaddr	)
>  		__dynamic_array(unsigned long,	args				)
>  	),
>  
> @@ -123,12 +123,12 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>  
>  	F_STRUCT(
>  		__field_struct(	struct ftrace_graph_ret,	ret	)
> -		__field_packed(	unsigned long,	ret,		func	)
> -		__field_packed(	unsigned long,	ret,		retval	)
> -		__field_packed(	unsigned int,	ret,		depth	)
> -		__field_packed(	unsigned int,	ret,		overrun	)
> -		__field(unsigned long long,	calltime		)
> -		__field(unsigned long long,	rettime			)
> +		__field_desc_packed(	unsigned long,	ret,	func	)
> +		__field_desc_packed(	unsigned long,	ret,	retval	)
> +		__field_desc_packed(	unsigned int,	ret,	depth	)
> +		__field_desc_packed(	unsigned int,	ret,	overrun	)
> +		__field_packed(unsigned long long,	calltime)
> +		__field_packed(unsigned long long,	rettime	)
>  	),
>  
>  	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u retval: %lx",
> @@ -146,11 +146,11 @@ FTRACE_ENTRY_PACKED(funcgraph_exit, ftrace_graph_ret_entry,
>  
>  	F_STRUCT(
>  		__field_struct(	struct ftrace_graph_ret,	ret	)
> -		__field_packed(	unsigned long,	ret,		func	)
> -		__field_packed(	unsigned int,	ret,		depth	)
> -		__field_packed(	unsigned int,	ret,		overrun	)
> -		__field(unsigned long long,	calltime		)
> -		__field(unsigned long long,	rettime			)
> +		__field_desc_packed(	unsigned long,	ret,	func	)
> +		__field_desc_packed(	unsigned int,	ret,	depth	)
> +		__field_desc_packed(	unsigned int,	ret,	overrun	)
> +		__field_packed(unsigned long long,	calltime	)
> +		__field_packed(unsigned long long,	rettime		)
>  	),
>  
>  	F_printk("<-- %ps (%u) (start: %llx  end: %llx) over: %u",
> diff --git a/kernel/trace/trace_export.c b/kernel/trace/trace_export.c
> index 1698fc22afa0..32a42ef31855 100644
> --- a/kernel/trace/trace_export.c
> +++ b/kernel/trace/trace_export.c
> @@ -42,11 +42,14 @@ static int ftrace_event_register(struct trace_event_call *call,
>  #undef __field_fn
>  #define __field_fn(type, item)				type item;
>  
> +#undef __field_packed
> +#define __field_packed(type, item)			type item;
> +
>  #undef __field_desc
>  #define __field_desc(type, container, item)		type item;
>  
> -#undef __field_packed
> -#define __field_packed(type, container, item)		type item;
> +#undef __field_desc_packed
> +#define __field_desc_packed(type, container, item)	type item;
>  
>  #undef __array
>  #define __array(type, item, size)			type item[size];
> @@ -104,11 +107,14 @@ static void __always_unused ____ftrace_check_##name(void)		\
>  #undef __field_fn
>  #define __field_fn(_type, _item) __field_ext(_type, _item, FILTER_TRACE_FN)
>  
> +#undef __field_packed
> +#define __field_packed(_type, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
> +
>  #undef __field_desc
>  #define __field_desc(_type, _container, _item) __field_ext(_type, _item, FILTER_OTHER)
>  
> -#undef __field_packed
> -#define __field_packed(_type, _container, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
> +#undef __field_desc_packed
> +#define __field_desc_packed(_type, _container, _item) __field_ext_packed(_type, _item, FILTER_OTHER)
>  
>  #undef __array
>  #define __array(_type, _item, _len) {					\
> @@ -146,11 +152,14 @@ static struct trace_event_fields ftrace_event_fields_##name[] = {	\
>  #undef __field_fn
>  #define __field_fn(type, item)
>  
> +#undef __field_packed
> +#define __field_packed(type, item)
> +
>  #undef __field_desc
>  #define __field_desc(type, container, item)
>  
> -#undef __field_packed
> -#define __field_packed(type, container, item)
> +#undef __field_desc_packed
> +#define __field_desc_packed(type, container, item)
>  
>  #undef __array
>  #define __array(type, item, len)
> -- 
> 2.51.0
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
