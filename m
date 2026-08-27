Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8833BB57
	for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Aug 2026 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857347; cv=none; b=u8rDUSTsrdCglfh8HywDbZEHOHPXUwdkl6/pSDT/IG7r0gBTRXcwZXn4yerP0ww/n0TEQ2hc2mr8tdAChR74Ko7WvXpVraovOMTDHknDUNaYL1bm4MeqhgxJnfTrYpVbD40RjVWlQTgtHjwaGUSaNgtfsK6mmBhVbl1uscm1am4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857347; c=relaxed/simple;
	bh=huRS+LoY308zLxTQW9uNCFTrVGNfcv1XcFUigqNktNA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KiAEKfxrmn4VfdMeL5XodETXAhRtkdgTZ3itcarHY0ekKnjPm1YwsPsd4FSI2J58by6JGiXPiNcO0DvqbEQ8rdGfN7bYHwnLn1qMkL0yKVf77UunX6Lj9Kok+KIzsRdMUKU0iF+yES7UjWCLC1KzbNAsbjHRlVKH30QJrZw1hCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYQDfQvD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYQDfQvD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC7A1F000E9;
	Thu, 27 Aug 2026 19:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857346;
	bh=WISgUkt55fBYwD6gvzqEYrtuZT2WJOG15PWN7M/11XY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYQDfQvDiCWRU1ozwTZuaFrmQAw3635FRlTfSrK3mApS3YSQ10d7GteC9J6OaE11L
	 u/vHvtMJQk1AQdNekKD0gs8iFT/5CX/SAQdKXtYDB8hB2evVl4HD1oFpNdKoZbpGsf
	 e/dhd2DIxEOgnXtaBk03o+baT4sJRc3VhL7Dl9KNTiriB26NRJOPblts6temHwsVUt
	 S5f9vEgw87vYa34Hx29gl1EGrYVXgfZeY/u10Q6XYFY2IDGFKydd/qBgpRg+V9WvsM
	 /nCWPB8rRI2rZqXBI+8LQrohXRg44lMOvlKosBH78K0rzqgQfmvlydKwhFrRo3ST2a
	 fqD+a9TrHkp6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 4/4] rv/reactors: add KUnit tests for reactor
 registration and dispatch
Reply-To: sashiko-reviews@lists.linux.dev
To: wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <ab4e483f66a7297fb5b9c247964051a7de4a7ab7.1787854397.git.wen.yang@linux.dev>
References: <cover.1787854397.git.wen.yang@linux.dev>
 <ab4e483f66a7297fb5b9c247964051a7de4a7ab7.1787854397.git.wen.yang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 19:02:25 +0000
Message-Id: <20260827190226.0DC7A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The test `test_react_callback_invoked` spuriously fails if the g=
lobal reactor dispatch is disabled via sysfs.
- [Medium] The 5ms busy-wait in `mock_react` is mathematically insufficient=
 to guarantee a timer interrupt on systems with HZ < 200, making the intend=
ed lockdep coverage flaky.
--

commit 2f80d797b5152331b6b88a29924dc870e4e2b6a0
Author: Wen Yang <wen.yang@linux.dev>

rv/reactors: add KUnit tests for reactor registration and dispatch

This commit adds KUnit tests for the RV reactor register/unregister lifecyc=
le.
It includes coverage for duplicate registration, name-length rejection, and
verifying that rv_react() correctly dispatches to the callback.

> diff --git a/kernel/trace/rv/rv_reactors_kunit.c b/kernel/trace/rv/rv_rea=
ctors_kunit.c
> new file mode 100644
> index 0000000000000..2ccbe55ce4087
> --- /dev/null
> +++ b/kernel/trace/rv/rv_reactors_kunit.c

[ ... ]

> +__printf(1, 0) static void mock_react(const char *msg, va_list args)
> +{
> +	react_call_count++;
> +	/* Busy-wait so a timer interrupt fires inside rv_react(). */
> +	mdelay(5);

[Severity: Medium]
Will this 5ms busy-wait reliably trigger a timer interrupt on systems where
HZ < 200?

On systems configured with HZ=3D100, where ticks occur every 10ms, a 5ms de=
lay
will only span a timer tick around half the time. Can this lead to flaky te=
st
coverage when trying to exercise the LD_WAIT_SPIN lockdep wait context?

> +}

[ ... ]

> +static void test_react_callback_invoked(struct kunit *test)
> +{
> +	struct rv_monitor monitor =3D {
> +		.name	=3D "kunit_dispatch_monitor",
> +		.react	=3D mock_react,
> +	};
> +
> +	react_call_count =3D 0;
> +	rv_react(&monitor, "callback invocation test");
> +	KUNIT_EXPECT_EQ(test, react_call_count, 1);

[Severity: Medium]
Can this assertion spuriously fail if the global reacting_on state is
disabled?

If the test executes while the global state is disabled, such as via
/sys/kernel/tracing/rv/reacting_on, rv_react() short-circuits:

kernel/trace/rv/rv_reactors.c:rv_react() {
	...
	if (!rv_reacting_on() || !monitor->react)
		return;
	...
}

Will this cause the test to fail by not invoking the callback at all?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787854397.gi=
t.wen.yang@linux.dev?part=3D4
