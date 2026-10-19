Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437542;
	b=41fK6Z2MztXlCfU//kGFaDUe0r5YUo8OlTyqJjUw/p4GFQ8pAH4RpgEAfrYO1DZFzAvu
	 ptrCTTQQ8j8Eg7EAVYqDs6lVUNzXaeBEupnu6aBjqK71avbKsiTdwjfGRvV7XyU3FgEI9
	 OAW+CcSR6z9zLQwBjVqya429nsLnyDKa/W8vmTMiW7B2rY+odaKEkBVnsMBI9xRKLDH5V
	 55yxpfnLRPc5z+zkUNcjm3XRyxbO6HAjo4oVYg1sQjxjPLoV/0MgCyLnfnHvNdwGb+2hl
	 wbLaF9DIIfvWEHYZ8usloBbSj8BJM2A/iH2Ip0cVbkyeIA1WkaJl6xL9vZnzENeYyhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437542;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=6N83DX9WwUZiCR3ZtEtO7doNLGg+fhf8sCF/HzTeO3s=;
	b=rdxPtcP9JE6WgNO+tdvNzzFLSzCMAjLxQ7RP1VlnUWH0nVLlwMlge/C2hjeoMuZf0Yso
	 yxqllPwsoIAGxP5bc/kgYV4hcqbYlfIC4OlvJfME3DXEE0SqptbzvJtNPillQESZYLqta
	 bhlxf9UWryqgbdSgFMD4oOvygFN3NfOeK35mWStTYifDA4DzMzxJJV0S41/oZjJMaYCtN
	 qkTi94+7CG/wEXvCahJjabTz9mTekwwsPOI4cFJ04AQreZQqqZEtvGtNe0DgK0NsS7oao
	 5QcoywRYjExc4HLIkh5DwrG5q9D/ZQsxJG/qEW8rNZjooS3eLixa8TYXHT/oAKo/gcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VvinA00w;
	arc=none smtp.remote-ip=91.218.175.123
