Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5112D3242BE;
	Tue,  9 Jun 2026 01:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780969365; cv=none; b=e8SI6U8OQK9w2kTpjrUkm4AT/n8x4fOp8Zd2iB4noWoKvGfFQoOER4k1gOCsmuOYMUZ0PzT3hASDlrZXuOt3nK7ee7hi4WH/LKpG7VocXL4S/ysz3PCxAbsG1HRWXwh0DE6SfuQF20kmdaOTg3RbGB/IS+C/s4uro+LD+P8UOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780969365; c=relaxed/simple;
	bh=+HFQhrlCP9FpZ3LCWsl97dDZOruMBx1TlcvW2V6/B28=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cJLBmY1FGHjdfhhAqwCNqhPWQFN8n7ASL4lfA0turF9IvMDrRfHp6kAlB7PPIoCuAOL/n7CvWNX8eyiUexKI+611cjtxFdLWJYDrYK9zfaNPVRJiqnOv0rEJMU7CGGEOb5xypDv6qTfC1qyyEUwYu+hYPuZfRIvuoOuV/P05M1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zdo6FWur; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zdo6FWur"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89D211F00893;
	Tue,  9 Jun 2026 01:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780969363;
	bh=U5/oRI5LWE976MxGo2nzIX5Q2u1ajqCiTNhhJJv6E44=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zdo6FWur2iYfoWkbx5ySONDe0FQy9jf3fEGC0VpzuW1ogNuMnkAJfmdICO/sARWd5
	 deCpni5oUfJsQZYMKK36lCyh2uZCrmZBQjMJwnxfNhoJXA2TnpIGLHp0QtasO6K3PI
	 vCrFe3tNa24i6lUmE9HiVuMe2o/oUMm/qx0TIGX1kk/A+1Nvb6x3X7tVQG6zB9g6Ee
	 P//68QKzQrAfXoe78adqVnmvTia9I14O5CRIYh/F5XTuHJSUOsXRutPezpPFUlc+9T
	 LU/BF1GPrgNHLAhCu9ARuiRmgqQwkuMGAf5pbangZoBrFPkSZcEYWUvHDuh1boL+GQ
	 hd8NPbfljvQ+A==
Date: Tue, 9 Jun 2026 10:42:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] tracing/probes: Add more typecast features
Message-Id: <20260609104239.a9fc9446602d5b4a5ab667e3@kernel.org>
In-Reply-To: <178092865666.163648.10457567771536160909.stgit@devnote2>
References: <178092865666.163648.10457567771536160909.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Mon,  8 Jun 2026 23:24:16 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> Hi,
> 
> Here is a series of patches to introduce more typecast features
> to probe events, which includes 1. expanding BTF typecast to
> fprobe and kprobe events, 2. introducing container_of like typecst
> option, 3. supporting nested typecast, 4. adding $current special
> variable support, 5. adding per-cpu dereference support, 6. adding
> a testcase to check typecasts.

Sashiko found many issues on this series. I'll fix those.

BTW, for $current, I think it should typecasted to task_struct without
typecast. (except if it is the container_of() type typecasting)
In this case, ctx->strcut_btf will be updated automatically if $current
is specified.

Also, I'm thinking redesign +CPU/+PCPU/this_cpu_ptr().
Instead of those, what about introducing followings?

 - this_cpu_read(VAR)
 - this_cpu_ptr(VAR)

Comments are welcome!

Thanks,

> 
> Steve introduced BTF typecast feature for eprobe[1].
> This series extends it and add more options:
> 
> 1. Expanding BTF typecast to kprobe and fprobe.
>    (currently only function entry/exit)
> 
> 2. Introduce container_of like typecast. This adds a "assigned
>    member" option to the typecast.
> 
>    (STRUCT,MEMBER)VAR->ANOTHER_MEMBER
> 
>    This casts VAR to STRUCT type but the VAR is as the address
>    of STRUCT.MEMBER. In C, it is:
> 
>    container_of(VAR, STRUCT, MEMBER)->ANOTHER_MEMBER
> 
> 3. Support nested typecast, e.g.
> 
>    (STRUCT)((STRUCT2)VAR->MEMBER2)->MEMBER
> 
>    the nest level must be smaller than 3.
> 
> 4. Add $current variable to point "current" task_struct.
>    This is useful with typecast, e.g.
> 
>    (task_struct)$current->pid
> 
> 5. per-cpu dereference support.
> 
>    +CPU(VAR) is the same as this_cpu_read(VAR), and
>    +PCPU(VAR) is the same as this_cpu_ptr(VAR).
>    Also, "this_cpu_ptr(VAR)" is available. This is good
>    with nesting expression.
> 
>    (STRUCT)(this_cpu_ptr(VAR))->MEMBER
> 
>    (However, it might be better to allow a special way to omit
>     parentheses for thi_cpu_ptr())
> 
> And added a test script to test part of them.
> 
> [1] https://lore.kernel.org/all/20260601130746.2139d926@gandalf.local.home/
> 
> 
> ---
> 
> Masami Hiramatsu (Google) (7):
>       tracing/probes: Support typecast for various probe events
>       tracing/probes: Support nested typecast
>       tracing/probes: Support field specifier option for typecast
>       tracing/probes: Add $current variable support
>       tracing/probes: Add +CPU() and +PCPU() dereference method to fetcharg
>       tracing/probes: Support reserved this_cpu_ptr() method
>       tracing/probes: Add a new testcase for BTF typecasts
> 
> 
>  Documentation/trace/eprobetrace.rst                |   11 +
>  Documentation/trace/fprobetrace.rst                |   11 +
>  Documentation/trace/kprobetrace.rst                |   12 +
>  kernel/trace/trace.c                               |    6 
>  kernel/trace/trace_probe.c                         |  312 +++++++++++++++-----
>  kernel/trace/trace_probe.h                         |   12 +
>  kernel/trace/trace_probe_tmpl.h                    |   33 ++
>  samples/trace_events/trace-events-sample.c         |   38 ++
>  samples/trace_events/trace-events-sample.h         |   34 ++
>  .../ftrace/test.d/dynevent/btf_probe_event.tc      |   52 +++
>  10 files changed, 422 insertions(+), 99 deletions(-)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/btf_probe_event.tc
> 
> --
> Signature


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
