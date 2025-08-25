Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFA22F75C;
	Mon, 25 Aug 2025 10:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756117891; cv=none; b=KxQ13dhvasUiWQQ5vJZXmGuch0QfoFeAcopOZBrdFvNtzMchiZL2mwLeycjAGNvSUP+N/DVf6LsNrca7CcP7XJuAXy2JPVkVDHUZwawttxSEtZi34sUdboo3vQsy4+yPqovNedoDCy2vftg8IU0nQy7ToXu4ueeFx9GCANUlTNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756117891; c=relaxed/simple;
	bh=DagyeZFyvQvu9dcSKHqH6sIuhOg3IuDx1uJP36Hi9Yw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lDACAYaS1tPrAlKHE0xgsFbeDV4fw1lfu6LlnmmxtscbigLtM5TjDKltnBC7yGnTdZhGP8LLpPcl0BBCC8CjD4f8dEkapSKuNg5+zzGgJa1dlDKY5Me8uuV2NXbnC+0kvVxDrxgc6/AYzbAp4Ygx/J/XW29wYcECXS5qEQ4VzE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lcsdjk5W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lcsdjk5W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31AE1C4CEED;
	Mon, 25 Aug 2025 10:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756117891;
	bh=DagyeZFyvQvu9dcSKHqH6sIuhOg3IuDx1uJP36Hi9Yw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Lcsdjk5WPEu5YcN3zcRiAuHS5TcZGkyS8HxubNM7obfocjx37IjRtd6HK/w73qsP0
	 erN8QRG5I4xEkNsDRoxSlD6ZKrlX86qjb+/q+ynIniTAy6SalxIXl+d+2F7mwjUJDV
	 RsOBMANh/+1M2Vu2c6/2LrEAYMIYDgxhFOdZ88cIUTVTkhck8vaOmulpyN4xZlS+rl
	 h8D6fbqOUsdiwbSOyF19Pz61tMmfE2LCuylCDhJjkaCa/vOQdCyFNzwqt3fiavcoXC
	 DpcxaBuoVkeW7VYaVFkPpRaQP52ntahv+AylTq0oGsX5haF6EZzNzfH/BuoS9lYsVq
	 zkC15AwIMtuuQ==
Date: Mon, 25 Aug 2025 19:31:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: akpm@linux-foundation.org, mhiramat@kernel.org, naveen@kernel.org,
 davem@davemloft.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 07/13] mm/kstackwatch: Add kprobe and stack watch
 control
Message-Id: <20250825193127.a0acb9831733e0e51a5ef81d@kernel.org>
In-Reply-To: <20250818122720.434981-8-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
	<20250818122720.434981-2-wangjinchao600@gmail.com>
	<20250818122720.434981-3-wangjinchao600@gmail.com>
	<20250818122720.434981-4-wangjinchao600@gmail.com>
	<20250818122720.434981-5-wangjinchao600@gmail.com>
	<20250818122720.434981-6-wangjinchao600@gmail.com>
	<20250818122720.434981-7-wangjinchao600@gmail.com>
	<20250818122720.434981-8-wangjinchao600@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 Aug 2025 20:26:12 +0800
Jinchao Wang <wangjinchao600@gmail.com> wrote:

> This patch adds the core logic for controlling the kernel
> stack watch mechanism using a combination of kprobes and kretprobes.
> 
> A kprobe is registered at function + ip_offset to turn on
> the hardware breakpoint that monitors the stack. This allows
> the tool to begin watching from a specific instruction within
> the function. At the same time, a kretprobe is registered to be
> triggered when the function returns. Its handler is responsible
> for turning off the hardware breakpoint.

Could you use fprobe instead of kretprobe for hooking function exit?
kretprobe is an old feature and will be replaced by fprobe.

You can find an example in samples/fprobe/fprobe_example.c

Thank you,

