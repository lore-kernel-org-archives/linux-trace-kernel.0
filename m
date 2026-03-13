Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D35B37881F
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 10:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397423; cv=none; b=J6uChBOB05b3AjyY7951FRYwikUkqkXF9cWXL+qGl8QVJL5voWwlOOv8osPbAWynuom8bc/pZ3cHxoFe/AwOyyzgkaDenMKENIllW0gmzUiKFkhY0GmZbZDNhcom5q+/ii+FDdbObGwoqKV84fYclI70ZrxNBJX9OuKwfKq6jL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397423; c=relaxed/simple;
	bh=fd2r+mdrfBvcRUhOpn16S4IY/cr9EgphYBGD5ZNHn1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npffM2rm7vED4gAyylHYUxo7mnLnzjiNquSwrKmgGWm1y/afYfTchVx1MYQDsbDI71o8wf+lz73LUZ3fR+s7Hjqy5wCNDiJO4GuQ0rZlmIK1iCwyenmlsPsXSsOy8hQOoephZNypRSBqCpIUP1tTORHAg8vEyfRkwVIjyllZyCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TEPh+bz5; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TEPh+bz5"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso17581285e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 03:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773397418; x=1774002218; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cfOFaaHh+7PGnBGlLxa6wky8f/wOxRXhX/B9IK4WGUU=;
        b=TEPh+bz5A6GPUjghMyFEJshRF7EJV1gAL3rIBimXLWL9eDPrH0PRw7E8kvohO0kvBS
         tQJPUyeFoXVQBYGdvSVjndomOlLmM7aEL3Tx9k4o4xEtfFFsQ8raL7t8HgvT/p74MxE2
         0n+YyWHepYvf20R52zlSdw9wleLwb77ZSketM6cDH7SC1rnq4ABvJuinU7r5o84i2gLH
         WpIRDCrJFk7hV2G+zgF2BEH0ao7/5p1ilJRFye64TypzSeFmoHCzK/mof9aaukI2aWEw
         eVXizQ8EhTcAypf0ZUvcUCfmy0SELx9hkGjunwBQrUec9dxD6H8tDGkjxQWeFoK8g9qV
         KmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773397418; x=1774002218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfOFaaHh+7PGnBGlLxa6wky8f/wOxRXhX/B9IK4WGUU=;
        b=I4i+zpMi1IIeEIm0VXYfqUO/y5imLJXUBOCkgVUpCQ8ooo1tdtR2AUY8i3kTOf6vHP
         4EO6Fco2a5Q8QvZTbQOWz9hoGYsc2YcHYA0yrjOpSSMlJwfpmPvewMe4FigpD5VBScBU
         74yvkxq6hrLMIKRw1haJPrPZ6f4ZjSBGEJ+Ap+KDJigFJSDPNag89gHL9Cu9q8LHc0IQ
         UNwUir8aD+KVWo6ky3BZQ1OirwlFt7ywfUguCNE8TbAunCBtKG4CVU70ssH5ksYbJylX
         G5pbTYB9WNpB/7N7g1Jy1n1zRwYF4+f6fJnBK5U3J5M05YXzl481oy+Djvs53QORGzZC
         rizQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkMehUZtJeFDuwKVtOB6MQdWP0IM/SPl71fVYljU3zMvdtQRIagFaPBLbADP6FE9cIg+9r8hENnwtJl7pdBw/wYXU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ifZEVtYfpCGGeoq92LhmPfQz82O3mulTzuEby+VZmY1wycfG
	t9SiA5PfNPU43Ge63oXVpiYFQm6MA3VlvZvWSzIoH+s6J6znelFSBLp9YJQeYml2+A==
