Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC62369D59;
	Tue, 23 Jun 2026 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208475; cv=none; b=iBzInRUoCUZLOeo3K8uE/oWYzi4Y6xYhenLDX3322g4fr/bCqc82om0zgvqEP7rhQ94ha6rLhwaObnlG3hQbvKTZ6yyAIFmfd2Jz/ZZSa7tlxy5Z6A32z+W+hELrDfI/0FN+l3BM+3Vqtm9ME+fO4rNZ2Qd2nO8GMA/M9LcjNSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208475; c=relaxed/simple;
	bh=1JmnwYIobU2n/Vd7xYa5ksdyuZRqwA+p9O/JK+8Os9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YE+uFXbTFsXeqY5I5pkCHht5YDkwQES5akWf1nwDv2wK23h7NlUR0AEHVOthlg1JyqCxWlJxvqXPPFjXdsJ2nDgNaQB6xJhv/0hriEnUqkIn0VoNx8CJOYDf4CU3JwlrKx0q0ZZuhstZ7FPew/KzV1TNfnYARM3Nhi4ktQE+ibU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BokoyEDh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kRAAHAH5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BokoyEDh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kRAAHAH5"
Date: Tue, 23 Jun 2026 11:54:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782208472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s084yR3GrFX8xeCFT87QRxP1TxLcA7Wjw4Sk5s8ivO8=;
	b=BokoyEDh8VJ8CAdabEaS8LV+muo1Lm3fluMBSSkSrv/NXQwkRYgBYoUTdEClN8iNdkZ3cp
	8pXn5fghDGRQE0vkkMoDgh0fCYS7nwPjMjHbAuvLku/+gO/8snuorugsw5j0J5QbYjqKUb
	GJD1+Pn6f7/yS6J7al1E8J9UNEFoZMfehQTueNyxYy/0HIRrR+OwbIjwaxBzGqfoRQstHa
	51WreXjYmnrfSlieFibd6SUxpskViS5/mDpwDzESl+ox7qzlfPVlkQHhmx9L66zjkxiaFl
	YYaCHhDQL2ySfDNw9RXTHOjFlJaNysMuzDFcxCVGFqsmZWsivGi6epPXLDTTcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782208472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s084yR3GrFX8xeCFT87QRxP1TxLcA7Wjw4Sk5s8ivO8=;
	b=kRAAHAH5ZV3Oilb03MeQh9aPWwoq2qLMiceSmiqFKNC5qS0+QIoR8fKZKWsAgnxQrVrcEL
	dr86iDEp7bns8bCg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: wen.yang@linux.dev
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rv/reactors: add KUnit tests for reactor_printk
Message-ID: <20260623114142-639eab7e-0227-4471-9117-b765fb37f7e8@linutronix.de>
References: <cover.1781541556.git.wen.yang@linux.dev>
 <690593305ad075539a804e0bf94493335354e6b9.1781541556.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <690593305ad075539a804e0bf94493335354e6b9.1781541556.git.wen.yang@linux.dev>

On Tue, Jun 16, 2026 at 12:44:49AM +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
> 
> Add KUnit tests for the printk reactor covering:
> - Reactor registration and unregistration lifecycle
> - React callback invocation via rv_react()
> - Double registration rejection
> - Multiple register/unregister cycles
> 
> The mock callback calls vprintk_deferred() — the same path as the real
> reactor — then busy-waits to simulate I/O back-pressure, exercising the
> LD_WAIT_FREE constraint of rv_react() under load.
> 
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
>  kernel/trace/rv/Kconfig                |  10 ++
>  kernel/trace/rv/Makefile               |   1 +
>  kernel/trace/rv/reactor_printk_kunit.c | 123 +++++++++++++++++++++++++
>  3 files changed, 134 insertions(+)
>  create mode 100644 kernel/trace/rv/reactor_printk_kunit.c
> 
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 3884b14df375..ff47895c897f 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -104,6 +104,16 @@ config RV_REACT_PRINTK
>  	  Enables the printk reactor. The printk reactor emits a printk()
>  	  message if an exception is found.
>  
> +config RV_REACT_PRINTK_KUNIT
> +	bool "KUnit tests for reactor_printk" if !KUNIT_ALL_TESTS

It would be nice if this was a tristate symbol.
Otherwise the test is completely unusable with CONFIG_KUNIT=m.
Maybe use EXPORT_SYMBOL_FOR_MODULES() for the few needed symbols.

> +	depends on RV_REACT_PRINTK && KUNIT

The dependency on RV_REACT_PRINTK is not actually necessary.

Nit: I would split this into two 'depends on'.

