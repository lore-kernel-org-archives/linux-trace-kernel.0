Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F97262A
	for <linux-trace-kernel@vger.kernel.org>; Sun, 10 May 2026 00:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778373400; cv=none; b=ehhf7qkC1sbsDQZ91oSqRbDQ0Efq8ZnnvqwfjB1ZkZ6j88YN0QRfORbjJjnzfzJblmi60hS/oqvu30qbplqgVndMjv7lVlb2zq/F0SERydeg81RkQBt+c8JzYDHtQ/QYhyiAUJTwkIO5dUQxkQLszblRkZTwIPptpi4pdR+UVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778373400; c=relaxed/simple;
	bh=0BVBRLJbMNFhmCGqiKQRRaieIuDVMx/tDLCqrbWpeks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9K+lfYRTFkDvGfpvOK1RcHOWTDXo0G3zdUxBfWu+wL09n0BsB7XQSXuPUXIbA5/5fWobXiJQW8zNKtwN2QEAEw0yqhOoA7HMrYfJCtmEkzFUrbA9XR33C5yiLZMkpYBt9oWLJhy2t2lNQFPaODvzj7izRexk75RiIGlT/e4fFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAGWdobM; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAGWdobM"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c80203b9d7bso1219149a12.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 09 May 2026 17:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778373399; x=1778978199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sMk/T8m2B72SvHR75gb7Fq5LKN2MIDxQg2HJVr5A6AY=;
        b=AAGWdobMF8DlmL9GcpMS8ARKKaMqVb2xCQyly8nbjBVt+hZQMxhFYPC46Ctbx6YeSD
         1CE7g1MvPPzS2G+s8Av+5BXzdw7095z6YK5yXLS/ZnxgbJpsGu3i5bEIm6gXYNKTQ2Gn
         yOGzlG7DQ88v0PkTWGkOM3A/A8TkIOtHUDE9T+lEnLGl6OcgE8p3ktFscZ4dKbxGl7tF
         EL3cEkEen/2b+gG43grzT70APaWkq6llFYwUctt+Jeq3b31lwdjfM4SwxxisGSmMhP+2
         s36se9vY6WPQOOd/G8TklIDRLSOaZIhOSrKCXWjMBv2X7q/7UYth60S/9k1Xo0lppX00
         SUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778373399; x=1778978199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMk/T8m2B72SvHR75gb7Fq5LKN2MIDxQg2HJVr5A6AY=;
        b=ZRzqggaOLF1LSXitienPyX3G58iq1frkNNeuCn0ZmYZ6b/r/qUrpySNUdfubduTfgv
         bi33pMoCI21x/qfKiFNDxfHfpCW2UOx5bgTKSGr5OtbMefYNqN0SMpNt6yKyowyZI8m3
         1kB2o2+o9SQsyx6kK7XCJOFyHftZzQis8H8R0pSeGEL8MXjQTx7vgK5PxdbhYsEYHA8A
         SCrUGb4ymfv+LDKxzuMIhyG/P64T3t/c7WfdEJpJGIhSrNJI5OnC/kUltCi6xxG8gJNM
         YEAUM/lEnIMIB0lT9of35N0TwYfu6f1zsQV8GOWzSKYTr84tlyF4QA/UzRJl+Hg1ydER
         FUgA==
X-Forwarded-Encrypted: i=1; AFNElJ8NVDUjr/a9uaSBpJVSnTr0lmFGzJfTandiFnTgHBIqs3XwoaD0InB+TF/iidKYrkq4Elnr28wN/jkpAJCDI7M+AUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1KjOQv65hz+qkfsk+lt4ci/L87E8g/3Fvi08FnpzUO7lj3+Y7
	2YO1PljgWzEMCqpSj9ZQZnRigVKAxDYsjRi+ma2/bn/eIFxiG8u9Q4qD
X-Gm-Gg: Acq92OFavKIs+ljJoYE9WrVb2xHFevKzcWQMFO5ijvBwUOLJWsfc8vIv9WN/th5OBJb
	ske7HrsOZYREpW4i5+aSbmPTknliMX/MUmSKOJphnHdJ4CHDHXt025znQHc3RoknjAb7QNBJ50Y
	daOgkkI280fLa78FloUnqE8Uao0mO2ul9AlyfmVisjotqnBQkYPbSJs0msUXabVXIWDG4YpoTJF
	HYZJBtMV1VC8uIEnwNHnd2QLxjYBsgRKNQsfvz403fp5Vev+nGxAHgYJ7KdMekvA5Z2mpfNxW90
	yV+DmRL8e0Zj0DZQLffy/8466ksGJAPG/mk8LJy8Tbm4biWDigveEf3LboQgXqRA9CXHtr3cqVm
	qoxMH0Ze/RUOjAmRrpFIy+2adnd9YPABK58ixzjT81dMeZnQmSIUF6U66LXlc1SyED8DWu3qyru
	6Kk9DibCPjStLn7CLZpNZOnhivxcmXPpzdviMnje7728dHAls=
X-Received: by 2002:a05:6a21:3390:b0:39f:94cb:1bc with SMTP id adf61e73a8af0-3aa5a901f0amr20946611637.1.1778373398887;
        Sat, 09 May 2026 17:36:38 -0700 (PDT)
Received: from localhost ([154.39.63.254])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767bf53sm5290343a12.6.2026.05.09.17.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 17:36:38 -0700 (PDT)
Date: Sun, 10 May 2026 08:36:34 +0800
From: chenqiwu <qiwuchen55@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, hannes@cmpxchg.org,
	david@kernel.org, mhocko@kernel.org, willy@infradead.org,
	linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
	"qiwu.chen" <qiwu.chen@transsion.com>
