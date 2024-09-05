Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3AD3A27E;
	Thu,  5 Sep 2024 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549320; cv=none; b=mrixapsiz9vtGmLY57QafaycAotzj/c8vSErP1JY+ZtH90aWEF/3VQY1Yl2rkmlKd9VG8OSDCjXDAexQUBrPVSRPcdNJUXGm82/edNsQwps6VftRPK6OkF4Nbu+AgUzeE8Vpq9B6gS56oegZmKDRtEcRBxuLP53axFZkvRk0wao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549320; c=relaxed/simple;
	bh=x59hBC6f2Ezk12MvkosF/SoIg1FNCzCKgMnXTFv+YPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=deOhx90vfV04yHPVXRXMBEboK9Ls4ZKW/vdNs68/C2Ho9q9FTdx4DaLtR1lcuMFBxX9ky6HyoKFPzuue50p8sGqlWqYgfpEpHraxiudcdI78fZT8PQWDkpHi1nd9BWJSvHskrJlKToYLS2Pv+w6kFptn3eSdlEmy+kI7VsmqIdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B839C4CEC3;
	Thu,  5 Sep 2024 15:15:18 +0000 (UTC)
Date: Thu, 5 Sep 2024 11:16:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sven Schnelle <svens@linux.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-csky@vger.kernel.org
Subject: Re: [PATCH 0/7] add function arguments to ftrace
Message-ID: <20240905111620.5211d9f8@gandalf.local.home>
In-Reply-To: <20240904065908.1009086-1-svens@linux.ibm.com>
References: <20240904065908.1009086-1-svens@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Sep 2024 08:58:54 +0200
Sven Schnelle <svens@linux.ibm.com> wrote:

> These patches add support for printing function arguments in ftrace.
> 
> Example usage:
> 
> function tracer:
> 
> cd /sys/kernel/tracing/
> echo icmp_rcv >set_ftrace_filter
> echo function >current_tracer
> echo 1 >options/func-args
> ping -c 10 127.0.0.1
> [..]
> cat trace
> [..]
>             ping-1277    [030] ..s1.    39.120939: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    39.120946: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    40.179724: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    40.179730: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    41.219700: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    41.219706: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    42.259717: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    42.259725: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    43.299735: icmp_rcv(skb = 0xa0ecab00) <-ip_protocol_deliver_rcu
>             ping-1277    [030] ..s1.    43.299742: icmp_rcv(skb = 0xa0ecac00) <-ip_protocol_deliver_rcu
> 
> function graph:
> 
> cd /sys/kernel/tracing
> echo icmp_rcv >set_graph_function
> echo function_graph >current_tracer
> echo 1 >options/funcgraph-args
> 
> ping -c 1 127.0.0.1
> 
> cat trace
> 
>  30)               |  icmp_rcv(skb = 0xa0ecab00) {
>  30)               |    __skb_checksum_complete(skb = 0xa0ecab00) {
>  30)               |      skb_checksum(skb = 0xa0ecab00, offset = 0, len = 64, csum = 0) {
>  30)               |        __skb_checksum(skb = 0xa0ecab00, offset = 0, len = 64, csum = 0, ops = 0x232e0327a88) {
>  30)   0.418 us    |          csum_partial(buff = 0xa0d20924, len = 64, sum = 0)
>  30)   0.985 us    |        }
>  30)   1.463 us    |      }
>  30)   2.039 us    |    }
> [..]
> 

First I want to say THANK YOU!!!!

This has been on my TODO list for far too long. I never got the time to
work on it :-p

Anyway, this is something I definitely want added. But I'm going to guess
that there is going to be issues with it and I doubt it will be ready for
the next merge window. I'm currently focused on some other things and also
have to get ready for next weeks travels (I'll be in Prague for GNU Cauldron,
then Vienna for Plumbers and OSS EU, then to Paris for Kernel Recipes!).

But I most definitely want this in. Hopefully by 6.13. This may be
something I can review on the plane (if I get my slides done).

Again, thanks for doing this!

-- Steve

> 
> Sven Schnelle (7):
>   tracing: add ftrace_regs to function_graph_enter()
>   x86/tracing: pass ftrace_regs to function_graph_enter()
>   s390/tracing: pass ftrace_regs to function_graph_enter()
>   Add print_function_args()
>   tracing: add config option for print arguments in ftrace
>   tracing: add support for function argument to graph tracer
>   tracing: add arguments to function tracer
> 
>  arch/arm/kernel/ftrace.c             |  2 +-
>  arch/arm64/kernel/ftrace.c           |  2 +-
>  arch/csky/kernel/ftrace.c            |  2 +-
>  arch/loongarch/kernel/ftrace.c       |  2 +-
>  arch/loongarch/kernel/ftrace_dyn.c   |  2 +-
>  arch/microblaze/kernel/ftrace.c      |  2 +-
>  arch/mips/kernel/ftrace.c            |  2 +-
>  arch/parisc/kernel/ftrace.c          |  2 +-
>  arch/powerpc/kernel/trace/ftrace.c   |  2 +-
>  arch/riscv/kernel/ftrace.c           |  2 +-
>  arch/s390/kernel/entry.h             |  4 +-
>  arch/s390/kernel/ftrace.c            |  4 +-
>  arch/sh/kernel/ftrace.c              |  2 +-
>  arch/sparc/kernel/ftrace.c           |  2 +-
>  arch/x86/include/asm/ftrace.h        |  2 +-
>  arch/x86/kernel/ftrace.c             |  6 +-
>  include/linux/ftrace.h               |  4 +-
>  kernel/trace/Kconfig                 | 12 ++++
>  kernel/trace/fgraph.c                |  7 ++-
>  kernel/trace/trace.c                 |  8 ++-
>  kernel/trace/trace.h                 |  4 +-
>  kernel/trace/trace_entries.h         |  7 ++-
>  kernel/trace/trace_functions.c       | 46 ++++++++++++++--
>  kernel/trace/trace_functions_graph.c | 74 +++++++++++++------------
>  kernel/trace/trace_irqsoff.c         |  4 +-
>  kernel/trace/trace_output.c          | 82 +++++++++++++++++++++++++++-
>  kernel/trace/trace_output.h          |  9 +++
>  kernel/trace/trace_sched_wakeup.c    |  4 +-
>  28 files changed, 228 insertions(+), 73 deletions(-)
> 
> --
> 2.43.0

