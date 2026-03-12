Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CF35A388
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773324476; cv=none; b=m9JR4ewt1eO8jrTRaQQYjnl+M3+aZih954XIvAJhbj1dKXuanpwsLkNloC000sq4pkMfDNeh4XqQRZ2s4ae6W4BWkNL8hAGuBQmclZfU06dqhiOpIKqVBbeC6OwFHWaAklnTcxgQpCTYoNbwQ7aqzhLpvfOG9iExtFyjRViS4TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773324476; c=relaxed/simple;
	bh=je2Su01mUc5JDXpVVT4CNHVYbw70OhSPnxJmGcuocjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gB714/ivP/eaHrOvRkVXmDzrYnlI579koUf29OU4lZCzfH7LaqSHzwLJeYxyHVA+E6Md7gJx6ku7vWfWIV1oXPHm8XapdKfM+Dg1MsWxMZgP5I5s8JKEjX8AI2qxdsJrDKFQbOBn4skRbNjkzrP/vjesXE+dun8phbuZ6XKrRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sN1pHa05; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sN1pHa05"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439ce3605ecso871454f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 07:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773324471; x=1773929271; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=viC1gPLlOGctSWu83HWjGEsXF70NJAe1D+sqpq58byY=;
        b=sN1pHa05bancSNtzCRPbfa3qfyBL3zKcUSAefgMNrnrmrxpN980dACzQt9a2Ss4Ys5
         ANMZzzllyr6V4EDXBP+OVZc75YbKo6d4J+Skl2tAD1hWYNswN+bYml/Nimyu7pC8NMdv
         jtoIefLPQwLcYXbVvne2k91TI/oH1cv3oSW8SB1pXO0YqwEV+2XPpCmGi/Gof4m4n1ni
         ucB5miiY6LWdOvF9oFFmiyiLVTzROJdFvsScfibdIyipVNufR54hnE+CdNA5ivf+KLX/
         C/ECDrxxXP2mtdqaQ7KvwGe+kkYzBQ+0bNqBCfHoSwMar5uLb1rlMkJoiipJCPXrHals
         g38w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773324471; x=1773929271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=viC1gPLlOGctSWu83HWjGEsXF70NJAe1D+sqpq58byY=;
        b=rMH3WT7Nh43bK015uqjmM4dv0sCWiWrFzYEULoVYedM5E1SSNPWmF8LEz4MGHsu65E
         N8itTv78JliqFNVSJHdtNoyVLof/hIvqjlbyLBYMVRpBgCbsdw48oPwHM6ZRI1yFxcek
         N6QQOf27ZenGqTCCpIW1D12uODMBxPa0jz/nA+F+7A5CRvwZyFGjWn9k/GDiHGLoDqDR
         LS6BJGmw1IEYW9s4j3JjiQ82h/cUdSfqX1tnv1u59opDPwFpxg5UL8l4bcO3+LBEPZ9A
         d9kcahwSINWoBxoUlJiKnWxV/qd/AVk76M9Iv1Xc95G/CEDTk5+BZYaHp9vIgIBe39ai
         cQdw==
X-Forwarded-Encrypted: i=1; AJvYcCW14lrnk03lPtLw9nVsTMjTfdP1OKPZoBSO1mEipfUV8OrxvTayCr9hZQCQH0DgzNLGgaLfvWj1zzmyx4MMgAvKKKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYKEQeMmK49NpUJZbFvznR+SQ5VAHzzSn6+psKGXCWwWWbdNkx
	9RJ3oEpf73MGDkSSrpoYeu3FIzwDqE1r/gjLg8iecO3bhg7or/BQkag4HvLMlnMXGw==
X-Gm-Gg: ATEYQzw7sGatizZ95FfelE1j1C2KqOYnGWGEj4zR7+Xo3F5toJ9H7b721kQWfhSckZ6
	7GTYKVxtf+sI6NEJQUkVHeYNGweJty80oCL33AB7djoZ1MZ7YwVW0zbIJh4Gt3+B6wmwmJWyXv4
	GX2lf6DrdhTcsX41wr+BglL9ciTEKWTZgdCOXdTmig30rLcMgu6QyTh1jBDhr7BKrxDwnLqdolE
	5YlnVzNUj9ZiOf8ay9ATC5YjVaZjgZM2YpMbqhnP+QIqgbyrknwoKS7VHlH779grMxk+TdODWtJ
	+Jo5Ipi+aFuVhddS87DLTjKEfEg2Z4kXcTRmP0446ZPNwaoHgAeQo7xPe40+PJXIvralFSIF8Pl
	N+T90IrSYLrx1vAL2nJcCDZZR+esM1SNqqgcnVxj0bA05rlglBeMnZdmfe9TjD5o4grYtCj1khi
	K+OYT/vdtSje09p7igo1OASKJHczUn92Riyf33FTR37mXoN7ewkmEcOz1bj2enlb1FmCbgPH0ER
	6LhGA==
X-Received: by 2002:a05:6000:2012:b0:439:cb20:f30c with SMTP id ffacd0b85a97d-439f81c77c9mr13119179f8f.23.1773324470601;
        Thu, 12 Mar 2026 07:07:50 -0700 (PDT)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe1a76e5sm8108613f8f.12.2026.03.12.07.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 07:07:50 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:07:46 +0000
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
Message-ID: <abLIslqIcVscZRFg@google.com>
References: <20260309162516.2623589-1-vdonnefort@google.com>
 <20260309162516.2623589-19-vdonnefort@google.com>
 <20260311221816.GA316631@ax162>
 <abJ_cm_yM3Q-99GL@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abJ_cm_yM3Q-99GL@google.com>

