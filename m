Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD32F0C79
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 16:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616006; cv=none; b=LJhj/436QRC7VN4d41OMM/uv5jthTiDZ7WVP5ol3XFOCjKzODxWAeSs6acFRYeAHmTXs9v1PiMSUIlaUoK6UkbFJVE4acd6IWR1hN8OfgFv08wlZecJeQGcNV/hF/IICZ26xOwgFBsPXEyMYXeBlrEdhlU/i0p/QtiqotpQ3uuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616006; c=relaxed/simple;
	bh=b7zfTQSTw7eJMHOfiepj3GFi2GERbOyWjaW7XWIL7KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KeCcQVMemoZPOBb5/CdCUK7jv7lOG5wEfCMw9o1k7dwY6xOye5a0Q+rHAPNxqMqxgzrvLAQFoZmwrRdZ6VzbjyCzyHVUIg7Dh+oITdC3UtJutp3hcaGloX2dA+xzs6s3cm4JWdNatsMfYnaWZ2UoXQP8JrZnsf4uSB8db4Wxqa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JvKdIEVi; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JvKdIEVi"
Message-ID: <051b5ac5-9fcd-4183-a811-c206a34c505a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783616002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=as92G9Y1HS9GHDZYyt2jo57Ute5ywL4X/GdT9Nat8e8=;
	b=JvKdIEViynVIidrtqbjtUvby+KLzShldTEN8qhHORSZIscSAkupYNduDodN5cEEmK1xbdV
	HbWhZkeJQPLckXr2NdUpGnuSIcACnNYKGr1jvCuanZGjAmA1u64fVIQCG+EQofSdLwbvO4
	DYi4qXMST8tiFDm/46adfbIk2nv7adc=
Date: Fri, 10 Jul 2026 00:53:05 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] rv/reactors: add KUnit tests for reactor_printk
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1781541556.git.wen.yang@linux.dev>
 <690593305ad075539a804e0bf94493335354e6b9.1781541556.git.wen.yang@linux.dev>
 <97dc3ac923f1910a6103665fa5d69aca28430b6a.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <97dc3ac923f1910a6103665fa5d69aca28430b6a.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/6/26 22:41, Gabriele Monaco wrote:
> 
> 
> On Tue, 2026-06-16 at 00:44 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> Add KUnit tests for the printk reactor covering:
>> - Reactor registration and unregistration lifecycle
>> - React callback invocation via rv_react()
>> - Double registration rejection
>> - Multiple register/unregister cycles
>>
>> The mock callback calls vprintk_deferred() — the same path as the real
>> reactor — then busy-waits to simulate I/O back-pressure, exercising the
>> LD_WAIT_FREE constraint of rv_react() under load.
>>
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> ---
>>   kernel/trace/rv/Kconfig                |  10 ++
>>   kernel/trace/rv/Makefile               |   1 +
>>   kernel/trace/rv/reactor_printk_kunit.c | 123 +++++++++++++++++++++++++
>>   3 files changed, 134 insertions(+)
>>   create mode 100644 kernel/trace/rv/reactor_printk_kunit.c
>>
>> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
>> index 3884b14df375..ff47895c897f 100644
>> --- a/kernel/trace/rv/Kconfig
>> +++ b/kernel/trace/rv/Kconfig
>> @@ -104,6 +104,16 @@ config RV_REACT_PRINTK
>>   	  Enables the printk reactor. The printk reactor emits a printk()
>>   	  message if an exception is found.
>>   
>> +config RV_REACT_PRINTK_KUNIT
>> +	bool "KUnit tests for reactor_printk" if !KUNIT_ALL_TESTS
>> +	depends on RV_REACT_PRINTK && KUNIT
>> +	default KUNIT_ALL_TESTS
>> +	help
>> +	  This builds KUnit tests for the printk reactor. These are only
>> +	  for development and testing, not for regular kernel use cases.
>> +
>> +	  If unsure, say N.
>> +
>>   config RV_REACT_PANIC
>>   	bool "Panic reactor"
>>   	depends on RV_REACTORS
>> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
>> index 94498da35b37..ef0a2dcb927c 100644
>> --- a/kernel/trace/rv/Makefile
>> +++ b/kernel/trace/rv/Makefile
>> @@ -23,4 +23,5 @@ obj-$(CONFIG_RV_MON_NOMISS) += monitors/nomiss/nomiss.o
>>   # Add new monitors here
>>   obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
>>   obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
>> +obj-$(CONFIG_RV_REACT_PRINTK_KUNIT) += reactor_printk_kunit.o
>>   obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
>> diff --git a/kernel/trace/rv/reactor_printk_kunit.c
>> b/kernel/trace/rv/reactor_printk_kunit.c
>> new file mode 100644
>> index 000000000000..933aa5602226
>> --- /dev/null
>> +++ b/kernel/trace/rv/reactor_printk_kunit.c
>> @@ -0,0 +1,123 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * KUnit tests for reactor_printk
>> + *
>> + */
>> +
>> +#include <kunit/test.h>
>> +#include <linux/rv.h>
>> +#include <linux/printk.h>
>> +#include <linux/sched/clock.h>
>> +#include <linux/processor.h>
>> +
>> +/*
>> + * Simulated execution time for mock_printk_react (sched_clock units,
>> + * nanoseconds).  Models the time a real printk reactor callback may consume
>> + * under I/O pressure, exercising the LD_WAIT_FREE constraint of rv_react().
>> + */
>> +#define MOCK_REACT_DURATION_NS	5000000ULL
>> +
>> +/*
>> + * Mock react callback mirroring rv_printk_reaction().
>> + *
>> + * Calls vprintk_deferred() — the same path as the real reactor — then holds
>> + * the CPU for MOCK_REACT_DURATION_NS via a sched_clock() timed busy-loop,
>> + * simulating a callback that is slow due to I/O back-pressure.
>> + * sched_clock() is notrace and lock-free; no sleep or lock acquisition is
>> + * performed, satisfying the LD_WAIT_FREE constraint of rv_react().
>> + */
>> +__printf(1, 0) static void mock_printk_react(const char *msg, va_list args)
>> +{
>> +	u64 start = sched_clock();
>> +
> 
> I'm fine testing something that looks like the printk reactor rather than the
> real thing, but here sched_clock() is playing with preemption and could trigger
> one, this isn't accurate.
> 
> I'm not sure all implementations are free from this problem, but why don't you
> just use mdelay() here?
> 

Thanks,
v2 uses mdelay(5) for the busy-wait. The goal is simply to hold the CPU 
inside rv_react()'s lockdep context; so mdelay() is a pure calibrated 
spin with no scheduler interaction, making the test's causal chain 
clearer than sched_clock().

The remaining comments are also very important, and we will address them 
in v2.

--
Best wishes,
Wen





