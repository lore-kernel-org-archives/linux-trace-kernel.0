Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E04248F51;
	Thu, 14 Aug 2025 03:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755141309; cv=none; b=gEopOUYm8COmxdCVEXCIEawt2FzTTD5IZdlxDcdwhagQxOnSnXiF/uCt63e6qI1yGDQhCngZJqZxYvSgBdKfRz7mG6vL/NnG6LApRGInApjRb8sxO5O0qAw0v9jkYA4pAAOG0+J1Xhg9wS9uDRGRnad6o0AUBMwkBhVhbKAY4dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755141309; c=relaxed/simple;
	bh=/EfTcHR4ehUN2Hq9zYIvlMl54+9haGT06nRpAh+gwOo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qjt8dDWAVRH9xsjJHCYvWTyh9STluVstpu5Bcj7eU0/x2NhMQPDTdewulorKbWT2tX7BBAXVHHxVcMus6/QH7e2yrdBwShdhmwXWBAVuxaHlUB8GDHCojBApRRj+T68bG3shVmDslZTdF3wtm6bQ30zAwWYqNUdUvPmbToiWacE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hh8w2C3i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hh8w2C3i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB2AC4CEEF;
	Thu, 14 Aug 2025 03:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755141308;
	bh=/EfTcHR4ehUN2Hq9zYIvlMl54+9haGT06nRpAh+gwOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hh8w2C3iROrgp7OV6ideDpPm1NZZB3h+lajUYpzNEIKbc3HqooHpQdR48fRUWZmDz
	 DahhpECxl8mJ01ep+OzeQKxcq68J5uS36UvvzFtVnrifpCz1NDx2NCOcXgY3tv5YRp
	 0KMAH8ul+kHAoePNwoZW7dKmr30lqLZA5jotg00NNFxD59F5nDTFU5uv0VkItu4SpJ
	 boNGZVOYAdta5iLZZmqjCzI2jFqD2XIoQe9O6jJJ+KXq1K+I4LuhAEFmAIxQ9KmrDe
	 acdNqR909gxUF2I1503lbsI9bEK2Rv8E/jltoDHp9BZN8hABS87xGxul9Dkpfq582Z
	 iu+XFetUV8J5A==
Date: Thu, 14 Aug 2025 12:15:04 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyer@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] trace/trace_fprobe.c: TODO: handle filter, nofilter or
 symbol list
Message-Id: <20250814121504.2784e740a4e6fd4e0dd563d6@kernel.org>
In-Reply-To: <20250812162101.5981-1-seokwoo.chung130@gmail.com>
References: <20250812162101.5981-1-seokwoo.chung130@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ryan,

On Wed, 13 Aug 2025 01:21:01 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

> Resolve TODO in `__register_trace_fprobe()`: 
> parse `tf->symbol` robustly (support `sym!filter` and comma-separated lists), trim tokens, ignore empties, deduplicate symbols, use bulk registration for lists, return `-EEXIST` if already registered, and preserve lockdown/tracepoint deferral semantics.

Thanks for the improvement!
And could you add the new syntax in the document too ?

> 
> Please note that this was my personal interpretation of what TODO
> required here. Welcoming any feedback. 
> 
> Signed-off-by: Ryan Chung <seokwoo.chung130@gmail.com>
> ---
>  kernel/trace/trace_fprobe.c | 102 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index b40fa59159ac..37d4260b9012 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -12,6 +12,8 @@
>  #include <linux/security.h>
>  #include <linux/tracepoint.h>
>  #include <linux/uaccess.h>
> +#include <linux/string.h>
> +#include <linux/slab.h>

Headers should be sorted alphabetically.

>  
>  #include "trace_dynevent.h"
>  #include "trace_probe.h"
> @@ -762,8 +764,104 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
>  		return __regsiter_tracepoint_fprobe(tf);
>  	}
>  
> -	/* TODO: handle filter, nofilter or symbol list */
> -	return register_fprobe(&tf->fp, tf->symbol, NULL);
> +    /* Parse tf->symbol */

