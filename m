Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637148;
	b=reE+bPaMkMZ8l/mgv7pZfXZADOUgdo4ISZ5MIuF38MZECL+ciSkZnFjvy1DmE77Il58q
	 4+rEI/9DFSe9uV36ohf9DmhMgHgZmw58wkBa9gNRmNiI/nMGo+iB0IrtAgdql1OamRbvd
	 hK4WP7vuw/6v5ihyUtSw0QOMd2gMkqd0e34dBJQcShxkhdywFAHs1yEUKIp3AkaDePnqU
	 x+YBP7pyVOQWD0OZJwSNtnhM0B5IagOIN6g1uobz5tZO9+rT9Aadkt9F+i5u5JfFO3xBI
	 3uZHrhHYhHkiY4F2csraOq5vVfhoCqSFz7ksLu7Z/X7mytfsWNYbrcjXbqPjgjD91hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637148;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=I2DcIW001sUYVfzNlJQeVBewOygtd2GgakfGiD8PY+M=;
	b=tSq6CFwawWhB9ECXy+yh5QAeKmOS8Fg2bYo275fOH2/nF3a6nMRHwqXxWlXsS88MHOX7
	 M6HrpfFOsA8o/jkuREtW4XOCw6R2ePDFsUAKdaD2lk7Iqb2LpbEOVqw+ZuGx2RC7IJpTM
	 45oikTMQ657apIiQDwDqubfJpHL88lIu01TeU3x5Eq11JeBlHqb/ohSEBOlFAMRYHaabn
	 p6ofVo5ztVZvAm9KO/RmvUhBRZcERr+7hkjwlMH/w2SHImhEiNc5WWWI5xmVZdwnTuEih
	 wiL1rVrmme54r+hEwaXZ4+5tbQ/vZHArWccsIaUMYJSG3yAoOc5/qngovEv6mJpVEEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vW5f75lY;
	arc=none smtp.remote-ip=91.218.175.130
Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7EA6072EE1
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Nov 2026 16:32:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E7EA6072EE1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vW5f75lY
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cMQd7ViTEEFLx21Upc27tT5FD51v8xytsO/TzIbpq/Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793637144; v=1; x=1794241944;
 b=vW5f75lY3uvwR6vtyN4jMAiR3ZGYHp4XmhktZZtRb7heFqmmGVd/+GHTe91uOlvftWfQxUuz
 5y45N2G5f/OplEFKtvM2MD0zSaUHbtMdpy/nbWAI4t/ve+TBmEdKaFpiayC08c/dWQ57jPVbJau
 E5O557Zdl3lZY02EyDt/i0hQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e5fc46e4f632b820;
	Mon, 02 Nov 2026 16:32:24 +0000
X-Mizu-Trace-ID: e5fc46e4f632b820
X-Migadu-Flow: FLOW_OUT
Message-ID: <e2cab3ba-e363-4d21-ab44-c009476f61f2@linux.dev>
Date: Tue, 3 Nov 2026 00:32:17 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/14] rv: Add task latency over budget RV monitor
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1791745088.git.wen.yang@linux.dev>
 <3eb0948c9ca67f64b3b311f823cd0f7628033c68.camel@redhat.com>
 <6a8b5d26-37cc-4a8f-ab1d-0df2c2e6c2d3@linux.dev>
 <8e13471b64e11218cab612e7662e8068c34e1219.camel@redhat.com>
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <8e13471b64e11218cab612e7662e8068c34e1219.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/20/26 23:30, Gabriele Monaco wrote:
> On Tue, 2026-10-20 at 03:18 +0800, Wen Yang wrote:
>>
> 
>>> there's been a conversation at the LPC conference about completely migrating
>>> RV
>>> to BPF.
>>> While we aren't sure of its feasibility yet, and it will take time, it's
>>> something to keep in mind for new contributions.
>>>
>>
>> Understood, and I have been following that direction.  I spent the last
>> few days reading the v2 "rv: Add support for BPF monitors" series in
>> detail, so the comparison below is against that code rather than the
>> general idea.
> 
> Great, I'm going to review your series when I get some time.
> 
>>> First of all, would dropping RV in-kernel support negatively affect your
>>> current
>>> workflow?
>>>
>> Yes, it would.  Some concrete points, all from the current tree.
>> (a) Event ABI.  event_da_monitor / error_env_* in
>>       kernel/trace/rv/rv_trace.h are plain tracepoints, so trace-cmd,
>>       perf and anything else reading tracefs consume them today with no
>>       extra userspace.  The BPF series delivers events through a ring
>>       buffer read by the rv tool, so the two backends are not
>>       interchangeable for existing consumers.
> 
> Good point, you might have noticed a similar discussion is happening also on the
> RV-BPF thread. We cannot have the absolute same ABI in BPF, but we probably need
> tracepoints or anything that can easily interact with other tracing tools.
> 
>> (b) Build and deployment.  On the images we target, BPF is often not
>>       compiled in or not permitted:
>>         CONFIG_BPF_SYSCALL            default n
>>         CONFIG_BPF_EVENTS             needs BPF_SYSCALL
>>         CONFIG_DEBUG_INFO_BTF         needed for CO-RE; depends on
>>                                       !DEBUG_INFO_REDUCED and pahole
>>         LOCKDOWN_BPF_READ_KERNEL      disables the probe_read helpers
>>       Those are product constraints, not local build issues.  tracefs/RV
>>       works in all of these configurations.
>>
>>       There is also a size cost: BPF implies CONFIG_DEBUG_INFO_BTF, and
>>       .BTF is resident in RO_DATA and kept in the boot image - about
>>       5 MB uncompressed on a full kernel, 1.2-1.6 MB compressed, plus
>>       roughly 25% per module with DEBUG_INFO_BTF_MODULES.  On a
>>       16-32 MB kernel partition that matters.
>>
> 
> I've vaguely heard automotive folks saying they don't want to build BPF support
> several times. Finally I get a proper technical reason!
> 
> Now I think this isn't easy to sort out, if that's a hard requirement, we are
> probably going to need to keep in-kernel monitors around.
> 
>> (c) Timing semantics.  tlob arms a per-task hrtimer with
>>       HRTIMER_MODE_REL_HARD.  bpf_timer is fixed to
>>       HRTIMER_MODE_REL_SOFT and the verifier states "bpf_timer callbacks
>>       are never sleepable" .  On PREEMPT_RT the callback runs in a
>> threaded
>>       softirq, so the expiry time carries scheduler latency.
> 
> I haven't looked into this yet, but from what you say, the bpf_timers code
> doesn't really support PREEMPT_RT.
> 
>>       For a budget monitor the expiry time is the output, so this is a
>>       semantic change, not just overhead.
> 
> Well, the expiry time you get from an hrtimer is what you configured + some
> system jitter. The jitter here is just going to be less predictable but is it
> really the output you need in your monitor?
> Or am I missing your point?
> 

