Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4046938A723
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 09:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773653480; cv=none; b=R7cgKTfIlzKD7Scn87Yl5xm2j/ItXbBRUWxMbIazfe19N3s8JoIwgAVkeYs5OmvEfcXxvmNbzO4l7Kh8cm5JgLI52ZdZ2XB5OS72TFZ+3MiBsWyMXVi20m54jH2Vp4A0SxO9rEMwaNgQztS7CYEUtODFcBmXKEHDpw5gCfZc0Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773653480; c=relaxed/simple;
	bh=NuPazOIPt/eiJl0d8nf/kqY0HIF3mB+qFDMIiVADh+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoWeHsE/6+6nVci+XwpAVcJeBLea9i2PGx6j1OrHxXRYldJTkIvAuExhHaw9F1MRNt6hop3Pkv1fUJWHqELgJb9gP0Rd3hLNys4C79Fo/+KCs9hHpZ/cqlspYhxR0EeIi78wUSSnAlVa8RW+VnZsUYhP/rS9njB/w2GVGlAaQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PYpKsDIS; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYpKsDIS"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439b73f4ab4so4878305f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 02:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773653477; x=1774258277; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+2cEm3LgZQtQuvqQDE8BJ8R3spEdGYM2Icfc1B4dcM=;
        b=PYpKsDISboT9eGztoF5JRK6vuTvfsxQX4KBXMOcsVqKsA+z0Yzm65/uzSTl4XlQOs8
         O4mijXlwNXwmG6CQaI9S584nvulWKaiG+o60cCpfQl9li/tT5Gf0csV4QFIyJkUJ7Y3u
         Q1HSjx8X2jcLUj8nJTEkUNB2/1vXjPKuPvbShn4CyK+FBsfIC4pb/V6/oPvYTOBYo1y9
         LZ6WMbkEldX0mSzzfys+2oZswJW7IeQ1eFt806hVnEMIXkE9itMbfiIrDJrvwEIJD4uu
         ifvFAww7FBHzrL+sEDUanKnP/XdbcVac7LICBj5A2XHhV+i14viknLvcFQPjMHOy9Dlp
         a7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773653477; x=1774258277;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+2cEm3LgZQtQuvqQDE8BJ8R3spEdGYM2Icfc1B4dcM=;
        b=bDhJ/N/q2MF6F0kezVm/UsXWW33UuGRX/mDjBufvnkHJAwB6aYOQR6JI2SZeKufGUX
         KJCDxo45ZJ2Insjta6TAP43POQPJqOMbBS7bbgzDFZimiPTyGGbNn3Rq8MhFFAJud96H
         SEYvJeo+OcaswLAnyhc08yMF0Brs6QgnOvio5QECV2NkXHnHHvPPllqD07SNdL2UPOIX
         1sUjYXl9cJoyItrVwTxT+wHArs6+WjbyXwsGzm5Q8XKPSpLKKYf2LSz0SDVy3R4Rq9On
         EM9A8qub9UgPQfM7Qhi6T5BiYIcRlXe0UClUFX2RhOOo+aQOUVUFmqnLtjrOyDgQTbTa
         0yqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWneT6dFWgRuuxhHyBJbb34ZnWCJ1jWPAmcW33asmBwOBqI48A9KEd8MG/NLw0/TDmE2p1hW/9z/mqDnQmiI53WJ4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI5eeWKKmTkUTMa8azjapgN2XanAFU5m2/lAYYMgbuoz+Ng8dL
	PLnwiwTZkAFFJQSE5jxODndEslW9G5KXGB3vgUFVu2PEyRUq2XtLFmb9vC0Arb/Bow==
X-Gm-Gg: ATEYQzwGQzoiFPUdEQFpZa0BL7mr0Yywuz9EtB15sC2NQFB3n5NkEnk15m+hdPXQOCH
	loji6WsBeXo5pa7EQpoC3+16Zn3RvvrxCQfuYzfct8iZjrlgX5SRNdjkI/2igqhqo3ItRX8pxOl
	N3RIQEjxafXYK3Yi6Tz9DuzR/z5TjEMEQZJZfZyBqfX9DRIDKVNwF1MfmGQUYzn4iz2C0GuScxr
	9FxfGNOQ+szu/8I5TwL9NM6Q0oyd4K4p8zMgwHid3YuYp9ZWsRS57vEi/QfA+gz+lGE4AYPGdTS
	rS+th3GiOpr3SLQocDtVm14pC4vQOwpYY0KPTdaBFdId9mq/gmPilY3HpUMLlfMLssQanmymy24
	FMTBU/6ZuVNmhg17omP/5fZnXzJAoqy1BW2yjHt9p/+DhZSfevsw6lIxFlk33usWASXCUyFdyK8
	BBRk+VIOX7KZ8OW4Vmq6aDm/EWerGhdwzpPK3CoztSPCN0dd+mX5XBZqQtnFKpGTN/m1WbM7sPZ
	RViAg==
X-Received: by 2002:a05:600c:8489:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-485566f7a2amr213257395e9.17.1773653477134;
        Mon, 16 Mar 2026 02:31:17 -0700 (PDT)
