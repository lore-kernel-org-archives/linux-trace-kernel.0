Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC61842EEB8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 13:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781702806; cv=none; b=flcd+/DtFBPNhddn1tV1+FMwIbKsFiKfC7BtXDOkd8CmNJGiQrkIBypp8yd6J7VfeJii+uGF/KbYdU7greSxmN4t5wb/xytlWG3+rkls+N+dKEEmbAiz9FompcJRFmG3G4weBrt61JsERvsprbEB4DZDn/Do3gwAmJXttrTAAK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781702806; c=relaxed/simple;
	bh=2empQF2J/OcdElnIEv2j+jOQoEM6gxuILIKRvoUJ4XA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VlC7w5nQCQm2QlubbZqVjQ7QJBtv2BteMWs9gHDUfmT4v7ZuoIj+vQTe8vbn34ymxq/B3dKBhiunULz+wYkjPAFv81tb4i1YIglESxwvOw6pxcnp/sfHJGo5eC1acT7QBij/PBd4Ey00uvGh+CTSHkKXf4e32NcS2G3EVGIe8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONejZZAP; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONejZZAP"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso73174775e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781702802; x=1782307602; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5zxb6GFRrhCgQ7TLt0ipxO76kANUtNRaysZidmTt9y8=;
        b=ONejZZAPF2BvEGe6NRsbzeiHDsKtxjxhL/PVspTGxtHatrJNnOCGCJ9sDtaWp83+jN
         n6QmmnzizbJmeXlqWok63gCTg0tN7aVcbwakCIXv/7IiKmBK6EIy5lNT90+22YgxC56U
         dqosxVAkDl2IQFvPNrMR1h5s6G6unj00ocjuNHjGY7n6He7itVRELIYhefkSaluZNb6c
         e/QOXvdszLth3s+t/4K3hvsItpsGLD2Ke4Q0c2O6afy3Ni2SyAv+h9Q7A9LUlCF9UeRS
         EW0ZBW5nroinrl+VNVOjp4Fda/Krrcf7GWOhNw5N1As/3iyFQwm+H2j0aXVKjycP4wOn
         9Afg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781702802; x=1782307602;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5zxb6GFRrhCgQ7TLt0ipxO76kANUtNRaysZidmTt9y8=;
        b=duFjolGNGTWPFPcOdtZfhHRlLlnQAg94CFOlcM5UXTYHbjZ3gw/zrKqjtuAc/S4AC8
         3C3Mbf4ZE4vNdEc5WcdCyXUjQTd/oXinIn5KX1m5EbVbYjXCKBEfy/unL7QgR+tzjeRi
         HSZHuB0H7+iwTnpLcFGBZ4fziFNJleuSeOW8Bt598LfykRZH68LMnFRVO9V0WnJg8b2V
         3VOT3gh5Wmn7FrdZcA4rHZHt83i+PYiS+FgZySnCer1TrzGPoiDSgy361Y32VmgJGx40
         ANC6VEnK4L3WvxweWTz61O0p2NuSDYvA27q07EUfRZn7eRY1Pi2u1Mabc0FjvnnG3gqS
         A7pQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qy7SexMQb1ZHGcpBoqK1drbnO7tNR0N0L2XIyXaoQuLmd/i9YcSjuhKYj1g2nyZ0zQO6P04YOMEBRcfKUDYi+4ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWXCN68wxPMd1vwVUqBDpesVDvD000eqj+DgFaR4aC/A+F4iH
	m6AmsH04vfC+uNgifto9KFUHI9E7g11Dzs/OLEMxXiEqZvcwOKmJprXta3MRyZbO3A==
X-Gm-Gg: Acq92OEIeXPPuiJ9lLk8JYB3dilE+Rgx2F59uGrTJcM6YU4LiFOb71wMReajFVsC1fh
	h0U/i6Kf2kOnw5KLMOicdfORmRyHG+lf+lykoEngy6TXjii7PuGMUYoaDY9is9ckdlYtCuOqpx3
	UNcoT0ih7ql2fw6PjbWiAs2iaIk/u+OWgJSOz6U/TT5SiI6ybwTti61JDxGJS5qZr9bNONFrTZQ
	h+jK9zD6pGsb4N0x33ftk4nIovnj0P4H9uJtuM0w5fJDDxA8dmwAjNjkF8fLWOalHrDAoSFYpUT
	OR8D7UYYrlOeWez3/+a2G+1KcrmTYTl6R+SU9jHWppv+rdtRl7h7lb82ml7Kso6MkxUO6GnUafZ
	/Dk6gT7co9JbWiSvyjMEOkR1xXtU6KDoKxJm+/+N+hIGexfWMcoJE5uL7o2+A2u2DDSXsTyMwPp
	imX3ib+s6K/acCjxE/+BkyiAop74ekW2St6xmAawW6pZsjg8DHQHyu94Hz
X-Received: by 2002:a05:600c:628b:b0:490:d354:bcef with SMTP id 5b1f17b1804b1-492333df0c7mr63112735e9.33.1781702801641;
        Wed, 17 Jun 2026 06:26:41 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923757b8a5sm5686655e9.2.2026.06.17.06.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 06:26:40 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:26:36 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] tracing: ring-buffer: allowlist clang-generated symbols
Message-ID: <ajKgjNuHUlteSziZ@google.com>
References: <20260616164211.3733326-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616164211.3733326-1-arnd@kernel.org>

On Tue, Jun 16, 2026 at 06:42:03PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> In randconfig build testing using clang-22, I came across two
> sets of extra symbols in the ring buffer code that may get
> inserted by the compiler:
> 
> Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>          U memset
> 
> Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>                  U llvm_gcda_emit_arcs
>                  U llvm_gcda_emit_function
>                  U llvm_gcda_end_file
>                  U llvm_gcda_start_file
>                  U llvm_gcda_summary_info
>                  U llvm_gcov_init
> 
> Add all of these to the allowlist.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/trace/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index f934ff586bd4..aa8564fb8ff4 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -146,6 +146,7 @@ KASAN_SANITIZE_undefsyms_base.o := y

Would "GCOV_PROFILE_undefsyms_base.o := y" work?

>  
>  UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __msan \
>  		      __aeabi_unwind_cpp __s390_indirect_jump __x86_indirect_thunk simple_ring_buffer \
> +		      memset llvm_gcda llvm_gcov \
>  		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
>  
>  quiet_cmd_check_undefined = NM      $<
> -- 
> 2.39.5
> 
