Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B23C1CA81;
	Sat,  5 Apr 2025 02:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743820224; cv=none; b=uMnKENxwKRzmkt44xIvrzmZM+WjQjuUEHv711ibcMCYUHLH9HOUAXV2YAyFJeQwzL3J1m+ah2l/cEeBxZ9kbDQIXCvzugXxS/bjI0tBoT6M0jCso7izwJj9XZnDU1t553AQers4N07R0WaPSeyAOD7blVk9k/w89R91hSHXXZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743820224; c=relaxed/simple;
	bh=+7j4PgUkLIuOXJL8HP5/H20XgqTYFkm2muPJyGGj9zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LLTH8D/48gF1pIr714Y1ndElAGnByJ0WW37Vfsf61qcoE14ioK03Q7SkpgdZU8oe5FRgkjmLNCAv/0v7EbCLDy+Naqas2i/5KH6lYA/60uutYAsZpoAL1OzEHGcPTIyKWyzVVxXXXZA0XRyqGdY94xs9j3XcP3sWZJedFW3GoL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSe6T+9Z; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSe6T+9Z"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e22e6ed2so3815524a12.3;
        Fri, 04 Apr 2025 19:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743820220; x=1744425020; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IS15rDDOUaZvubbeDN/CRQmwSnCO8pmZhHDJU2CSssA=;
        b=mSe6T+9ZaAr2b1sXCfvGC5+e/Q9C3urJSuYo1iPsZCz8mJxbjP9C2lYMvAZdaHoHHJ
         N2BkmTAQ5M+n1Ww/+uuDAz/kP2rbUA0QyYtaKRy0vGgaf/r/nG7YXnw6M/Hn9rgv1xk/
         8vUWLH+TeqCTDzRS9sW4keG2i5FtxjgZQJIm4VD39Bn8AER06sxHrcbE0EkHwWMvAVUp
         y0CT0eMExT/LhBgM/KW7tr1N22lJ3o+gDgtYQdBdf7IbC8zbzHGGA4o9zQ7av5Bmie1H
         SMsKuNlr1VhyTbR9venn4lX5BYWv+8n53Iu25cdTyEhHprDvptgoFtzwYZTyUVQ/YKK/
         bwTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743820220; x=1744425020;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:reply-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IS15rDDOUaZvubbeDN/CRQmwSnCO8pmZhHDJU2CSssA=;
        b=T2QPpvD+t0SS+1t27nuNnXwXr7q1MMdPlkOCU9uxpkzm6ejpvsB4ND4Gqn/2mna0xs
         qdmS6l4m0WVYvxh6M25UEx83korCbx0qcXrFPHwiiloIro9/pJ/lFgTLOghPnol/nDDy
         zOvaVek8yqftMhYtC9ZCnFg2oflEkAilFxBHnJXfAPY0c118IazP8/o42rY7oFcKO1FB
         T1fMNNPLrfShchGEKcpFH4PMnmbztahJv4dwYkqG5LouhwFd4nmKH/bsGfs/hgckJ/k7
         h8ZordSVOBgjvDEaescOreUQ16y4XuSfccUxZdVIxEJCi/e5i9FOmCAmV9tXXn841T5M
         qQ6A==
X-Forwarded-Encrypted: i=1; AJvYcCV4DUNrS7c/VyHyRWTpvgNqcFnq08vcfrOV1BqghROb8lj6QexM7Yy2turBmu7gXvINAuv1E/BOyb0gZNv34pj5JNOM@vger.kernel.org, AJvYcCWrVdH0KcY16qT2wHYsES6UVl2GyyTltIHuc4wB3LYoNgfMJIzRrTJQW6bISeI8nznKOU/xuG30C9KRGIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwG2ztm5Hwzq4vCfJYN+JLRHzgPIIyezFtHnwEFy5KwKXp/6H3
	RZzEEHZCKew4Z26gcGwIwk3Y+LU5AEUB938oCXJRdN0v2jKbwdTu
