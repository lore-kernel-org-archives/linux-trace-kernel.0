Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435F525A641;
	Wed, 29 Jan 2025 01:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738112518; cv=none; b=K2tH98bCoyJBuOeKmL6sXOrm1bKJB5+YfT/SmUKRZeBIqauPFFezeGF+McTr5IAr0vANE4aGDyKU2ggHfchmYrJ1VXEX7jpaunWq0kRUdUihwY0x6Hs/6C9LlxvvdyqC6bR+a2EYB9GBiQ/ESgCSg49VYoYuP4S0PzPUaE66PD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738112518; c=relaxed/simple;
	bh=R2R8EfPMk5LuRwC0rVMqQRJnptE/LJTRjS2Csr4eypQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nK5u1EFX6lR6Vh5MMaFPllaUe77QMPUnZPe91pmONRYiscLxdRNKRz/iimnkJnGNUO5Uxm6Wxq3hx7ZBbMV8sROz1EyGgkhGbUDGySSZoML6rJcOt71EX8PLnOlt9uNB1D00r6Ka1xDXl68yEiY1NnNxMR8WHaskmspZipRvctw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaClBFan; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaClBFan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70001C4CED3;
	Wed, 29 Jan 2025 01:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738112517;
	bh=R2R8EfPMk5LuRwC0rVMqQRJnptE/LJTRjS2Csr4eypQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QaClBFanTwD7InYKOyTqKeeLbiAMsLRPoCG7ZQP/deC0p0Be8Ll59KJZx9VV34/lG
	 KAppbbErxRDEOgZsLg/h4y703UJsqNkqTamYj6Ma+dtuczjl0v+Qp8M7d4EDpQeUW7
	 vAUcGxxqxu8mLx4v1sYymLDWKqKOiY19TQl2qlVM3eMLG/rqZMZR7mU1g5cq+0k7zY
	 9YlBxEXbYR6/MbvNgbntv4wFnfuD69l3RjZS3p9EypTy/vOPamRRaoJxG85HOsFPtw
	 rRnPLB726bb2UfL5n3ANXFO+xPKKh+3QwKYno/0utN3TSA/Q4Dnxhll0oQIyYfygZ+
	 8h/bJUxWWILIA==
Date: Wed, 29 Jan 2025 10:01:53 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix DECLARE_TRACE_CONDITION
Message-Id: <20250129100153.26fae521f0fcbf444c70c375@kernel.org>
In-Reply-To: <20250128111926.303093-1-gmonaco@redhat.com>
References: <20250128111926.303093-1-gmonaco@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 12:19:26 +0100
Gabriele Monaco <gmonaco@redhat.com> wrote:

> Commit 287050d39026 ("tracing: Add TRACE_EVENT_CONDITIONAL()") adds
> macros to define conditional trace events (TRACE_EVENT_CONDITIONAL) and
> tracepoints (DECLARE_TRACE_CONDITION), but sets up functionality for
> direct use only for the former.
> Any attempt to use DECLARE_TRACE_CONDITION fails the build.
> 
> Add preprocessor bits in define_trace.h to allow usage of
> DECLARE_TRACE_CONDITION just like DECLARE_TRACE.
> 
> Fixes: 287050d39026 ("tracing: Add TRACE_EVENT_CONDITIONAL()")
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> ---
>  include/trace/define_trace.h | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/include/trace/define_trace.h b/include/trace/define_trace.h
> index e1c1079f8c8d..ed52d0506c69 100644
> --- a/include/trace/define_trace.h
> +++ b/include/trace/define_trace.h
> @@ -76,6 +76,10 @@
>  #define DECLARE_TRACE(name, proto, args)	\
>  	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
>  
> +#undef DECLARE_TRACE_CONDITION
> +#define DECLARE_TRACE_CONDITION(name, proto, args, cond)	\
> +	DEFINE_TRACE(name, PARAMS(proto), PARAMS(args))
> +
>  /* If requested, create helpers for calling these tracepoints from Rust. */
>  #ifdef CREATE_RUST_TRACE_POINTS
>  #undef DEFINE_RUST_DO_TRACE
> @@ -108,6 +112,8 @@
>  /* Make all open coded DECLARE_TRACE nops */
>  #undef DECLARE_TRACE
>  #define DECLARE_TRACE(name, proto, args)
> +#undef DECLARE_TRACE_CONDITION
> +#define DECLARE_TRACE_CONDITION(name, proto, args, cond)
>  
>  #ifdef TRACEPOINTS_ENABLED
>  #include <trace/trace_events.h>
> @@ -129,6 +135,7 @@
>  #undef DEFINE_EVENT_CONDITION
>  #undef TRACE_HEADER_MULTI_READ
>  #undef DECLARE_TRACE
> +#undef DECLARE_TRACE_CONDITION
>  
>  /* Only undef what we defined in this file */
>  #ifdef UNDEF_TRACE_INCLUDE_FILE
> 
> base-commit: 9c5968db9e625019a0ee5226c7eebef5519d366a
> -- 
> 2.48.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