Subject: Re: [PATCH v2] mm: vmscan: rework lru_shrink and write_folio
 tracepoints
Message-ID: <20260510003634.GB5833@rlk>
References: <20260506083652.100160-1-qiwu.chen@transsion.com>
 <20260508182932.ee1931dec680db80a8a8e660@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508182932.ee1931dec680db80a8a8e660@linux-foundation.org>

On Fri, May 08, 2026 at 06:29:32PM -0700, Andrew Morton wrote:
> 
> Applying this to 7.1-rc1, my x86_64 allmodconfig blew up.
> 
> 
> 
> In file included from ./include/trace/define_trace.h:132,
>                  from ./include/trace/events/vmscan.h:602,
>                  from mm/vmscan.c:72:
> ./include/trace/events/vmscan.h: In function 'trace_raw_output_mm_vmscan_write_folio':
> ./include/trace/events/vmscan.h:358:19: error: format '%p' expects argument of type 'void *', but argument 3 has type 'long unsigned int' [-Werror=format=]
>   358 |         TP_printk("folio=%p lru=%s",
>       |                   ^~~~~~~~~~~~~~~~~
> ./include/trace/trace_events.h:219:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
>   219 |         trace_event_printf(iter, print);                                \
>       |                                  ^~~~~
> ./include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
>    45 |                              PARAMS(print));                   \
>       |                              ^~~~~~
> ./include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
>   342 | TRACE_EVENT(mm_vmscan_write_folio,
>       | ^~~~~~~~~~~
> ./include/trace/events/vmscan.h:358:9: note: in expansion of macro 'TP_printk'
>   358 |         TP_printk("folio=%p lru=%s",
>       |         ^~~~~~~~~
> In file included from ./include/trace/trace_events.h:256:
> ./include/trace/events/vmscan.h:358:27: note: format string is defined here
>   358 |         TP_printk("folio=%p lru=%s",
>       |                          ~^
>       |                           |
>       |                           void *
>       |                          %ld
> ./include/trace/events/vmscan.h: In function 'do_trace_event_raw_event_mm_vmscan_write_folio':
> ./include/trace/events/vmscan.h:354:32: error: assignment to 'long unsigned int' from 'struct folio *' makes integer from pointer without a cast [-Wint-conversion]
>   354 |                 __entry->folio = folio;
>       |                                ^
> ./include/trace/trace_events.h:427:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
>   427 |         { assign; }                                                     \
>       |           ^~~~~~
> ./include/trace/trace_events.h:435:23: note: in expansion of macro 'PARAMS'
>   435 |                       PARAMS(assign), PARAMS(print))                    \
>       |                       ^~~~~~
> ./include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
>    40 |         DECLARE_EVENT_CLASS(name,                              \
>       |         ^~~~~~~~~~~~~~~~~~~
> ./include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
>    44 |                              PARAMS(assign),                   \
>       |                              ^~~~~~
> ./include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
>   342 | TRACE_EVENT(mm_vmscan_write_folio,
>       | ^~~~~~~~~~~
> ./include/trace/events/vmscan.h:353:9: note: in expansion of macro 'TP_fast_assign'
>   353 |         TP_fast_assign(
>       |         ^~~~~~~~~~~~~~
> In file included from ./include/trace/define_trace.h:133:
> ./include/trace/events/vmscan.h: In function 'do_perf_trace_mm_vmscan_write_folio':
> ./include/trace/events/vmscan.h:354:32: error: assignment to 'long unsigned int' from 'struct folio *' makes integer from pointer without a cast [-Wint-conversion]
>   354 |                 __entry->folio = folio;
>       |                                ^
> ./include/trace/perf.h:51:11: note: in definition of macro '__DECLARE_EVENT_CLASS'
>    51 |         { assign; }                                                     \
>       |           ^~~~~~
> ./include/trace/perf.h:67:23: note: in expansion of macro 'PARAMS'
>    67 |                       PARAMS(assign), PARAMS(print))                    \
>       |                       ^~~~~~
> ./include/trace/trace_events.h:40:9: note: in expansion of macro 'DECLARE_EVENT_CLASS'
>    40 |         DECLARE_EVENT_CLASS(name,                              \
>       |         ^~~~~~~~~~~~~~~~~~~
> ./include/trace/trace_events.h:44:30: note: in expansion of macro 'PARAMS'
>    44 |                              PARAMS(assign),                   \
>       |                              ^~~~~~
> ./include/trace/events/vmscan.h:342:1: note: in expansion of macro 'TRACE_EVENT'
>   342 | TRACE_EVENT(mm_vmscan_write_folio,
>       | ^~~~~~~~~~~
> ./include/trace/events/vmscan.h:353:9: note: in expansion of macro 'TP_fast_assign'
>   353 |         TP_fast_assign(
>       |         ^~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> make[3]: *** [scripts/Makefile.build:289: mm/vmscan.o] Error 1
> make[2]: *** [scripts/Makefile.build:548: mm] Error 2
> make[1]: *** [/usr/src/25/Makefile:2141: .] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>
Sorry, I ignored the rookie mistake which I built pass with the aarch64-linux-gnu toolchain.
Could you please apply the following minor fix change based on this patch?
--- a/include/trace/events/vmscan.h
+++ b/include/trace/events/vmscan.h
@@ -346,7 +346,7 @@ TRACE_EVENT(mm_vmscan_write_folio,
        TP_ARGS(folio),

        TP_STRUCT__entry(
-               __field(unsigned long, folio)
+               __field(struct folio *, folio)
                __field(int, lru)
        ),

