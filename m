Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A453BB11C;
	Mon, 22 Jun 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782139463; cv=none; b=UF5uSatZzX9cVkfKOw6/05WI3l1BJKeaOWOtSVzUpvGGEBW4NrMPF0UX4WpHsS06p5TR4x2nUYrr6Ph+EASavTa3jhF3BTwWW6qC1RJmrEiSu9r5P5MZH/nfWjfh4jtEz4UroO3ETUvX3kzkVZhquI4ZMP2Wzy7qXKKK4ihx6Zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782139463; c=relaxed/simple;
	bh=0OU6XQ8wzKu/LJ7ydiS3SawlgeVKcnBnJ3K2PdNNSmA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=e/bKyU7Ry7V9JdbcVJklQuLO8v0SmcR1sShI6+DoVCV9FMZLF/YyD5wvKYtQF12uH9zOoKN14Aa2tvkvoYOOStj5dgpYemYiQs+xgILca9lujsCzvfQhpm6cvB6AvgzPRzjy4S83l1WpF0ALzhPCbrkDjaW5JfgdAx6fSVzyZXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ASSgoIua; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ASSgoIua"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F9A1F000E9;
	Mon, 22 Jun 2026 14:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782139461;
	bh=037wF7dymDpb7kcezCe9NBTvn7+4a+UGPHZtzA3JBTo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ASSgoIua6AAVe+jw1CheSzV4BERNm+gU3OV5lK3mW3bg77Y1bxLWazAhFWeGlfOLh
	 ZuFfU5jx5QybKdbObKPI8dgJxt7RtWgOnSu4GHo2DhTdfv2siQK7GtrB3vk/8aINy7
	 CD3p4tJWmDoT8HSYbLquASbvYle1TnyzkZtPs1jtANyCbcleUd9AB4upQYBr7D7eHg
	 SOGAWaDh31jyZ/HEtHOJjF90AF6N/SvpS+m8NyjSGEoW5J3os//IoaPMewdloTl9NQ
	 RSUJCg7pyWYHKdsEyLEOpA7ReyCDXZNNNHCwYY/czcpts1/Wq5dnLnztqtqeMQrmXW
	 ez01V+TrDxuUQ==
Date: Mon, 22 Jun 2026 23:44:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Thomas
 Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Julia
 Lawall <julia.lawall@inria.fr>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v2 0/2] tracing: Remove trace_printk.h from kernel.h
Message-Id: <20260622234416.9f85ff87b81bcfb9776c73a6@kernel.org>
In-Reply-To: <20260622130739.375198646@kernel.org>
References: <20260622130739.375198646@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jun 2026 09:07:39 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> 
> Remove trace_printk.h by creating a trace_controls.h for those places that
> need access to tracing prototypes like tracing_off() and for the places that
> need trace_printk() directly, to have it included directly.
> 
> Changse since v1: https://lore.kernel.org/all/20260621093430.264983361@kernel.org/
> 
> - Create a trace_controls.h header to move the prototypes into and not
>   include it back into kernel.h
> 
> - Just remove trace_printk.h from kernel.h with no alternative to keep the
>   previous behavior.
> 
> Steven Rostedt (2):
>       tracing: Move non-trace_printk prototypes into trace_controls.h
>       tracing: Remove trace_printk.h from kernel.h
> 

The series looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

for this series.

Thanks,

> ----
>  arch/powerpc/kvm/book3s_xics.c         |  1 +
>  arch/powerpc/xmon/xmon.c               |  1 +
>  arch/s390/kernel/ipl.c                 |  1 +
>  arch/s390/kernel/machine_kexec.c       |  1 +
>  drivers/gpu/drm/i915/gt/intel_gtt.h    |  1 +
>  drivers/gpu/drm/i915/i915_gem.h        |  2 ++
>  drivers/hwtracing/stm/dummy_stm.c      |  4 +++
>  drivers/infiniband/hw/hfi1/trace_dbg.h |  1 +
>  drivers/tty/sysrq.c                    |  1 +
>  drivers/usb/early/xhci-dbc.c           |  1 +
>  fs/ext4/inline.c                       |  1 +
>  include/linux/ftrace.h                 |  2 ++
>  include/linux/kernel.h                 |  1 -
>  include/linux/sunrpc/debug.h           |  1 +
>  include/linux/trace_controls.h         | 54 ++++++++++++++++++++++++++++++++
>  include/linux/trace_printk.h           | 56 ++--------------------------------
>  kernel/debug/debug_core.c              |  1 +
>  kernel/panic.c                         |  1 +
>  kernel/rcu/rcu.h                       |  2 ++
>  kernel/rcu/rcutorture.c                |  1 +
>  kernel/trace/ring_buffer_benchmark.c   |  1 +
>  kernel/trace/trace.h                   |  1 +
>  kernel/trace/trace_benchmark.c         |  1 +
>  lib/sys_info.c                         |  1 +
>  samples/fprobe/fprobe_example.c        |  1 +
>  samples/ftrace/ftrace-direct-too.c     |  1 -
>  samples/trace_printk/trace-printk.c    |  1 +
>  27 files changed, 86 insertions(+), 55 deletions(-)
>  create mode 100644 include/linux/trace_controls.h


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
