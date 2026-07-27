Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C38242BC30;
	Mon, 27 Jul 2026 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183670; cv=none; b=REIACYdk4bBuHUM+ZZ9ToNDygJIjKQsAsCnsWancje6D26dFPkq1fMS2CdUti7kpxyR4sAXBJz2asaHYHbbeBN4ZO8/UMl2+WZMBudT9XpGMwDP50Gu3fb0FAMX5/kBcz7i2st/41qps6Kiau9NqlssZapjX5I2XbEj9uSd2Xeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183670; c=relaxed/simple;
	bh=Ycss83zuq3aSxDrgKovPC45PXkQ6YNSZo8S6VnfTW5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fTlH9Zxa+WJVXzStobOwYlctDGgrQiTKYhOy3+FX7iaPRaRnvDPHcA25A5Wy1QJT/KLcKEEvXjMRqMB5YabJMpAChNxqpoHvHzMtN98Dw8kpttrH+IF1Or9Wu2Axz07E5IBl209gV8GNtW43EQb3y3MUSh7ttHvQGmqvcL+70Ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 699471401ED;
	Mon, 27 Jul 2026 20:20:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 644302000F;
	Mon, 27 Jul 2026 20:20:50 +0000 (UTC)
Date: Mon, 27 Jul 2026 16:21:22 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Eugene Mavick <m@mavick.dev>
Cc: Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Gary
 Guo <gary@garyguo.net>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo
 <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org
Subject: Re: [PATCH v3 1/5] tracing: add ref_trace_final_put tracepoint
Message-ID: <20260727162122.39f292fe@gandalf.local.home>
In-Reply-To: <20260711-refcount-final-put-trace-v3-1-674c8f03d9f9@mavick.dev>
References: <20260711-refcount-final-put-trace-v3-0-674c8f03d9f9@mavick.dev>
	<20260711-refcount-final-put-trace-v3-1-674c8f03d9f9@mavick.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: fgcfqqm13143u3ims6rkybjnkfsaj7qa
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 644302000F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+U+kKjBbPFD54KqmqnnY4FS5W9hOMdd5g=
X-HE-Tag: 1785183650-206634
X-HE-Meta: U2FsdGVkX19FO7mRN3KFTDvCHJwoCxA+GKzV5oe1wAT+Fjd5iIGO8q/9zt375ZLf4Ob80IvMvlnJGLG/tCdIh7OhHlhDp2W0SrUYescMSrcsCWVZ+JGZxAhwb9MqKSoU6YXSLi+R9qwmL2wdFt9vLAyeD1JY+iai+6uPt5Qwj7ztXOTUSVN2F4fhMQTT+mVjzWxIocKOOTzF71pXyLJPaauqDBCOAw3gbEUYZJMk1HoBZD5Y07/cmp94BTidwr0ft2PIuSmhbywuqLfRkdwWpzsz4VRotMPAcsdf5u3qcuOVYzN6nCVtkwAnVqPfFpMda5z6R0q8sr0WJ1L9isOap/EvRPTWfIBB

On Sat, 11 Jul 2026 12:40:19 +0800
Eugene Mavick <m@mavick.dev> wrote:

> Add ref_trace_final_put tracepoint and related core infrastructure
> 
> ref_trace_final_put fires when a reference
> count reaches zero and the object enters its final release path.
> 
> The tracepoint records three fields:
> - caller: function that called the refcounting
>   function(refcount_sub_and_test, percpu_ref_put_many)
> - fn: refcounting function(eg refcount_sub_and_test)

Why save the string just to figure out which function is used. It's quite
expensive in both recording the string and saving the name all over the
place.

