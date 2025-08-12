Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628DE1C84C7;
	Tue, 12 Aug 2025 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021797; cv=none; b=f7zff5UqPe7/DhXKSYnhS50ejcOgRMykS9MfT6AWHXHaG5FbMctffY4QlFWundnqNSwOuaBpG82o1ZU/k6K+F8Z7nqamccR36Vwd5gsKgBOS6MzQwmXod6s+xrBslAmINk2SaG4Fv6UVmfkQheXDhxoZ1ttC9+0i6c35BYh5MPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021797; c=relaxed/simple;
	bh=uoE5dWMT1rbqa37q/SivFeXKyXJu/a/1HAMw6FnM4ro=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TvMm3XEJLXkSyXrAF6MpthQBnMZVgr06uQT4TDS5nK1awahWK+e6xAXcfPvzpselvfLg1e3FEvId1ufRTiY01NFUUbyN6FV0fyJPJyvcXvRFmO48p9u0dePsC2V3m1P1ukfpQI/Vkm/OT4xdqqQmAj0wN8HVZpc+WKQn+LoJ0YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id D90E0135974;
	Tue, 12 Aug 2025 18:03:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 05A2A2002F;
	Tue, 12 Aug 2025 18:03:11 +0000 (UTC)
Date: Tue, 12 Aug 2025 14:03:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyer@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] trace/trace_fprobe.c: TODO: handle filter, nofilter or
 symbol list
Message-ID: <20250812140357.65d19062@gandalf.local.home>
In-Reply-To: <20250812162101.5981-1-seokwoo.chung130@gmail.com>
References: <20250812162101.5981-1-seokwoo.chung130@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 05A2A2002F
X-Stat-Signature: aqcdbrt1erm5365tnao8mx9yhbaosjwf
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18LYCTa3MKLGobOeCISNikzJOsZFzw7P0w=
X-HE-Tag: 1755021791-302747
X-HE-Meta: U2FsdGVkX19fo64gy4Zmd7lQ16RmDJ/YSTaXubJq5K4RC4Zl3Fj+PmlGAwrI5d9YWCmiVpt+GNLS0pc5F3/b8ohogMxg8jgLuIrv/pJVuV576eu9E9O/koFqgL1+4CtvQV2Gvd4tmxxTr0RJ/azgWNkR0qW57WvUWVR26/eUEwZ2mOCKFTy/XIDt5BZUvh0QrNiK6aop/q+jP4o72eYA0snS7rWtjH8LMhdwigiMHIH3xvU9VVKCZvLjUZB0RyZibbc6YDwInO1RG1NV2VmbF5iZ8AX7oS9KU6PzJ8RRLZhxMn7z4KH7fhuNhZHffFlcvGVfVmPKejDIcirricTTZKibU4vUpZNep0W+oGL4rZYMap8mUEL9US24BlQQlEstXtm6812xpnU=

On Wed, 13 Aug 2025 01:21:01 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

> Resolve TODO in `__register_trace_fprobe()`: 
> parse `tf->symbol` robustly (support `sym!filter` and comma-separated lists), trim tokens, ignore empties, deduplicate symbols, use bulk registration for lists, return `-EEXIST` if already registered, and preserve lockdown/tracepoint deferral semantics.

Hi Ryan,

Please read the Submitting Patches document to have proper format.

 https://docs.kernel.org/process/submitting-patches.html


For example, the change long should have a max column of 74 (with the
exception of cut and paste commands or output)

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
> +    {

Code does not add random blocks.

> +        char *spec, *bang, *p;
> +        int n = 0, w = 0, j, rc;

Indentation is always 8 byte tabs (not spaces).

> +        char **syms = NULL;
> +
> +        spec = kstrdup(tf->symbol, GFP_KERNEL);

Why did you declare spec as "char **" when you use it as "char *"?

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
> +
> +            if (!*sym || !*flt) {
> +                kfree(spec);
> +                return -EINVAL; /* reject empty symbol/filter */
> +            }
> +
> +            rc = register_fprobe(&tf->fp, sym, flt);
> +            kfree(spec);
> +            return rc;
> +        }
> +
> +        /* Comma list (or single symbol without '!') */
> +        /* First pass: count non-empty tokens */

Strange comments. Did you use AI to help you write this?

-- Steve

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