Please make this parse and check as a sub-function instead of new
scope. Also, it should be done in parse_symbol_and_return(), so that
we can handle wrong syntax when parsing it.

> +    {
> +        char *spec, *bang, *p;
> +        int n = 0, w = 0, j, rc;
> +        char **syms = NULL;
> +
> +        spec = kstrdup(tf->symbol, GFP_KERNEL);
> +        if (!spec)
> +            return -ENOMEM;
> +
> +        /* If a '!' exists, treat it as single symbol + filter */
> +        bang = strchr(spec, '!');
> +        if (bang) {
> +            char *sym, *flt;
> +
> +            *bang = '\0';
> +            sym = strim(spec);
> +            flt = strim(bang + 1);

You don't need to do strim, since if there is a space, it
should be parsed already. New syntax must be ',' separated.
My basic syntax for this probe event is;

WORD WORD WORD[:OPTWORD] SUBWORD[,SUBWORD]

OPTWORD is qualifying the previous WORD, SUBWORDs are not
quarifying, but the same-level words. (Currently using "%return"
for the return of the function, that is a special case.)

> +
> +            if (!*sym || !*flt) {
> +                kfree(spec);

Please use __free(kfree) instead of repeating kfree().

> +                return -EINVAL; /* reject empty symbol/filter */

Also, before returning an error, use trace_probe_log_err() to
notice the reason and the place of the error to user.

> +            }
> +
> +            rc = register_fprobe(&tf->fp, sym, flt);
> +            kfree(spec);
> +            return rc;
> +        }
> +
> +        /* Comma list (or single symbol without '!') */
> +        /* First pass: count non-empty tokens */
> +        p = spec;
> +        while (p) {
> +            char *tok = strsep(&p, ",");
> +            if (tok && *strim(tok))
> +                n++;
> +        }
> +
> +        if (n == 0){
> +            kfree(spec);
> +            return -EINVAL;
> +        }
> +
> +        /* Allocate array for pointers into spec (callee copies/consumes) */
> +        syms = kcalloc(n, sizeof(*syms), GFP_KERNEL);
> +        if (!syms) {
> +            kfree(spec);
> +            return -ENOMEM;
> +        }
> +
> +        /* Second pass: fill, skipping empties */

Again, symbol should not have a space.

> +        p = spec;
> +        while (p) {
> +            char *tok = strsep(&p, ",");
> +            char *s;
> +
> +            if (!tok)
> +                break;
> +            s = strim(tok);
> +            if (!*s)
> +                continue;
> +            syms[w++] = s; 
> +        }
> +        
> +        /* Dedup in-place */
> +        for (i = 0; i < w; i++){
> +            if (!syms[i])
> +                continue;
> +            for (j = i + 1; j < w; j++) {
> +                if (syms[j] && !strcmp(syms[i], syms[j]))
> +                    syms[j] = NULL;
> +            }

I think dedup will be done in ftrace, so we don't need to do this
costly operation.

> +        }
> +
> +        /* Compact */
> +        for (i = 0, j = 0; i < w; i++) {
> +            if (syms[i])
> +                syms[j++] = syms[i];
> +        }
> +        w = j;
> +
> +        /* After dedup, ensure we still have at least one symbol */
> +        if (w == 0){
> +            kfree(syms);
> +            kfree(spec);
> +            return -EINVAL;
> +        }
> +
> +        /* Register list or single symbol, using the existing bulk API */
> +        if (w == 1)
> +            rc = register_fprobe(&tf->fp, syms[0], NULL);

Hmm, you might misunderstand this. What you need to do is to classify
the list of symbols with '!' as nofilter, and others as "filter",
and pass those as "register_fprobe(&tf->fp, filter, nofilter)".

Thank you,

> +        else
> +            rc = register_fprobe_syms(&tf->fp, (const char **)syms, w);
> +
> +        kfree(syms);
> +        kfree(spec);
> +        return rc;
> +    }
>  }
>  
>  /* Internal unregister function - just handle fprobe and flags */
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