Hi Gabriele,

Thanks for the feedback.

For tlob, the primary goal is detecting deadline overruns on the order 
of milliseconds or sub-milliseconds (e.g. 10 ms budget).
Under HRTIMER_MODE_REL_SOFT on PREEMPT_RT, the timer callback runs in a
threaded softirq (ksoftirqd or threaded irq context).  If the system is
under CPU or scheduler pressure, the softirq latency itself can easily 
add several milliseconds of unpredictable delay.  When that happens, it
blurs attribution: users cannot distinguish whether the monitored task
exceeded its budget, or whether the task finished on time but the timer
callback was delayed in the scheduler queue.  HARD hrtimer avoids this 
by firing directly in hardirq context at the physical deadline.

>>
>>       What a BPF tlob would look like once those exist:
>>         - model: still tlob.dot, with rvgen -b extended to the hybrid
>>           backend;
>>         - state: one record per task in BPF_MAP_TYPE_TASK_STORAGE (or
>>           the per-object hash map the series has today), holding the
>>           state, the binding id and the budget;
> 
> Yeah I wasn't aware of BPF_MAP_TYPE_TASK_STORAGE before, I have a draft V3
> (coming some time after the merge window) using that.
> But I'd assume this type of storage would simplify the design of your monitor,
> which is currently using a PER_OBJ just to add more things to a PER_TASK.
> I'm going to keep in mind your use-case where you essentially extend the storage
> (which is perfectly fine in BPF since we don't use the task_struct slot).
> 


Thanks.
On the in-kernel side, your DA_OBJ_EMBEDDED_TYPE PoC delivered
the exact same simplification.

In v8, we adopted DA_OBJ_EMBEDDED_TYPE so struct tlob_record is embedded
directly into struct da_monitor_storage:
- Deleted the private mempool and custom allocator entirely; tlob now
   relies 100% on the framework pre-allocated pool.
- Deleted the parallel state machine (OPEN / CLOSED / RETIRED) and
   tlob_binding_lock.  The window lifecycle is now driven purely by the
   automaton states (stopped, running, waiting, sleeping).
- Overall, tlob.c shrunk from ~1065 lines to ~660 lines (-38%), with no
   locking on the scheduler hot path.

We are currently testing and will send out v8 soon.

--
Best wishes,
Wen


>>         - window: two uprobe programs attached to PATH:START and
>>           PATH:STOP, with the binding id and budget passed through the
>>           attach cookie or a small config map populated before load;
>>         - expiry: a bpf_timer in the same record, armed on state
>>           transitions and cancelled on STOP, submitting an error entry
>>           to the monitor's ringbuf;
>>         - output: the rv tool reads the ringbuf and prints it, and the
>>           reactor is linked in with bpf_linker as v2 already does.
>>
>>       The DA engine and the ringbuf/reactor plumbing would carry over
>>       unchanged.  The three missing pieces are the uprobe
>>       attach/configuration path, the timer and env handling in
>>       da_monitor_bpf.h, and the hybrid backend in rvgen.
>>
>>       None of this argues against migrating.  It argues that the BPF
>>       backend has to reach parity on (a)-(c) before the in-kernel path
>>       can be removed.
>>
> 
> 
> Thanks for taking time to assess this, it looks like the right direction.
> 
> Gabriele
> 