> - obj: refcount object(struct percpu_ref, refcount_t)
> 
> Signed-off-by: Eugene Mavick <m@mavick.dev>
> ---
>  include/linux/ref_trace.h        | 26 +++++++++++++++++++++++
>  include/trace/events/ref_trace.h | 46 ++++++++++++++++++++++++++++++++++++++++
>  lib/Makefile                     |  2 ++
>  lib/ref_trace.c                  | 13 ++++++++++++
>  4 files changed, 87 insertions(+)
> 
> diff --git a/include/linux/ref_trace.h b/include/linux/ref_trace.h
> new file mode 100644
> index 000000000000..6c6600938a47
> --- /dev/null
> +++ b/include/linux/ref_trace.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_REF_TRACE_H
> +#define _LINUX_REF_TRACE_H
> +
> +#include <linux/tracepoint-defs.h>
> +#include <linux/instruction_pointer.h>
> +
> +/* Declare the tracepoint so tracepoint_enabled() can be used */
> +DECLARE_TRACEPOINT(ref_trace_final_put);
> +
> +#ifdef CONFIG_TRACEPOINTS
> +/* Wrapper function implemented in lib/ref_trace.c */
> +extern void do_ref_trace_final_put(unsigned long caller, const char *fn, const void *obj);
> +
> +#define do_trace_ref_final_put(obj)						\
> +	do {									\
> +		if (tracepoint_enabled(ref_trace_final_put))			\
> +			do_ref_trace_final_put(_RET_IP_, __func__, obj);	\

Why save __func__ and and not just __THIS_IP__?

The name is quite expensive to save and even to store in memory, as it will
*always* be there.

> +	} while (0)
> +
> +#else /* !CONFIG_TRACEPOINTS */
> +static inline void do_ref_trace_final_put(unsigned long caller, const char *fn, const void *obj) { }
> +#define do_trace_ref_final_put(obj) do { } while (0)
> +#endif
> +
> +#endif /* _LINUX_REF_TRACE_H */
> diff --git a/include/trace/events/ref_trace.h b/include/trace/events/ref_trace.h
> new file mode 100644
> index 000000000000..3bf1b1d390b8
> --- /dev/null
> +++ b/include/trace/events/ref_trace.h
> @@ -0,0 +1,46 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM ref_trace
> +
> +#if !defined(_TRACE_REF_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_REF_TRACE_H
> +
> +#include <linux/tracepoint.h>
> +
> +/**
> + * ref_trace_final_put - trace when a reference count reaches zero
> + * @caller: return address of refcount
> + * function(refcount_sub_and_test, percpu_ref_put_many)
> + * @fn: refcounting function(eg refcount_sub_and_test)
> + * @obj: refcount object(struct percpu_ref, refcount_t)
> + *
> + * Tracepoint instrumentation can be added using the do_ref_trace_final_put
> + * macro defined in include/linux/ref_trace.h
> + * which uses _RET_IP_ and __func__ for caller and fn arguments respectively,
> + * thus only requiring obj arg to be supplied
> + */
> +TRACE_EVENT(ref_trace_final_put,
> +
> +	TP_PROTO(unsigned long caller, const char *fn, const void *obj),
> +
> +	TP_ARGS(caller, fn, obj),
> +
> +	TP_STRUCT__entry(
> +	__field(unsigned long, caller)
> +	__string(fn, fn)
> +	__field(const void *, obj)

The TP_STRUCT__entry is to be in structure format:

	TP_STRUCT__entry(
		__field(	unsigned long,		caller	)
		__field(	unsigned long,		ip	)
		__field(	const void *,		obj	)
> +	),

See how much better that looks and easier to read. Just like writing:

struct entry {
	unsigned long	caller;
	unsigned long	ip;
	const void	*obj;
};

	
> +
> +	TP_fast_assign(
> +	__entry->caller = caller;
> +	__assign_str(fn);
> +	__entry->obj = obj;

The code should be indented:

	TP_fast_assign(
		__entry->caller = caller;
		__entry->ip = ip;
		__entry->obj = obj;
> +	),

> +
> +	TP_printk("caller=%pS fn=%s obj=%p", (void *)__entry->caller, __get_str(fn), __entry->obj)

	TP_printk("caller=%pS fn=%pS obj=%p", ...

-- Steve

> +);
> +
> +#endif /* _TRACE_REF_TRACE_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>
> diff --git a/lib/Makefile b/lib/Makefile
> index f33a24bf1c19..41737090a95d 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -335,3 +335,5 @@ CONTEXT_ANALYSIS_test_context-analysis.o := y
>  obj-$(CONFIG_CONTEXT_ANALYSIS_TEST) += test_context-analysis.o
>  
>  subdir-$(CONFIG_FORTIFY_SOURCE) += test_fortify
> +
> +obj-$(CONFIG_TRACEPOINTS) += ref_trace.o
> diff --git a/lib/ref_trace.c b/lib/ref_trace.c
> new file mode 100644
> index 000000000000..466647772ce1
> --- /dev/null
> +++ b/lib/ref_trace.c
> @@ -0,0 +1,13 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/ref_trace.h>
> +#include <linux/ref_trace.h>
> +
> +//Wrapper function for functions defined entirely in header files
> +void do_ref_trace_final_put(unsigned long caller, const char *fn, const void *obj)
> +{
> +	trace_call__ref_trace_final_put(caller, fn, obj);
> +}
> +EXPORT_SYMBOL_GPL(do_ref_trace_final_put);
> +
> +EXPORT_TRACEPOINT_SYMBOL_GPL(ref_trace_final_put);
> 