X-Gm-Gg: ATEYQzyyw6GMmVd79fe8HahqHS0rBUVmvq8uTUTt7NTDQOvSe6cqzJe9RUFiHhOGWtF
	LDCKoy2wSDXjn6HjPOtcIgwfOpVF2FKq+MWrs5Nqi1OH5IY0g7vnNz9wUhVc/Zssi/D44bdd0gx
	V7hD4InSFHw5HqH4x7k5nSEpG38gr9EE7iNIWK2kBquVKNXxFZ9kfmBQ+vrt5hMv/YlGfHqlsqM
	AOSYfYi+YpSbJalRgYzPzuZ2VZCNgMj60PcZOGk59upLyq3chMuyd1ALSk29uQCg9gZ2bAlN3Y3
	gtMM7Q7Kr19vrXj+3ob/OaydzHFo08JCq8ZQVPyHSSRlBJOIIAip1oiu7VNy4d2eQEPUpd2YNzi
	Ex/2cFIoSBZbZrXjCyR5/3R8FCHvGudIcOqKE5Z2VSrGFW4mB4BOiYRl/zq4tvTw9HfE6cU2FJR
	RdWgK8AcaJ1hvlVZ3EAxU5XuS1uunOtWOY4zIb3DcOzoZyo4PErNcT2kmioB/dXMJDVk8=
X-Received: by 2002:a05:600c:a08c:b0:485:42ba:fc8 with SMTP id 5b1f17b1804b1-485566cdb46mr38569995e9.4.1773397417987;
        Fri, 13 Mar 2026 03:23:37 -0700 (PDT)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm433813545e9.11.2026.03.13.03.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 03:23:37 -0700 (PDT)
Date: Fri, 13 Mar 2026 10:23:34 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: maz@kernel.org, rostedt@goodmis.org, arnd@arndb.de,
	linux-trace-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	kernel-team@android.com
Subject: Re: [PATCH] tracing: Generate undef symbols allowlist for
 simple_ring_buffer
Message-ID: <abPlpjwY_fT81B-E@google.com>
References: <20260312182010.111013-1-vdonnefort@google.com>
 <20260312235153.GA1147071@ax162>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312235153.GA1147071@ax162>