Received: from google.com (198.115.140.34.bc.googleusercontent.com. [34.140.115.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a74266sm84270715e9.17.2026.03.16.02.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 02:31:16 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:31:12 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: maz@kernel.org, rostedt@goodmis.org, arnd@arndb.de,
	linux-trace-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
	kernel-team@android.com
Subject: Re: [PATCH v2] tracing: Generate undef symbols allowlist for
 simple_ring_buffer
Message-ID: <abfN4OEbYVe5h-6H@google.com>
References: <20260313105829.1214123-1-vdonnefort@google.com>
 <20260313163724.GA2573924@ax162>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313163724.GA2573924@ax162>

On Fri, Mar 13, 2026 at 09:37:24AM -0700, Nathan Chancellor wrote:
> On Fri, Mar 13, 2026 at 10:58:29AM +0000, Vincent Donnefort wrote:
> > Compiler and tooling-generated symbols are difficult to maintain
> > across all supported architectures. Make the allowlist more robust by
> > replacing the harcoded list with a mechanism that automatically detects
> > these symbols.
> > 
> > This mechanism generates a C function designed to trigger common
> > compiler-inserted symbols.
> > 
> > Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> > 
> > ---
> > 
> > Changes in v2:
> > 
> >   - Use filechk (Nathan)
> >   - Removed deprecated extra-y (Nathan)
> >   - Added simple_ring_buffer in allowlist (Nathan)
> >   - Added memcpy() to generate more symbols (Nathan)
> >   - Added __sancov 
> > 
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index beb15936829d..96627a909ecc 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -136,17 +136,42 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
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
> > +filechk_undefsyms_base = \
> > +	echo '$(pound)include <linux/atomic.h>'; \
> > +	echo '$(pound)include <linux/string.h>'; \
> > +	echo '$(pound)include <asm/page.h>'; \
> > +	echo 'static char page[PAGE_SIZE] __aligned(PAGE_SIZE);'; \
> > +	echo 'void undefsyms_base(void *p, int n);'; \
> > +	echo 'void undefsyms_base(void *p, int n) {'; \
> > +	echo '	char buffer[256] = { 0 };'; \
> > +	echo '	u32 u = 0;'; \
> > +	echo '	memset((char * volatile)page, 8, PAGE_SIZE);'; \
> > +	echo '	memset((char * volatile)buffer, 8, sizeof(buffer));'; \
> > +	echo '	memcpy((void * volatile)p, buffer, sizeof(buffer));'; \
> > +	echo '	cmpxchg((u32 * volatile)&u, 0, 8);'; \
> > +	echo '	WARN_ON(n == 0xdeadbeef);'; \
> > +	echo '}'
> > +
> > +$(obj)/undefsyms_base.c: FORCE
> > +	$(call filechk,undefsyms_base)
> > +
> > +clean-files += undefsyms_base.c
> > +
> > +$(obj)/undefsyms_base.o: $(obj)/undefsyms_base.c
> > +
> > +targets += undefsyms_base.o
> > +
> > +UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
> > +		      simple_ring_buffer \
> > +		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
> >  
> >  quiet_cmd_check_undefined = NM      $<
> > -      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(UNDEFINED_ALLOWLIST)`"
> > +      cmd_check_undefined = test -z "`$(NM) -u $< | grep -v $(addprefix -e , $(UNDEFINED_ALLOWLIST))`"
> >  
> > -$(obj)/%.o.checked: $(obj)/%.o FORCE
> > +$(obj)/%.o.checked: $(obj)/%.o $(obj)/undefsyms_base.o FORCE
> >  	$(call if_changed,check_undefined)
> >  
> >  always-$(CONFIG_SIMPLE_RING_BUFFER) += simple_ring_buffer.o.checked
> > 
> > base-commit: 33f2e266515717c4b2df585dadefa0525557726c
> > -- 
> > 2.53.0.851.ga537e3e6e9-goog
> > 
> 
> Thanks! This is almost perfect for my tests, one final thing that I
> noticed as a result of my full overnight builds. For ARCH=riscv (and
> some other architectures from a quick grep), there is some logic in
> their include/asm/string.h files to avoid FORTIFY_SOURCE when KASAN is
> enabled for the entire build but not enabled for the particular file. As
> undefsyms_base.o is not linked into vmlinux or modules, it does not
> automatically have KASAN enabled.
> 
>   $ cat allmod.config
>   CONFIG_GCOV_KERNEL=n
>   CONFIG_LTO_CLANG_THIN=y
>   CONFIG_WERROR=n
> 
>   $ make -skj"$(nproc)" ARCH=riscv KCONFIG_ALLCONFIG=1 LLVM=1 mrproper allmodconfig kernel/trace/
>   Unexpected symbols in kernel/trace/simple_ring_buffer.o:
>                    U __fortify_panic
>                    U __write_overflow_field
>   ...
> 
> This cures that for me.
> 
> diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> index 260382f62dbf..55af887a90e2 100644
> --- a/kernel/trace/Makefile
> +++ b/kernel/trace/Makefile
> @@ -164,6 +164,11 @@ $(obj)/undefsyms_base.o: $(obj)/undefsyms_base.c
>  
>  targets += undefsyms_base.o
>  
> +# ensure KASAN is enabled to avoid logic that may disable FORTIFY_SOURCE when
> +# KASAN is not enabled. undefsyms_base.o does not automatically get KASAN flags
> +# because it is not linked into vmlinux.
> +KASAN_SANITIZE_undefsyms_base.o := y
> +
>  UNDEFINED_ALLOWLIST = __asan __gcov __kasan __kcsan __hwasan __sancov __sanitizer __tsan __ubsan __x86_indirect_thunk \
>  		      simple_ring_buffer \
>  		      $(shell $(NM) -u $(obj)/undefsyms_base.o 2>/dev/null | awk '{print $$2}')
> --
> 
> With that addressed:
> 
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Tested-by: Nathan Chancellor <nathan@kernel.org>

I've just sent a v3 with all that. I have tested locally with allmodconfig and
many architectures with both clang and gcc.

Thanks a lot for your help!

--
Vincent

> 
> Cheers,
> Nathan