Received: from mta0.migadu.com (out-123.mta0.migadu.com [91.218.175.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A6606A331
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 19:19:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57A6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VvinA00w
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=vPWQYegsPo9BFyvK2QoSWgjiaxWxLi0QeZC8zrU5K7s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792437538; v=1; x=1793042338;
 b=VvinA00wvwCpJyad3+Di9pmqAAF40v74nqUI07URlq4q01lTGkgpP5OI5KoKI1LBs9/QIoDC
 zuo8WrTDvDGcDp6BPThd577nPasRyv2Q2erTkkq1DoCExq36xtyDFAgqqwlmqiYQ1sWEQaCvOp8
 EGX9p053av4f1VeEAA7G8Yd0=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e4a0f783e38dc997;
	Mon, 19 Oct 2026 19:18:58 +0000
X-Mizu-Trace-ID: e4a0f783e38dc997
X-Migadu-Flow: FLOW_OUT
Message-ID: <6a8b5d26-37cc-4a8f-ab1d-0df2c2e6c2d3@linux.dev>
Date: Tue, 20 Oct 2026 03:18:48 +0800
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
Content-Language: en-US
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <3eb0948c9ca67f64b3b311f823cd0f7628033c68.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/26 19:58, Gabriele Monaco wrote:
> On Mon, 2026-10-12 at 03:39 +0800, wen.yang@linux.dev wrote:
>> From: Wen Yang <wen.yang@linux.dev>
>>
>> This series introduces tlob (task latency over budget), a per-task
>> hybrid automaton RV monitor that measures elapsed wall-clock time across
>> a user-delimited code section and emits an error when the elapsed time
>> exceeds a configurable budget.
> 
> Hi Wen,
> 
Hi Gabriele,

Thanks for the context.

> there's been a conversation at the LPC conference about completely migrating RV
> to BPF.
> While we aren't sure of its feasibility yet, and it will take time, it's
> something to keep in mind for new contributions.
> 

Understood, and I have been following that direction.  I spent the last
few days reading the v2 "rv: Add support for BPF monitors" series in
detail, so the comparison below is against that code rather than the
general idea.


> First of all, would dropping RV in-kernel support negatively affect your current
> workflow?
>
Yes, it would.  Some concrete points, all from the current tree.
(a) Event ABI.  event_da_monitor / error_env_* in
     kernel/trace/rv/rv_trace.h are plain tracepoints, so trace-cmd,
     perf and anything else reading tracefs consume them today with no
     extra userspace.  The BPF series delivers events through a ring
     buffer read by the rv tool, so the two backends are not
     interchangeable for existing consumers.

(b) Build and deployment.  On the images we target, BPF is often not
     compiled in or not permitted:
       CONFIG_BPF_SYSCALL            default n
       CONFIG_BPF_EVENTS             needs BPF_SYSCALL
       CONFIG_DEBUG_INFO_BTF         needed for CO-RE; depends on
                                     !DEBUG_INFO_REDUCED and pahole
       LOCKDOWN_BPF_READ_KERNEL      disables the probe_read helpers
     Those are product constraints, not local build issues.  tracefs/RV
     works in all of these configurations.

     There is also a size cost: BPF implies CONFIG_DEBUG_INFO_BTF, and
     .BTF is resident in RO_DATA and kept in the boot image - about
     5 MB uncompressed on a full kernel, 1.2-1.6 MB compressed, plus
     roughly 25% per module with DEBUG_INFO_BTF_MODULES.  On a
     16-32 MB kernel partition that matters.

(c) Timing semantics.  tlob arms a per-task hrtimer with
     HRTIMER_MODE_REL_HARD.  bpf_timer is fixed to
     HRTIMER_MODE_REL_SOFT and the verifier states "bpf_timer callbacks
     are never sleepable" .  On PREEMPT_RT the callback runs in a 
threaded
     softirq, so the expiry time carries scheduler latency.
     For a budget monitor the expiry time is the output, so this is a
     semantic change, not just overhead.

     What a BPF tlob would look like once those exist:
       - model: still tlob.dot, with rvgen -b extended to the hybrid
         backend;
       - state: one record per task in BPF_MAP_TYPE_TASK_STORAGE (or
         the per-object hash map the series has today), holding the
         state, the binding id and the budget;
       - window: two uprobe programs attached to PATH:START and
         PATH:STOP, with the binding id and budget passed through the
         attach cookie or a small config map populated before load;
       - expiry: a bpf_timer in the same record, armed on state
         transitions and cancelled on STOP, submitting an error entry
         to the monitor's ringbuf;
       - output: the rv tool reads the ringbuf and prints it, and the
         reactor is linked in with bpf_linker as v2 already does.

     The DA engine and the ringbuf/reactor plumbing would carry over
     unchanged.  The three missing pieces are the uprobe
     attach/configuration path, the timer and env handling in
     da_monitor_bpf.h, and the hybrid backend in rvgen.

     None of this argues against migrating.  It argues that the BPF
     backend has to reach parity on (a)-(c) before the in-kernel path
     can be removed.

> About this series, completely converting it to BPF isn't trivial, I can keep on
> reviewing it and we could upstream it in-kernel, then convert it later (together
> with the work with other HA).

That is the order I would like to take.  The series is already split so
that a later conversion only replaces the tlob-specific part:

   1-5   framework fixes, independent of tlob and needed regardless:
         - HA environment reset on monitor start (Patch 1)
         - HA timer remainder / invariant underflow (Patch 2)
         - HA timer still queued on storage freed via RCU (Patch 4)
         3 and 5 are their KUnit coverage.
   6-8   small extension points tlob needs, but generic: overridable
         reset hook / EVENT_NONE_LBL, the per-object allocation
         strategy, and da_extra_cleanup.
   9-13  uprobe wrapper and tlob itself (DOT model, monitor, KUnit,
         verification selftests).
   14    ftracetest: find test.d/functions from a nested test
         directory.  Generic, not tlob-specific.

Could we merge the whole series now rather than staging it:
   - 1-5 fix live bugs and should not wait for an unrelated design
     decision;
   - the BPF work needs the model in tlob.dot and the tracepoint fields
     in rv_trace.h as a concrete reference now, rather than being
     designed twice;
   - 9-13 are self-contained - one monitor and its tests, plus no shared
     framework beyond the small hooks in 6-8 - so accepting them does
     not commit the framework to anything that would make the later
     conversion harder.

When the BPF backend reaches parity on (a)-(c), 9-13 are replaced
without touching 1-8 or 14.


> But I'd prioritise not affecting the in-kernel implementation much to keep it on
> par with the BPF one.
> 

Agreed, and that is why 6-8 are deliberately small and generic, and why
the monitor keeps the same model/event contract as the BPF path instead
of growing in-kernel-only semantics.

> I'd first like to focus on what should the rv userspace tool support for a
> monitor like yours to be useful. You'd have all reporting as stdout (or any BPF
> reactor you'd want to write), then we should probably support some way to set
> the uprobe location and threshold before loading.

Reporting already works: `rv mon -t tlob` creates a trace instance and
prints event_tlob / error_env_tlob through ikm_event_handler() and
ikm_error_handler(), so a BPF backend could feed the same output.

The missing piece is pre-enable configuration.  Proposal:
   rv mon tlob --uprobe PATH:START:STOP[:threshold=NS]   (repeatable)
   rv mon tlob --list-uprobes
   rv mon tlob --budget NS            default for bindings without one
   rv mon tlob --summary              per-pid counts instead of transitions
The tool would write the monitor file before enabling.  tracefs stays
the low-level path for scripts and tests, as uprobe_events coexists
with perf.


> Would you really need dynamic uprobe addition?
> 
Minimum: bindings configured before enable.  That covers the normal
case, including restarting the target, because a binding is per
path+offset, not per pid.

Live add/remove is what makes the code large: quiesce/reap of in-flight
windows, the TLOB_RETIRED claim, concurrent add/remove versus handlers,
and shadowed-binding reporting when two ranges match one task.  If you
want the smaller interface, I will require configuration while the
monitor is disabled and keep only the teardown needed for disable and
unload with live tasks; uprobe_unbind_live, uprobe_disable_live and
uprobe_multi_instance then move to the tool's restart flow.


> What do you think?
> 

If you're OK with it, I'd suggest merging the series in-kernel now, with 
1-8 and 14 kept as the shared infrastructure and 9-13 acting as the 
reference implementation the BPF backend is measured against. I'd be 
glad to help with the uprobe and timed-HA pieces on the BPF side once 
they're on the table.


Thanks,
Wen


