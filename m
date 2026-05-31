Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE991BD9D0
	for <linux-trace-kernel@vger.kernel.org>; Sun, 31 May 2026 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780239311; cv=none; b=f94gy29SW3e+fan8uI16wwWphzuupdh3HTPRg3/q/1rp/NwXa18bFOEA/ELxUsykgjboF3OdTCOYRs8vgshy3xtIMSJwhMc5cfDDEkPYKqpwB3d59MMYeDmH+7Ujjj4197Kth/wriiPCDJYmBMS81i1y4D9btI3cmVwpm+NSrKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780239311; c=relaxed/simple;
	bh=ZT4wCnLFof/n6IUSu8/dAC5BN6m5+53EL1kyd2NApdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SAUaq/yan+Jhtcf5yzbkoaOYh+M7B+KmljoV5U3EKbSOx8h1jepp/ILpHmnDKENSFchP9Qe/7nA6UKg1lLyihHL8jma+h8FSjbQ3cLb3M/1YEZHJyYqdaafLXLRvZz4LVXa/KTBzawIG1AKyHF5ci194Kpj56n8hKgyHpA1myoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vn528AU7; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vn528AU7"
Message-ID: <13e7a713-3fd8-4180-9336-e6bcc11872d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780239298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7OGdVGcXpjpfNjeoR3WSYOIj7ymQoVulH7Dhp5L+x8=;
	b=vn528AU7HMcYXsbM4GEOsXcmsfHG1AphWEp+Jo8K5cwngNeznX0nLsqX03fXlTU/4s66k2
	GwRIFRe5JFqfBmLUXEZMXVmt+96YAL6gX5Zb0ussW76wzIqGRLThcwT7Yb9xE8001D+6wm
	+S75OyrN0D1AC8mxgn/MLFqR5IOUuTM=
Date: Sun, 31 May 2026 22:54:28 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/12] rv: Fix monitor start ordering and memory
 ordering for monitoring flag
To: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org
References: <20260527062313.39908-1-gmonaco@redhat.com>
 <20260527062313.39908-8-gmonaco@redhat.com> <877bonoq70.fsf@yellow.woof>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <877bonoq70.fsf@yellow.woof>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/28/26 17:09, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> da_monitor_start() set monitoring=1 before calling da_monitor_init_hook(),
>> may racing with the sched_switch handler:
>>
>>    da_monitor_start()               sched_switch handler
>>    -------------------------        ---------------------------------
>>    da_mon->monitoring = 1;
>>                                     if (da_monitoring(da_mon))  /* true  */
>>                                         ha_start_timer_ns(...);
>>                                         /* hrtimer->base == NULL, crash */
>>    da_monitor_init_hook(da_mon);
>>    /* hrtimer_setup() sets base */
>>
>> Fix the ordering and pair with release/acquire semantics:
>>
>>    da_monitor_init_hook(da_mon);
>>    smp_store_release(&da_mon->monitoring, 1);    /* da_monitor_start()  */
>>    return smp_load_acquire(&da_mon->monitoring); /* da_monitoring()     */
>>
>> On ARM64 a plain STR + LDR does not form a release-acquire pair, so
>> the load can observe monitoring=1 while hrtimer->base is still NULL.
>> The plain accesses are also data races under KCSAN.
>>
>> Use WRITE_ONCE for the monitoring=0 store in da_monitor_reset() to
>> cover the reset path.
>>
>> Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor definition via C macros")
>> Signed-off-by: Wen Yang <wen.yang@linux.dev>
>> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> 
> Looks correct to me.
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> 
> Wen, I am curious, how did you find this issue?
> 

It was caught during development of the tlob monitor by a KUnit test 

(since moved to selftests) that monitored a kthread running concurrently 

on another CPU.  On a multi-core box the window between setting 

monitoring=1 and da_monitor_init_hook() was wide enough to trigger the 

crash, and KCSAN flagged the plain monitoring accesses as data 
                                                races as well.

--
Best wishes,
Wen


