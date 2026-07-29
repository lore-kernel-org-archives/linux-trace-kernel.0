Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0E938D6A8;
	Wed, 29 Jul 2026 18:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348496; cv=none; b=aAjbhY8YQXKPJ5QMrYFGkHIqUlX/texm+OB6cy4sZMiVh9S0yvq8oLx70mQNzetl2U41Ft6NBI1/mGLRg4ONmSG7N1MdFi8u1mZvg10f7jXw17X4TLHTdAXOAo6Dz3qLP2QybtYxQ3QqYOCFFY0E2fTOOuEeZCa7FwxW+/2xR7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348496; c=relaxed/simple;
	bh=Hm6PGFaiPPS83t1EGaQig5GY2imSX3sSXllvUW8uUYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bths/spEsxN+6CxChlm6Ego6qhuxAMk9v9I/ad4gWHh011xJQFtfQHuxQZ2Tr0wAVPe4SDZ3dnj2D5DaeRlzyTPeXI+8k6DfDBaP6dv4K9lVkkqgChKGi1fIpnbLUb06NBFAfMDKL/hrMpUpB0fuz/8f8ZvjKRRItIzEHqRwrzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org; spf=pass smtp.mailfrom=rostedt.org; dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b=JRdh59Gv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+GMsB8B; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rostedt.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rostedt.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rostedt.org header.i=@rostedt.org header.b="JRdh59Gv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+GMsB8B"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D8C4014002E6;
	Wed, 29 Jul 2026 14:08:11 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 29 Jul 2026 14:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rostedt.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1785348491;
	 x=1785434891; bh=NwF6WahzMHm2895PJCZr64azvFZo3rJf0ZJJcnJOyTI=; b=
	JRdh59GvEw2YJjNl4b0sb2XXDN/Wb2PCc/JW2F/OV/a7kRmZ1FITXfoI7p0tHTaa
	PQfszlVejq3AKOGIYMQOVDwUGQBfYl9XxtIiJpAMGDFPb19lvoltUVFNTztlks+m
	Om3B8fS/cHK/74JHMylRgDm0kSQ/X/s2bPIacOm35jJTKdriFb5QGfpQJrY9FMp9
	loU7WNOFAV1hd+pI6vt6xPrgbEzy/j9+0r++VSFSWVmBJrcYasOnQHuDBamNUDP+
	Pj9vL0+thOKtr2e3HD437RT4jjVTaIqyy65XLoJKhVDrTKwWbImbXZejxFV5TPZj
	FC4mTzZlGLCfuGEtRglsfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1785348491; x=
	1785434891; bh=NwF6WahzMHm2895PJCZr64azvFZo3rJf0ZJJcnJOyTI=; b=b
	+GMsB8BaZzp9S8uTtN2iW19GRLMCZGSp3VyhrRheqXMvJBLUaMENric23PgprnJD
	nHSxBtYmlEnhyGrwozhx+cQ/0W5yS1t6L3oP2Dld7mD+CLhv+BShND6GcBiRYBaP
	8Iy2MSEp9eAT+Q8oT76faaJF7Mh87fdOBkEJ1GnPYlvTL2Bf4GQIzP3uZfrHxaTe
	dogakftHkBPHR29e/nmeBME5RrgL7UndR6O031XBs9L1Sf6iF+ws0WLch4hGsprZ
	NEYtQI5v2663sQ4i5x6upgzj0Izl+uevzcFEWIYWJ3qRAimaR4lShiX0FQf/hoRD
	aSINvusbC8nowItbuWp/w==
X-ME-Sender: <xms:i0FqahhvI6KHKauYf_IyzQZIy7_zl0CAr-6dWfkCngQGSu2O6gNWxg>
    <xme:i0FqamaRFOOyx-jGTE4cRmB_MMTOoDuv7vtzGXnUCgoMptFFHi9YOOIbrq7BpeUIk
    Mb3edO6KE5cq8dGtjqfMOsqO4BNirUMEl8Z_g_DXmPx-39El-yG26o>
