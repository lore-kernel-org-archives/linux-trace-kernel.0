Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794564158;
	b=YZxqw7giGqR0vj7wn5VDeRvopoQ7s9gqqHeFbm8SUH9qhttFPhcKtQ/5MiKffAI5VaXL
	 /T3ymA++EtX1+KzIQJDPu9t4Iv8oWpC5tvUhJlSZ9BLfr/c+3VaTNC1adiHhPHbngm20F
	 EfaO6mwA4h0bNhv/d48mbiDMqkk/XH8OJBdVEFr9OXwcKbP5FtBA2uiwRPPGTGFvdeQ55
	 euq0cVnQvO0Fc70Iu71u1DpczAVLhFjN5WRdqFHk93skktNWjjpvKrSSYFiVnFKigqlug
	 mDo80TYHUQ6HSobiPD6pz2Vc4e18P6BJGUTKT/EtJ1aqCbmlZ6Nxfh++mnQoIJrV1oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794564158;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q4jz2rb+3ayaGjNpX/u7p+U/YjCSD8t8rMldoGiC75Y=;
	b=23csMfjNIjgzOzVAdF+Zrt7C685wy3K/AHW8p1xz2hS4cp6pWkpZiA1TGB4TRSw369KY
	 PO04tbA6vKxhl0uKBE4dIYh7vMx1m3DrPH+uZnf2Z9wXLpmAB5AACKq8496S5llQnIy1y
	 33d8xz8J0u4zhAOHxl2AXssNQidBScheeLlpuKmsO9S7P/W6/9usxeImOGncmOvy6kI75
	 KuYR/Kn2CGuDTvHmyxJO0Go41kSiGBXTVDZLD+Nwq603/EnOShbJKOMzfwL7LvQUx0+iJ
	 KcS9xYlLQENW4+nQ+Z2/Is2nCdCaLXMOKy+5cOEnJp+7nLqYTToGzWLWrXGNnKMV5hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfXKuDhY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EECA606A32E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 10:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MfXKuDhY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7533E1F000C4;
	Fri, 13 Nov 2026 10:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794564157;
	bh=q4jz2rb+3ayaGjNpX/u7p+U/YjCSD8t8rMldoGiC75Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MfXKuDhYwk5Tv+nLeEo81GYsk38q+9AnF4fAjGvtyapMMAHHPR5/sTkubbiANakF9
	 92D/Q8SfeqXisClhB7eVO6ZsYNMBxsyZffF74lXn1MW/5YsGrrKeUw6LrYGG3c8nuJ
	 ZHDzt/bVE0PiSIW2udvYIZnLcqpgG/XlUnVuvr5HXFvxqE8zDHOwtq9XT1puiemDwX
	 znJfX/agFAhnbkbIKY0xlpJU47JUWy2jhYxaI8QuYRLmrP4YtSIUMLxGSyi0ScFaP3
	 D6U87uui9isq/4hZTfZeeDhFImlewEl0CICHGSSHL30a47v0dUNz4Kt1yYoVFja8gj
	 pC6w0F7upX7ZQ==
Message-ID: <sashiko-outbox-212596@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] tracing/hwlat: Do the latency calculations in
 nanoseconds
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wenwu Hou" <hwenwur@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261113094918.2402297-1-hwenwur@gmail.com>
References: <20261113094918.2402297-1-hwenwur@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 10:02:37 +0000
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
- [Medium] tracing/hwlat: broken backward-clock check order in
  get_sample()
--

commit e1ff23abe0f3e347e9f8fcfd5d38bde48773198a
Author: Wenwu Hou <hwenwur@gmail.com>

tracing/hwlat: Do the latency calculations in nanoseconds

This commit changes get_sample() to compute latency deltas in nanoseconds
and fixes the backward-clock error paths to clear
trace_hwlat_callback_enabled before returning.

> diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
> index 3fe274b84f1c2..d8540c24b1ca3 100644
> --- a/kernel/trace/trace_hwlat.c
> +++ b/kernel/trace/trace_hwlat.c
> @@ -229,18 +227,19 @@ static int get_sample(void)
> =20
>  		if (time_u64(last_t2)) {
>  			/* Check the delta from outer loop (t2 to next t1) */
> -			outer_diff =3D time_to_us(time_sub(t1, last_t2));
> +			outer_diff =3D time_sub(t1, last_t2);
>  			/* This shouldn't happen */
>  			if (outer_diff < 0) {
>  				hwlat_err(BANNER "time running backwards\n");
> -				goto out;
> +				ret =3D -1;
> +				break;
>  			}
>  			if (outer_diff > outer_sample)
>  				outer_sample =3D outer_diff;
>  		}
>  		last_t2 =3D t2;
> =20
> -		total =3D time_to_us(time_sub(t2, start)); /* sample width */
> +		total =3D time_sub(t2, start); /* sample width */
> =20
>  		/* Check for possible overflows */
>  		if (total < last_total) {
> @@ -250,7 +249,7 @@ static int get_sample(void)
>  		last_total =3D total;
> =20
>  		/* This checks the inner loop (t1 to t2) */
> -		diff =3D time_to_us(time_sub(t2, t1));     /* current diff */
> +		diff =3D time_sub(t2, t1);     /* current diff */
> =20
>  		if (diff > thresh || outer_diff > thresh) {
>  			if (!count)
> @@ -261,7 +260,8 @@ static int get_sample(void)
>  		/* This shouldn't happen */
>  		if (diff < 0) {
>  			hwlat_err(BANNER "time running backwards\n");
> -			goto out;
> +			ret =3D -1;
> +			break;
>  		}

[Severity: Medium]
Can a backward clock jump between t1 and t2 bypass the diff < 0 check and
record uninitialized stack memory in s.timestamp?

Because total < last_total is checked before diff =3D time_sub(t2, t1), any
backward jump between t1 and t2 where t2 drops below the previous t2 (or
below start on the first iteration) trips total < last_total first.  That
logs "Time total overflowed" instead of "time running backwards" and breaks
out of the loop with ret =3D=3D 0 before ktime_get_real_ts64(&s.timestamp) =
runs.
If outer_diff exceeded thresh earlier in the same iteration while count was
still 0, outer_sample > thresh then causes trace_hwlat_sample(&s) to copy
an uninitialized s.timestamp from the stack into the ring buffer.

Also, diff > thresh is evaluated before diff < 0, which converts a negative
s64 diff to a large u64 when comparing against unsigned u64 thresh.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113094918.2402=
297-1-hwenwur@gmail.com?part=3D1
