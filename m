Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6204B431499
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 23:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786577650; cv=pass; b=Y/VVTdlmG0ZB5EZPERvgFlc7/+2hVNt9mcUaM68qFwt1PrDqp9Fej4C0MqQjBDpD0WJVUZ7RyJYHHBOIb5C1kRlfwbF1n42rF4rpOo1ogmxKWubFCUvUV4PVRhqm6I34lrppsjfeX1WPez8e9xgZyEAwtFGhGVuLrygXuhnMWTI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786577650; c=relaxed/simple;
	bh=6+IZbK1XLVdRo0iSvcawAO33xWaA+5eYNbi6QzTLRVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2PpRcsbeVgyaMX3g9fzCCc8/rCBBjG/Zh/gAZEJnW9GxXQibwaek+8ke72pChH5IVoZwAqkZY7UdZRIpCDDbnCSE//RvJzZb2E3J1BhCrg4s0P2z1wyGRtCTrS2LkR+1xYH0AB7Ek7Irfbnt15W2AVdXN2y8fbVsARXi8AWVj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LhxG5yNP; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LhxG5yNP"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01c79467so54661cf.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786577648; cv=none;
        d=google.com; s=arc-20260327;
        b=LM5kk6Lwg8nis4iKjxUNPEVtPAdGBRJg4WR6+KuoYLFWcQTO1rNDI47HNiq1xQ/Wye
         A5YUdLAsQCQ0933yS/rq1NnmQ0DLghbujwnZ/5hSf8+NeO5YUUxh8Dshnjb9kWWQsKje
         73IbrdS4WNoeyUeNRwpclpnmPWLBccZM5vndDLAnH4xc8dJLK/KQxYyvh6bpyqwB5wfb
         dkvpXWJEMEbqNY1T16PiVfcJ2/i5fsTTBN4GgJvc9Kg6vm7NKtFQkOS2Yj+J25AMCo9x
         LXUdmTQe48djJVPsDdNoELtnLdDDAMCjT/kSFS0jy8EszM7bF9DqY4AvKA5fe+A3C8+C
         b61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=thS6W+fao1nFVWmRcc04F9UA6vYDU4/A39G2jwslH5c=;
        fh=P3NpKtHBZaPV8jqjaBFNmIrGfkrE+WZth5Q/l/f7NQ0=;
        b=ED3ahLftBoU3clQFtueUHoj8OQRjKkXQ0/JwhN0DZY0PrvVGvyqbPLdLUgFuleQYlE
         BS29TnrIxRY0n7bGSV6BHeCBVHCoBmzOF21VrfbA7w6fm47zOksflqp51U1nZSOXG8ys
         OaiHwUpMi3UAKvNeanAzb/XG1L0nktvpJaeGyFalT4a0O+geL2lRt6Q31TIY8PCHzxPO
         hBrZmVYgOGwLZmiJinfA5jbMN3sZkYTNDRSpprzx4F2jXsF+bNibgYkzbH/DvBHtGK94
         iJ4Vaf0RLgKeF6q/M8qMCFh4KPec50G8artm6S+gXS/13j/25a+DbnD+eIKupEnPufAP
         UPWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786577648; x=1787182448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=thS6W+fao1nFVWmRcc04F9UA6vYDU4/A39G2jwslH5c=;
        b=LhxG5yNP8liK1TNvhyxW/evSpl+bzUwjeW3J69bE57sJ0Y6EB2sLB5kQsCS9wWhKVK
         C8lEOgw3lw3wrrnNGo6IqvvKaOrOqLMePwzYB6jfZgYvm0kV3ijwXQnmPAd3FVVZwpFC
         2dtxmhjWwQ6eLNusn5jq3ZbkECnZ7PNc4YJncYIxpJEu9RF3XTsXdZmj/zHwn47ah+rn
         XP4wVn7wjNSXBrE3feO7+E9zyIaStPDs3i+D0miy9M9zgVpAWn61aXqRRSOqOgJReonM
         oyoI0Jz7ggdmQIBSN6whPuhZdC98NjED/TyUBK9PDAfjGYFvstgLc8TUYOyO/VlY+gvI
         FqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786577648; x=1787182448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=thS6W+fao1nFVWmRcc04F9UA6vYDU4/A39G2jwslH5c=;
        b=KqkXqSEpAXgNyAA14czGl1ARmkkt1ZOthPEQFKz2RskrThKeSQUypkr+SgQvkXOY5B
         RbTjn+rOoLXNmoDFC4rwtIMGoy3ywPEr9ZG1dBx+3a5IXT/jyXWtC24/6Cwq+SBt3H1O
         b2lpCshNqFLoJxb2jURx9Pq8w9tyNp4sZPGxR8vUjtm98i4GEakbW3W0FVbvwoY0BlPn
         S5gFTxS7w5wAxZ1BsM8FzcydDUtt/fhLUtoYLh+7GraDI8KdM8HVnGd+WbM8sImYhfM3
         48jRpfw/s7hJqM876yPH3TRKD64dVGq8Q2mJLo8q9Uqls1pdDjY8n9muB9rc8AoQXCSL
         jkqg==
X-Forwarded-Encrypted: i=1; AHgh+Rp1FajtpVqEC8TZi9+A9Ibys+Gou7fvUlftWu1PBlYFY1Em2q0S1K9yfqVtVM5FTnEZA2/3LZ0k285TVUKSP3eV5HM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkfIvxTPiv4OZ5uBQsWWOGjtmRopM4jzC9iy535FCX9q3ZfhnO
	3F4mOs5z2D2yBY+FKCF8Dxje/bQMGmpj1d/72/f1kBuB5oLASQPa3q9x+LVtG1tFZ04Jz1U5UWE
	M/klUxc2qlbGiJq2iUv9Yc09KR+n5bbmPFz8ERebx
