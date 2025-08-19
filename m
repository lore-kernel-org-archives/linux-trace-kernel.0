Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D82571D4;
	Tue, 19 Aug 2025 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621446; cv=none; b=G6MJJy6APLpKx+gDNdQlv5EpjgHvjJxq9f7/Cf/V4X7acgzj+pQleTbSxZKXxUbx5c+aM8HQapA6rFTvaWBKs9FpKeFgnaCvtxUHl0U8tHZ3ZvoVokERcRuOxqFAmBZteAHjTM+l+1TTy9BwWFiB5PKNulNCS5UWpV6P/cxtoqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621446; c=relaxed/simple;
	bh=scbaPHNUfafnIekgS1W/IcAwZjeclgXRiBG9pKjzDeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pnDSWZKWhcUM8RdV7P1JYQbdf85cIG//w/0xLhzvsXViOt3fG6KEmyXguEpC+S3lxN7T5+Q5Ox4gBtkvDFzJ7E8+hOFHTFhZePJoW1GrStZUOSQNOves4Z2SUYX0YG9i9cT16Oolox1e7ldDJwfHzE9m5ap8P1SVKFigO1wo7jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TcTg8QKU; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TcTg8QKU"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b472fd93ad1so2705992a12.0;
        Tue, 19 Aug 2025 09:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755621444; x=1756226244; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pN3oR61/c0uiXLRfyBJRzpXCbawo5PgtjuwTdlJFdps=;
        b=TcTg8QKUYDfNfgOU3AzLK+ESSm5T5l4xp/2rCM22knueb9UxX4yc2qskqfIr9q8NlG
         2ie3cNncD9BloeOjZJYDdyP5ymDNbzyVALwBL47oIXae0wwwlAoCxo5aUvgvp4e8CMnU
         A+rrsFndKjCqp4ja14mLZ71uXb1vQFwz8M6kapEU+eS9awLd0it0rlzs7FxPKJAor20k
         SGa+gKt1goaRJVRSCeaXKxG7NDONWh49JYfganmeaIBTg51XtlYgJuur5jye1AiNw5gg
         y57nUPbl9pebFSwa02eW+CQbvVeh54LfoXXny+cZqMDr50jRvcfGZQqnG9Y+xwfJKeMZ
         LzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755621444; x=1756226244;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pN3oR61/c0uiXLRfyBJRzpXCbawo5PgtjuwTdlJFdps=;
        b=WzGJTIJysr0cHrQQLd1xRE6wS0cpbA8IlYeXAp7oKA9QbKIa1rDkgX687Gh2tNBMlu
         pRLuNFef424ybRrFNBUSpHU4QX2T6G+A5Nb6huxv3vVxJjh7KgDXt0Hh7tHBu3kVHv+a
         hJj8p2L9b9nK7KKN/ST5JHCODs5HDDe1HxWTZOzQdcUqqTkRT4BMg51XrPGhpTNhfppm
         K69MlERNtXh0hf8z5YU+kmrId4kEvfgQ5Vu0AdaREV84QgmOtqeRDXWzl9WuOJzmz89O
         XFwg3Ni9TvDh463W2eVqpboCwoePKFa1+ZmIpZu8FCHsy3cKTl8Uqj9ffm5sM4omuH1Z
         sD3g==
X-Forwarded-Encrypted: i=1; AJvYcCVFOrU7GD0zNEUC61KD9H6sij0mqMIEBIUlpcYmEcowCztjlS3rUVkjQBQi5vrsyxb9Ll7M0Qt+qH94vvk=@vger.kernel.org, AJvYcCWdoqNnnPEC9/Qgc7GLLtc/iYJKo9h0egUhmN9nrQiWVGR3/Pe7KNNc4kH5fW5du1oNamP0cDfDoVUYXamrzMZ1hHUQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxbkdM8tOC7bcwLzmTaQXvJgCarFirsZWnqvY6I5byEx3DL72rw
	dzjq+auLZqr+tgLxUwhsuV8Pr8+ToZVUYa8C9I6cpsMkLabSbv+N04Gp
X-Gm-Gg: ASbGncvI1ePcAKIFYUxUJfn5rKApGyP2fygk+BaZElH1gFLivyn9xHRqYNeKSa3U77G
	fBFRhEjLnACCLnRy8CAhhkrb6A4/EU719LRdIkTTl1JajyraKyf94os6L8/J0zIPA4E3Z/2cB3l
	I/doNCOshtQF6KLHV6EXG9H1V7jWi5BqUP1y2QoQGzSWf/z37fx6na+RlOwwoN3pV9ZLw0n23BL
	xcwzDIGhGFHz5ZjSw/ItAx1wEFxO1CSyaNx742QJGEpWglQoTlfgBCTiAjn/S34iTTDXVbx6uiH
	wn5T+khx0rPHiF+z7HVr88OE33uFY82HZQ9kzFUuZbcNnpX20g4AEI7kPpsdAHmQY7llW+VPNfE
	kGpfZxtg8
