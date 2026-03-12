Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085283C061F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 13:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773322833; cv=none; b=heufpHCJHvz1SKzgYGBkJF8RyBNhd28D/axWq9bLLqNuCGijnbLNsr/dZPD8akNDzMe8cMHDRLQduRSsv/Xs43ama/4w5mjhACIVDLxjQSgccmh6sXLqtJHlkHYW4TtI1zNpEjg1y530HHESHSP1Ft48ElXk6mrnQivz83YyoyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773322833; c=relaxed/simple;
	bh=BvAiibuUpZLpfUNB7gXIX+r4BI4miozW1XZfm8iXVlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nh2aHb2XIb4ZHQc1W0QODZDpC++sZ6+E6g0+pXJ6mroswKH6lzAkd76ueFljNN2In7OsCosRNKZer1PHmfy220zvIggE2BCoT0cBDT89G5ZQnRzqZIDf7qMpHX7jXk6FqdOy/q76aflY5BUYoIUwtRAzWWk3ye8BpUs2f53dR1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AQjmBVw9; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AQjmBVw9"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852e09e23dso8836435e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 06:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773322830; x=1773927630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OFj4FIAyaBDQhCM6aoVyBP6RQdQ+DyECbcgfPyQRXT8=;
        b=AQjmBVw97LytUUnfDUzuNoYV9zS0abIasdKXp2L98L0G2DmLg3IXjbRWHR1SqUNGYK
         cCvP10unWDbg17goX7GZLVFFmqhpIrBBbjyCuHOxDBJtSfue/so+iQ0vTcCWTSyw60Vd
         Pjqk7QVnka4JY9kkk1hPoczYmxLces5QVaDRbffd6nA+fPB/n6e7A35RYAzgZnXYUemm
         EKhReELRUOVBlUs0mqBfI9QINOM1MlKAFYxMURM4TAOa0ASZO7t/izry/uuXNZTHZupC
         +OA1Y4Ij8BzWdsYrRRtj8BvkjWVN7WjuNLNfKyojwQT7//QPj4JxOGH6Bcn1NiBTDmRz
         HMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773322830; x=1773927630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OFj4FIAyaBDQhCM6aoVyBP6RQdQ+DyECbcgfPyQRXT8=;
        b=Zx6wYTyUTxCAin/+92wDci6fwadSxoJmconIXrWkeS9jfCWHn6Vmk+BibgYxOGok61
         ODVjhpnesuem4u33Z8whlxt9FC/t3HpsQjajqjJ/PghmiqC0uzA6s7T/CnCPPt4xQ92C
         DTaPYaXp5r+OV4oSE8PPa/2Ebkhyerjr0laYdVa86TPJgxrK8s/TcpyKfwWP93XZ1UeV
         y++xvlVbQVaQcM4kOSH4W4p2fMWCjeZLgohMPsaMjEfIgG9MOZQ4EHCdkL2D4gIa6z9m
         8igfhUSYzi6wuQZ+NK8YEHvcszoRpP7wSOBsplR9Qlz/yDZsUF2Vu06vFKUt/IFFozSA
         k2Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU263AFZ9yF2IvhwA1nxIswFVNnEk7qtFyqpuBBfWsw34EogbCisCCUEJgf87SRBLwcFntTUc1Iqbp7sg7hsi75MYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzzT1OdJJBf8BVFXVZRnEEZB7xLGiXRY9w7Y+dCEb68P1Noppv
	W8N5KAPALm7x7KpByg6fE43UO3ChftpvS8dvLuEjGEEhJLAqhInB7KuK8IVcAaN0pA==
X-Gm-Gg: ATEYQzyndhTfBbacRTmyetZy0O3yjZifPG+/dECrEbCTUiYqsK4LSxORN+BRGZYfaTi
	LBrZd1OYIB3PlDkgKpozmgVi7TVOcWmAuEZ+J2goOSbnAr6DolGcPzM9+pvQJP4FQWgL2++fbB1
	alCUB9cVY+ECM9OMLmYkkEdnMbi28la6C5+ZcZ3sCloYDgd4fXvGpyGe1Cxsuc6rLb6nOHVtNyB
	uFpvNypVzKk0R7+RVHufl8u+WmVuits/vR4WzbEdfhdW9Kr+2QIn1PyyrjTKNIxtEXBT3h93I3Y
	frNWNop2kqar9y7xtDegrRop4yLicUBJcJw7qsw9AI86HvO9U7Vu295CE+ruZ1xpMpNiOODbFQ5
	nf6Yibw89AkgyIKEuli23FZgQKRhGxI/1ro0kOUDja5BrlY9+0vHtEWQz9mkPlQ4VogY7cOYgKb
	Bbhlyibfjy93CZpSRvvtACfX60bsH+GAdV4BHokYO+ikW8OH6dLGGICGYcU9kb5jK0Q34=
X-Received: by 2002:a05:600c:1d16:b0:483:1403:c47f with SMTP id 5b1f17b1804b1-4854b0a6fcamr109744395e9.6.1773322829959;
        Thu, 12 Mar 2026 06:40:29 -0700 (PDT)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e92d5sm129868785e9.1.2026.03.12.06.40.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 06:40:29 -0700 (PDT)
Date: Thu, 12 Mar 2026 13:40:26 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Oliver Upton <oupton@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] tracing: add more symbols to whitelist
Message-ID: <abLCSk4ZZv1h6xFq@google.com>
References: <20260312123601.625063-1-arnd@kernel.org>
 <20260312123601.625063-2-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312123601.625063-2-arnd@kernel.org>

On Thu, Mar 12, 2026 at 01:35:43PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Randconfig builds show a number of cryptic build errors from
> hitting undefined symbols in simple_ring_buffer.o:
> 
> make[7]: *** [/home/arnd/arm-soc/kernel/trace/Makefile:147: kernel/trace/simple_ring_buffer.o.checked] Error 1
> 
> These happen with CONFIG_TRACE_BRANCH_PROFILING, CONFIG_KASAN_HW_TAGS,
> CONFIG_STACKPROTECTOR, CONFIG_DEBUG_IRQFLAGS and indirectly from WARN_ON().
> 
> Add exceptions for each one that I have hit so far on arm64, x86_64 and arm
> randconfig builds.
> 
> Other architectures likely hit additional ones, so it would be nice
> to produce a little more verbose output that include the name of the
> missing symbols directly.
> 
> Fixes: a717943d8ecc ("tracing: Check for undefined symbols in simple_ring_buffer")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  kernel/trace/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 3182e1bc1cf7..e3f8d6e619d2 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -138,6 +138,8 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
>  #
>  UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
>  UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
> +UNDEFINED_ALLOWLIST += ftrace_likely_update __hwasan_load __hwasan_store __hwasan_tag_memory
> +UNDEFINED_ALLOWLIST += warn_bogus_irq_restore warn_slowpath_fmt __stack_chk_guard
>  UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
>  
>  quiet_cmd_check_undefined = NM      $<
> -- 
> 2.39.5
> 

Thanks for the patch.

Most of those ones are covered here
https://lore.kernel.org/all/20260312113535.2213350-1-vdonnefort@google.com/.

This should fix allmodconfig.

For the ones not covered, I'm working on a follow-up patch using a different
approach which should fix them. I'll be able to share it today or tomorrow. Not
sure if we want to take this temporarily?
