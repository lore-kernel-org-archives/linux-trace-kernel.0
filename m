Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D1E2C21F0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 04:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786593692; cv=none; b=r2REA7jCAayVNEi97GF1ny+nr5d4DAeC2azI1cnAJ4p2G511Thr/QiGs1qLUDR3yVgadXjgGYDEOTzFhpw/+/b+zB8xa73EywVBdYDxrSlrlYB53STH+ZZMkRYuy4VDU3qZRe60/bzD3ljtdpTzOY9DO7hlYv8n2OjC0bKlCsK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786593692; c=relaxed/simple;
	bh=vG0FDfXoXFOcjnL8xRrDzZ2vlgGZK0HyEYd6IHOonr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qyp7vzYv30UR3T8iI35BsdnFogYa5tg0mnNzRZj6LSoagvOBI1iT/mT5HuartScv7AtNogcFKgGtRITDPENHVbTmyiAyNK11u4ATLXb0BROLNDB8kk5/IoU/D0Z0wWGU37AOyjWNyEFl7N5kTjObyV2yyYEUxz71tBolY5AzbxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imKjqyCd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imKjqyCd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D67D1F000E9;
	Thu, 13 Aug 2026 04:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786593690;
	bh=AOU6/d7Ki9oijdfIcZKCcgCzQ4v/6mQwXHmgvwsu8A4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imKjqyCdxa+Gdx97XOSVDSrJPgELZtsHsygwaJ9BWCSoAlKS+pbNFwo2I0x5bVYME
	 lL6cYShYjxfqORe725lmiMk84TIzS4Esh2HYyXrNbASuftKN7KhI3K3Gfjjv3XYsTt
	 3UtVzjMfbvRKXcovag1LFaRdlPfRr/aJrSl2RtOw8eQVoUKRSPS/6mQo4jMw6h2a1u
	 CM+OVxROfs3s8srjgFQyXd6HvPgOWESjy9zf3dmGeRmf6RGkh2v7rbE+9eY+4B901k
	 +hJ8rSjbnYANkOgrkwE8WCuXNppNuwEpXhOoIpkzjN+PuQU22DnKI9trZqVpgliAyi
	 rt7JId4yfgoFw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/5] kunit: add test for refcount_final_put
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eugene Mavick" <m@mavick.dev>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260813-refcount-final-put-trace-v5-4-6e8bf8a38b31@mavick.dev>
References: <20260813-refcount-final-put-trace-v5-0-6e8bf8a38b31@mavick.dev>
 <20260813-refcount-final-put-trace-v5-4-6e8bf8a38b31@mavick.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 04:01:30 +0000
Message-Id: <20260813040130.7D67D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] KUNIT_ASSERT_* usage bypasses test cleanup on failure, permanently=
 leaking memory and leaving a global trace probe registered.
- [Medium] Shared test state is initialized after the global tracepoint pro=
be is registered, creating a data race with concurrent kernel threads.
- [Medium] Missing wake_up_var in the tracepoint probe causes a 10-second h=
ang on test failure.
--

--- Patch [4]: [PATCH v5 4/5] kunit: add test for refcount_final_put ---
commit fef38efeda6f44aecbf042d2f2cbb9c0d0c7ccb4
Author: Eugene Mavick <m@mavick.dev>

kunit: add test for refcount_final_put
   =20
Add a KUnit test suite for the refcount_final_put tracepoint.
   =20
The test registers a probe function and triggers both refcount_t and
percpu_ref final put paths, verifying that the tracepoint fires
correctly and that the recorded fields match expected values.

> diff --git a/lib/tests/refcount_trace_kunit.c b/lib/tests/refcount_trace_=
kunit.c
> new file mode 100644
> index 0000000000000..a57e9e4cfa427
> --- /dev/null
> +++ b/lib/tests/refcount_trace_kunit.c
> @@ -0,0 +1,141 @@

[ ... ]

> +struct data {
> +	unsigned long caller;
> +	unsigned long ip;
> +	const void *obj;
> +	atomic_t count;
> +};
> +
> +struct data capture;
> +
> +const void *chk_obj;
> +
> +#define test_init()								\
> +	do {									\
> +		KUNIT_EXPECT_FALSE(						\
> +			test, register_trace_refcount_final_put(probe, NULL));	\
> +										\
> +		atomic_set_release(&capture.count, 0);				\
> +										\
> +		chk_obj =3D &obj;							\
> +	} while (0)

[Severity: Medium]
Does registering this system-wide tracepoint before initializing
capture.count and chk_obj create a data race?

If a concurrent kernel thread triggers a refcount final put immediately
after register_trace_refcount_final_put() succeeds, it will execute probe()
and locklessly read chk_obj before the test thread initializes it here.

Would it be safer to initialize the test state variables prior to
registering the probe?

> +
> +
> +#define test_exit()								\
> +	do {									\
> +		/* wait for probe completion */					\
> +		int notimeout =3D wait_var_event_timeout(				\
> +			&capture.count,						\
> +			atomic_read_acquire(&capture.count),			\
> +			msecs_to_jiffies(10000)					\
> +		);								\

[Severity: Medium]
Will this wait unconditionally hang for the full 10-second timeout on a
test failure?

The test thread waits here for capture.count to change, but looking at
probe(), the state is incremented with atomic_inc_return_release() without
a corresponding wake_up_var(&capture.count).

If the tracepoint fails to fire synchronously, does the missing wakeup
leave the thread permanently sleeping until the timeout expires?

> +										\
> +		unregister_trace_refcount_final_put(probe, NULL);		\
> +		tracepoint_synchronize_unregister();				\
> +										\
> +		KUNIT_ASSERT_TRUE(test, notimeout);				\

[Severity: High]
Is it safe to use KUNIT_ASSERT_TRUE() here before the test cleanup has
finished?

If this assertion fails (e.g. the wait times out), the test aborts
immediately and skips the remainder of test_exit(). For tests like
test_percpu_ref_put_many(), this means percpu_ref_exit() is never called,
resulting in a memory leak.

> +										\
> +		KUNIT_EXPECT_EQ(test, atomic_read_acquire(&capture.count), 1);	\

[ ... ]

> +static void test_percpu_ref_put_many(struct kunit *test)
> +{
> +	struct percpu_ref obj;
> +
> +	test_init();
> +
> +	KUNIT_ASSERT_FALSE(test, percpu_ref_init(&obj, dummy_release, 0, GFP_KE=
RNEL));

[Severity: High]
Does using KUNIT_ASSERT_FALSE() here risk leaving the global trace probe
permanently registered?

If percpu_ref_init() fails, KUNIT_ASSERT_FALSE() will abort the test execut=
ion
and skip test_exit(). This leaves the probe function registered globally.
When the KUnit module is later unloaded, any subsequent refcount final put
in the system will invoke the freed probe function, causing a kernel panic.

Should this test use kunit_add_action() for deferred cleanup to ensure
the tracepoint is always unregistered?

> +
> +	percpu_ref_get(&obj);
> +	percpu_ref_get(&obj);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813-refcount-f=
inal-put-trace-v5-0-6e8bf8a38b31@mavick.dev?part=3D4
