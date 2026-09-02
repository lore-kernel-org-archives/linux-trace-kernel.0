Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2354A5C37;
	Wed,  2 Sep 2026 14:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788361125; cv=none; b=gSCgqLMzLt6Bjr72Vd2jGIMKHuKVX5VC1T3evfMmye+HNKYVSEYtTmsnX2QdFNTJtTbZzt0To0xzJR0lp0D1O0k10FroXzYiv8mDQxPMP7ZsJONHAmA3YwMQ9LUk5LH/tMDQ1zxefgf8RZI+MtLwNPyStUjkz28daDP971Lty08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788361125; c=relaxed/simple;
	bh=Bq/pn6qLDuCOy4q6Inih1M/7CWb1GJrhoAlaFxB0hWY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=f0b0fqiXHHM3rHjV4N1zGZA6x0kwAES5IIIzhG+7RCDnF/g1uT5QsrCAtQaSWWiifBqy2cP8MuJl1kFxckWLEfWZLI5fQlFE9sBLPaFyWwk8RofNhWgunYZjeSH9NIWeX2W8EiP2zmckChZlpC15CnAEX4DWJCDq0zXLq3wKnL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEJxl0xx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEJxl0xx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF2A1F00A3A;
	Wed,  2 Sep 2026 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788361117;
	bh=pbIrjoPs4ESo8HvfZjuo4ycyazh6Toox1T+Kj5d6QcE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HEJxl0xx2PoI0ldW+z7GFqEaW59vDMByEeAsuScGUDUHeurh0tzYybo2czdJkc+ZV
	 XBJovFDlVFCxsAF/xK+q5MoMVfSf6hqTdvlJKP4rBSU5cXan3mozQ09wMu7fXM6/3v
	 5cnEfBR/GHKBo/hP8DvnjaWH3vOefm0M5EGcDtWP6/75t1nixQx8GEx7wJmX+gseOe
	 4MzL9RpDBWupoGqSqTmFU1XQLTWJqr8PdT9fFH16BKNOrrY4R+9/ft2OHlXdKC26AT
	 rUOWpXsdSHfY8QdDaUU+tqWgaTSTbWrWfaxy6j3OqGaVNjiMfYabc7/Pf+19lSsVJ3
	 UzmY6Qq52RvPA==
Date: Wed, 2 Sep 2026 23:58:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, dolinux.peng@gmai.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 pengdonglin <pengdonglin@xiaomi.com>, Xiaoqin Zhang
 <zhangxiaoqin@xiaomi.com>
Subject: Re: [PATCH v5 1/3] ftrace: Build trace_btf.c when
 CONFIG_DEBUG_INFO_BTF is enabled
Message-Id: <20260902235833.542376d81082fe54c6057b37@kernel.org>
In-Reply-To: <20260901134604.4052265-2-dolinux.peng@gmail.com>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
	<20260901134604.4052265-2-dolinux.peng@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Sep 2026 21:46:02 +0800
Donglin Peng <dolinux.peng@gmail.com> wrote:

> From: pengdonglin <pengdonglin@xiaomi.com>
> 
> The trace_btf.c file provides BTF helper functions used by the ftrace
> subsystem. Make the compilation of trace_btf.c solely depend on
> CONFIG_DEBUG_INFO_BTF, allowing features like funcgraph-retval to also
> utilize these helpers.
> 
> Additionally, the redundant dependency on CONFIG_PROBE_EVENTS_BTF_ARGS
> is removed, as CONFIG_DEBUG_INFO_BTF already depends on
> CONFIG_BPF_SYSCALL.

OK, nowadays BPF requires BTF. This looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> 
> Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  kernel/trace/Kconfig  | 2 +-
>  kernel/trace/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 0ab5916575a9..d8faeb659cfc 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -770,7 +770,7 @@ config FPROBE_EVENTS
>  config PROBE_EVENTS_BTF_ARGS
>  	depends on HAVE_FUNCTION_ARG_ACCESS_API
>  	depends on FPROBE_EVENTS || KPROBE_EVENTS
> -	depends on DEBUG_INFO_BTF && BPF_SYSCALL
> +	depends on DEBUG_INFO_BTF
>  	bool "Support BTF function arguments for probe events"
>  	default y
>  	help
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index f934ff586bd4..28b08f31e7e5 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -119,7 +119,7 @@ obj-$(CONFIG_KGDB_KDB) += trace_kdb.o
>  endif
>  obj-$(CONFIG_DYNAMIC_EVENTS) += trace_dynevent.o
>  obj-$(CONFIG_PROBE_EVENTS) += trace_probe.o
> -obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) += trace_btf.o
> +obj-$(CONFIG_DEBUG_INFO_BTF) += trace_btf.o
>  obj-$(CONFIG_UPROBE_EVENTS) += trace_uprobe.o
>  obj-$(CONFIG_BOOTTIME_TRACING) += trace_boot.o
>  obj-$(CONFIG_FTRACE_RECORD_RECURSION) += trace_recursion_record.o
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