X-Google-Smtp-Source: AGHT+IElLHXy5Z0g7yBhgA4isDUqzATIIqXde4d2BmuwggJSAMpaov5koyT/PbDQ1G2u3jDfv9QvHg==
X-Received: by 2002:a17:902:d48f:b0:242:a0b0:3c1f with SMTP id d9443c01a7336-245e02cfc12mr45322725ad.7.1755621444380;
        Tue, 19 Aug 2025 09:37:24 -0700 (PDT)
Received: from gmail.com ([2406:5900:2:f21::2a1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed51c0aasm1428815ad.144.2025.08.19.09.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 09:37:23 -0700 (PDT)
Date: Wed, 20 Aug 2025 01:37:18 +0900
From: Ryan Chung <seokwoo.chung130@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyer@efficios.com,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] trace/trace_fprobe.c: TODO: handle filter, nofilter or
 symbol list
Message-ID: <aKSoPiEeixEtcxys@gmail.com>
References: <20250812162101.5981-1-seokwoo.chung130@gmail.com>
 <20250814121504.2784e740a4e6fd4e0dd563d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814121504.2784e740a4e6fd4e0dd563d6@kernel.org>

On Thu, Aug 14, 2025 at 12:15:04PM +0900, Masami Hiramatsu wrote:
> Hi Ryan,
> 
> On Wed, 13 Aug 2025 01:21:01 +0900
> Ryan Chung <seokwoo.chung130@gmail.com> wrote:
> 
> > Resolve TODO in `__register_trace_fprobe()`: 
> > parse `tf->symbol` robustly (support `sym!filter` and comma-separated lists), trim tokens, ignore empties, deduplicate symbols, use bulk registration for lists, return `-EEXIST` if already registered, and preserve lockdown/tracepoint deferral semantics.
> 
> Thanks for the improvement!
> And could you add the new syntax in the document too ?
> 

Yes. I will add the syntax in the document.
To clarify, by document, you mean
Documentation/trace/fprobetrace.rst?

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
> 
> Headers should be sorted alphabetically.
> 

I will fix this in v2.

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
> 
> Please make this parse and check as a sub-function instead of new
> scope. Also, it should be done in parse_symbol_and_return(), so that
> we can handle wrong syntax when parsing it.
> 

I will move the parsing into parse_symbol_and_return()
so syntax errors are detected at parse time.

> > +    {
> > +        char *spec, *bang, *p;
> > +        int n = 0, w = 0, j, rc;
> > +        char **syms = NULL;
> > +
> > +        spec = kstrdup(tf->symbol, GFP_KERNEL);
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
> 
> You don't need to do strim, since if there is a space, it
> should be parsed already. New syntax must be ',' separated.
> My basic syntax for this probe event is;
> 
> WORD WORD WORD[:OPTWORD] SUBWORD[,SUBWORD]
> 
> OPTWORD is qualifying the previous WORD, SUBWORDs are not
> quarifying, but the same-level words. (Currently using "%return"
> for the return of the function, that is a special case.)
> 

Understood. I will drop strim() and treat tokens as you mentioned.
I will leave return behavior unchanged.

> > +
> > +            if (!*sym || !*flt) {
> > +                kfree(spec);
> 
> Please use __free(kfree) instead of repeating kfree().
> 

I will also include this in v2.

> > +                return -EINVAL; /* reject empty symbol/filter */
> 
> Also, before returning an error, use trace_probe_log_err() to
> notice the reason and the place of the error to user.
> 

I will log parse failiures with trace_probe_log_err().

> > +            }
> > +
> > +            rc = register_fprobe(&tf->fp, sym, flt);
> > +            kfree(spec);
> > +            return rc;
> > +        }
> > +
> > +        /* Comma list (or single symbol without '!') */
> > +        /* First pass: count non-empty tokens */
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
> 
> Again, symbol should not have a space.
> 

Understood. I will also fix this in v2.

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
> 
> I think dedup will be done in ftrace, so we don't need to do this
> costly operation.
> 

I see. I will remove the dedup here.

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
> 
> Hmm, you might misunderstand this. What you need to do is to classify
> the list of symbols with '!' as nofilter, and others as "filter",
> and pass those as "register_fprobe(&tf->fp, filter, nofilter)".
> 

Thank you for the clarification.
I will change as followed:
- tokens prefixed with '!' go to the nofileter list
- all other tokens go to filter list
- pass both to register_fprobe(&tf->fp, filter, nofilter)

> Thank you,
> 
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
> > -- 
> > 2.43.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you. Please let me know if you have any questions or concerns.

Best regards,
Ryan Chung