> +	default KUNIT_ALL_TESTS
> +	help
> +	  This builds KUnit tests for the printk reactor. These are only
> +	  for development and testing, not for regular kernel use cases.
> +
> +	  If unsure, say N.
> +
>  config RV_REACT_PANIC
>  	bool "Panic reactor"
>  	depends on RV_REACTORS
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 94498da35b37..ef0a2dcb927c 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -23,4 +23,5 @@ obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
>  # Add new monitors here
>  obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
>  obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
> +obj-$(CONFIG_RV_REACT_PRINTK_KUNIT) += reactor_printk_kunit.o
>  obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
> diff --git a/kernel/trace/rv/reactor_printk_kunit.c b/kernel/trace/rv/reactor_printk_kunit.c
> new file mode 100644
> index 000000000000..933aa5602226
> --- /dev/null
> +++ b/kernel/trace/rv/reactor_printk_kunit.c
> @@ -0,0 +1,123 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KUnit tests for reactor_printk
> + *
> + */
> +
> +#include <kunit/test.h>
> +#include <linux/rv.h>
> +#include <linux/printk.h>
> +#include <linux/sched/clock.h>
> +#include <linux/processor.h>
> +
> +/*
> + * Simulated execution time for mock_printk_react (sched_clock units,
> + * nanoseconds).  Models the time a real printk reactor callback may consume
> + * under I/O pressure, exercising the LD_WAIT_FREE constraint of rv_react().
> + */
> +#define MOCK_REACT_DURATION_NS	5000000ULL
> +
> +/*
> + * Mock react callback mirroring rv_printk_reaction().
> + *
> + * Calls vprintk_deferred() — the same path as the real reactor — then holds
> + * the CPU for MOCK_REACT_DURATION_NS via a sched_clock() timed busy-loop,
> + * simulating a callback that is slow due to I/O back-pressure.
> + * sched_clock() is notrace and lock-free; no sleep or lock acquisition is
> + * performed, satisfying the LD_WAIT_FREE constraint of rv_react().
> + */
> +__printf(1, 0) static void mock_printk_react(const char *msg, va_list args)
> +{
> +	u64 start = sched_clock();
> +
> +	vprintk_deferred(msg, args);

This can get out of sync with the real reactor.

> +
> +	while (sched_clock() - start < MOCK_REACT_DURATION_NS)
> +		cpu_relax();
> +}
> +
> +static struct rv_reactor mock_printk_reactor = {
> +	.name		= "test_printk",
> +	.description	= "test printk reactor",
> +	.react		= mock_printk_react,
> +};
> +
> +/* Test 1: register and unregister reactor */

Not a fan of the test numbers in the comment.
They will become stale fast.

> +static void test_printk_register_unregister(struct kunit *test)
> +{
> +	int ret;
> +
> +	ret = rv_register_reactor(&mock_printk_reactor);
> +	KUNIT_EXPECT_EQ(test, ret, 0);

> +	KUNIT_EXPECT_STREQ(test, mock_printk_reactor.name, "test_printk");

This doesn't really test anything.

> +
> +	rv_unregister_reactor(&mock_printk_reactor);
> +}
> +
> +/* Test 2: react callback is invoked via rv_react() */
> +static void test_printk_react_called(struct kunit *test)
> +{
> +	struct rv_reactor reactor = {
> +		.name	= "printk_cb_test",
> +		.react	= mock_printk_react,
> +	};
> +	struct rv_monitor monitor = {
> +		.name	= "test_monitor",
> +		.reactor = &reactor,
> +		.react	= mock_printk_react,
> +	};
> +
> +	rv_react(&monitor, "printk violation message");

The invocation is not actually tested.

> +}
> +
> +/* Test 3: double registration should fail */
> +static void test_printk_double_register(struct kunit *test)
> +{
> +	int ret;
> +
> +	ret = rv_register_reactor(&mock_printk_reactor);
> +	KUNIT_ASSERT_EQ(test, ret, 0);
> +
> +	ret = rv_register_reactor(&mock_printk_reactor);
> +	KUNIT_EXPECT_NE(test, ret, 0);

This could test the specific return value.

> +
> +	rv_unregister_reactor(&mock_printk_reactor);
> +}
> +
> +/* Test 4: register/unregister cycle */
> +static void test_printk_register_cycle(struct kunit *test)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < 5; i++) {
> +		ret = rv_register_reactor(&mock_printk_reactor);
> +		KUNIT_EXPECT_EQ(test, ret, 0);
> +
> +		rv_unregister_reactor(&mock_printk_reactor);
> +	}
> +}
> +
> +/* Test 5: react callback is not NULL (printk reactors must provide react) */
> +static void test_printk_react_not_null(struct kunit *test)
> +{
> +	KUNIT_EXPECT_NOT_NULL(test, mock_printk_reactor.react);

This doesn't really test anything.

> +}
> +
> +static struct kunit_case reactor_printk_kunit_cases[] = {
> +	KUNIT_CASE(test_printk_register_unregister),
> +	KUNIT_CASE(test_printk_react_called),
> +	KUNIT_CASE(test_printk_double_register),
> +	KUNIT_CASE(test_printk_register_cycle),
> +	KUNIT_CASE(test_printk_react_not_null),

Most tests are not related to the printk reactor at all.
Maybe add a generic "rv_reactor" suite.

> +	{}
> +};
> +
> +static struct kunit_suite reactor_printk_kunit_suite = {
> +	.name		= "rv_reactor_printk",
> +	.test_cases	= reactor_printk_kunit_cases,
> +};
> +
> +kunit_test_suite(reactor_printk_kunit_suite);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("KUnit tests for reactor_printk");
> -- 
> 2.25.1
> 
