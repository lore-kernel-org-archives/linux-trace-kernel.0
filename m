Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805812C470;
	Mon, 25 Nov 2024 05:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732512326; cv=none; b=lOWIwJQJuESnevbTTBlRgpmwbWUWiV2FqLFgU2z4CiaUZeCY1tUmAjW0Oorl5+wBUbfbc1yyH0X2x7UvZ+UHkAEOj0jdpThBdA3ELO9U/4DeKo8zgTSP3ZHqSYd5BWhUHv6viG4En1edYIbCuVrI4PQTMirAxuP07MTJH8NQ7kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732512326; c=relaxed/simple;
	bh=L0pmXvqHV4+w5TZGkrN9Gq9bZ/z4LU3UH+6SB1zRC1U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=poAoTXugrlHrM/CskXhGteZUJsAOrxJELlpepORlpYwT37mdX0IwVIDgRNghTQKLGLlK/w87aqkTp6H+FAo4jwXr5Isi0MT49lz8vgW7v10vEkV7RPTlIZRV1/uvDSVWJBjJiAZPThN4PsWU2dRl7ybKh4ywBnrmRroT2FhVAlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0gE3Prj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0gE3Prj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD65C4CECE;
	Mon, 25 Nov 2024 05:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732512325;
	bh=L0pmXvqHV4+w5TZGkrN9Gq9bZ/z4LU3UH+6SB1zRC1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E0gE3Prj1GXb2munkfOfR+To6clGBTn/JkBZWopiwRSquCfb+9JhfyEWSWOxaRD1I
	 hKQj5Z0NPJrlFqUSZz9fMfj4fv454oamNcQhQl7LlYdz6IsOVLvdfTjW3iTswD2due
	 4URkJfdXFbG9AszKZ/jl45/dhgPOZfxfvxG0SGzSu7jCWl4LG5+FYyM/OW4cHzRpj3
	 xXD0fmL4cHBqEnyCktuzCATP2orB+Fnftvm47NGWqBneZmczs9N6JFlzN1z71xV+z0
	 drMcjpyWn8nsG0f3FppNj4RYy2phblXh2UAlQXieE2S/07a18gSPzgfjGNmAy250DY
	 JFemH6fLZWD5g==
Date: Mon, 25 Nov 2024 14:25:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>
Cc: Naveen N Rao <naveen@kernel.org>, Anil S Keshavamurthy
 <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] kprobes: Reduce preempt disable scope in
 check_kprobe_access_safe()
Message-Id: <20241125142520.85539bd25f3a686c5e507130@kernel.org>
In-Reply-To: <20241121-kprobes-preempt-v1-1-fd581ee7fcbb@linutronix.de>
References: <20241121-kprobes-preempt-v1-1-fd581ee7fcbb@linutronix.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 Nov 2024 08:38:08 +0100
Thomas Weißschuh <thomas.weissschuh@linutronix.de> wrote:

> Commit a189d0350f387 ("kprobes: disable preempt for module_text_address() and kernel_text_address()")
> introduced a preempt_disable() region to protect against concurrent
> module unloading. However this region also includes the call to
> jump_label_text_reserved() which takes a long time;
> up to 400us, iterating over approx 6000 jump tables.

Oops, that's too long.

> 
> The scope protected by preempt_disable() is largen than necessary.
> core_kernel_text() does not need to be protected as it does not interact
> with module code at all.
> Only the scope from __module_text_address() to try_module_get() needs to
> be protected.
> By limiting the critical section to __module_text_address() and
> try_module_get() the function responsible for the latency spike remains
> preemptible.

Yes, after getting the module refcount, no need to take care of
preemption.

> 
> This works fine even when !CONFIG_MODULES as in that case
> try_module_get() will always return true and that block can be optimized
> away.
> 
> Limit the critical section to __module_text_address() and
> try_module_get(). Use guard(preempt)() for easier error handling.
> 
> While at it also remove a spurious *probed_mod = NULL in an error
> path. On errors the output parameter is never inspected by the caller.
> Some error paths were clearing the parameters, some didn't.
> Align them for clarity.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

Looks good to me. let me pick it.

Thank you,

> ---
>  kernel/kprobes.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index da59c68df8412c4662d39d3e286d516e8cee9a69..369020170e832a34ea9c05eda6693bded02ec505 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -39,6 +39,7 @@
>  #include <linux/static_call.h>
>  #include <linux/perf_event.h>
>  #include <linux/execmem.h>
> +#include <linux/cleanup.h>
>  
>  #include <asm/sections.h>
>  #include <asm/cacheflush.h>
> @@ -1570,16 +1571,25 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	if (ret)
>  		return ret;
>  	jump_label_lock();
> -	preempt_disable();
>  
>  	/* Ensure the address is in a text area, and find a module if exists. */
>  	*probed_mod = NULL;
>  	if (!core_kernel_text((unsigned long) p->addr)) {
> +		guard(preempt)();
>  		*probed_mod = __module_text_address((unsigned long) p->addr);
>  		if (!(*probed_mod)) {
>  			ret = -EINVAL;
>  			goto out;
>  		}
> +
> +		/*
> +		 * We must hold a refcount of the probed module while updating
> +		 * its code to prohibit unexpected unloading.
> +		 */
> +		if (unlikely(!try_module_get(*probed_mod))) {
> +			ret = -ENOENT;
> +			goto out;
> +		}
>  	}
>  	/* Ensure it is not in reserved area. */
>  	if (in_gate_area_no_mm((unsigned long) p->addr) ||
> @@ -1588,21 +1598,13 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  	    static_call_text_reserved(p->addr, p->addr) ||
>  	    find_bug((unsigned long)p->addr) ||
>  	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
> +		module_put(*probed_mod);
>  		ret = -EINVAL;
>  		goto out;
>  	}
>  
>  	/* Get module refcount and reject __init functions for loaded modules. */
>  	if (IS_ENABLED(CONFIG_MODULES) && *probed_mod) {
> -		/*
> -		 * We must hold a refcount of the probed module while updating
> -		 * its code to prohibit unexpected unloading.
> -		 */
> -		if (unlikely(!try_module_get(*probed_mod))) {
> -			ret = -ENOENT;
> -			goto out;
> -		}
> -
>  		/*
>  		 * If the module freed '.init.text', we couldn't insert
>  		 * kprobes in there.
> @@ -1610,13 +1612,11 @@ static int check_kprobe_address_safe(struct kprobe *p,
>  		if (within_module_init((unsigned long)p->addr, *probed_mod) &&
>  		    !module_is_coming(*probed_mod)) {
>  			module_put(*probed_mod);
> -			*probed_mod = NULL;
>  			ret = -ENOENT;
>  		}
>  	}
>  
>  out:
> -	preempt_enable();
>  	jump_label_unlock();
>  
>  	return ret;
> 
> ---
> base-commit: adc218676eef25575469234709c2d87185ca223a
> change-id: 20241120-kprobes-preempt-09826f5e5d9c
> 
> Best regards,
> -- 
> Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
