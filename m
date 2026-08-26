Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259CB17D6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709732; cv=none; b=rhkdUlZuYrjSJJXSra53RtcIy1lMxAbHkNaJ3+BDPF+peBoJZ+tjvFraAZsvvsDrxCw9F2KAKbv4RwRBiiLMPjISU4DmdZhcFiyua1Mgr22tEu0z+g7sepiB8Xmre/DSc/7p0NPvZEoMum6NxWgTvyiJ1lVlqFo3rlxJQLWJdHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709732; c=relaxed/simple;
	bh=ZH8BMTEQxGIff/DMsXw4gV6N1Aeb8YA2tOlaOjHx8l0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=m0sm/CW9Sh7HrgWVCbJjMUo2JtoXiV+IYSBVWL6PUW8WyaMdO05BU5DWhbuY+tcwXCD8XVwwXRKOSzLMuhbkfOipGcDdsKjwQeWkO87wXSutoaRoO3gdHNGUJTNIuUPO8qGzdfiEpsbBk6mA03BhknY2fbVAiYHo3OFArYnBU9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7VUGUPm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7VUGUPm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACFB1F000E9;
	Wed, 26 Aug 2026 02:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787709731;
	bh=s73QrgF7aqARFJ87igMbHQBR45alWts4JN9/LQOrVW8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z7VUGUPmDigp5UCdUCMdornAKKDzkL8BuJYzN5ueo3v+yFYO2oJ+zeb2nmA8RDwvf
	 /pXUu1W91WZhc7mUZeYleaSMZtcPERFZCQdgbBcWQS0grC61ycFdgX35rU1CjXI3j/
	 Xg475NkPXzynIQ1Ld2Csksfu9D7/aqXM+vcqqJBBcs+xmnrl8br27v1PEJb4SsqEZ/
	 GC7nsaidRcgq5FOtHW9XfLWE/uAR0JdZ+G7fiobagJbHi3KauvSrgHtk/udSMeQU3h
	 QawC+irSZLpSRPvmFscak1aW4RDSWcwOcNWK55a97JMMse3fc5g4tkn8sNsR/iFyIV
	 B2GQojXdymQKA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] samples/ftrace: Fix kthread_stop() on ERR_PTR in
 ftrace-direct-modify
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haotian Zhang" <vulab@iscas.ac.cn>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260826015034.10755-1-vulab@iscas.ac.cn>
References: <20260826015034.10755-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 02:02:10 +0000
Message-Id: <20260826020210.CACFB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing IS_ERR() check on kthread_run() leads to kernel panic on m=
odule unload
--

commit 83cdbb346a20d7607e5ef97af8d7a9a9c9c57687
Author: Haotian Zhang <vulab@iscas.ac.cn>

samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-modify

This commit fixes a bug in the ftrace-direct-modify sample module where
the return value of kthread_run() was not checked with IS_ERR(). Without
this check, an initialization failure could leave an error pointer in
simple_tsk, causing a kernel panic when kthread_stop() is called during
module unload. The patch correctly propagates the error and cleans up
by unregistering the ftrace direct call on failure.

> diff --git a/samples/ftrace/ftrace-direct-modify.c b/samples/ftrace/ftrac=
e-direct-modify.c
> index 1ba1927b548ee..164d9dd6fd921 100644
> --- a/samples/ftrace/ftrace-direct-modify.c
> +++ b/samples/ftrace/ftrace-direct-modify.c
> @@ -320,9 +320,15 @@ static int __init ftrace_direct_init(void)
>  	ftrace_set_filter_ip(&direct, (unsigned long) my_ip, 0, 0);
>  	ret =3D register_ftrace_direct(&direct, my_tramp);
> =20
> -	if (!ret)
> -		simple_tsk =3D kthread_run(simple_thread, NULL, "event-sample-fn");
> -	return ret;
> +	if (ret)
> +		return ret;
> +	simple_tsk =3D kthread_run(simple_thread, NULL, "event-sample-fn");
> +	if (IS_ERR(simple_tsk)) {
> +		unregister_ftrace_direct(&direct, my_tramp, true);
> +		return PTR_ERR(simple_tsk);
> +	}
> +
> +	return 0;
>  }

[Severity: High]
This is a pre-existing issue, but it looks like the exact same missing
IS_ERR() check is present in samples/ftrace/ftrace-direct-multi-modify.c:

samples/ftrace/ftrace-direct-multi-modify.c:ftrace_direct_multi_init() {
    [ ... ]
	ret =3D register_ftrace_direct(&direct, my_tramp);

	if (!ret)
		simple_tsk =3D kthread_run(simple_thread, NULL, "event-sample-fn");
	return ret;
}

If kthread_run() fails here, it returns an ERR_PTR which is assigned to
simple_tsk, and the module still successfully loads since the function
returns 0.

When the module is unloaded, kthread_stop() is called on the ERR_PTR, which
dereferences it and causes a kernel panic.

Should this same fix be applied to ftrace_direct_multi_init() in
ftrace-direct-multi-modify.c as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826015034.1075=
5-1-vulab@iscas.ac.cn?part=3D1
