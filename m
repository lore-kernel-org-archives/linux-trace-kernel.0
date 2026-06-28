Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050DB1A6803
	for <linux-trace-kernel@vger.kernel.org>; Sun, 28 Jun 2026 17:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782667044; cv=none; b=ZC48MXX5g5m1W7tKtnxEQ8v92h+hzVbAG/5GsNN5HNrQQHMOiW3gl1bxX/P4yl/Oo+imzqtfdCibREWyDMJ296IIh+iHUm3Kf0W/F/0P/lqb6gz/uxtc/Wd5eMZKNcB2Ln2vMuzoKudKxXn5w0af88eeE84HNrlNA4gB+dDxOAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782667044; c=relaxed/simple;
	bh=504fYIhwhnc1E15JkYZwkaCUlv1LyXrp96uKuDCtt34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uN7UvmUgm7kIGwolWTx3t3PMhZXi+5BnW52640I03ecA1f2fUKmhFOBBz92S2O6qfptz1looBg+aU5AMd2sToYddZiUoM3cmJ1GOs6ZDo5kSeHp/SB8lBYjDs7yrkbLxtd02cgmvFsPC/8rNmtfA3AX0k+RVjyfp1NLKrStHDXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ikRohfcu; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ikRohfcu"
Message-ID: <b2e841ee-cfcd-41d1-96af-7ba89bfb86a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782667041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/nomXNtafgS/Jm1r3gg63+Cg/9OQF4y+EK9C/MtURk=;
	b=ikRohfcu+jPMtm45G+XSAoQNaB2OVnfv7SoJr81T0gDMynbi0SPwb69jPjWSJQa+ha/HmG
	MWTWURvLhbXSnrw7/ZojLaClXzfP+iDz+5hHvejK18uBQSW5IMDMQWE6Q8D6mSFY5E6/bk
	PC+I+IirumjClRo/yIwl72dJEdKrnCk=
Date: Mon, 29 Jun 2026 01:17:02 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 11/17] rv: Prevent unintentional tracepoints during
 KUnit tests
To: Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>,
 Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
 Tomas Glozar <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-12-gmonaco@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260625121440.116317-12-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/25/26 20:14, Gabriele Monaco wrote:
> Monitor initialisation also called during KUnit tests may register some
> tracepoints, this can lead to issues since we don't expect real monitor
> events running during KUnit tests.
> 
> Prevent tracepoint registration if an RV KUnit test is running.
> 
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   include/rv/instrumentation.h |  5 +++++
>   include/rv/kunit.h           |  2 ++
>   kernel/trace/rv/rv.c         | 11 +++++++++++
>   3 files changed, 18 insertions(+)
> 
> diff --git a/include/rv/instrumentation.h b/include/rv/instrumentation.h
> index d4e7a02ede..761f8f147d 100644
> --- a/include/rv/instrumentation.h
> +++ b/include/rv/instrumentation.h
> @@ -9,12 +9,15 @@
>    */
>   
>   #include <linux/ftrace.h>
> +#include <rv/kunit.h>
>   
>   /*
>    * rv_attach_trace_probe - check and attach a handler function to a tracepoint
>    */
>   #define rv_attach_trace_probe(monitor, tp, rv_handler)					\
>   	do {										\
> +		if (rv_mon_test_is_running())						\
> +			break;								\
>   		check_trace_callback_type_##tp(rv_handler);				\
>   		WARN_ONCE(register_trace_##tp(rv_handler, NULL),			\
>   				"fail attaching " #monitor " " #tp "handler");		\
> @@ -25,5 +28,7 @@
>    */
>   #define rv_detach_trace_probe(monitor, tp, rv_handler)					\
>   	do {										\
> +		if (rv_mon_test_is_running())						\
> +			break;								\
>   		unregister_trace_##tp(rv_handler, NULL);				\
>   	} while (0)
> diff --git a/include/rv/kunit.h b/include/rv/kunit.h
> index 5e8c604cf7..0c4c4bc933 100644
> --- a/include/rv/kunit.h
> +++ b/include/rv/kunit.h
> @@ -19,6 +19,7 @@
>   
>   int rv_set_testing(struct kunit_suite *suite);
>   void rv_clear_testing(struct kunit_suite *suite);
> +bool rv_mon_test_is_running(void);
>   struct task_struct *rv_get_current(void);
>   
>   struct rv_kunit_ctx {
> @@ -59,6 +60,7 @@ void teardown_test(void *arg);
>   #else /* !CONFIG_RV_MONITORS_KUNIT_TEST */
>   
>   #define rv_get_current() current
> +#define rv_mon_test_is_running() false
>   
>   #endif /* CONFIG_RV_MONITORS_KUNIT_TEST */
>   #endif /* _RV_KUNIT_H */
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index 61d4f13960..86ef5dee7f 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -864,6 +864,14 @@ int __init rv_init_interface(void)
>   #include <rv/kunit.h>
>   #include <kunit/visibility.h>
>   
> +static bool rv_mon_test_running;
> +
> +bool rv_mon_test_is_running(void)
> +{
> +	return rv_mon_test_running;
> +}
> +EXPORT_SYMBOL_GPL(rv_mon_test_is_running);
> +

The flag rv_mon_test_running is a plain bool with no ordering
guarantees, and the tracepoint handlers that call 
rv_mon_test_is_running() may execute on
arbitrary CPUs. A store to rv_mon_test_running on the test CPU may not
be visible to another CPU's tracepoint handler.
What abbout READ_ONCE/WRITE_ONCE?

--
Best wishes,
Wen




>   /*
>    * rv_set_testing - ensure mutual exclusion between KUnit tests and real monitors
>    *
> @@ -886,6 +894,8 @@ int rv_set_testing(struct kunit_suite *suite)
>   		}
>   	}
>   
> +	rv_mon_test_running = true;
> +
>   	return 0;
>   }
>   EXPORT_SYMBOL_IF_KUNIT(rv_set_testing);
> @@ -895,6 +905,7 @@ EXPORT_SYMBOL_IF_KUNIT(rv_set_testing);
>    */
>   void rv_clear_testing(struct kunit_suite *suite)
>   {
> +	rv_mon_test_running = false;
>   	mutex_unlock(&rv_interface_lock);
>   }
>   EXPORT_SYMBOL_IF_KUNIT(rv_clear_testing);
