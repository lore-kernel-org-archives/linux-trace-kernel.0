Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101552;
	b=viE6UF3jz8dtyo468GICLbteZZ0ZNyhSXOXzrXYNLe+Frl/71LmZmzQJRTwG9rdLhHFY
	 G7kSRykBNoN0Y7iSrNuek8bzJCcpS9QlGZ1lrcfXRpQNchX/EPh3fCGULyyLDEDv+K9LG
	 SPm4xeqGLnL5eCxbApzmZf8SPAFrzNRspPMt5QZ2oAL+0DuaRX6D6aa28NYq0fi09NnVZ
	 qIMKcfliO7Sc0/QZDqHPfeba5uH52MCw7M58YXvWKYiTeJf+tSdJZH7UzGDkCMvabQUh0
	 lA6w4xMOrXSl/oevO083ZwOSS/R0XufXdla8PX6MzQNXHw0/ck3wsUNitN3G4xlvlow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101552;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=p59+oRBqVD/OfRkrKGZMmpgQd6Fck6sy0XKFzDdr5i0=;
	b=GYoEY4ZW/nflRaVC9qIQcHQbtN6S5gPALsS9vBzeMnCIN8fTiJQLyQqadWMplAI7sDuV
	 BJ0hm1MVT8GRGU8ut+ymNOpp01Zuyyxq3CzyV0OSxGKcoKTRVPoM3MOcq8kftDCMKJh6p
	 kBCQMiMSG1xvIz2xVqYcSeVutETeMR4i50syZkCdWa4HEmeX6Yv4Nmc6p9xvgb1buG4Za
	 kBk21dmnTFM3+z0TJkH1c5gDJXth4w5nSMlohJmsl8TM2UrT+Rstmbs/6Y5pQDGKS2N/m
	 +YwQf6yZNfV/W4I8s6Fng98w98DIdkIHMME7X9KiyD1t6HAwUYkeNBK62QjXWhem1sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pl8FpfEj;
	arc=none smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AF606A320
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 15:19:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 893AF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pl8FpfEj
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4a2f4ca0dcfso1214076f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 07:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795101551; x=1795706351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=p59+oRBqVD/OfRkrKGZMmpgQd6Fck6sy0XKFzDdr5i0=;
        b=Pl8FpfEjC14Hjrto9S7109Ok0Enk6KkMxBYg4wxv7gNy38p10dC1x0lXDdQQrvrmxf
         0hwGWGIY+nblvLNyicbvByMqa94IU8c5piBf5sZXZBTs41j9sbi2sllcivutcHRcoHXP
         k7Cn1QjhXBhHliUWj4qfgE0yXOjYinCRA1R8bp9jiq7wV+bWxIiwtMmKiBMl9TFqyp+I
         6iosKfsKGftKRnKwLet0Mc6BQJ9OAXcwqrXNpbFW8sz7Jr5poYwS+Jz8AUfxAk68+tOn
         P0O004MocKSbYkU6xxMmlLPLTUjxJ9Xf9a8crxe3ZZ7tkTxiMgIoG7cMIulGketN0UhN
         xQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795101551; x=1795706351;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p59+oRBqVD/OfRkrKGZMmpgQd6Fck6sy0XKFzDdr5i0=;
        b=aF3fwhaxUWEg8bPaCwgTZiZrgFn6e4W5rFOuBM/5XLoVf0PXIMeWmgOGCgm2z1MXZ0
         8EUOnPheoUPzy55kU7VGUQu2yA/Yz+6u50jcZ5WJNgmpgcpnyLwND3oJtiwt0YlHQX4H
         Z4haC2261GCgITcTfukknWvFwZwDk1k9NvGCrtsC+2gFqGnQU2JX5IKwmqTiplekkILn
         mxgwOQXIjB7qgd4XmyQa/I+jyYtph5MTR0J7Uzg66qJko020noPHlPWZL8DMGdI3DvnY
         Oi7xfVdAgn2s5A3nqDqxoysYVU2ChOq62c769R3T66+dwR6BWnX9CVD/Xl6J5E6eL2Zu
         gLdg==
X-Forwarded-Encrypted: i=1; AL+hErEPdxb7ivHcwAVX+uO2TPAc7sCyGDQxKhxqfXVus+YiE9XJWmx1eZ/bVJIOCO0sLGglK3/rmxGyT4qk3mrVQ4v3d2c=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ulMsQdylj46qc7UlG3/DWy+U3vOjO1igMwEPsH2Art34pNqPc
	HYuOEEusBJ37ggroFC5m5FPp02duNOvGs9kyP9IFwhmiX8jQmnfGVPIIHwlJHyRK