On Thu, Mar 12, 2026 at 04:51:53PM -0700, Nathan Chancellor wrote:
> Hi Vincent,
> 
> On Thu, Mar 12, 2026 at 06:20:10PM +0000, Vincent Donnefort wrote:
> > Compiler and tooling-generated symbols are difficult to maintain
> > across all supported architectures. Make the allowlist more robust by
> > replacing the harcoded list with a mechanism that automatically detects
> > these symbols.
> > 
> > This mechanism generates a C function designed to trigger common
> > compiler-inserted symbols.
> 
> This certainly seems more robust.
> 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index beb15936829d..3b427b76434a 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -136,17 +136,37 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
> >  # simple_ring_buffer is used by the pKVM hypervisor which does not have access
> >  # to all kernel symbols. Fail the build if forbidden symbols are found.
> >  #
> > -UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
> > -UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer llvm_gcda llvm_gcov
> > -UNDEFINED_ALLOWLIST += .TOC\. __clear_pages_unrolled __memmove copy_page warn_slowpath_fmt
> > -UNDEFINED_ALLOWLIST += ftrace_likely_update __hwasan_load __hwasan_store __hwasan_tag_memory
> > -UNDEFINED_ALLOWLIST += warn_bogus_irq_restore __stack_chk_guard
> > -UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
> > +# undefsyms_base generates a set of compiler and tooling-generated symbols that can
> > +# safely be ignored for simple_ring_buffer.
> > +#
> > +$(obj)/undefsyms_base.c: FORCE
> > +	$(Q)echo '#include <asm/page.h>' > $@
> > +	$(Q)echo '#include <asm/local.h>' >> $@
> > +	$(Q)echo 'static char page[PAGE_SIZE] __aligned(PAGE_SIZE);' >> $@
> > +	$(Q)echo 'void undefsyms_base(int n);' >> $@
> > +	$(Q)echo 'void undefsyms_base(int n) {' >> $@
> > +	$(Q)echo '	char buffer[256] = { 0 };' >> $@
> > +	$(Q)echo '	u32 u = 0;' >> $@
> > +	$(Q)echo '	memset((char * volatile)page, 8, PAGE_SIZE);' >> $@
> > +	$(Q)echo '	memset((char * volatile)buffer, 8, sizeof(buffer));' >> $@
> > +	$(Q)echo '	cmpxchg((u32 * volatile)&u, 0, 8);' >> $@
> > +	$(Q)echo '	WARN_ON(n == 0xdeadbeef);' >> $@
> > +	$(Q)echo '}' >> $@
> 
> This should use filechk, otherwise undefsyms_base.c will be regenerated
> every build, resulting in undefsyms_base.o being rebuilt every time.
> 
>   $ make -skj"$(nproc)" ARCH=x86_64 mrproper allmodconfig kernel/trace/
> 
>   $ make -skj"$(nproc)" ARCH=x86_64 V=2 kernel/trace/
>   ...
>     CC      kernel/trace/undefsyms_base.o - due to: kernel/trace/undefsyms_base.c
>     NM      kernel/trace/simple_ring_buffer.o - due to target missing
> 
> filechk_undefsyms_base = {                                              \
> 	echo '$(pound)include <asm/page.h>';                            \
> 	echo '$(pound)include <asm/local.h>';                           \
> 	echo 'static char page[PAGE_SIZE] __aligned(PAGE_SIZE);';       \
> 	echo 'void undefsyms_base(int n);';                             \
> 	echo 'void undefsyms_base(int n) {';                            \
> 	echo '	char buffer[256] = { 0 };';                             \
> 	echo '	u32 u = 0;';                                            \
> 	echo '	memset((char * volatile)page, 8, PAGE_SIZE);';          \
> 	echo '	memset((char * volatile)buffer, 8, sizeof(buffer));';   \
> 	echo '	cmpxchg((u32 * volatile)&u, 0, 8);';                    \
> 	echo '	WARN_ON(n == 0xdeadbeef);';                             \
> 	echo '}';                                                       \
> 	}
> 
> $(obj)/undefsyms_base.c: FORCE
> 	$(call filechk,undefsyms_base)
> 
>   $ make -skj"$(nproc)" ARCH=x86_64 mrproper allmodconfig kernel/trace/
> 
>   $ make -skj"$(nproc)" ARCH=x86_64 V=2 kernel/trace/
>     GEN     Makefile - due to target is PHONY
>     DESCEND objtool
>     CALL    scripts/checksyscalls.sh - due to target is PHONY
>     INSTALL libsubcmd_headers
>     NM      kernel/trace/simple_ring_buffer.o - due to target missing
> 
> > +clean-files += undefsyms_base.c
> > +targets += undefsyms_base.c
> 
> I don't think this targets addition is necessary.
> 
> > +$(obj)/undefsyms_base.o: $(obj)/undefsyms_base.c
> > +
> > +extra-y += undefsyms_base.o
> 
> I think this should be
> 
>   targets += undefsyms_base.o
> 
> as extra-y is deprecated per Documentation/kbuild/makefiles.rst.
> 
> > +UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sanitizer __tsan __ubsan __x86_indirect_thunk \
> > +		       $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
> 
> With an allmodconfig + ThinLTO build, I still see:
> 
>   $ cat allmod.config
>   CONFIG_GCOV_KERNEL=n
>   CONFIG_KASAN=n
>   CONFIG_LTO_CLANG_THIN=y
> 
>   $ make -skj"$(nproc)" ARCH=x86_64 KCONFIG_ALLCONFIG=1 LLVM=1 mrproper allmodconfig kernel/trace/
>   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>                    U __fortify_panic
>                    U __write_overflow_field
>                    U simple_ring_buffer_commit
>                    U simple_ring_buffer_enable_tracing
>                    U simple_ring_buffer_init
>                    U simple_ring_buffer_reserve
>                    U simple_ring_buffer_reset
>                    U simple_ring_buffer_swap_reader_page
>                    U simple_ring_buffer_unload
> 
> Something like:
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 48c415a0c7e4..0f9a6ce9abd9 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -142,13 +142,15 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
>  filechk_undefsyms_base = {                                              \
>  	echo '$(pound)include <asm/page.h>';                            \
>  	echo '$(pound)include <asm/local.h>';                           \
> +	echo '$(pound)include <linux/string.h>';                        \
>  	echo 'static char page[PAGE_SIZE] __aligned(PAGE_SIZE);';       \
> -	echo 'void undefsyms_base(int n);';                             \
> -	echo 'void undefsyms_base(int n) {';                            \
> +	echo 'void undefsyms_base(int n, void *ptr);';                  \
> +	echo 'void undefsyms_base(int n, void *ptr) {';                 \
>  	echo '	char buffer[256] = { 0 };';                             \
>  	echo '	u32 u = 0;';                                            \
>  	echo '	memset((char * volatile)page, 8, PAGE_SIZE);';          \
>  	echo '	memset((char * volatile)buffer, 8, sizeof(buffer));';   \
> +	echo '	memcpy((void* volatile)ptr, buffer, sizeof(buffer));';  \
>  	echo '	cmpxchg((u32 * volatile)&u, 0, 8);';                    \
>  	echo '	WARN_ON(n == 0xdeadbeef);';                             \
>  	echo '}';                                                       \
> --
> 
> cures the first two. The simple_ring_buffer symbols are very odd...
> 
>   $ llvm-nm kernel/trace/simple_ring_buffer.o | grep simple_ring_buffer
>   ---------------- d __UNIQUE_ID_addressable_simple_ring_buffer_commit_845
>   ---------------- d __UNIQUE_ID_addressable_simple_ring_buffer_enable_tracing_849
>   ---------------- d __UNIQUE_ID_addressable_simple_ring_buffer_init_847
>   ---------------- d __UNIQUE_ID_addressable_simple_ring_buffer_reserve_841
>   ---------------- d __UNIQUE_ID_addressable_simple_ring_buffer_reset_846
>   ---------------- d __UNIQUE_ID_addressable_simple_ring_buffer_swap_reader_page_837
>   ---------------- d __UNIQUE_ID_addressable_simple_ring_buffer_unload_848
>   ---------------- t __export_symbol_simple_ring_buffer_commit
>   ---------------- t __export_symbol_simple_ring_buffer_enable_tracing
>   ---------------- t __export_symbol_simple_ring_buffer_init
>   ---------------- t __export_symbol_simple_ring_buffer_reserve
>   ---------------- t __export_symbol_simple_ring_buffer_reset
>   ---------------- t __export_symbol_simple_ring_buffer_swap_reader_page
>   ---------------- t __export_symbol_simple_ring_buffer_unload
>   ---------------- T simple_ring_buffer_commit
>                    U simple_ring_buffer_commit
>   ---------------- T simple_ring_buffer_enable_tracing
>                    U simple_ring_buffer_enable_tracing
>                    U simple_ring_buffer_init
>   ---------------- T simple_ring_buffer_init
>   ---------------- T simple_ring_buffer_init_mm
>   ---------------- T simple_ring_buffer_reserve
>                    U simple_ring_buffer_reserve
>   ---------------- T simple_ring_buffer_reset
>                    U simple_ring_buffer_reset
>                    U simple_ring_buffer_swap_reader_page
>   ---------------- T simple_ring_buffer_swap_reader_page
>                    U simple_ring_buffer_unload
>   ---------------- T simple_ring_buffer_unload
>   ---------------- T simple_ring_buffer_unload_mm
> 
> This is LLVM IR bitcode at this stage, which could be messing things up.
> 
>   $ file kernel/trace/simple_ring_buffer.o
>   kernel/trace/simple_ring_buffer.o: LLVM IR bitcode
> 
> Maybe not worth thinking about too much and just adding it to the
> allowlist manually?

That looks good, thanks for having a look. I'll spin a v2 with your comments.

> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 0f9a6ce9abd9..cb1ec50a8386 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -166,6 +166,7 @@ $(obj)/undefsyms_base.o: $(obj)/undefsyms_base.c
>  targets += undefsyms_base.o
>  
>  UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sanitizer __tsan __ubsan __x86_indirect_thunk \
> +		       simple_ring_buffer \
>  		       $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
>  
>  quiet_cmd_check_undefined = NM      $<
> --
> 
> Cheers,
> Nathan