X-Gm-Gg: AR+sD13NXTNgztSTWYaNqM7VsYFuGay5/UgyQBTl/FKfP9Ge32X3QhLeWGshbJuCOPv
	gE7f2x9/S+iXS0eJlBbNuz06hK3THo9SjS7shjh6AuaXq2R8eW7ukQ3+rRINYStwGtFYQleMLCh
	hTDRRkA0094zJyDWlAwe2EyuclKhnCUwknGxcVxf4e4JjRyjz5sOOIyOjxgSTkmeUEVX9DbJGg1
	WgFKmGitb7JjwPslLwIphBZD5yhRk4GcS0QXUUdSAgfU1NzPWd6slxhDeKIw+fUWVC07+1q1Og6
	X99GY6hEvW8ZGJhdvsuUn7OM/T5wDDC2JnzrHkjXMuU=
X-Received: by 2002:a05:622a:1818:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-52d76908a9dmr2273101cf.10.1786577647658; Wed, 12 Aug 2026
 16:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <178656406317.2437052.7257990869957704195@slm.duckdns.org>
In-Reply-To: <178656406317.2437052.7257990869957704195@slm.duckdns.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 12 Aug 2026 16:33:55 -0700
X-Gm-Features: AUfX_mxczg7oTc2X7HTyQR0Stgtoe03j6Jl-M6qjMNje4w6VW78_BUeDVB4GCoo
Message-ID: <CAJuCfpGidP8p16aacUDpox4UiROdQDrwMTEXmZmb+hXWNhi+zg@mail.gmail.com>
Subject: Re: [PATCH] percpu: Drop CONFIG_DEBUG_FORCE_WEAK_PER_CPU
To: Tejun Heo <tj@kernel.org>
Cc: Dennis Zhou <dennis@kernel.org>, Christoph Lameter <cl@gentwo.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 12:55=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> alpha requires percpu variables in modules to be defined as weak so that =
the
> compiler generates GOT based external references for them. This puts two
> extra restrictions on percpu variable definitions. The symbol must be
> globally unique even when static and a static percpu variable can't be
> defined inside a function. DEBUG_FORCE_WEAK_PER_CPU exists to give generi=
c
> code build coverage for these restrictions without building for alpha.
>
> MEM_ALLOC_PROFILING defines a static percpu counter at each allocation ca=
ll
> site and thus can't be built with weak percpu definitions, so it depends =
on
> !DEBUG_FORCE_WEAK_PER_CPU. As allmodconfig enables DEBUG_FORCE_WEAK_PER_C=
PU,
> this knocks MEM_ALLOC_PROFILING out of allmodconfig build coverage.
>
> allmodconfig coverage for MEM_ALLOC_PROFILING is worth more than build
> coverage for restrictions which only matter to alpha module builds. Drop
> DEBUG_FORCE_WEAK_PER_CPU. Restriction violations will now show up only on
> alpha builds.
>
> Reported-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Cc: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Thanks Tejun and Andrew!

> ---
>  include/linux/percpu-defs.h |    7 +------
>  include/rv/da_monitor.h     |    2 +-
>  lib/Kconfig.debug           |   16 ----------------
>  3 files changed, 2 insertions(+), 23 deletions(-)
>
> --- a/include/linux/percpu-defs.h
> +++ b/include/linux/percpu-defs.h
> @@ -65,13 +65,8 @@
>   *
>   * Archs which need weak percpu definitions should set
>   * CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU when necessary.
> - *
> - * To ensure that the generic code observes the above two
> - * restrictions, if CONFIG_DEBUG_FORCE_WEAK_PER_CPU is set weak
> - * definition is used for all cases.
>   */
> -#if (defined(CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU) && defined(MODULE)) =
|| \
> -       defined(CONFIG_DEBUG_FORCE_WEAK_PER_CPU)
> +#if defined(CONFIG_ARCH_MODULE_NEEDS_WEAK_PER_CPU) && defined(MODULE)
>  /*
>   * __pcpu_scope_* dummy variable is used to enforce scope.  It
>   * receives the static modifier when it's used in front of
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -24,7 +24,7 @@
>
>  /*
>   * Per-cpu variables require a unique name although static in some
> - * configurations (e.g. CONFIG_DEBUG_FORCE_WEAK_PER_CPU or alpha modules=
).
> + * configurations (e.g. alpha modules).
>   */
>  #define DA_MON_NAME CONCATENATE(da_mon_, MONITOR_NAME)
>
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -613,21 +613,6 @@ config BUILTIN_MODULE_RANGES
>          It also records an anchor symbol to determine the load address o=
f the
>          section.
>
> -config DEBUG_FORCE_WEAK_PER_CPU
> -       bool "Force weak per-cpu definitions"
> -       depends on DEBUG_KERNEL
> -       help
> -         s390 and alpha require percpu variables in modules to be
> -         defined weak to work around addressing range issue which
> -         puts the following two restrictions on percpu variable
> -         definitions.
> -
> -         1. percpu symbols must be unique whether static or not
> -         2. percpu variables can't be defined inside a function
> -
> -         To ensure that generic code follows the above rules, this
> -         option forces all percpu variables to be defined as weak.
> -
>  config WARN_CONTEXT_ANALYSIS
>         bool "Compiler context-analysis warnings"
>         depends on CC_IS_CLANG && CLANG_VERSION >=3D 230000
> @@ -1053,7 +1038,6 @@ config MEM_ALLOC_PROFILING
>         default n
>         depends on MMU
>         depends on PROC_FS
> -       depends on !DEBUG_FORCE_WEAK_PER_CPU
>         select CODE_TAGGING
>         select PAGE_EXTENSION
>         select SLAB_OBJ_EXT
