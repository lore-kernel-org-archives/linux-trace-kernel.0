Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED7338B153
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305722; cv=none; b=ZruMQsUyp/22FnSxTeaBWKX1cu3kFlGWI76L/rKYr5QPw5N/Ra6u0cUqgi61UZZk7RXFUqWz9AmF0zZoS2LWp/H/z+fBDl8o6cbXVlNesscnUYfV8KpMulMqsuc83BZnh93c85peHYW7q5HxNczav0DmSa86Ou98AYv8tCd1w48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305722; c=relaxed/simple;
	bh=/3vdoFQ6xBKuMKdZ3izMz8e4s2bhLnzcXpE/ttaYt/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iQSKCTsyeL6/l3++4BYR5264zmRVMyZDGDPUvjLv6M6F1Zeu9SFfNViHUPnnWDNhFFSVnRPhlYC9sMtR6JI0CacbV6bZuddKdYSVO6+tHqPEWx1M0f1KSYki3ZDGLTLIQDR9cl3sqUlew+RphcZD0enq+VUdk/3J/AWNffNpANE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=30ZTxx8d; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="30ZTxx8d"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-483487335c2so5727145e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 01:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773305719; x=1773910519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6m3iVjAJ3GnbX16/A8yr0Uv8IZ6KsZjKuUcZqEbIVJA=;
        b=30ZTxx8dlwWyskSH57IW5I+EXAXu9Jq3YTxo4VclyJu5UIFpSvs+eNLFGwFHT/lw00
         3gO1OdP8L44ZOAffV/PFq+MguOSnuKqox2OkX+cmlbcyQzwPXROAyQfk6rFogsdbXBEE
         gLuP1i6DQD4zw7TdlMGW+b888NXo5Jx5MGHt1K2q906c2nXJmCxNBlpczvtYAY2E2A/Z
         gGEj9RYF7TM9f44YKsBia8iLGNV3XoSD1S/TY4udDqu9QwzMk2NZ2FnQ5Vx4DM5huvS5
         FumQbM77GenBs4lMECvJ8YT+VfA0ffOrs0vwAaS3aeOUJjEeNh4ghHS7nTZVy3iOWzvf
         gCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773305719; x=1773910519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6m3iVjAJ3GnbX16/A8yr0Uv8IZ6KsZjKuUcZqEbIVJA=;
        b=GP1z6FiDyBf6JZqQk16mENhQskL+Hrrn3wjdHKeUVxTFWv21yPWFWheJMu1kgmuGuK
         DCHCUdsUTAORbs7SQLCT/noOtg4t2JYj9I9jwYp/Cy9sSaAYqi5rDNKpkPSDlmcjQzwj
         NQIbKLTbrceCBoleZmelHIOLNFOGbv9UNi2PuBC78ViJh2eqEVc9oqP9GpztMAhCKFMX
         S3vrLAiYIbjMNl6wwQEbFn2c5kXycIsGcGaI9ytM+srO3CjqVLZM52YLPVGSiLnFVaH1
         aOAOgOUPTP8y1FilrRiLF412447Wfx6EOkv6xzMn55Y+CpAFimlzq9hy51J0XfgiWiLX
         mSyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFaQK2FTUR6XQIbxgoUY8a7fmEIxPUVTs6kUnz655Gyp9WO1gUx4BqdE5Glrjh6DqmcDA7+4E0lV48dpHCyk67TIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuZFGPsFAMyGaZ9g5PwJ6iTXfMw7Z7Ejg5gGwW3l9VTwx5t+kT
	TUSZUMB50jmxiipC/iLs7F0H2/GKRX2V6a5y8pZqJyYEA2cNiUm515F0navnWALxmQ==
X-Gm-Gg: ATEYQzxeAV7bcPcRaoJuVAHgYtSEsEXOpox+DMGOMkq4+30M/5xDRp54V0ISPKKF+38
	L0zbKlA3xLSv3e+ILgZDpFyvgG38OxOGpj+mV7TmzK2O4Qhhy3tbWWf73b13ZSGlN3J5Yxa8S1J
	w+sFC+NL99COvw8206f0MKvObyFq15/zyXjYzDhAzAURetGGQO2k+B3io/pMbFBTCGT3uMKzJMQ
	CKJ5Iskh73kTQuSObdRAKisLNvO7JN/wPAeiAbts0w1ctw7uJzIGqtDyhbeD8WATEBBaK3gUn6f
	9a++7s1QOiCZAYzIKO/2Do/mRKPV7jiZ+dHJJV3uuWM1iIJQ488MB305AIyUt1b62STIoj8E8+F
	Fkzu5OFV6PSHTgwu0/bJ9AioQr9EKUwtkRHHJ95FT/11XgGd3t4BL7yG6jLlPk34uhOX4ZFB1i9
	QSkUY9gA5XU9GyonIt2sByeW5whfdZvjKCFPphZVkTllNUNC2fRdLSOEDMWsTH95XHdoE=
