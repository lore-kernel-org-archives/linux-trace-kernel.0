Received: from out-181.mta1.migadu.com (mta1.migadu.com [37.59.57.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D096E3921DC
	for <linux-trace-kernel@vger.kernel.org>; Sun,  9 Aug 2026 17:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.59.57.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786295984; cv=none; b=ip/RfCetogJ6T3s3wra+oLbp+2NjB1SWfr0l2uKw+TMo5bOX5GsEtJRLH4Fkq6KTgzOsJCDE6eyEXnt7UqxCaISrJc2hU8eFsfEtJTkdlUKK7nivo99uyikowKK7zbs+au52W+rqkjnKC2F+E4UUSBHrf31U+KTiV7ck7alq2gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786295984; c=relaxed/simple;
	bh=PY29OQNmzYerE4cPnv7iEBoBKWNOAGrIDBAyZUEOOFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pvi+u541TwXIIRzIJ80UZxM+Vkcwz7Eu7bzD/J+g/Kvbqt/VGGunZxCmxRObmmFYvBVB8MIY5WFtrDuAHcHcY+VHkwxH3wahvvrTDtGmxRy6HWRgseDR0CnOCLbmdxryMgXH79NzoDbhfdBVg8/wBAXfoSayPfmlOsZUWMOwMtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aHxe7wjn; arc=none smtp.client-ip=37.59.57.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aHxe7wjn"
Message-ID: <41f39390-52e6-48a4-a2e7-69e7eef5a1da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786295979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g/1UCb6YDgemU3OZyD3Rpg7LzhwIyiQ5wXKVsK63FIg=;
	b=aHxe7wjnr48CrR0qXPsktIt2fn5U2I90802a1ExQ7NPgTcxMa75ZiG2P1qXaGKuDhSUf+e
	721D9u7e8K77J+7AxxSWOOj/x6TnVAUoHwggm8x3ks1NlIha8Spm4ps6bEtaPXQUBzB5Ef
	21OHZmfob8AM9ofK1/ObsQ9y+n/WKOg=
Date: Mon, 10 Aug 2026 01:19:19 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/4] rv/reactors: use context-sensitive lockdep wait
 type in rv_react()
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
References: <cover.1785695669.git.wen.yang@linux.dev>
 <fb4c2c0ab10e32bb02cd7da747a00ef988eaf276.1785695669.git.wen.yang@linux.dev>
 <fa933b780eb63da7b194f9ca076d0d22f827c511.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <fa933b780eb63da7b194f9ca076d0d22f827c511.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 8/3/26 23:39, Gabriele Monaco wrote:
> On Mon, 2026-08-03 at 02:43 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> The single DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE) in
>> rv_react() declares wait_type_inner = LD_WAIT_FREE for every execution
>> context.  In a preemptible context (e.g. CONFIG_PREEMPT_RT or a KUnit
>> test running on a task), a timer interrupt can fire during a reactor
> 
> We are obviously not doing this for KUnit tests, but aren't tracepoint handlers
> also running with preemption enabled on non-PREEMPT_RT kernels now?
> So technically this is a problem with any configuration if events don't run with
> preemption disabled for other reasons.
> 
> Or is the issue with spinlocks only popping out on PREEMPT_RT because they
> become sleeping locks?
> Is lockdep really happy to allow an interrupt/schedule taking spinlocks under
> LD_WAIT_FREE on non-PREEMPT_RT?
> 
>> callback; the interrupt exit path then schedules and acquires rq->__lock
>> (LD_WAIT_SPIN) while the override map is still held.  Since the map
>> declares the context to be wait-free, lockdep reports a spurious
>> "Invalid wait context" warning:
>>
>>      [ BUG: Invalid wait context ]
>>      context-{5:5}
>>      1 lock held by kunit_try_catch/209:
>>       #0: (rv_react_map-wait-type-override){+.+.}-{1:1}
>>      kunit_try_catch/209 is trying to lock:
>>      ffff8a743ed3e8a0 (&rq->__lock){-...}-{2:2}
>>
>> Use two lockdep override maps, selected by execution context:
>>
>>    - Preemptible context (task, softirq, PREEMPT_RT irq thread): the
>>      scheduler may preempt, so use LD_WAIT_SPIN, the tightest wait type
>>      the scheduler itself uses, to suppress the spurious warning.
>>
>>    - NMI/hardirq context: preemption is disabled and the scheduler cannot
>>      run, so the false positive cannot arise.  Keep LD_WAIT_FREE here to
>>      preserve the original constraint that reactors must not take raw
>>      spinlocks in atomic context.
> 
> So here you're describing at length the solution but not really why you're doing
> that. A reader that didn't follow the discussion might think the requirement is
> indeed context-dependant, it isn't.
> 
> I'd write very bluntly something like:
> 
>    "Reactors are not supposed to explicitly take locks, reactor code must comply
> with LD_WAIT_FREE. However reactors may run with interrupts and preemption
> enabled, so the interrupting code may not satisfy this constraint. Relax it if
> we are running from a context that cannot be interrupted to avoid false
> positives."
> 
> I would write something like that also in the comment, to make clear that
> reactors really should be LD_WAIT_FREE, but we are asserting that as best
> effort.
> 
> What do you think?

Good point, thank you.
We've made the changes in v3 as you suggested.

--
Best wishes,
Wen


> 
>> Fixes: 69d8895cb9a9 ("rv: Add explicit lockdep context for reactors")
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
>> ---
>>   kernel/trace/rv/rv_reactors.c | 17 ++++++++++++-----
>>   1 file changed, 12 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/trace/rv/rv_reactors.c b/kernel/trace/rv/rv_reactors.c
>> index 2f5fc8d18dea..cd571b1649f5 100644
>> --- a/kernel/trace/rv/rv_reactors.c
>> +++ b/kernel/trace/rv/rv_reactors.c
>> @@ -465,18 +465,25 @@ int init_rv_reactors(struct dentry *root_dir)
>>   
>>   void rv_react(struct rv_monitor *monitor, const char *msg, ...)
>>   {
>> -	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
>> +	/*
>> +	 * A reactor callback can be preempted; the scheduler then takes
>> +	 * rq->__lock (LD_WAIT_SPIN).  Advertise that in preemptible contexts
>> +	 * to avoid a spurious lockdep report, and keep LD_WAIT_FREE in
>> atomic
>> +	 * ones where the scheduler cannot run.
>> +	 */
>> +	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map,        LD_WAIT_SPIN);
>> +	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map_atomic, LD_WAIT_FREE);
>> +	struct lockdep_map * __maybe_unused map;
>>   	va_list args;
>>   
>>   	if (!rv_reacting_on() || !monitor->react)
>>   		return;
>>   
>> +	map = (in_nmi() || in_hardirq()) ? &rv_react_map_atomic :
>> &rv_react_map;
>>   	va_start(args, msg);
>> -
>> -	lock_map_acquire_try(&rv_react_map);
>> +	lock_map_acquire_try(map);
>>   	monitor->react(msg, args);
>> -	lock_map_release(&rv_react_map);
>> -
>> +	lock_map_release(map);
>>   	va_end(args);
>>   }
>>   EXPORT_SYMBOL_GPL(rv_react);
> 
