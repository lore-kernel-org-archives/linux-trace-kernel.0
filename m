Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571CBEEBA;
	Wed, 30 Jul 2025 03:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753844881; cv=none; b=NrSpsIWbYMuJIFGCX5j1Z6T0kp549FANdpmpXS3Efob2sjxf/dxFQ/RV7TokwARkNVNHddY5dyX4x88R6CshVKOLJMsUqz8kUhmeszSUh/94OrDkmdpkfzKSrHDCdlBqIadkiy5sK7V453YfpMcE8TNC5mX2VZxrfdI6v7/Xze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753844881; c=relaxed/simple;
	bh=22JhCyglsPUS7n2HIlluUovVfg0gdi1H2bFhA3h5f2I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AZjn4U1B2Gx4+4xtk2Umt4Lr6teYvm7yvVOOReV+HndL3r+cQpqXhByHEvLHQhIt/wRohbmMb3qf82119a/7t39EG3r43eeVvyjO9XrVjujus4hQAIjiqsB3xG+TLx4EmNVla4LZD5WIzlcrgmDNK5xPnnE0LXyI7fqqJ3xfpIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jDwp4EVw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jDwp4EVw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC53C4CEEF;
	Wed, 30 Jul 2025 03:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753844880;
	bh=22JhCyglsPUS7n2HIlluUovVfg0gdi1H2bFhA3h5f2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jDwp4EVw1g8SvHbFCRjrDMDqtQrfuRlrsJrSk1n8V/DfJAlXqwpTsrAmSgZ0LTiCU
	 WpwGnt0det3VO4BDH3X12/vsJptOoFDZsrtIPj+s9QDrIZR5dhTS7txqrfyvzfn6Mn
	 B43hEnfubrG0xAZRXE55MaC4xSikeenNTMXjXuR9y9b6p5x0cKYd0uvHFzhkijAMzh
	 9MYJlW8BKfaRh7zPRt9XvGvF9tcrAteIpAG/5O9zswbZ7wHrhLo42+Nh7r1tgGfBC3
	 E7hMbYZcjxw4Tp8ftHGwTpm05M4OJBEnZs6UWIZ3RGiX6q7y71i++bUgbazrBiYpSQ
	 g8mfFuh2iWfKg==
Date: Wed, 30 Jul 2025 12:07:57 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Namhyung Kim <namhyung@kernel.org>, Jonathan
 Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: Have eprobes have their own config
 option
Message-Id: <20250730120757.c1441d2ffd08bf4c0d4f7e65@kernel.org>
In-Reply-To: <20250729161912.056641407@kernel.org>
References: <20250729161816.678462962@kernel.org>
	<20250729161912.056641407@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Jul 2025 12:18:17 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Eprobes were added in 5.15 and were selected whenever any of the other
> probe events were selected. If kprobe events were enabled (which it is by
> default if kprobes are enabled) it would enable eprobe events as well. The
> same for uprobes and fprobes.
> 
> Have eprobes have its own config and it gets enabled by default if tracing
> is enabled.
> 
> Link: https://lore.kernel.org/all/20250729102636.b7cce553e7cc263722b12365@kernel.org/
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, is it a bugfix or improvement?

Thanks,

> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/Kconfig  | 13 +++++++++++++
>  kernel/trace/Makefile |  2 +-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 93e8e7fc11c0..b951c027fffb 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -792,6 +792,19 @@ config UPROBE_EVENTS
>  	  This option is required if you plan to use perf-probe subcommand
>  	  of perf tools on user space applications.
>  
> +config EPROBE_EVENTS
> +	bool "Enable event-based dynamic events"
> +	depends on TRACING
> +	select PROBE_EVENTS
> +	select DYNAMIC_EVENTS
> +	default y
> +	help
> +	  Eprobes are dynamic events that can be placed on other existing
> +	  events. It can be used to limit what fields are recorded in
> +	  an event or even dereference a field of an event. It can
> +	  convert the type of an event field. For example, turn an
> +	  address into a string.
> +
>  config BPF_EVENTS
>  	depends on BPF_SYSCALL
>  	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 057cd975d014..dcb4e02afc5f 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -82,7 +82,7 @@ obj-$(CONFIG_EVENT_TRACING) += trace_event_perf.o
>  endif
>  obj-$(CONFIG_EVENT_TRACING) += trace_events_filter.o
>  obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
> -obj-$(CONFIG_PROBE_EVENTS) += trace_eprobe.o
> +obj-$(CONFIG_EPROBE_EVENTS) += trace_eprobe.o
>  obj-$(CONFIG_TRACE_EVENT_INJECT) += trace_events_inject.o
>  obj-$(CONFIG_SYNTH_EVENTS) += trace_events_synth.o
>  obj-$(CONFIG_HIST_TRIGGERS) += trace_events_hist.o
> -- 
> 2.47.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