On Thu, Mar 12, 2026 at 08:55:14AM +0000, Vincent Donnefort wrote:
> On Wed, Mar 11, 2026 at 03:18:16PM -0700, Nathan Chancellor wrote:
> > Hi Vincent,
> > 
> > On Mon, Mar 09, 2026 at 04:25:04PM +0000, Vincent Donnefort wrote:
> > > The simple_ring_buffer implementation must remain simple enough to be
> > > used by the pKVM hypervisor. Prevent the object build if unresolved
> > > symbols are found.
> > > 
> > > Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > > 
> > > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > > index d106beca8d7f..3182e1bc1cf7 100644
> > > --- a/kernel/trace/Makefile
> > > +++ b/kernel/trace/Makefile
> > > @@ -132,4 +132,20 @@ obj-$(CONFIG_TRACE_REMOTE) += trace_remote.o
> > >  obj-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o
> > >  obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
> > >  
> > > +#
> > > +# simple_ring_buffer is used by the pKVM hypervisor which does not have access
> > > +# to all kernel symbols. Fail the build if forbidden symbols are found.
> > > +#
> > > +UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
> > > +UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
> > > +UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
> > > +
> > > +quiet_cmd_check_undefined = NM      $<
> > > +      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
> > 
> > This check triggers when building allmodconfig targeting arm, arm64,
> > powerpc, and x86_64 (at least, I did not test more at the moment) with
> > clang. If this is a hard failure, this really needs to print something
> > out to the developer/user to help them debug off the bat, versus having
> > to manually dig the $(NM) command out from the .cmd file or V=1. I came
> > up with
> > 
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index 3182e1bc1cf7..c725b06876bc 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -141,7 +141,13 @@ UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sani
> >  UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
> >  
> >  quiet_cmd_check_undefined = NM      $<
> > -      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
> > +      cmd_check_undefined = \
> > +          undefsyms=$$($(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST) || true); \
> > +          if [ -n "$$undefsyms" ]; then \
> > +              echo "Unexpected symbols in $<:" >&2; \
> > +              echo "$$undefsyms" >&2; \
> > +              false; \
> > +          fi
> >  
> >  $(obj)/%.o.checked: $(obj)/%.o FORCE
> >  	$(call if_changed,check_undefined)
> > --
> > 
> > which prints
> > 
> >   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >                    U llvm_gcda_emit_arcs
> >                    U llvm_gcda_emit_function
> >                    U llvm_gcda_end_file
> >                    U llvm_gcda_start_file
> >                    U llvm_gcda_summary_info
> >                    U llvm_gcov_init
> > 
> > for arm64, which makes sense since these are LLVM specific GCOV symbols,
> > so they should probably get the same treatment as the other ones:
> > 
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index c725b06876bc..d464e3aa5bdd 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -136,8 +136,8 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
> >  # simple_ring_buffer is used by the pKVM hypervisor which does not have access
> >  # to all kernel symbols. Fail the build if forbidden symbols are found.
> >  #
> > -UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
> > -UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
> > +UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov llvm_gcda llvm_gcov
> > +UNDEFINED_ALLOWLIST += __aeabi_unwind __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
> >  UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
> >  
> >  quiet_cmd_check_undefined = NM      $<
> > --
> > 
> > For x86_64, I see
> > 
> >   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >                    U __clear_pages_unrolled
> >                    U __memmove
> >                    U copy_page
> > 
> > which comes from the use of KCFI_ADDRESSABLE(), since allmodconfig has
> > CONFIG_CFI=y.
> > 
> > For powerpc (with both clang and GCC), I see
> > 
> >   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >                    U .TOC.
> > 
> > For arm (with both clang and GCC), I see
> > 
> >   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
> >            U __stack_chk_guard
> >            U warn_slowpath_fmt
> > 
> > Presumably adding all of those should be fine as well?
> > 
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index d464e3aa5bdd..4f120cb8c79c 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -137,7 +137,8 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
> >  # to all kernel symbols. Fail the build if forbidden symbols are found.
> >  #
> >  UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov llvm_gcda llvm_gcov
> > -UNDEFINED_ALLOWLIST += __aeabi_unwind __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
> > +UNDEFINED_ALLOWLIST += __aeabi_unwind __stack_chk_fail __stack_chk_guard stackleak_track_stack __ref_stack __sanitizer
> > +UNDEFINED_ALLOWLIST += \.TOC\. __clear_pages_unrolled __memmove copy_page warn_slowpath_fmt
> >  UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
> >  
> >  quiet_cmd_check_undefined = NM      $<
> > --
> > 
> > I don't mind sending a series for these, I just wanted to make sure I
> > was reasoning about everything correctly.
> 
> Yes this is all fine. If you have something already, please send it. Meanwhile, I'll try
> something a bit more durable. 
> 
> Thanks,
> Vincent

In the end to unblock linux-next I have already sent an updated list of symbols.
However feel free to send the logging bit, that is surely useful.

> 
> > 
> > Cheers,
> > Nathan
