Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486500;
	b=r2QZdPltLFVkJSmsjqureNqB9H4/xh/HQq1P+IhJwL79tIStL2T6jQtWXWU7hoD73fF2
	 Djs/VN5bX2+Yw3pnpoLl+PHVtwNDfVtqAveiP/tjIv8Tv1ec9VF9QeUDmMiNhx/IYIoEn
	 NAB3nglvnsaxTqOlTyV/lGdMnxo77P+gMtqznwksqn1onkwl4sWagyz/Jb2OPx8oT+E+7
	 ex4s9yGd9UDeJX1BmvGRAa/qF+FnWq8yaR5puckt1M5x3/zyGSEPOPyPoxfFOfnS2g3CE
	 6VIogayljVQdGFwlaMiBFMvB7aR9mH3UN7kSoj+m2u/9agGjygNQ/HnxyXx+Jtt7xbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486500;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m4MKWia4nN5k+JL47DDn52ZJxdPz7qwlnfDLOrThtvY=;
	b=PcESSAczf6cfg5gCdPiVc8iWB+oII2lhocRGioicu5bD06lAH7Q/DAkyHv70yEHDH1mi
	 OaSANGhM03EstlfNTDw+B3VWFeKSmmJous1JcGMXNJkZUMmdPyPyWB1L9kMHILJEWV8m6
	 k9GBYYAIulSiYRJ2wi9OCQ8yzsUS3OMFZPS2dDZ01dfRYVN2RYe1xcQz4HfMp1ow5//uX
	 5CfUn4exQaNBtDTN9Bj16BnKWQRvtavWLUdbehG4xbPCKExwIV/sEDKyXFGzL/i4/pEM+
	 sSQAwyi8yG8cvEKSU7piftF53hXwEIO6VPQawcom9lp8qdzOcExXvqlfWsdwIdZD0BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pd4D7ZyT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366C8606A32A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 12:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pd4D7ZyT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AFD61F00A05;
	Thu, 12 Nov 2026 12:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486499;
	bh=m4MKWia4nN5k+JL47DDn52ZJxdPz7qwlnfDLOrThtvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Pd4D7ZyTN0ahnjyGmLhBll3NaApSgXqmDCuasK/VxWqh8zb7fuMT0P3v0cYjcJWHn
	 izi3XC+THjB1EefEFGiRGU8cqFMOEKjl7eRSCbJ3u7L+dOZN+QvQeCtwiuK4iCdxeU
	 kq57cd1eZjm0s9lEuyGKeTdvfOVMuowLJsCDoH/0bTjaq0f44L6FvvXn2Vr+C/pLOF
	 w9waUhd1HwvBWoHvfb1hZ9wIyNSyNwE8mtxg0asxV5m8nCWWm5Q9jvyRrimqc2W9Y5
	 1j5pIEQJgQaFx/ECsDd49s0+4gKKmb6cXHyk3shw8ya4yRR92xE2uR8Ai9VssCL7O0
	 sHG/DgbDODNWg==
Message-ID: <sashiko-outbox-211086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] tracing/hwlat: Do the latency calculations in
 nanoseconds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wenwu Hou" <hwenwur@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261112121502.2070755-1-hwenwur@gmail.com>
References: <20261112121502.2070755-1-hwenwur@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 12:28:19 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] tracing/hwlat: get_sample() leaves NMI callback enabled on
  goto out path
--

commit b2b5eb31ef0ca8b02c68fc0666337a94df8c67b9
Author: Wenwu Hou <hwenwur@gmail.com>

tracing/hwlat: Do the latency calculations in nanoseconds

This commit changes get_sample() to perform its latency calculations in
nanoseconds so tr->max_latency is stored in nanoseconds, converting the
durations to microseconds only when recording the hwlat event.

> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 3fe274b84f1c2..b230cf14de93e 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -203,14 +203,12 @@ static int get_sample(void)
>  	time_type start, t1, t2, last_t2;
>  	s64 diff, outer_diff, total, last_total =3D 0;
>  	u64 sample =3D 0;
> -	u64 sample_width =3D READ_ONCE(hwlat_data.sample_width);
> +	u64 sample_width =3D READ_ONCE(hwlat_data.sample_width) * NSEC_PER_USEC;
>  	u64 thresh =3D tracing_thresh;
>  	u64 outer_sample =3D 0;
>  	int ret =3D -1;
>  	unsigned int count =3D 0;
> =20
> -	do_div(thresh, NSEC_PER_USEC); /* modifies interval value */
> -
>  	kdata->nmi_total_ts =3D 0;
>  	kdata->nmi_count =3D 0;
>  	/* Make sure NMIs see this first */
> @@ -229,7 +227,7 @@ static int get_sample(void)
> =20
>  		if (time_u64(last_t2)) {
>  			/* Check the delta from outer loop (t2 to next t1) */
> -			outer_diff =3D time_to_us(time_sub(t1, last_t2));
> +			outer_diff =3D time_sub(t1, last_t2);
>  			/* This shouldn't happen */
>  			if (outer_diff < 0) {
>  				hwlat_err(BANNER "time running backwards\n");
> @@ -240,7 +238,7 @@ static int get_sample(void)
>  		}
>  		last_t2 =3D t2;
> =20
> -		total =3D time_to_us(time_sub(t2, start)); /* sample width */
> +		total =3D time_sub(t2, start); /* sample width */
> =20
>  		/* Check for possible overflows */
>  		if (total < last_total) {
> @@ -250,7 +248,7 @@ static int get_sample(void)
>  		last_total =3D total;
> =20
>  		/* This checks the inner loop (t1 to t2) */
> -		diff =3D time_to_us(time_sub(t2, t1));     /* current diff */
> +		diff =3D time_sub(t2, t1);     /* current diff */

[Severity: Medium]
Can the "goto out" paths when outer_diff < 0 or diff < 0 leave
trace_hwlat_callback_enabled set to true?

Previously, time_to_us() passed the delta through unsigned div_u64(), which
cleared the sign bit and made the negative checks unreachable.  Assigning
time_sub() directly makes those error paths reachable on a backward clock
reading, and jumping to out skips clearing trace_hwlat_callback_enabled:

kernel/trace/trace_hwlat.c:get_sample() {
	...
	trace_hwlat_callback_enabled =3D true;
	...
	do {
		...
			if (outer_diff < 0) {
				hwlat_err(BANNER "time running backwards\n");
				goto out;
			}
		...
		if (diff < 0) {
			hwlat_err(BANNER "time running backwards\n");
			goto out;
		}
		...
	} while (total <=3D sample_width);

	barrier(); /* finish the above in the view for NMIs */
	trace_hwlat_callback_enabled =3D false;
	...
out:
	return ret;
}

Because nothing else resets trace_hwlat_callback_enabled, NMI tracking stays
active while kthread_fn() re-enables interrupts and sleeps, and remains ena=
bled
even after the tracer is stopped if kthread_stop() wakes the thread before
another sample finishes normally.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112121502.2070=
755-1-hwenwur@gmail.com?part=3D1