> 
> By using these two probes, the tool can precisely watch a function's
> stack frame for its entire duration. This makes sure the HWBP is active
> only when needed, which reduces overhead and avoids accidental triggers.
> This also provides a clear and reliable way to manage the HWBP.
> 
> Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> ---
>  mm/kstackwatch/stack.c | 86 ++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 82 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
> index 8b558cdbda97..ba5280787e8f 100644
> --- a/mm/kstackwatch/stack.c
> +++ b/mm/kstackwatch/stack.c
> @@ -6,8 +6,10 @@
>  
>  #include "kstackwatch.h"
>  
> +struct ksw_config *probe_config;
> +
>  /* Find canary address in current stack frame */
> -static unsigned long __maybe_unused ksw_stack_find_canary(struct pt_regs *regs)
> +static unsigned long ksw_stack_find_canary(struct pt_regs *regs)
>  {
>  	unsigned long *stack_ptr, *stack_end;
>  	unsigned long expected_canary;
> @@ -33,7 +35,7 @@ static unsigned long __maybe_unused ksw_stack_find_canary(struct pt_regs *regs)
>  }
>  
>  /* Resolve stack offset to actual address */
> -static unsigned long __maybe_unused ksw_stack_resolve_offset(struct pt_regs *regs,
> +static unsigned long ksw_stack_resolve_offset(struct pt_regs *regs,
>  					      s64 local_var_offset)
>  {
>  	unsigned long stack_base;
> @@ -53,7 +55,7 @@ static unsigned long __maybe_unused ksw_stack_resolve_offset(struct pt_regs *reg
>  }
>  
>  /* Validate that address is within current stack bounds */
> -static int __maybe_unused ksw_stack_validate_addr(unsigned long addr, size_t size)
> +static int ksw_stack_validate_addr(unsigned long addr, size_t size)
>  {
>  	unsigned long stack_start, stack_end;
>  
> @@ -73,7 +75,7 @@ static int __maybe_unused ksw_stack_validate_addr(unsigned long addr, size_t siz
>  }
>  
>  /* Setup hardware breakpoints for active watches */
> -static int __maybe_unused ksw_stack_prepare_watch(struct pt_regs *regs,
> +static int ksw_stack_prepare_watch(struct pt_regs *regs,
>  				   struct ksw_config *config, u64 *watch_addr,
>  				   u64 *watch_len)
>  {
> @@ -110,3 +112,79 @@ static int __maybe_unused ksw_stack_prepare_watch(struct pt_regs *regs,
>  	*watch_len = len;
>  	return 0;
>  }
> +
> +/* Kprobe handlers */
> +static struct kprobe entry_probe;
> +static struct kretprobe exit_probe;
> +
> +static void ksw_stack_entry_handler(struct kprobe *p, struct pt_regs *regs,
> +				    unsigned long flags)
> +{
> +	int ret;
> +	u64 watch_addr;
> +	u64 watch_len;
> +
> +	/* Setup breakpoints for all active watches */
> +	ret = ksw_stack_prepare_watch(regs, probe_config, &watch_addr,
> +				      &watch_len);
> +	if (ret) {
> +		pr_err("KSW: Failed to parse watch info: %d\n", ret);
> +		return;
> +	}
> +	ret = ksw_watch_on(watch_addr, watch_len);
> +	if (ret) {
> +		pr_err("KSW: Failed to arm hwbp: %d\n", ret);
> +		return;
> +	}
> +	pr_info("KSW: Armed for %s at addr:0x%llx len:%llu\n",
> +		probe_config->function, watch_addr, watch_len);
> +}
> +
> +/* Function exit handler */
> +static int ksw_stack_exit_handler(struct kretprobe_instance *ri,
> +				  struct pt_regs *regs)
> +{
> +	ksw_watch_off();
> +	pr_info("KSW: Disarmed for %s\n", probe_config->function);
> +
> +	return 0;
> +}
> +
> +int ksw_stack_init(struct ksw_config *config)
> +{
> +	int ret;
> +
> +	/* Setup entry probe */
> +	memset(&entry_probe, 0, sizeof(entry_probe));
> +	entry_probe.symbol_name = config->function;
> +	entry_probe.offset = config->ip_offset;
> +	entry_probe.post_handler = ksw_stack_entry_handler;
> +	probe_config = config;
> +	ret = register_kprobe(&entry_probe);
> +	if (ret < 0) {
> +		pr_err("KSW: Failed to register kprobe ret %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Setup exit probe */
> +	memset(&exit_probe, 0, sizeof(exit_probe));
> +	exit_probe.kp.symbol_name = config->function;
> +	exit_probe.handler = ksw_stack_exit_handler;
> +	exit_probe.maxactive = 20;
> +
> +	ret = register_kretprobe(&exit_probe);
> +	if (ret < 0) {
> +		pr_err("KSW: Failed to register exit probe for %s: %d\n",
> +		       probe_config->function, ret);
> +		unregister_kprobe(&entry_probe);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +void ksw_stack_exit(void)
> +{
> +	unregister_kretprobe(&exit_probe);
> +	unregister_kprobe(&entry_probe);
> +}
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