X-Received: by 2002:a05:600c:4455:b0:485:3e6c:aa84 with SMTP id 5b1f17b1804b1-4854b13b3cbmr83483945e9.33.1773305718060;
        Thu, 12 Mar 2026 01:55:18 -0700 (PDT)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b47145dsm110869815e9.0.2026.03.12.01.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 01:55:17 -0700 (PDT)
Date: Thu, 12 Mar 2026 08:55:14 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	jstultz@google.com, qperret@google.com, will@kernel.org,
	aneesh.kumar@kernel.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 18/30] tracing: Check for undefined symbols in
 simple_ring_buffer
Message-ID: <abJ_cm_yM3Q-99GL@google.com>
References: <20260309162516.2623589-1-vdonnefort@google.com>
 <20260309162516.2623589-19-vdonnefort@google.com>
 <20260311221816.GA316631@ax162>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311221816.GA316631@ax162>

On Wed, Mar 11, 2026 at 03:18:16PM -0700, Nathan Chancellor wrote:
> Hi Vincent,
> 
> On Mon, Mar 09, 2026 at 04:25:04PM +0000, Vincent Donnefort wrote:
> > The simple_ring_buffer implementation must remain simple enough to be
> > used by the pKVM hypervisor. Prevent the object build if unresolved
> > symbols are found.
> > 
> > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index d106beca8d7f..3182e1bc1cf7 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -132,4 +132,20 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
> >  obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
> >  obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
> >  
> > +#
> > +# simple_ring_buffer is used by the pKVM hypervisor which does not have access
> > +# to all kernel symbols. Fail the build if forbidden symbols are found.
> > +#
> > +UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
> > +UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
> > +UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
> > +
> > +quiet_cmd_check_undefined = NM      $<
> > +      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
> 
> This check triggers when building allmodconfig targeting arm, arm64,
> powerpc, and x86_64 (at least, I did not test more at the moment) with
> clang. If this is a hard failure, this really needs to print something
> out to the developer/user to help them debug off the bat, versus having
> to manually dig the $(NM) command out from the .cmd file or V=1. I came
> up with
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 3182e1bc1cf7..c725b06876bc 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -141,7 +141,13 @@ UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sani
>  UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
>  
>  quiet_cmd_check_undefined = NM      $<
> -      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
> +      cmd_check_undefined = \
> +          undefsyms=$$($(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST) || true); \
> +          if [ -n "$$undefsyms" ]; then \
> +              echo "Unexpected symbols in $<:" >&2; \
> +              echo "$$undefsyms" >&2; \
> +              false; \
> +          fi
>  
>  $(obj)/%.o.checked: $(obj)/%.o FORCE
>  	$(call if_changed,check_undefined)
> --
> 
> which prints
> 
>   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>                    U llvm_gcda_emit_arcs
>                    U llvm_gcda_emit_function
>                    U llvm_gcda_end_file
>                    U llvm_gcda_start_file
>                    U llvm_gcda_summary_info
>                    U llvm_gcov_init
> 
> for arm64, which makes sense since these are LLVM specific GCOV symbols,
> so they should probably get the same treatment as the other ones:
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index c725b06876bc..d464e3aa5bdd 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -136,8 +136,8 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
>  # simple_ring_buffer is used by the pKVM hypervisor which does not have access
>  # to all kernel symbols. Fail the build if forbidden symbols are found.
>  #
> -UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
> -UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
> +UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov llvm_gcda llvm_gcov
> +UNDEFINED_ALLOWLIST += __aeabi_unwind __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
>  UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
>  
>  quiet_cmd_check_undefined = NM      $<
> --
> 
> For x86_64, I see
> 
>   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>                    U __clear_pages_unrolled
>                    U __memmove
>                    U copy_page
> 
> which comes from the use of KCFI_ADDRESSABLE(), since allmodconfig has
> CONFIG_CFI=y.
> 
> For powerpc (with both clang and GCC), I see
> 
>   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>                    U .TOC.
> 
> For arm (with both clang and GCC), I see
> 
>   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>            U __stack_chk_guard
>            U warn_slowpath_fmt
> 
> Presumably adding all of those should be fine as well?
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index d464e3aa5bdd..4f120cb8c79c 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -137,7 +137,8 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
>  # to all kernel symbols. Fail the build if forbidden symbols are found.
>  #
>  UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov llvm_gcda llvm_gcov
> -UNDEFINED_ALLOWLIST += __aeabi_unwind __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
> +UNDEFINED_ALLOWLIST += __aeabi_unwind __stack_chk_fail __stack_chk_guard stackleak_track_stack __ref_stack __sanitizer
> +UNDEFINED_ALLOWLIST += \.TOC\. __clear_pages_unrolled __memmove copy_page warn_slowpath_fmt
>  UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
>  
>  quiet_cmd_check_undefined = NM      $<
> --
> 
> I don't mind sending a series for these, I just wanted to make sure I
> was reasoning about everything correctly.

Yes this is all fine. If you have something already, please send it. Meanwhile, I'll try
something a bit more durable. 

Thanks,
Vincent

> 
> Cheers,
> Nathan
