Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB31137E;
	Tue, 26 Nov 2024 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732579416; cv=none; b=cUczhQfH/TEqGvawAJNiqPKLavl3df1TQ17/mAOPEqYFn5APLf6bYqRtrQF3fhoexRkluZ9/JNfzDGnJSf/8shDmyMRfAciGcmyLZ2uW9h1guZRnm00n/MnULSg5HKgI4qTFpgCqRX+yfZ08doeFIzwQUuifA0/y+faHTK7QEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732579416; c=relaxed/simple;
	bh=BEiUsKmYO0eWOyQLroD2MlMy6oITnYJV3hPYYK2gNGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VdBIVzeYGvJj19rKIfKnb6GM1mzaPqgpu/bOCIXHdoijtViAuZIhQThAYobYWBnOcw8uGZHmEWAN+q40o5FwpS/SxCiQoIMKQcjh95aTg573Hb+uOgiwFHezn6nNn5mV/5VsS6+UXW5EwbKUxGeygQDUAkKLbFP+hafVPp7rn8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C309C4CECE;
	Tue, 26 Nov 2024 00:03:34 +0000 (UTC)
Date: Mon, 25 Nov 2024 19:04:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/ftrace: fix boot time slowdown
Message-ID: <20241125190422.7372fc2c@gandalf.local.home>
In-Reply-To: <20241124140705.2883-1-rppt@kernel.org>
References: <20241124140705.2883-1-rppt@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 24 Nov 2024 16:07:05 +0200
Mike Rapoport <rppt@kernel.org> wrote:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Steven Rostedt reported slowdown by over 30ms caused by commit 9bfc4824fd48
> ("x86/module: prepare module loading for ROX allocations of text")
> 
>   Before:
> 
>    # cat /sys/kernel/tracing/dyn_ftrace_total_info
>   57695 pages:231 groups: 9
>   ftrace boot update time = 14733459 (ns)
>   ftrace module total update time = 449016 (ns)
> 
>   After:
> 
>    # cat /sys/kernel/tracing/dyn_ftrace_total_info
>   57708 pages:231 groups: 9
>   ftrace boot update time = 47195374 (ns)
>   ftrace module total update time = 592080 (ns)
> 
> The slowdown happened because initial patching of kernel code for ftrace
> was switched from text_poke_early() to text_poke() to accommodate ftrace
> updates of module text allocated as ROX.
> 
> Restore the use of text_poke_early() for boot time patching of the kernel
> code.
> 
> Reported-by: Steven Rostedt <rostedt@goodmis.org>

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> Closes: https://lore.kernel.org/all/20241118132501.4eddb46c@gandalf.local.home
> Fixes: 9bfc4824fd48 ("x86/module: prepare module loading for ROX allocations of text")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/x86/kernel/ftrace.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> index 4dd0ad6c94d6..9e50288abbaa 100644
> --- a/arch/x86/kernel/ftrace.c
> +++ b/arch/x86/kernel/ftrace.c
> @@ -111,7 +111,7 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
>   */
>  static int __ref
>  ftrace_modify_code_direct(unsigned long ip, const char *old_code,
> -			  const char *new_code)
> +			  const char *new_code, struct module *mod)
>  {
>  	int ret = ftrace_verify_code(ip, old_code);
>  	if (ret)
> @@ -120,6 +120,8 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
>  	/* replace the text with the new text */
>  	if (ftrace_poke_late) {
>  		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> +	} else if (!mod) {
> +		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
>  	} else {
>  		mutex_lock(&text_mutex);
>  		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
> @@ -145,7 +147,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long ad
>  	 * just modify the code directly.
>  	 */
>  	if (addr == MCOUNT_ADDR)
> -		return ftrace_modify_code_direct(ip, old, new);
> +		return ftrace_modify_code_direct(ip, old, new, mod);
>  
>  	/*
>  	 * x86 overrides ftrace_replace_code -- this function will never be used
> @@ -164,7 +166,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  	new = ftrace_call_replace(ip, addr);
>  
>  	/* Should only be called when module is loaded */
> -	return ftrace_modify_code_direct(rec->ip, old, new);
> +	return ftrace_modify_code_direct(rec->ip, old, new, NULL);
>  }
>  
>  /*
> 
> base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833

