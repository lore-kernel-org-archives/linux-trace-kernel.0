Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E82749DC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 03:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593545; cv=none; b=BoNMM3pbsU7qxhT8wrOptYu5OUIF1pdza+3jq2qTL718yYMP0L6xVuYjbZZH1BFJ8kpQ8ph+JcL4PF7CjEnGLdzh08ZcE24pcNOTmIBEE6xRDTZXTA/PxwZ7bCXsdjAQ/qTkkQUosqp+Pbhmd4wndAJe1RYXGTGab3QrdrcufNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593545; c=relaxed/simple;
	bh=KCX19psVm2v2413LzTrwvna4e5y/e7+4AsDibYelKlY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZhDqqYQ+SVM8QnNA9nli0RPvWdJK3GlpWKaRuCXl3iQlnLrKd+SBPU+tioHnpi1wzkCVyNxjdOZU4V8HQy0eiFH+GuB0CweFC9PiD4Yb810EUtwuVesx1EGLht0d3YK4G9tUIwoG38rlLUtFFMgwgwt8U7KgHkmcRW6hQ8QkYgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m9M+ozQ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m9M+ozQ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21061F000E9;
	Thu, 13 Aug 2026 03:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593544;
	bh=ZozHSV4d5BJ/DSxYzEGh8Dbp1/E8qzeMuzJeAcP/Ayg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m9M+ozQ/Qxyiu685HV0E/+35cRGzQ2ywC3/+Co/UG6a2lC+hPvFqA+QscXxetk8H+
	 IAAFQa3ErnGn+WOstI5PmXtCx+vpNRAzRL0UQVkdlk1AjWV8o+IxHBgTKlh6NAiZ49
	 IlxRctfr5cD5sy4VH4vWRhTttq4lFKD/PBJRNNlMNUAIHLVoZWHZqTDDITPH6t8ivY
	 xz6Y2hC2LBMAPkA8O2f+7Q/Q3BXpFOlbilb1/iVGadvLKGzd1B7rqIOBBJ/r3lY27a
	 RyHg/frW8qWGjmqUZolEVq6u40UdrEcPhmQz4KEBhbh9dhFqbmv/v70tHaFn+qXab5
	 fkaG1wte9rO9A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/5] refcount: add refcount_final_put tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eugene Mavick" <m@mavick.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813-refcount-final-put-trace-v5-2-6e8bf8a38b31@mavick.dev>
References: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
 <20260813-refcount-final-put-trace-v5-2-6e8bf8a38b31@mavick.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 03:59:03 +0000
Message-Id: <20260813035903.F21061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Exporting the trace wrapper via GPL-only symbols inside fundamenta=
l static inline refcount primitives breaks the ability of non-GPL modules t=
o load.
- [Medium] The `caller` and `ip` fields recorded by the tracepoint yield fu=
ndamentally inconsistent addresses depending on whether the calling functio=
n is evaluated as inline or out-of-line.
--

--- Patch [2]: [PATCH v5 2/5] refcount: add refcount_final_put tracepoint -=
--
commit 89e648b43dd0e3f81f4dd1bfaaa093ab2953cba7
Author: Eugene Mavick <m@mavick.dev>

refcount: add refcount_final_put tracepoint
   =20
Add the refcount_final_put tracepoint to __refcount_sub_and_test()
and refcount_dec_if_one()

refcount_final_put fires when a reference
count reaches zero and the object enters its final release path.

> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index ba7657ced2817..23291a31d1be2 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
[ ... ]
> @@ -393,6 +394,7 @@ bool __refcount_sub_and_test(int i, refcount_t *r, in=
t *oldp)
> =20
>  	if (old > 0 && old =3D=3D i) {
>  		smp_acquire__after_ctrl_dep();
> +		do_trace_refcount_final_put(r);

[Severity: High]
Does this break out-of-tree non-GPL modules?

Since __refcount_sub_and_test() is a fundamental inline primitive, embedding
the tracepoint macro here forces callers to resolve the GPL-only tracepoint
symbols. This will cause non-GPL modules to fail to load when they include
<linux/refcount.h> and call this function.

[Severity: Medium]
Will this record inconsistent instruction pointers depending on whether the
function is evaluated inline?

Because __refcount_sub_and_test() is static inline, _RET_IP_ will evaluate =
to
the return address of the module invoking the refcount API (the caller's
caller), while _THIS_IP_ evaluates to the caller.

>  		return true;
>  	}
> =20
> diff --git a/lib/refcount.c b/lib/refcount.c
> index a207a8f22b3ca..8b148b5765037 100644
> --- a/lib/refcount.c
> +++ b/lib/refcount.c
[ ... ]
> @@ -56,7 +57,10 @@ bool refcount_dec_if_one(refcount_t *r)
>  {
>  	int val =3D 1;
> =20
> -	return atomic_try_cmpxchg_release(&r->refs, &val, 0);
> +	bool ret =3D atomic_try_cmpxchg_release(&r->refs, &val, 0);
> +
> +	do_trace_refcount_final_put_cond(ret, r);

[Severity: Medium]
In this out-of-line context, _RET_IP_ evaluates to the immediate caller.

Does this mean the caller and ip fields recorded by the tracepoint will yie=
ld
fundamentally inconsistent addresses compared to the inline usage in
__refcount_sub_and_test()?

> +	return ret;
>  }
>  EXPORT_SYMBOL(refcount_dec_if_one);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-refcount-f=
inal-put-trace-v5-0-6e8bf8a38b31@mavick.dev?part=3D2
