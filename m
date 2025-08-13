Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2D31DDA09;
	Wed, 13 Aug 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755091319; cv=none; b=asrenGIILPOkWvZ7kJJVbtfK5h7GunDcGS9sE5FOAZqdnfvA2u15vtoq0CwdEZMWtL8SOi1w7XgRDjhzXSigGaFRO1cIJ3RuTJWQBzZB3b+00aw7GLla6iIf7z/nVTosjIkPkhCoyVHRJlObRUMRWkqGthWZNAMldcahZzfHOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755091319; c=relaxed/simple;
	bh=SJE6fsMy/q/x1sFepPBQD+jE3uBfNRoLWaulGq/HAxE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uxUOzHiHp9p0KASPoIDJrc35tIoo9xwEt97jws8zkjFKmy5qeAHWaE2AkswOPFSuHs/bFyVRZADiTRtrILm7fm2EGqe1xRDbvuBYHZzvpShlyHdwwi06CdTnub2mIKtAhaBDITGom5wLsGMRZdHauWRBj5cE9lDja3SbsEVKf+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nqW/hUf8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nqW/hUf8"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bd9d723bfso5629067b3a.1;
        Wed, 13 Aug 2025 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755091317; x=1755696117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DeW3YS6ZpEp6cb21mzmL/tJL4kz2qFZdu1xrCIw6JEE=;
        b=nqW/hUf8wOqX9LOcpFGZyXYs9z2oeB7eeYi2VwWdpepnXh09foCcnarNgTNpPdV5xU
         aJuw4kXsMOeFk4Hj5XZ3qmd6zZdHT/SJFrRKiVK6EaBnUA0717QEytW4WJ+NhiCW1Epi
         WLf58kyROSzi2JcP0APVMqAo5L3FN9IIEnwKFWFiJBQXxuRStXBxKXmXTzeGIaLvW/4H
         97JNYZsuzEuF8jeF22ykXTym6A0C8cAKtRDnBwyI88o7hz/vLqHar9RUcFYNovr3Y0DB
         jmqSojuLPT96RY/yr9SYsAKINtlp3+seNpLuNITb0/P1L++OVXOdIs0H3jggUwomPEYN
         1P/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755091317; x=1755696117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DeW3YS6ZpEp6cb21mzmL/tJL4kz2qFZdu1xrCIw6JEE=;
        b=T20vwZ1lsllvfBAGLZQ9dEfZ6N7kT2q8AyXW3w5N/3UUvmtMXiUM0NR9IB4sF3m1UC
         OpNdp+1oCwbxNwEj6ThajuWCVT9bboO91QXiZ9VrUZtDsWimm2Vw26pMpaczEsPxm/wC
         b91FOSFZAEgs970siBhfx3xU8zLs/zkGPAXbQY7jcmiWaiK1ZKmBP0eGBJVlxC///NSF
         6BBuLIIh9tta8jhjqcHAj6U0/LwNPsHwdj5KWN0WcbMdAgwn/EYnqYKkl+jU15r7JfMT
         L2U/yJurJGuPap2Bd/tzC+trB3RmYW+daIZZVqzwSOhh6QzTLXpSIBVUuqLB/Xj7veYE
         2i7A==
X-Forwarded-Encrypted: i=1; AJvYcCUiKpfsSbIMzmC2ye49u6rvGX8ZnshzW5oj2i0Gnmw4jPCYuDgelrZ91qTfdY9TJLVmF2TyA7AW5EfcZ1o=@vger.kernel.org, AJvYcCWwHaKXC97BGwatxrgZu6XN7LhiGZcVLAXNvpr+uzWMTeBUs921GeyVLUhA8ova/KJmJ7a+ISjf9BgOcdZLg877R8am@vger.kernel.org
X-Gm-Message-State: AOJu0YwnWBYLTpX16Oa6hcjIvLiSSJBFGBkG17UnXEcMXMpy21LFecVk
	NEgPNCPyIHBfHvdxRN1OAU2Co0fODOYGEgDPoKprxPtGo76nL5KAtnu9