X-Gm-Gg: AZFdTZfRi04QZIJzkieTvBYxPlWfK2pZZEG6FidZ3n3i+FtyiZKCYxVItQtLf9y+TCb
	H6GJpkWmIo10saU+wYvppieZtv+3tGEF0zYTxf5i1GkU4utQjvF/j7XUg+5k2aYs/HTed8J8A5K
	yftUCrLDO7UkNtwY4MhvlLRvLYDOq74I0fgIn5ryEWMi7xYTHZy2Nu2PeZQCN/gDQo8nY0muKXG
	yKXj2zy2Hfyc6KUkcynUTAC0Xne7wN6Q7QOmoChalvxZlQVHxR1FREUyjdpdZPGufRcZCF6dlGE
	Gva9KuI21dO/9BtXzmgdC/UCnrNtfhA1gDH0FPfpVmvaYh9E3iwxt82OAJ4Jsz/L75BKmOnwbfU
	bdwV+pnHYz+br1g5z9OjIlCCU+Tg/YBD3ptrJwU8p+ggk9Jg2seAbLAyimG5h4OpOegvELij2R8
	zHZdS7yewbdSN/yr2Tc3Arafa+S374+cAiD405+83OrQT01i+VeL5kwQSQcRP1cikROdVxPIDV0
	smf/ZmfpKI0j4SAZgsxv5rx8kE029xIGYBf/3AvYjFKl39pfO7HFYmZ4XboC9LFL2jbSgrY1sU4
	HW4PjSEBTV+snh4x
X-Received: by 2002:a05:6000:4a17:b0:4a9:760f:1824 with SMTP id ffacd0b85a97d-4a9760f28c8mr4476827f8f.21.1795101550635;
        Thu, 19 Nov 2026 07:19:10 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6ae2dd55sm128332f8f.30.2026.11.19.07.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:19:10 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Nov 2026 16:19:08 +0100
To: Yifan Feng <evanfengff@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fgraph: Fix the unwind hint at the end of
 return_to_handler()
Message-ID: <av8TbKv7I_3LEm1d@krava>
References: <20261118235023.14978-1-evanfengff@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118235023.14978-1-evanfengff@gmail.com>

On Wed, Nov 18, 2026 at 03:50:23PM -0800, Yifan Feng wrote:
> return_to_handler() reserves 8 bytes of stack for the return address
> and marks that with UNWIND_HINT_FUNC. The hint stays in effect after
> "addq $(FRAME_SIZE) + 8, %rsp" has dropped the slot again, so the ORC
> entry of the following call has CFA = sp+0:
> 
>   return_to_handler+0x41: sp+0	call .Ldo_rop
>   return_to_handler+0x46: (und)	int3
>   return_to_handler+0x47: sp+8	mov %rdi, (%rsp)
> 
> A stack trace taken from an interrupt which hits the call or the mov
> ends up at that entry, the stack pointer does not advance and the
> unwinder prints:
> 
>   WARNING: stack going in the wrong direction? at return_to_handler+0x46/0x50
> 
> The return address is only in %rdi at that point. Mark the code as
> UNWIND_HINT_UNDEFINED again, as it was before the hint was added, so
> that the unwinder stops there without the warning.
> 
> Fixes: 20a0bc10272f ("x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe")
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>

Reviewed-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka


> ---
> QEMU, function_graph + 20 kHz perf callchains: warning in 2s before, none in 10 min after.
> Found and written with the help of an AI coding assistant.
> 
>  arch/x86/kernel/ftrace_64.S | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
> index 4b20673a3395..8b488f99de02 100644
> --- a/arch/x86/kernel/ftrace_64.S
> +++ b/arch/x86/kernel/ftrace_64.S
> @@ -387,6 +387,8 @@ SYM_CODE_START(return_to_handler)
>  	movq RAX(%rsp), %rax
>  
>  	addq $(FRAME_SIZE) + 8, %rsp
> +	/* The return address is only in %rdi now, the unwinder cannot follow. */
> +	UNWIND_HINT_UNDEFINED
>  
>  	/*
>  	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi
> 
> base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
> -- 
> 2.39.3 (Apple Git-146)
> 
