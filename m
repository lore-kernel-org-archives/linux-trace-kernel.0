Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012423EAB3
	for <linux-trace-kernel@vger.kernel.org>; Sun,  2 Aug 2026 04:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785646612; cv=none; b=VwWFaE3WW4rKpJxWSrNC++4YEjES87JsaGpgVba5GMEUAP8y17/dbpmjas8anEMQ/vm/XlR7o7l2q24kFgOsWcoUCZQCHZtRhpplX4fF4BxK7rBFtrlQrStkgwClZzr2abCm1eSt4w1p+CsEuYy4dth696hdDkeG6DMHlyHyyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785646612; c=relaxed/simple;
	bh=7ayZbjQ3hsQwgkMvcSgm8BnbQ2pvbvceGtcA8LVsP+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tre80x2hRHwtAOtKLN9mCmzOA6+z3K9hhvAFjI7RwY+MSFVlVHXEWAUdjL69TMXFBhM7yP+QFXOiwBJo7ZZGh648rVkoUaQTsrWfWk9wxfDW2jJ5vG5GpkZDsmd7cSMB7BtHAKSbfFrUY+hJGWfg0WyymXsNdwrtArZScT2EyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xTIpPIyK; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xTIpPIyK"
Message-ID: <e0fe1e85-c885-4ce6-b250-1b2028112f26@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785646607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tJI3LmlhJF+HEzR/cdHTH+CWZ+UUfkJ88wyadc/8UN0=;
	b=xTIpPIyKenSLSjkoO6hqaz0fTZDtUIq5QTuo7L2MntW0iQaxhsbqBmbCV6ld0zdbGdpEJL
	tZTIJ2vnTCzfet7HTdEVwp2qfqKiARRRKuZfYLbpFH9hqDa4EV2jO6CrfAA1/GFx2E/KRS
	BxIaSX8wkLIGKas1uQ73HT/f9OatrGI=
Date: Sun, 2 Aug 2026 12:55:52 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 13/17] rv: Add KUnit mock for current
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260723074534.43521-1-gmonaco@redhat.com>
 <20260723074534.43521-14-gmonaco@redhat.com>
 <38a2480b-b420-4b14-9793-5ab3d7cfb2b9@linux.dev>
 <0CC2C4B0-6E6A-4199-A7FA-EEDEB28866B6@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <0CC2C4B0-6E6A-4199-A7FA-EEDEB28866B6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/30/26 13:13, Gabriele Monaco wrote:
> 
> 
> Il 29 luglio 2026 18:17:31 UTC, Wen Yang <wen.yang@linux.dev> ha scritto:
> 
>>> +#define rv_get_current() (unlikely(kunit_get_current_test()) ? rv_get_mock_current() : current)
>   
> ...
> 
>>> +/*
>>> + * rv_get_mock_current() is called only if we are running from a KUnit test.
>>> + * This can occur from a legitimate RV test or any unrelated test running when
>>> + * a real RV monitor is active and triggering events.
>>> + * We assume the former case is the only one where mock_current is not NULL and
>>> + * can occur only sequentially (KUnit doesn't run tests in parallel).
>>> + * We cannot rely on the test's context because there is no way to safely
>>> + * understand from which test we are running and KUnit utilities require
>>> + * locking, which is unsafe from NMI or scheduling context.
>>> + * Note that it is not possible for a real RV monitor to run when the RV KUnit
>>> + * tests are running (see rv_set_testing()).
>>> + */
>>> +static struct task_struct *mock_current;
>>> +
>>> +void rv_mock_current(struct task_struct *tsk)
>>> +{
>>> +	mock_current = tsk;
>>> +}
>>> +EXPORT_SYMBOL_IF_KUNIT(rv_mock_current);
>>> +
>>> +struct task_struct *rv_get_mock_current(void)
>>> +{
>>> +	return mock_current ?: current;
>>> +}
>>> +EXPORT_SYMBOL_GPL(rv_get_mock_current);
>>>    #endif
>>
>> rv_mock_current() uses EXPORT_SYMBOL_IF_KUNIT, but rv_get_mock_current() uses EXPORT_SYMBOL_GPL. Both are defined inside the same CONFIG_RV_MONITORS_KUNIT_TEST block, so rv_get_mock_current should use EXPORT_SYMBOL_IF_KUNIT as well, otherwise it leaks a test-only symbol into production builds.
>>
>> With that fixed:
>> Reviewed-by: Wen Yang <wen.yang@linux.dev>
> 
> Thanks for the review.
> This was intentional however: rv_get_current() can be called by any monitor, those don't have to be KUnit.
> Since rv_get_current() is a macro also calling rv_get_mock_current() we need to be able to link that too.
> 
> The idea is that a "real" (non-kunit) monitor handler could be run when interrupting a KUnit test (not an RV one, we make sure of that). In that case we do call rv_get_mock_current() and return current after the function call.
> 
> rv_mock_current() CANNOT be called outside of the RV KUnit test cases, it uses a global variable (for problems I tried to explain in the comment), so should be exported only to KUnit and called directly from the test case.
> 
> Does it make sense to you?
> 

Thanks for the explanation.
That does make sense.

One small thought though -- the kernel already provides 
KUNIT_STATIC_STUB_REDIRECT as the idiomatic way to handle this kind of 
pattern. It allows a production function to be transparently redirected 
to a stub during KUnit tests, with zero overhead when no test is running 
(since it uses the same static_branch_unlikely(&kunit_running) path as 
kunit_get_current_test()).

This might be a cleaner fit here, since it avoids exporting 
rv_mock_current() beyond KUnit and keeps the redirection logic internal 
to the test harness.

Just wanted to throw that out there -- what do you think?


diff --git a/kernel/trace/rv/rv_monitors_test.c 
b/kernel/trace/rv/rv_monitors_test.c
index 8026176eee90..f4e3e2e4a6d4 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
...
+struct task_struct *rv_current(void)
+{
+       KUNIT_STATIC_STUB_REDIRECT(rv_current);
+       return current;
+}
+EXPORT_SYMBOL_GPL(rv_current);

...

diff --git a/kernel/trace/rv/rv_monitors_test.c 
b/kernel/trace/rv/rv_monitors_test.c
index 8026176eee90..f4e3e2e4a6d4 100644
--- a/kernel/trace/rv/rv_monitors_test.c
+++ b/kernel/trace/rv/rv_monitors_test.c
...

+static struct task_struct *mock_current_task;
+
+static struct task_struct *rv_mock_current_fn(void)
+{
+       return mock_current_task ?: current;
+}
+
+void rv_mock_current(struct kunit *test, struct task_struct *tsk)
+{
+       mock_current_task = tsk;
+       if (tsk)
+               kunit_activate_static_stub(test, rv_current, 
rv_mock_current_fn);
+       else
+               kunit_deactivate_static_stub(test, rv_current);
+}
+EXPORT_SYMBOL_IF_KUNIT(rv_mock_current);


diff --git a/kernel/trace/rv/monitors/pagefault/pagefault_kunit.c 
b/kernel/trace/rv/monitors/pagefault/pagefault_kunit.c
index unchanged..unchanged 100644
--- a/kernel/trace/rv/monitors/pagefault/pagefault_kunit.c
+++ b/kernel/trace/rv/monitors/pagefault/pagefault_kunit.c
@@ -nn,7 +nn,7 @@ static void rv_test_pagefault(struct kunit *test)
         rv_pagefault_ops.handle_task_newtask(NULL, target, 0);
-       rv_mock_current(target);
+       rv_mock_current(test, target);



--
Best wishes,
Wen





