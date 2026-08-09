Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5542A1F8755
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 17:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786297351; cv=none; b=BvGW/ZoRFT5vRwwKq6javr5AxZCxyxhU20xqHdLuDRZlE7qFo4g82Kbp6V9XniAM/BXiSfX143Lw0wxedNPSy+mQQo52J1uDWuRLoZSipjUZNsq4zA/+fLfMztapobvUibn+Rw1QZFnc7zLeFbX93/SCQCPPhYEy3/lt+NBDXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786297351; c=relaxed/simple;
	bh=jHaJAxu5HjPRRIhZJYMVYhQAaoUGehqnqbJxd/9L5CQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L83JXTZM+zmqm6hd11340lQ4tO0AfxqJFFACRp7Iox7Ou57/j7oEdi+5e+nKAHiqMIbqyHNEjjNjIjh7PPjqGrRcfYNVuDcBeCiwyfb+6SV/pGd9+1Ubu9QVIPpREU3Ivh/pWqlBjNyBrqTpwU4/UYZigEYnnhOgG6gwtW1meb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lXiAmGR3; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lXiAmGR3"
Message-ID: <6762485a-a6af-4250-b7e1-1548d7a772e6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786297345;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PprEhvA83UnQ1ZESVM6sgqSJSfr3iw8469C1fY8YS5k=;
	b=lXiAmGR3gpd33IpPjmKiBijEqstH2jgKiYgOO6kqD2SFkCUkshM/4Dwwh0ozZnkPdlTt70
	N36ermOR5fzTEfFq1tfHx9VUB8n7255qn6v9wcmFIY+Qd5tp2ju62fz45n2CeFEEbcsHSP
	HDp9yL7SwCt0XCvolVKy9s1Tns8KwZs=
Date: Mon, 10 Aug 2026 01:42:15 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] rv/reactors: add KUnit tests for reactor
 registration and dispatch
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1785695669.git.wen.yang@linux.dev>
 <55a167aacaf1497fafbbe9fd578ffe14cbee368f.1785695669.git.wen.yang@linux.dev>
 <d2bbe352facbd02de931305d23bcc2115d14fba5.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <d2bbe352facbd02de931305d23bcc2115d14fba5.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/3/26 20:49, Gabriele Monaco wrote:
> On Mon, 2026-08-03 at 02:43 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> Add KUnit tests covering the reactor register/unregister lifecycle
>> (including duplicate and name-length rejection) and rv_react() dispatch
>> (a no-op without a callback, exactly one invocation with one; the mdelay
>> callback keeps the CPU busy so a timer interrupt exercises the LD_WAIT_SPIN
>> lockdep context).  The Kconfig entry is tristate so the tests can be built
>> as a module when CONFIG_KUNIT=m; only RV_REACTORS is required.
>>
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> ---
>>   kernel/trace/rv/Kconfig             |  12 +++
>>   kernel/trace/rv/Makefile            |   1 +
>>   kernel/trace/rv/rv_reactors_kunit.c | 143 ++++++++++++++++++++++++++++
>>   3 files changed, 156 insertions(+)
>>   create mode 100644 kernel/trace/rv/rv_reactors_kunit.c
>>
>> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
>> index efa930f94ea4..9bfd429ffdea 100644
>> --- a/kernel/trace/rv/Kconfig
>> +++ b/kernel/trace/rv/Kconfig
>> @@ -113,6 +113,18 @@ config RV_REACT_PANIC
>>   	  Enables the panic reactor. The panic reactor emits a printk()
>>   	  message if an exception is found and panic()s the system.
>>   
>> +config RV_REACTORS_KUNIT
>> +	tristate "KUnit tests for RV reactors" if !KUNIT_ALL_TESTS
>> +	depends on KUNIT
>> +	depends on RV_REACTORS
>> +	default KUNIT_ALL_TESTS
>> +	help
>> +	  Enable KUnit tests for RV reactor registration and dispatch.
>> +	  These tests verify the register/unregister lifecycle, duplicate
>> +	  rejection, and that rv_react() correctly invokes callbacks.
>> +
>> +	  If unsure, say N.
>> +
>>   config RV_MONITORS_KUNIT_TEST
>>   	tristate "KUnit tests for RV monitors" if !KUNIT_ALL_TESTS
>>   	depends on KUNIT && RV && RV_REACTORS
>> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
>> index cdbf68c84f5a..c895d81dfdad 100644
>> --- a/kernel/trace/rv/Makefile
>> +++ b/kernel/trace/rv/Makefile
>> @@ -25,4 +25,5 @@ obj-$(CONFIG_RV_MON_WAKEUP) += monitors/wakeup/wakeup.o
>>   obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
>>   obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
>>   obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
>> +obj-$(CONFIG_RV_REACTORS_KUNIT) += rv_reactors_kunit.o
>>   obj-$(CONFIG_RV_MONITORS_KUNIT_TEST) += rv_monitors_test.o
>> diff --git a/kernel/trace/rv/rv_reactors_kunit.c
>> b/kernel/trace/rv/rv_reactors_kunit.c
>> new file mode 100644
>> index 000000000000..32c25dcf0cb6
>> --- /dev/null
>> +++ b/kernel/trace/rv/rv_reactors_kunit.c
>> @@ -0,0 +1,143 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit tests for RV reactor registration and dispatch.
>> + */
>> +
>> +#include <kunit/test.h>
>> +#include <linux/rv.h>
>> +#include <linux/delay.h>
>> +#include <linux/atomic.h>
>> +#include "rv.h"
>> +
>> +static struct rv_reactor test_reactor = {
>> +	.name		= "kunit_test_reactor",
>> +	.description	= "KUnit test reactor",
>> +};
>> +
>> +/*
>> + * rv_unregister_reactor() on a reactor that was never registered would
>> + * list_del() an uninitialized list_head, so track registration and only
>> + * unregister in the teardown if it is still on the list.
>> + */
>> +static bool test_reactor_registered;
> 
> I'm not too fond of adding more logic than necessary in the test, but if you
> really want to keep the dynamic teardown cannot this variable stay somehow in
> test-specific memory (test->priv)?
> 
> That feels to me a bit cleaner, although the reactor and obviously the reactors
> list are still static, so we probably wouldn't gain a huge deal.
> 
> What do you think?
> 
Thansk, your suggestion in the next comment -- relying purely on 
theteardown action.  Since reactor_teardown() is only registered after 
rv_register_reactor() succeeds, calling rv_unregister_reactor() 
unconditionally inside it is always safe.  This lets us drop 
test_reactor_registered entirely, along with the 
unregister_test_reactor() wrapper.  See the updated code below.