X-Gm-Gg: ASbGnctAemEgX8lX596kV3Z/j6TxeVAeW21ELpz4+yJzloAKDbwZTfjTbAqMxb0T0Gm
	3Ay3zK+kOiqNzhW45W40QHRT1vt3FLOfbhV88gXbC+vF5uUEFQiRXNYB9/x9ONnPzSMuFiQDK5i
	6blhX8yinsmG7ufv+aX3oXIqJiIyRZEBMlwO+ZKZXDh9jQCS7yMMvMLUGVpz3MnPZ20YEuI+2TU
	kJLVKYGUui2VqxfbM2fbrWOpjIznjDFtZipwZMiEAHvJ6tOX1pZvxOX2ZIHI3Ym2ePxS3rL+RPD
	KxRhpLUQ/3CnNfRGrG+55k1inD1/UqoYe5OTGpgd4gK5s3pFLwi9EdSDVmvspC+uSpgeH4rSw7M
	tOK3AUvm1
X-Google-Smtp-Source: AGHT+IEO2C51W4ZA2n9RzuoiCubS/KwacyY8G27bYXr+yJ18kOOHtunnabAfnRZE8xyAQM+j5BjvUA==
X-Received: by 2002:aa7:8889:0:b0:769:9f87:1dfa with SMTP id d2e1a72fcca58-76e20fba1damr4367769b3a.23.1755091316718;
        Wed, 13 Aug 2025 06:21:56 -0700 (PDT)
