Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C7C2F3C3E
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 May 2026 14:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777646423; cv=none; b=bb2gJ1dEvZV+5WA4RlnkVOLN8IoWVWWe8Tpd8MVoor4Kwj2ntZRNFHxzRFN9T3XE4QhIOP3g2WwqXw0sS4fXpBHTg6u1IWbYJyciBd3OQC8UJYB6BbrIUHX4f4j1LpqnAb5ckB5w5VCW9MGXRr0GhCWpCduYa8YVHvRrNtnSkHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777646423; c=relaxed/simple;
	bh=hI3sELbh9pZAk1UJ91eIaTfaNqaL0ffPPb6un02NOxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYW3AKXEFu4ty82Ieu1FVouAzTklTpV0HeA1NqHM/NnPlt+z/Lx2LIHAXuAPhbHO68nGGh8qPCvWwBLgLfqJb221+cVAyD0uK6rceUtQ7Mv7cPpgMLu5stl3aWwrM02/D75MRrMdbincIu0qD5wI6hFE4x2MC39nRpDTV7WFF+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pjZlU87J; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjZlU87J"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f1bfc9b8fso917557b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 01 May 2026 07:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777646421; x=1778251221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e+szxW8rgNgMBzsETrdf0sjEoyYi25PAwC2V8Vep6Dk=;
        b=pjZlU87JwHu08n9Y2RvzIo235F7C/95P+B4YJOu6V6gkOLmhHzyI6kPEfkvvMH7EYw
         2/DtLzAgmbbhlEy0OGsom/dYGFnWMZr6ImyFq/qWSRLOjoe7vjL56x3yhwKxqW4PXiZs
         wLdE7lN11mF6He4RIqCjSMSo2NbvzYJcXQ36pGCT9i5cw0eYK3G6MDKhlI5vJMz1YlaW
         4X5h/1LrF5E+Sbqsv5exqtViafQSWpwdqzVQt+DjgFo6WmkuNth7kf4zVNoZERMGnsQJ
         3xaGzLdaUYfFX3Ty1G6CVICGYU79beKvIEsnpsDOS1uXShFUbQhy9nf3Z5EeJxN2Gtoc
         BofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777646421; x=1778251221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+szxW8rgNgMBzsETrdf0sjEoyYi25PAwC2V8Vep6Dk=;
        b=bY8SNZW6BPtsvhKzWUT6ZbhuA8ypLqPoE24eEyFvIsQvj6i/78vijPLKEIWyxIHy/S
         9NZM5rBWeMM3pE9L4kdnhl07AesEeH7+aeWuco5RjCspkeKYh9PoLxuh1e8yxuw2hAa3
         buWc1K9RYCC0Cel3aQTxNSEpdtm1jwTLWxkl0jvxPoO51Winm4PisFbIsZejv7zPu5Jd
         kMfKTN79U61zQWDkP3SBGDH/Q+LUeIDMk8+DtfVt0qhkbAFayMP0DM9/b0hYCCxmTwCc
         2mbaoMx3VyVBptN8n7Qq/RW54wkuSnjs3bo64ff13rR8ohgcos2H9tBtzuiS0h0E5Jv1
         cmmA==
X-Forwarded-Encrypted: i=1; AFNElJ9EoXp6MyywbdeTQwdjZ2E0hBrYRZoTYhHLTUXIRjl3UXNw/WcrjIut0MAW+mLxQoOOoDAenc/1IhtzypHHCdU52Do=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJBRQAqH7Spj1uv8kQTdTtza6ZQTVeNbztxNGapN8Y0d9jftcs
	NiGYASF9hbhk3xMtUsbdYMJ4hbs8A4Ub0J8r1t9768Fr1JUPlqfK74luNDPNdDPS
X-Gm-Gg: AeBDievbpcRBtRqkSxLXck55j9gu9jN/4IVFDw2AuunIVJlvn3tschJhv7dXN6Xq7Km
	NlZgf/v2fBKR1PMsOwzRYhT4jk6MBejmp31FJ+/KOLR2kw2gpsQEBW0pW19wgtvNBG+KhhThB2a
	Z7Zt9dTagF3/Q9ftmUtLONXRsqjPyC6jRQt6ung2bVYqBBYf2iFnWADhST43Uuu1pMn9O6kUHzw
	PUkKzxNnNZGOHSnh+yg9J8Y7PSU+tGilxGJ6t4Qq0GGfCZ3O3zTPNpGM+Xo8pMNYPOA7rsFW9db
	QF4frpSbjgBXcwkzeuxmw4C5b3CAGqHFgZnOK1YixeQlyh8NXAjVtXfOD5O5khL7fnRMe6UiYC+
	Vr5vde7gHKn1atOW/Fi5aDxLAt41BawC3uNZm81GE41JGxDolD5U55jePigl+Zek0FvuxL5kw+I
	3x/KKBAKFyt199jNzhtyBpJq+4q14JkA==