>> +
>> +static int unregister_test_reactor(void)
>> +{
>> +	int ret = 0;
>> +
>> +	if (test_reactor_registered) {
>> +		ret = rv_unregister_reactor(&test_reactor);
>> +		test_reactor_registered = false;
> 
> rv_unregister_reactor() cannot fail and probably never will (I'm not quite sure
> it should return int).
> But setting test_reactor_registered to false here is assuming it didn't fail
> while the rest of the test doesn't make this assumption.
> 
> Maybe let's make it void and stop tracking a result that can never change (and
> that real reactors already have to ignore).
> 
> If we do that you may even stop unregistering manually and rely only on the
> teardown, and perhaps get rid of test_reactor_registered. Even
> test_register_unregister() would be mostly already covered by the next one.
> Just throwing in the idea.
> 

Agreed on all points.  In v3:
- unregister_test_reactor() is gone; reactor_teardown() calls
   rv_unregister_reactor() directly.
- test_reactor_registered is gone.
- test_register_unregister() is removed; the teardown covers
   the unregister path, and test_double_register() already exercises
   the register→verify→unregister (via teardown) flow.

The updated teardown is:

   static void reactor_teardown(void *arg)
   {
	rv_unregister_reactor(&test_reactor);
   }

   static void register_test_reactor(struct kunit *test)
   {
	KUNIT_ASSERT_EQ(test, rv_register_reactor(&test_reactor), 0);
	KUNIT_ASSERT_EQ(test,
			kunit_add_action_or_reset(test,reactor_teardown,
						  NULL), 0);
   }


>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +/*
>> + * The teardown action guarantees the reactor is unregistered even if a
>> + * test fails mid-way, so a leftover entry cannot corrupt later tests.
>> + */
>> +static void reactor_teardown(void *arg)
>> +{
>> +	unregister_test_reactor();
>> +}
>> +
>> +static void register_test_reactor(struct kunit *test)
>> +{
>> +	KUNIT_ASSERT_EQ(test, rv_register_reactor(&test_reactor), 0);
>> +	test_reactor_registered = true;
>> +	KUNIT_ASSERT_EQ(test,
>> +			kunit_add_action_or_reset(test, reactor_teardown,
>> NULL), 0);
>> +}
>> +
>> +static void test_register_unregister(struct kunit *test)
>> +{
>> +	register_test_reactor(test);
>> +
>> +	KUNIT_EXPECT_EQ(test, unregister_test_reactor(), 0);
>> +}
>> +
>> +static void test_double_register(struct kunit *test)
>> +{
>> +	register_test_reactor(test);
>> +
>> +	KUNIT_EXPECT_EQ(test, rv_register_reactor(&test_reactor), -EINVAL);
>> +
>> +	KUNIT_EXPECT_EQ(test, unregister_test_reactor(), 0);
>> +}
>> +
>> +static void test_name_too_long(struct kunit *test)
>> +{
>> +	/* Name length of MAX_RV_REACTOR_NAME_SIZE (32) must be rejected. */
>> +	static struct rv_reactor long_reactor = {
>> +		.name = "kunit_reactor_name_too_long_xxx_",
>> +	};
>> +
>> +	KUNIT_ASSERT_EQ(test, (int)strlen(long_reactor.name),
>> +			MAX_RV_REACTOR_NAME_SIZE);
> 
> You probably want KUNIT_ASSERT_GE, or even better
> _Static_assert(sizeof(long_name) - 1 >= MAX_RV_REACTOR_NAME_SIZE)
> 
> (you'd need to save the name to a static array first for sizeof() to work as
> expected) 
> 

Good idea.  The _Static_assert approach is strictly better: it catches 
the mistake at build time rather than test run time, and the assertion 
is always evaluated regardless of whether the test runs at all.

In v3 the name is stored in a fixed-size array:

static const char long_reactor_name[] = "kunit_reactor_name_too_long_xxx_";
_Static_assert(sizeof(long_reactor_name) - 1 >= MAX_RV_REACTOR_NAME_SIZE,
               "long_reactor_name must be at least 
MAX_RV_REACTOR_NAME_SIZE chars");

static void test_name_too_long(struct kunit *test)
{
        static struct rv_reactor long_reactor = {
                .name = long_reactor_name,
        };

        KUNIT_EXPECT_EQ(test, rv_register_reactor(&long_reactor), -EINVAL);
}

The KUNIT_ASSERT_EQ(strlen(...)) runtime check is removed.


>> +	KUNIT_EXPECT_EQ(test, rv_register_reactor(&long_reactor), -EINVAL);
>> +}
>> +
>> +static struct kunit_case rv_reactor_registration_cases[] = {
>> +	KUNIT_CASE(test_register_unregister),
>> +	KUNIT_CASE(test_double_register),
>> +	KUNIT_CASE(test_name_too_long),
>> +	{}
>> +};
>> +
>> +static struct kunit_suite rv_reactor_registration_suite = {
>> +	.name		= "rv_reactor_registration",
>> +	.test_cases	= rv_reactor_registration_cases,
>> +};
>> +
>> +static atomic_t react_call_count;
>> +
>> +__printf(1, 0) static void mock_react(const char *msg, va_list args)
>> +{
>> +	atomic_inc(&react_call_count);
>> +	/*
>> +	 * Hold the CPU for 5 ms so a timer interrupt is likely to fire
>> +	 * inside rv_react()'s lockdep context, exercising the LD_WAIT_SPIN
>> +	 * constraint.  mdelay() is a calibrated busy-wait with no scheduler
>> +	 * interaction.
>> +	 */
>> +	mdelay(5);
>> +}
>> +
>> +static void test_react_no_callback(struct kunit *test)
>> +{
>> +	struct rv_monitor monitor = {
>> +		.name = "kunit_null_react",
>> +	};
>> +
>> +	/* rv_react() must silently return when monitor->react is NULL. */
>> +	rv_react(&monitor, "no callback");
> 
> So what are we testing here? That the kernel doesn't panic? It's fair to expect
> a silent return, but we cannot really validate that.
> 
> If that's your intent, maybe specify it better, since, in fact, KUnit cannot
> validate this. Something like:
> 
>    "The only possible failure in this test case is a kernel panic"
> 

Good point. And thinking further about it: we actually can do better 
than a pure crash guard here.  The existing mock_react() already 
increments react_call_count, so we can reuse that counter to assert that 
the callback was never invoked.  That turns the test from "does not 
panic" into "callback count stays zero", which catches a broader class 
of bugs.

In v3 the test becomes:

static void test_react_no_callback(struct kunit *test)
{
        struct rv_monitor monitor = {
                .name = "kunit_null_react",
        };

        atomic_set(&react_call_count, 0);
        rv_react(&monitor, "no callback");

        /*
         * The only possible failure in this test case is a kernel panic.
         * NULL react guard: callback must NOT have been invoked
         */
        KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 0);
}


Thanks,

--
Best wishes,
Wen

> 
>> +}
>> +
>> +static void test_react_callback_invoked(struct kunit *test)
>> +{
>> +	struct rv_monitor monitor = {
>> +		.name	= "kunit_dispatch_monitor",
>> +		.react	= mock_react,
>> +	};
>> +
>> +	atomic_set(&react_call_count, 0);
>> +	rv_react(&monitor, "callback invocation test");
>> +	KUNIT_EXPECT_EQ(test, atomic_read(&react_call_count), 1);
>> +}
>> +
>> +static struct kunit_case rv_react_dispatch_cases[] = {
>> +	KUNIT_CASE(test_react_no_callback),
>> +	KUNIT_CASE(test_react_callback_invoked),
>> +	{}
>> +};
>> +
>> +static struct kunit_suite rv_react_dispatch_suite = {
>> +	.name		= "rv_react_dispatch",
>> +	.test_cases	= rv_react_dispatch_cases,
>> +};
>> +
>> +kunit_test_suites(&rv_reactor_registration_suite, &rv_react_dispatch_suite);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("KUnit tests for RV reactor registration and dispatch");
> 
