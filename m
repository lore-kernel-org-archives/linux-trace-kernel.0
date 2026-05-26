Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F61F1DBB3A;
	Tue, 26 May 2026 06:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775682; cv=none; b=q8MNPNG+V0j2F+Brv34RZWUqoCO1yvUCnJdBSNTdBPZ0p5YnIuvwgvPekDUsasL9Xv3AXb3fMvxpN6Do0E+H3iUqo8ArxXnwVjIYKeMccnPKF6DQ6XyxgkUJcg1g4yZOQDDqDEryGBTRgp59SaMx2pgJ6ZVPHSa/DO4cZsq8lrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775682; c=relaxed/simple;
	bh=I9SsEbdWV7IypUQTDOqa/CJciQMRPspnBF/zMFbmkBY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XyjQ3+VWJt/W3+OVWDDQzl9AqeNd4fYYDZVOsDv3w9vo05+iiH1F8HBikM40kwbS8oI4PXumsfltX0rz4y4Kw5tChGOeG9nEZJqUolg6YCrmk9lurMtqDtHkHp5Rhb7EWBMFf/DgcHKXBPttYLAC/NIB/52jEnncflyasIs57zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSCDDw5F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSCDDw5F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D13A1F000E9;
	Tue, 26 May 2026 06:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779775681;
	bh=aak4+01qnVKoi21bTQfg4V4qY4Cseyt0nbepz3fZcS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iSCDDw5FJxgL4bDVy3168tSU2is8u5ga4pcSubh2QGQAQ1JnTuY9uamqlG1qAreNN
	 kvbBYSVPcmdREA+cgm4aI7n47lZ3dB1ufuP3KVU7DiK06uLv9GLenCjxFciu7PEQuR
	 HS60wfRSbt4lJ498xaQI6QOvonF7iOXF3k8oY6mZdNCpuPF3Ajan5rtNyOrjgWnCpl
	 /OEY/wYmnevoEqGFkn6gEh8bSRO3fAl3NkXp4JsPN96OZiQcYW2vlluH00RJ4ktIHT
	 ELSfk1diIHO5j6KIbhaEWQFs0fmdgfiDd17zYYhT/yFlxRDR6xxBzST8Z62MAi5wWZ
	 EGcpGahd29iIQ==
Date: Tue, 26 May 2026 15:07:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Marco Elver <elver@google.com>,
 kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Disable KCOV instrumentation for
 trace_irqsoff.o
Message-Id: <20260526150758.4e0f37745d688f95a1c710d8@kernel.org>
In-Reply-To: <20260525170428.67211-1-kmehltretter@gmail.com>
References: <20260525170428.67211-1-kmehltretter@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 May 2026 19:04:28 +0200
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> When KCOV runs its boot selftest with whole-kernel instrumentation
> enabled, it sets current->kcov_mode to KCOV_MODE_TRACE_PC without
> installing a coverage area. Any instrumented code accepted as task-context
> coverage in that window dereferences current->kcov_area and crashes.
> 
> On ARMv5 Versatile PB with CONFIG_KCOV_SELFTEST=y,
> CONFIG_KCOV_INSTRUMENT_ALL=y and CONFIG_IRQSOFF_TRACER=y, boot hits a
> NULL pointer fault during the selftest:
> 
>   kcov: running self test
>   Internal error: Oops: 5 [#1] ARM
>   PC is at __sanitizer_cov_trace_pc+0x4c/0x90
>   Kernel panic - not syncing: Fatal exception
> 
> A diagnostic run showed the unwanted coverage comes from the IRQs-off
> tracer callbacks reached from ARM IRQ entry before hardirq context is
> visible to KCOV:
> 
>   __sanitizer_cov_trace_pc from tracer_hardirqs_off+0x18/0x1cc
>   tracer_hardirqs_off from trace_hardirqs_off+0x34/0x54
>   trace_hardirqs_off from __irq_svc+0x58/0xb0
>   __irq_svc from kcov_init+0x7c/0xdc
> 
> and similarly through tracer_hardirqs_on().
> 
> trace_preemptirq.o is already excluded because this tracing path can run
> from early interrupt code and produce coverage unrelated to syscall
> inputs. Exclude trace_irqsoff.o as well, instead of requiring users to
> turn off CONFIG_KCOV_INSTRUMENT_ALL=y, which is the default whole-kernel
> KCOV mode.
> 
> With the exclusion in place, the same ARMv5 Versatile PB QEMU test boots
> through the KCOV selftest and reaches userspace.
> 
> Tested on ARMv5 Versatile PB QEMU with CONFIG_KCOV_SELFTEST=y,
> CONFIG_KCOV_INSTRUMENT_ALL=y and CONFIG_IRQSOFF_TRACER=y.


Thanks for reporting. This looks good to me for a mitigation.
BTW, I could not reproduce the bug with above configs.
Is this only for arm32?


> 
> Assisted-by: Codex:gpt-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>  kernel/trace/Makefile | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 8d3d96e847d8..f934ff586bd4 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -48,9 +48,10 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
>  GCOV_PROFILE := y
>  endif
>  
> -# Functions in this file could be invoked from early interrupt
> -# code and produce random code coverage.
> +# Functions in these files can run from IRQ entry before hardirq context
> +# is visible to KCOV, and produce coverage unrelated to syscall inputs.
>  KCOV_INSTRUMENT_trace_preemptirq.o := n
> +KCOV_INSTRUMENT_trace_irqsoff.o := n
>  
>  CFLAGS_bpf_trace.o := -I$(src)
>  
> -- 
> 2.39.5 (Apple Git-154)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