X-Gm-Gg: ASbGncuPH/M4NQ2ZhW7okxWfzd7ELlQmwDteiAwSvjFfew9ghqMMuoj0WNd+zPNGsx8
	c1E640pHv34+AgiiIEljH7L6Ogngkk01pA529Nr6UvcTbvGlEUmDFtHubDNKzWAEWN6riQvPJMl
	tXx1x01pyVyZogy/mk+4rIunM2x5eYa1HXs/s6pXPkffkXKNGx97bFq14zjLfbNKIJPiIlzaPMd
	X+syHZnWfrOaONYHy/IsBzV8IvDHdDhp/65sdPfr0Suzqiwie0a52VWrqizbtq5GE+z5By8Lefo
	j8/Xgmsm6q8q+gn4/MFaHXKHqDlmykhQrSnU6oLWWrxG
X-Google-Smtp-Source: AGHT+IE7wFn6ERJrBkfR1Q7/KnqdJjGKd1nUQ/1w3C9FdGeL3AF2csZF/cfRhKp8Z4EAaS7twttq5A==
X-Received: by 2002:a05:6402:90e:b0:5e6:1996:7902 with SMTP id 4fb4d7f45d1cf-5f0b6631b4bmr4006673a12.32.1743820220359;
        Fri, 04 Apr 2025 19:30:20 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087ed1f40sm3097531a12.26.2025.04.04.19.30.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Apr 2025 19:30:19 -0700 (PDT)
Date: Sat, 5 Apr 2025 02:30:18 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/2] mm/memblock: Add reserved memory release function
Message-ID: <20250405023018.g2ae52nrz2757b3n@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <173989132750.230693.15749600013776132201.stgit@devnote2>
 <173989133862.230693.14094993331347437600.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <173989133862.230693.14094993331347437600.stgit@devnote2>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Feb 19, 2025 at 12:08:58AM +0900, Masami Hiramatsu (Google) wrote:
>From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
>Add reserve_mem_release_by_name() to release a reserved memory region
>with a given name. This allows us to release reserved memory which is
>defined by kernel cmdline, after boot.
>
>Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Cc: linux-mm@kvack.org
>---
> Changes in v4:
>  - Use free_reserved_area() according to Mike's comment.
> Changes in v2:
>  - Rename reserved_mem_* to reserve_mem_*.
>---
> include/linux/mm.h |    1 +
> mm/memblock.c      |   66 +++++++++++++++++++++++++++++++++++++++++++---------
> 2 files changed, 55 insertions(+), 12 deletions(-)
>
>diff --git a/include/linux/mm.h b/include/linux/mm.h
>index 7b1068ddcbb7..1ee9e7447485 100644
>--- a/include/linux/mm.h
>+++ b/include/linux/mm.h
>@@ -4123,6 +4123,7 @@ void vma_pgtable_walk_begin(struct vm_area_struct *vma);
> void vma_pgtable_walk_end(struct vm_area_struct *vma);
> 
> int reserve_mem_find_by_name(const char *name, phys_addr_t *start, phys_addr_t *size);
>+int reserve_mem_release_by_name(const char *name);
> 
> #ifdef CONFIG_64BIT
> int do_mseal(unsigned long start, size_t len_in, unsigned long flags);
>diff --git a/mm/memblock.c b/mm/memblock.c
>index 95af35fd1389..8cd95f60015d 100644
>--- a/mm/memblock.c
>+++ b/mm/memblock.c
>@@ -16,6 +16,7 @@
> #include <linux/kmemleak.h>
> #include <linux/seq_file.h>
> #include <linux/memblock.h>
>+#include <linux/mutex.h>
> 
> #include <asm/sections.h>
> #include <linux/io.h>
>@@ -2283,6 +2284,7 @@ struct reserve_mem_table {
> };
> static struct reserve_mem_table reserved_mem_table[RESERVE_MEM_MAX_ENTRIES];
> static int reserved_mem_count;
>+static DEFINE_MUTEX(reserve_mem_lock);
> 

This looks break the memblock tests in tools/testing/memblock.

memblock.c:2289:8: warning: type defaults to ‘int’ in declaration of ‘DEFINE_MUTEX’ [-Wimplicit-int]
 2289 | static DEFINE_MUTEX(reserve_mem_lock);
      |        ^~~~~~~~~~~~
memblock.c:2289:1: warning: parameter names (without types) in function declaration
 2289 | static DEFINE_MUTEX(reserve_mem_lock);
      | ^~~~~~
memblock.c: In function ‘reserve_mem_find_by_name’:
memblock.c:2332:9: warning: implicit declaration of function ‘guard’ [-Wimplicit-function-declaration]
 2332 |         guard(mutex)(&reserve_mem_lock);
      |         ^~~~~