X-ME-Received: <xmr:i0FqaiOaJSdwHME7YRhRV89o6RnwAiqdny4zwCKU1urScVh8w3DltkhOEzMcVLnU3tJxM4eN>
X-ME-Proxy-Cause: dmFkZTERBjXApnrZrwfYcYubtd8IizaaJqU0kamfvzZdOJhvnPPUf06TI5DFPDTIcatc28
    2an4NFY/41OsegM7YIizOcF3moFF5tPsTqvOEWMQ49m/J9ujLJLevMme8PQF2WUY5QmBm6
    nz5aape8gfrzo7xjNg52J0NJs/H4wY2qB2dO5GSMsEmMJIUk/rcHiWJhe20Z6NwiObz3Zq
    WST4S9B1DwsDaGGoeQe7/o/DEIO98FM6f2Pi93sG4xJiOjE4RmWz9v5f/bX5w5JPRan3cw
    07qPOtAsZ2FWnKk+GUM3y2FQotAisp7eo1YGmOF5z85KHeLwJts5U1vJy5sA5C2K8HGZOk
    3Bjp6FkzfsKLiass48861fo/4E0zzIvGq6ByRJTsHEwMciPmcsNZktiMu5OhwEmv57UMXo
    ZKc/YcbrEZqakZat4X2VOMt1S71EUwUqpjXyCW4MoE7F5GSFUp8vdZEFBwwXM/ghCGugAU
    BOZyy/vjfXooose5kT6eg2PhaoNf62OTrq2Cy55Rp22J22kjvzvz/vMBQW0s8QS5+IvJ9z
    m7rnUc8W0NlQn7g+fUcB7JlG/CT+z6MrN7Aqy8BEP5cx0sxrtyVKUChNUFRs3CeFp0UnHO
    7pl2URwtEkDfDgPeNdo14bH/g924Y+OGcIPl2hCq/P/K4kryJG6+lvlEz+OA
X-ME-Proxy: <xmx:i0FqaiTEk4Px3IqRWyOkYSyoiqXYfXwwX1WvdWljVc7YUMXKh5-unQ>
    <xmx:i0Fqat7fgWxLdBgGJXISIihWXY6hiTMv6aNJjTAN7jmgXHhrHMb6yw>
    <xmx:i0FqalZt0XGFuASztUrqxEPNuEGH_xf577Ar7ulgqgxf4GO_06xlag>
    <xmx:i0FqahZv1EOEd6ncLcch_4PePD-5cJpSomOqh2vqcgvENPJRFiuY9w>
    <xmx:i0FqatanVUSGSY54zh1guP6xSXN33irC96kRL2jFnJmgAxSp2N8YF8xV>
Feedback-ID: id06e481b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Jul 2026 14:08:10 -0400 (EDT)
Date: Wed, 29 Jul 2026 14:08:46 -0400
From: Steven Rostedt <steven@rostedt.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Hongyan Xia <hongyan.xia@transsion.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Oleg Nesterov
 <oleg@redhat.com>, Naveen N Rao <naveen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jiazi Li <jiazi.li@transsion.com>,
 Pu Hu <hupu@transsion.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
 <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH 9/9] arm64/debug: Mark debug exception helpers
 __always_inline
Message-ID: <20260729140846.3c18f437@gandalf.local.home>
In-Reply-To: <eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
References: <cover.1785153469.git.hongyan.xia@transsion.com>
	<eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Masami,


On Mon, 27 Jul 2026 12:25:48 +0000
Hongyan Xia <hongyan.xia@transsion.com> wrote:

> From: Hongyan Xia <hongyan.xia@transsion.com>
> 
> Static inline should be enough to actually inline functions for most
> compilers, but my Clang-19 somehow thinks it's better to outline them.
> These tiny helpers then live in normal .text sections instead of
> .noinstr sections, violating noinstr.
> 
> Mark them __always_inline so the compiler can never outline them.
> 
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> ---
>  arch/arm64/include/asm/esr.h       | 2 +-
>  arch/arm64/include/asm/percpu.h    | 2 +-
>  arch/arm64/include/asm/preempt.h   | 4 ++--
>  arch/arm64/include/asm/ptrace.h    | 4 ++--
>  arch/arm64/kernel/debug-monitors.c | 2 +-
>  include/linux/kprobes.h            | 8 ++++----

Are you OK with this patch? If so, can you ack it?

-- Steve

>  6 files changed, 11 insertions(+), 11 deletions(-)
> 

[..]

> diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> index 8c4f3bb24429..5880445ed0f0 100644
> --- a/include/linux/kprobes.h
> +++ b/include/linux/kprobes.h
> @@ -384,17 +384,17 @@ static inline void kprobe_ftrace_kill(void) {}
>  struct kprobe *get_kprobe(void *addr);
>  
>  /* kprobe_running() will just return the current_kprobe on this CPU */
> -static inline struct kprobe *kprobe_running(void)
> +static __always_inline struct kprobe *kprobe_running(void)
>  {
>  	return __this_cpu_read(current_kprobe);
>  }
>  
> -static inline void reset_current_kprobe(void)
> +static __always_inline void reset_current_kprobe(void)
>  {
>  	__this_cpu_write(current_kprobe, NULL);
>  }
>  
> -static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
> +static __always_inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
>  {
>  	return this_cpu_ptr(&kprobe_ctlblk);
>  }
> @@ -449,7 +449,7 @@ static inline struct kprobe *get_kprobe(void *addr)
>  {
>  	return NULL;
>  }
> -static inline struct kprobe *kprobe_running(void)
> +static __always_inline struct kprobe *kprobe_running(void)
>  {
>  	return NULL;
>  }

