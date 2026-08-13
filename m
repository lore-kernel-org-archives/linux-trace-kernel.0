Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92602737FC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 04:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593740; cv=none; b=ADe5SS6bpSHb/afOvHtAh+MAxF1IgfEIWv+NGFqwERm+oFUdw4dAlpKAQ15+teyT+2E3+CHWd2J2y/BNZMRYu6omiQks9nUV0VeXHHZJI1YhHy30jecvxzcBOupb2jVTKUClIYgsPUTQev3InK/3G1p77bxVsUdvTkzvmyRnios=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593740; c=relaxed/simple;
	bh=rVApbGGh+gwEayGWmWzWsVUikhz5UxkT1Z5NQDs0S7c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kPNT+zYq+5k4cCUo3hnINkm9ljXmugUdrMPLFbCOJPlRuWkmYOXxLqbBhbtfVOkRkylEjni2j5X/OYO+opHPIVH3B7a6wYK+xi7unNHYEGCUgp2YETfs+CkarxOXK9ArFcHARm/6oi3F8ouNke03kwa4nZUXlWqE1TiH3ZTZlps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvJDrsgM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvJDrsgM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A241F000E9;
	Thu, 13 Aug 2026 04:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593739;
	bh=7SRuvH4rdjp9ma+C/CWCN4/TfHa4fWOvQsoHGpR8HMw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VvJDrsgMhOVxHLK9sfXe5Xw0enDKhGRu1+iRc4cGlu6ddXqhryVc1QZaUTbIPTYJ3
	 8AfYVWIBw4Y9FTkC34HwRkRM4TnbvvhuQkeTtRKWDGKijkvqoUjIu8mxUbKAiPPdN1
	 3buKstOoHSCBxMfVxwVHmN9E/FfRcmg6c8dStLlYLaixJpD48tI2gjCgA6L9vrRm5v
	 2G0KaoIuGeB6BloEbvc0uo398K/NXBtgCfjoR71qh/lPrMtUljJz6Z32UxgQhpfiyO
	 /BvO6Cv9WCEsvB3hv3oUc1P6kApA5Ca7FkSfwORj6B3qfkGuuT7Why99YGiNE37lX4
	 8Azc6GFjiAzZw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] tracing: add refcount_final_put tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eugene Mavick" <m@mavick.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813-refcount-final-put-trace-v5-1-6e8bf8a38b31@mavick.dev>
References: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
 <20260813-refcount-final-put-trace-v5-1-6e8bf8a38b31@mavick.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:02:18 +0000
Message-Id: <20260813040219.50A241F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The `do_trace_refcount_final_put_cond` macro does not parenthesi=
ze its `cond` parameter, which can lead to logical errors and bypass the tr=
acepoint static branch.
- [Medium] The refcount_final_put tracepoint is dead code because no caller=
s were added to invoke it.
- [Low] Missing `<linux/export.h>` in `lib/refcount_trace.c`.
- [Low] Incorrect file name referenced in comment for the trace wrapper imp=
lementation.
--

--- Patch [1]: [PATCH v5 1/5] tracing: add refcount_final_put tracepoint ---
commit 6fe677465a197120927dfba704ab4c4aff5f134a
Author: Eugene Mavick <m@mavick.dev>

tracing: add refcount_final_put tracepoint

Add refcount_final_put tracepoint and related core infrastructure

refcount_final_put fires when a reference
count reaches zero and the object enters its final release path.

> The tracepoint records three fields:
> - caller: function that called the refcounting
>   function(refcount_sub_and_test, percpu_ref_put_many)

[Severity: Medium]
Are there missing callers for the tracepoint macro?

The commit message mentions that the tracepoint records the caller function,
such as refcount_sub_and_test or percpu_ref_put_many, but this patch doesn't
add any calls to do_trace_refcount_final_put() in the refcount release path=
s.

This leaves the tracepoint inactive.

> diff --git a/include/linux/refcount_trace.h b/include/linux/refcount_trac=
e.h
> new file mode 100644
> index 0000000000000..6f8d0ba910f05
> --- /dev/null
> +++ b/include/linux/refcount_trace.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_REFCOUNT_TRACE_H
> +#define _LINUX_REFCOUNT_TRACE_H
> +
> +#include <linux/tracepoint-defs.h>
> +#include <linux/instruction_pointer.h>
> +
> +#ifdef CONFIG_REFCOUNT_TRACE_FINAL_PUT
> +/* Declare the tracepoint so tracepoint_enabled() can be used */
> +DECLARE_TRACEPOINT(refcount_final_put);
> +
> +/* Wrapper function implemented in lib/ref_trace.c */

[Severity: Low]
This isn't a bug, but there's a typo in the filename here.

The wrapper is implemented in lib/refcount_trace.c, not lib/ref_trace.c.

> +extern void do_refcount_trace_final_put(unsigned long caller, unsigned l=
ong ip, const void *obj);
> +
> +#define do_trace_refcount_final_put(obj)					\
> +	do {									\
> +		if (tracepoint_enabled(refcount_final_put))			\
> +			do_refcount_trace_final_put(_RET_IP_, _THIS_IP_, obj);	\
> +	} while (0)
> +
> +#define do_trace_refcount_final_put_cond(cond, obj)				\
> +	do {									\
> +		if (tracepoint_enabled(refcount_final_put) && cond)		\

[Severity: Medium]
Should cond be wrapped in parentheses here?

If a caller passes a condition containing a logical OR, such as a || b,
operator precedence would cause this to evaluate as:

    (tracepoint_enabled(...) && a) || b

If b is true, the trace wrapper would be invoked unconditionally even when =
the
tracepoint is disabled, bypassing the static key optimization.

> +			do_refcount_trace_final_put(_RET_IP_, _THIS_IP_, obj);	\
> +	} while (0)

[ ... ]

> diff --git a/lib/refcount_trace.c b/lib/refcount_trace.c
> new file mode 100644
> index 0000000000000..2476bb5f2f603
> --- /dev/null
> +++ b/lib/refcount_trace.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define CREATE_TRACE_POINTS
> +#include <trace/events/refcount.h>
> +#include <linux/refcount_trace.h>
> +

[Severity: Low]
Should this file include <linux/export.h>?

It uses EXPORT_SYMBOL_GPL and EXPORT_TRACEPOINT_SYMBOL_GPL below. Relying on
implicit inclusions can sometimes cause build failures on different
architectures or configurations.

> +//Wrapper function for functions defined entirely in header files
> +void do_refcount_trace_final_put(unsigned long caller,
> +				 unsigned long ip,
> +				 const void *obj)
> +{
> +	trace_call__refcount_final_put(caller, ip, obj);
> +}
> +EXPORT_SYMBOL_GPL(do_refcount_trace_final_put);
> +EXPORT_TRACEPOINT_SYMBOL_GPL(refcount_final_put);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-refcount-f=
inal-put-trace-v5-0-6e8bf8a38b31@mavick.dev?part=3D1
