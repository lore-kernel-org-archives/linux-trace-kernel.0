Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1BC30677E;
	Mon, 17 Aug 2026 10:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786963948; cv=none; b=P5AbjRA+nvLrSQjj5SqbsDvhI5CF4yCs1Xtgtbay7MB4udaVY0azcqcpFIMwFBqBw2yQ4ZW3j6MHv74IQJBUT8LgnF5S5WYs9DRzsguUJ8OVPQp8gBqwMD2afuRUmJb918uvgwwY89SdeMXPeRQiemUH+Rh4MpFOy2QeOLsPhNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786963948; c=relaxed/simple;
	bh=+Aa8kA0bcROs07rEP6nl7VLBOX2p8/i3LfV6X5Nu6r0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n0mR88/7K+agCEhhTJRpGpliItbw1xQNvlx4+5deQ5lBPm/Dxq2zcPjJ2v4l7kYa2+YzLXPbwrwJ3dIFD2blwcLI+Fa4SJduZtsuY8Ynar6QCr30zYFfqINz+jJEQWgaCeZyvv9D9hNAldP7sMCZbZzen3Rb65qq+LxuIO6BQVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fZpLOB7y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B/X+O+nA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZpLOB7y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B/X+O+nA"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1786963942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xjXT3Bo0xX9T+x7HPxsKCu91wNHeeXNty2gn8zVflc=;
	b=fZpLOB7ymIspnlZx4xk7KVmKTdZzMOx1E8oTR7RpZniVDsLF6N8cAv+RhAbJjPoex1TOZI
	W5HGchdcJEZ0KD16IcZXTkQlWRafxtzsW8Yo/piPctYqL8G5ikb8N+pv7gU7+hGTb8jMGk
	9abTS7A0mT6LjzXLHFRQ+H4KdBFjWTMKQsfUeS8He5HFiuDWKARcY6QFyMgiIDURiOmjMk
	AeiugAidA2yeFWaVwvp545FeYF87UdbYP+geOOLLZ52/SHHkxC5Gs8F7pvmzvy3Cq/IW/R
	SWGljKQsTX9bRy6VQBG3K8Rq3J2/MK/+03tarPp/bnaEKQC5A+fUiOcOpujkVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1786963942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6xjXT3Bo0xX9T+x7HPxsKCu91wNHeeXNty2gn8zVflc=;
	b=B/X+O+nAq/arDtau5++KdiNMRkj+mSOongrDsegcv4VdVO1fGDEAOMsmOrQpFIMAkIDW2W
	7vrgHN3nJUvy8nCQ==
To: wen.yang@linux.dev, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Wen
 Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v3 4/4] rv/reactors: add KUnit tests for reactor
 registration and dispatch
In-Reply-To: <2b91af9f6d045f7fdb8620ef5c66c3b3e189833b.1786294920.git.wen.yang@linux.dev>
References: <cover.1786294920.git.wen.yang@linux.dev>
 <2b91af9f6d045f7fdb8620ef5c66c3b3e189833b.1786294920.git.wen.yang@linux.dev>
Date: Mon, 17 Aug 2026 12:52:21 +0200
Message-ID: <87wltpnhne.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

wen.yang@linux.dev writes:
> +/*
> + * Use a fixed-size array so sizeof() gives the exact byte count at
> + * compile time.
> + */

There is no need for a comment. This is obvious from the code itself.

> +static const char long_reactor_name[] = "kunit_reactor_name_too_long_xxx_";
> +_Static_assert(sizeof(long_reactor_name) - 1 >= MAX_RV_REACTOR_NAME_SIZE,
> +	       "long_reactor_name must be at least MAX_RV_REACTOR_NAME_SIZE chars");
> +
> +static void test_name_too_long(struct kunit *test)
> +{
> +	static struct rv_reactor long_reactor = {
> +		.name = long_reactor_name,
> +	};
> +
> +	KUNIT_EXPECT_EQ(test, rv_register_reactor(&long_reactor), -EINVAL);
> +}
> +
> +static struct kunit_case rv_reactor_registration_cases[] = {
> +	KUNIT_CASE(test_double_register),
> +	KUNIT_CASE(test_name_too_long),
> +	{}
> +};

I am not sure about the usefulness of these test cases.
rv_register_reactor() is not an user API that we have to prepare
for corner case usage. We can expect its users to be sane since the
users are us.

But well, if Gabriele wants to keep them..

> +
> +static struct kunit_suite rv_reactor_registration_suite = {
> +	.name		= "rv_reactor_registration",
> +	.test_cases	= rv_reactor_registration_cases,
> +};
> +
> +static atomic_t react_call_count;

Do we really need atomic_t? Does int work?

> +
> +__printf(1, 0) static void mock_react(const char *msg, va_list args)
> +{
> +	atomic_inc(&react_call_count);
> +	/*
> +	 * Hold the CPU for 5 ms so a timer interrupt is likely to fire
> +	 * inside rv_react()'s lockdep context, exercising the LD_WAIT_SPIN
> +	 * constraint.  mdelay() is a calibrated busy-wait with no scheduler
> +	 * interaction.
> +	 */

The comment above mdelay()'s definition already explains what it does.

> +	mdelay(5);
> +}
> +
> +static void test_react_no_callback(struct kunit *test)
> +{
> +	struct rv_monitor monitor = {
> +		.name = "kunit_null_react",
> +	};
> +
> +	atomic_set(&react_call_count, 0);
> +	rv_react(&monitor, "no callback");
> +
> +	/*
> +	 * The only possible failure in this test case is a kernel panic.
> +	 * NULL react guard: callback must NOT have been invoked
> +	 */

Obvious comment.

> +	KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 0);
> +}
> +
> +static void test_react_callback_invoked(struct kunit *test)
> +{
> +	struct rv_monitor monitor = {
> +		.name	= "kunit_dispatch_monitor",
> +		.react	= mock_react,
> +	};
> +
> +	atomic_set(&react_call_count, 0);
> +	rv_react(&monitor, "callback invocation test");
> +	KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 1);
> +}

So the test calls rv_react(), and validates that the reactor is called?
Honestly I am not sure how useful that is. Especially since Gabriele
already made the selftest which validates that the reactor is invoked.

Nam
