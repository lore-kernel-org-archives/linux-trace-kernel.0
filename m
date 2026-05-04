Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800BC78F4F;
	Mon,  4 May 2026 08:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883970; cv=none; b=nYGjqCj7yH1S6kczbmMNRqameqmvrHn9tMP+HPrRcl9fXmDQLaGjOa8yIPnO9efULtmhcw1w3rFQNVaTlFjffnQ5d/htPzVdkQgN9z99jc0gYiS4uHU01qOMx3TICcyCkhSiwGxd1k/gXe6ukxnabyFagTRxBZEtVvxaSoeiVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883970; c=relaxed/simple;
	bh=NS4wf6UHEY+AqYhQBkvvI/Fs2SBRv/zhDja3F+EkSrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mrftdSCNYrpK9/CIIgTonkVKD45sUoX2LaCOQGyJmND5sAzXiMajPJSAD/YNlyvGTAr0IH4yNGs3L2KC3+eOGHs1jZ0UVvTr1UmdjW+urM2wJfT02q+0UTF3F27G3Be8KfZORqivRotvb5g0rnT93KLDehLpny8cG92OIdhjKpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H1dNtraz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5wumDHVk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H1dNtraz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5wumDHVk"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777883967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/iKmXbydKy2m1rxfJuG9Wo10oQ0xvgWQX6Eel+vmHM=;
	b=H1dNtrazJptiuHmRn58wCpkwOpnIEuWKRQQfb0FXF83ZsC1mipENCLv5KBHNgIHUU2DRSZ
	bMpgW7ilxnlHmcaDnv1ZeASPlke8IcbCNCphtDxOh4XUDHnxTscJgC09u9fz+b9/8g6yFA
	M9cWu1x6RDs7u3fU3V6n/leP5pmczmwTGS+SATIJCaSAdylnTSfrFqrhn4iwdquOBPIPnh
	u0E+W5So9ABtVJQHIK6zfvqw0r3q4+UfVdVV5tPeDxVeBeRpcdIXEfm9bZkDHXUxsix2cD
	GEd5bl7DYoX92ubia2OQhLH00PiRuOzY4KLClRw67DmQ+9NGeDsplW/7AUVhHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777883967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C/iKmXbydKy2m1rxfJuG9Wo10oQ0xvgWQX6Eel+vmHM=;
	b=5wumDHVk9T0NAbrkwD2JmZmve/J2Y7wdbGymmrXLsv/ZELrKhGYf01sHp0MWgQir/2npjU
	8aE40G8ort38M1Dg==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [RFC PATCH 10/12] rv: Add KUnit tests for some DA/HA monitors
In-Reply-To: <20260427151134.192971-11-gmonaco@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
 <20260427151134.192971-11-gmonaco@redhat.com>
Date: Mon, 04 May 2026 10:39:27 +0200
Message-ID: <875x531scg.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +#ifdef CONFIG_RV_MONITORS_KUNIT_TEST
> +#include <kunit/test.h>
> +
> +/*
> + * rv_prepare_test - Disable the monitor for a kunit test
      ^^^^^^^^^^^^^^^
      wrong name

> +obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_monitors_test.o
> +# Stubbing rv_react triggers the error
> +CFLAGS_rv_monitors_test.o += -Wno-suggest-attribute=format

I try removing this flag, but my compiler does not produce any
warning. Which warning did you see?

If it is not a hassle, I would prefer to address the warning in C code.
Grep tells me the rest of the kernel does not use this, how do other
subsystems not suffer from this warning?

> +void rv_test_opid(struct kunit *test)
> +{
> +	struct rv_kunit_ctx *ctx = test->priv;
> +
> +	da_prepare_test(test, &rv_this);
> +
> +	/*
> +	 * The handlers are called with an additional level of preemption,
> +	 * ensure we start from 0 but apply it here to avoid warnings.
> +	 */
> +	KUNIT_ASSERT_TRUE(test, preemptible());
> +	guard(preempt)();
> +
> +	/* Wakeup with preemption and interrupts enabled */
> +	handle_sched_waking(NULL, NULL);
> +	RV_KUNIT_EXPECT_REACTION(test, ctx);
> +
> +	/* Need resched with interrupts enabled */
> +	scoped_guard(preempt)
> +		handle_sched_need_resched(NULL, NULL, 0, TIF_NEED_RESCHED);

From my understanding, this last one is testing that need_resched with
interrupt enabled does not invoke the reactor? And if the monitor is
broken and the reactor is invoked, we would have no test failure here,
but instead we have test failure the next time
RV_KUNIT_EXPECT_REACTION() is called. And if this is the last test, we
would not see a failure?

If so, should we perhaps have something like RV_KUNIT_EXPECT_NO_REACTION()
here? So that if the monitor is broken and the reactor is called, then
the kunit test will fail exactly where the failure is.

Reading the patch further down below, we actually do have that
macro! Shouldn't we use it here?

> +#ifdef CONFIG_RV_MON_SCO
> +extern void rv_test_sco(struct kunit *test);
> +#else
> +static inline void rv_test_sco(struct kunit *test)
> +{
> +	kunit_skip(test, "Monitor not enabled\n");
> +}
> +#endif

Instead of these, I would prefer we have something like

#define KUNIT_CASE_IF(test_name, enabled) \
	{ .run_case = enabled ? test_name : some_stub, ... }

and

static struct kunit_case rv_trigger_test_cases[] = {
	KUNIT_CASE_IF(rv_test_sco, CONFIG_RV_MON_SCO),
        ...
	{}
};

or something like that. But no big deal.

Nam
