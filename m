Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7183E1227
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845095; cv=none; b=sba9oM/CU7/G6vpxHgH06zpJDj+WcksszSW+bgFyXZ1C9uDtag4pcb2mmMEfHQudpvDCRIufOl5RsPbL3LMHcrmeAeUcSXP1SiKVppWIA2j9aIvQs8iT72SG8ANNnfIXaistsE857jBpw394VWKHpD1L6re8BR2brI4GkZ2URkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845095; c=relaxed/simple;
	bh=EBAwhDMsQpQ3/oIE4IwMkyRqOLKzwgNV+sBSaxiGlA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eh4d0aEcJ3eyFsx/Fddsm3ky0Im2ZqxStlkEHmEO+MiKPTiwdRTJblXAc8lMx+5xZ5Zgh2Ls0FPR2SWmzqvq2TzUAgSHUGTBhA+lt/8fE1/M8Ti2QatjgH7R8oXwdYktVSLroUSvghx/HPyQkWFIOvh7ndqIwDYqPK1bKxuJ7zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=voX65xFz; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="voX65xFz"
Message-ID: <d1e84072-7968-4a64-9497-09db83b38682@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782845090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K4NYnx5uGWF22xzblo3NCre+Z11/WlXt9QQym/OQ8LQ=;
	b=voX65xFzphQAoQK4qpPpuS9U8NMm6rliuA219upmY+p+Lf/lukJmc+ZVDsXUGuDzEZ7h1S
	ynZi2+wifyr1cVF/WzlGrXolgO/XU2yUtTO6oG3pvqeEEPezPv1XfBaGhyzPVDSbpU2S1v
	wwCQ9DOmV5DBdpGr37aCpBjs3oUA3PA=
Date: Wed, 1 Jul 2026 02:44:45 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/9] rv: add generic uprobe infrastructure for RV
 monitors
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1780847473.git.wen.yang@linux.dev>
 <9d1a1d491af16853b2b421f358fd6cca965588ab.1780847473.git.wen.yang@linux.dev>
 <a645534b04d9bf32f2c2caa5d2206bb87cfcb3e1.camel@redhat.com>
 <878be1d4-2f93-4fbd-a1f6-b2b7836c9c44@linux.dev>
 <ebde84b7c65cd6b01a1e8d124de0b1eaf0793006.camel@redhat.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <ebde84b7c65cd6b01a1e8d124de0b1eaf0793006.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 6/30/26 16:48, Gabriele Monaco wrote:
> On Mon, 2026-06-29 at 00:47 +0800, Wen Yang wrote:
>> On [2-1]~[2-5]: embedded consumer causes UAF on PREEMPT_RT
>> -----------------------------------------------------------
>>
>> The uprobe_bind selftest oopses on PREEMPT_RT(full):
>>
>>     handler_chain+0xc9: mov rax, [r15+0x18]  ; advance list iterator
>>     RAX: 000015ec00001f28   ; garbage — &uprobe->consumers after kfree
>>
>> handler_chain() reads uc->cons_node.next after uc->handler() returns,
>> still inside rcu_read_lock_trace().  That pointer is &uprobe->consumers
>> (the list head embedded in struct uprobe), which gets freed through:
>>
>>     put_uprobe()
>>       -> schedule_work(uprobe_free_deferred)   /* async */
>>          -> call_srcu(&uretprobes_srcu, ...)
>>             -> call_rcu_tasks_trace(kfree_uprobe)
>>                -> kfree(uprobe)
>>
>> rv_uprobe_sync() calls uprobe_unregister_sync() which calls
>> synchronize_srcu(&uretprobes_srcu), but that only matters after the
>> kworker has submitted work to uretprobes_srcu.  On a loaded PREEMPT_RT
>> box the kworker may not have run yet, so synchronize_srcu() returns
>> immediately and kfree(uprobe) races with the still-iterating
>> handler_chain():
>>
>>     CPU A                                CPU B
>>     consumer_del() → list_del_rcu        rcu_read_lock_trace()
>>     put_uprobe()   → schedule_work         uc->handler() returns
>>     rv_uprobe_sync():                       reading cons_node.next...
>>       synchronize_srcu(&uretprobes_srcu)
> 
> If CPU B is in an RCU trace read-side critical section this doesn't
> return immediately, it returns after readers are done, doesn't it?
> (well, what you really care here is the synchronize_rcu_tasks_trace()
> but we do both).
> 
>>       ← idle; returns immediately
>>     [kworker fires later]
>>       kfree(uprobe)  ← frees &uprobe->consumers
>>                                           cons_node.next = freed mem → CRASH
>>
> 
> So I had a bit of a look and as far as I understand, we don't have any
> control over the uprobe allocation pattern (workqueues and whatnot) and
> we don't really care as long as we deregister it appropriately.
> 
> What we do control is the uprobe_consumer, that must be freed only after
> the uprobe was synchronously deregistered, that should guarantee no
> reader is going to reference it, shouldn't it?
> 
> uprobe_unregister_nosync() removes it from the cons_node list, so it's
> safe to assume any handler_chain() after the next RCU-trace grace period
> won't see it.
> 
> In the sketch I sent this is happening (all kfree(b) are after
> rv_uprobe_unregister() which does the sync). What am I missing here?
> 
> 
> uprobe is also freed after both grace periods, so no reader should use
> that either.
> 
> The situation you're seeing isn't fully clear to me, I applied my sketch
> and don't see any splat on a vng box.
> 
>> With uc embedded in the binding (as [2-1] suggests), no amount of
>> delaying kfree(binding) helps: uprobe->consumers is freed by a chain we
>> don't control.  The fix is to keep uc->cons_node in memory that outlives
>> the handler_chain() iteration, which means a separate allocation freed
>> only after rv_uprobe_sync():
>>
>>     rv_uprobe_unregister_nosync()  /* list_del_rcu + schedule_work */
>>     rv_uprobe_sync()               /* waits for any already-submitted
>> srcu work */
> 
> We of course need to do any free after this sync, but I don't get why we
> need an additional allocation since the following are both plain
> synchronous frees, why isn't a single one (on b) enough?
> 

Thank you for the patient explanation.
You are right, and v4 implements the embedded approach.
struct rv_uprobe directly embeds struct uprobe_consumer:

   struct rv_uprobe {
       struct uprobe_consumer  uc;
       struct uprobe          *uprobe;
       struct inode           *inode;
       void                   *priv;
       int (*handler)(...);
       int (*ret_handler)(...);
   };

rv_uprobe_free() is gone — no allocation means no explicit free.  After
rv_uprobe_unregister() (or rv_uprobe_unregister_nosync() + 
rv_uprobe_sync()), the caller frees the containing struct directly.  In 
tlob:

   rv_uprobe_unregister_nosync(&b->start_probe);
   rv_uprobe_unregister_nosync(&b->stop_probe);
   rv_uprobe_sync();
   kfree(b);   /* frees both embedded consumers */

This is the pattern from your sketch.

Regarding my earlier reply that argued for the separate allocation: I 
was wrong. The key barrier is synchronize_rcu_tasks_trace() (called 
first in uprobe_unregister_sync()), which waits for all 
rcu_read_lock_trace() readers including handler_chain().  After it 
returns, no cons_node.next read is in flight and embedding is safe.

We appreciate your thorough review. All of your comments have been 
addressed in v4.
We'll run local tests for one or two days, and then it will be sent out 
shortly.

--
Best wishes,
Wen