X-Received: by 2002:a05:6a00:aa04:b0:81e:ef16:b288 with SMTP id d2e1a72fcca58-834fdb5c13dmr8147514b3a.22.1777646421184;
        Fri, 01 May 2026 07:40:21 -0700 (PDT)
Received: from nova ([134.208.63.146])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515b5b921sm3492599b3a.54.2026.05.01.07.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 07:40:20 -0700 (PDT)
Date: Fri, 1 May 2026 22:40:17 +0800
From: Qian-Yu Lin <tiffany019230@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, david.laight.linux@gmail.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Message-ID: <afS7UUAfzgiSzEHv@nova>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
 <20260429134226.49e95e9d@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429134226.49e95e9d@robin>

On Wed, Apr 29, 2026 at 01:42:26PM -0400, Steven Rostedt wrote:
> On Thu, 30 Apr 2026 00:57:07 +0800
> Qian-Yu Lin <tiffany019230@gmail.com> wrote:
> 
> > The macro trace_printk() uses a hardcoded identifier _______STR
> > within a statement expression, which can lead to variable name
> > shadowing if a caller happens to use the same name in its scope.
> 
> Has this ever been a problem?
> 

No, this has not been a practical problem. However, the long-underscore
name ___STR is an indication of a potential shadowing risk.

> > 
> > Following the pattern in commit 24ba53017e18 ("rcu: Replace ________p1
> > and _________p1 with __UNIQUE_ID(rcu)") and commit 589a9785ee3a
> >  ("min/max: remove sparse warnings when they're nested"), replace the
> >  hardcoded identifier with __UNIQUE_ID(STR).
> > 
> > Since __UNIQUE_ID() must be expanded once to remain consistent across
> > declaration and sizeof() within the statement expression, introduce a
> > nested helper macro ___trace_printk.
> 
> Hmm, so we are replacing one name with underscores with another name
> with underscores?
> 
> > 
> > Signed-off-by: Qian-Yu Lin <tiffany019230@gmail.com>
> > ---
> >  include/linux/trace_printk.h | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> > index 2670ec7f4262..060eccb40838 100644
> > --- a/include/linux/trace_printk.h
> > +++ b/include/linux/trace_printk.h
> > @@ -2,6 +2,7 @@
> >  #ifndef _LINUX_TRACE_PRINTK_H
> >  #define _LINUX_TRACE_PRINTK_H
> >  
> > +#include <linux/compiler.h>
> 
> People are already saying that trace_printk.h slows down the compile.
> Does this add any overhead to the compile?
> 
> -- Steve

Yes. I measured compile time of kernel/trace/ring_buffer_benchmark.o
after make clean on an x86_64 machine running Ubuntu 24.04 LTS:

  - Original _______STR:                 49.8s
  - v1 with __UNIQUE_ID (compiler.h):    53.5s
  - compound literal (no extra include): 33.2s

I propose using a compound literal in v2, which eliminates the local
variable entirely and requires no extra include:

#define trace_printk(fmt, ...)                          \
do {                                                    \
    if (sizeof((char[])                             \
        {__stringify((__VA_ARGS__))}) > 3)      \
        do_trace_printk(fmt, ##__VA_ARGS__);    \
    else                                            \
        trace_puts(fmt);                        \
} while (0)

This fully eliminates the shadowing risk without any compile overhead.

Qian-Yu

> 
> 
> >  #include <linux/compiler_attributes.h>
> >  #include <linux/instruction_pointer.h>
> >  #include <linux/stddef.h>
> > @@ -84,15 +85,18 @@ do {									\
> >   * let gcc optimize the rest.
> >   */
> >  
> > -#define trace_printk(fmt, ...)				\
> > +#define ___trace_printk(fmt, str, ...)				\
> >  do {							\
> > -	char _______STR[] = __stringify((__VA_ARGS__));	\
> > -	if (sizeof(_______STR) > 3)			\
> > +	char str[] = __stringify((__VA_ARGS__));	\
> > +	if (sizeof(str) > 3)			\
> >  		do_trace_printk(fmt, ##__VA_ARGS__);	\
> >  	else						\
> >  		trace_puts(fmt);			\
> >  } while (0)
> >  
> > +#define trace_printk(fmt, ...) \
> > +	___trace_printk(fmt, __UNIQUE_ID(str), ##__VA_ARGS__)
> > +
> >  #define do_trace_printk(fmt, args...)					\
> >  do {									\
> >  	static const char *trace_printk_fmt __used			\
> 