Received: from gmail.com ([2406:5900:2:f21::2a1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfbd156sm32006909b3a.84.2025.08.13.06.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 06:21:56 -0700 (PDT)
Date: Wed, 13 Aug 2025 22:21:50 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyer@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] trace/trace_fprobe.c: TODO: handle filter, nofilter or
 symbol list
Message-ID: <aJyRblXjHcxz4EGF@gmail.com>
References: <20250812162101.5981-1-seokwoo.chung130@gmail.com>
 <20250812140357.65d19062@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812140357.65d19062@gandalf.local.home>

On Tue, Aug 12, 2025 at 02:03:57PM -0400, Steven Rostedt wrote:
> On Wed, 13 Aug 2025 01:21:01 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > Resolve TODO in `__register_trace_fprobe()`: 
> > parse `tf->symbol` robustly (support `sym!filter` and comma-separated lists), trim tokens, ignore empties, deduplicate symbols, use bulk registration for lists, return `-EEXIST` if already registered, and preserve lockdown/tracepoint deferral semantics.
> 
> Hi Ryan,
> 
> Please read the Submitting Patches document to have proper format.
> 
>  https://docs.kernel.org/process/submitting-patches.html
> 
> 
> For example, the change long should have a max column of 74 (with the
> exception of cut and paste commands or output)
> 

Thank you. I will make sure to follow the style guide.

> > 
> > Please note that this was my personal interpretation of what TODO
> > required here. Welcoming any feedback. 
> > 
> > Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> > ---
> >  kernel/trace/trace_fprobe.c | 102 +++++++++++++++++++++++++++++++++++-
> >  1 file changed, 100 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> > index b40fa59159ac..37d4260b9012 100644
> > --- a/kernel/trace/trace_fprobe.c
> > +++ b/kernel/trace/trace_fprobe.c
> > @@ -12,6 +12,8 @@
> >  #include <linux/security.h>
> >  #include <linux/tracepoint.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/string.h>
> > +#include <linux/slab.h>
> >  
> >  #include "trace_dynevent.h"
> >  #include "trace_probe.h"
> > @@ -762,8 +764,104 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
> >  		return __regsiter_tracepoint_fprobe(tf);
> >  	}
> >  
> > -	/* TODO: handle filter, nofilter or symbol list */
> > -	return register_fprobe(&tf->fp, tf->symbol, NULL);
> > +    /* Parse tf->symbol */
> > +    {
> 
> Code does not add random blocks.
> 

I will remove the block and integrate the code directly. 
Is this the recommended way in linux kernel development?

> > +        char *spec, *bang, *p;
> > +        int n = 0, w = 0, j, rc;
> 
> Indentation is always 8 byte tabs (not spaces).
> 

I will convert to 8 byte tabs as mentioned.

> > +        char **syms = NULL;
> > +
> > +        spec = kstrdup(tf->symbol, GFP_KERNEL);
> 
> Why did you declare spec as "char **" when you use it as "char *"?
> 

This is my mistake. 
I will correct the declaration. 

> > +        if (!spec)
> > +            return -ENOMEM;
> > +
> > +        /* If a '!' exists, treat it as single symbol + filter */
> > +        bang = strchr(spec, '!');
> > +        if (bang) {
> > +            char *sym, *flt;
> > +
> > +            *bang = '\0';
> > +            sym = strim(spec);
> > +            flt = strim(bang + 1);
> > +
> > +            if (!*sym || !*flt) {
> > +                kfree(spec);
> > +                return -EINVAL; /* reject empty symbol/filter */
> > +            }
> > +
> > +            rc = register_fprobe(&tf->fp, sym, flt);
> > +            kfree(spec);
> > +            return rc;
> > +        }
> > +
> > +        /* Comma list (or single symbol without '!') */
> > +        /* First pass: count non-empty tokens */
> 
> Strange comments. Did you use AI to help you write this?
> 

Yes I did use AI but not in a blatant way of copy-and-paste.
I am relatively new to the codebase and kernel development and therefore used
AI to help me get up to speed. 
Please let me know if you don't recommend using AI.

> -- Steve
> 
> > +        p = spec;
> > +        while (p) {
> > +            char *tok = strsep(&p, ",");
> > +            if (tok && *strim(tok))
> > +                n++;
> > +        }
> > +
> > +        if (n == 0){
> > +            kfree(spec);
> > +            return -EINVAL;
> > +        }
> > +
> > +        /* Allocate array for pointers into spec (callee copies/consumes) */
> > +        syms = kcalloc(n, sizeof(*syms), GFP_KERNEL);
> > +        if (!syms) {
> > +            kfree(spec);
> > +            return -ENOMEM;
> > +        }
> > +
> > +        /* Second pass: fill, skipping empties */
> > +        p = spec;
> > +        while (p) {
> > +            char *tok = strsep(&p, ",");
> > +            char *s;
> > +
> > +            if (!tok)
> > +                break;
> > +            s = strim(tok);
> > +            if (!*s)
> > +                continue;
> > +            syms[w++] = s; 
> > +        }
> > +        
> > +        /* Dedup in-place */
> > +        for (i = 0; i < w; i++){
> > +            if (!syms[i])
> > +                continue;
> > +            for (j = i + 1; j < w; j++) {
> > +                if (syms[j] && !strcmp(syms[i], syms[j]))
> > +                    syms[j] = NULL;
> > +            }
> > +        }
> > +
> > +        /* Compact */
> > +        for (i = 0, j = 0; i < w; i++) {
> > +            if (syms[i])
> > +                syms[j++] = syms[i];
> > +        }
> > +        w = j;
> > +
> > +        /* After dedup, ensure we still have at least one symbol */
> > +        if (w == 0){
> > +            kfree(syms);
> > +            kfree(spec);
> > +            return -EINVAL;
> > +        }
> > +
> > +        /* Register list or single symbol, using the existing bulk API */
> > +        if (w == 1)
> > +            rc = register_fprobe(&tf->fp, syms[0], NULL);
> > +        else
> > +            rc = register_fprobe_syms(&tf->fp, (const char **)syms, w);
> > +
> > +        kfree(syms);
> > +        kfree(spec);
> > +        return rc;
> > +    }
> >  }
> >  
> >  /* Internal unregister function - just handle fprobe and flags */
> 

I will send v2 shortly with the above comments in mind.

Best regards,
Ryan Chung
