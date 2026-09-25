Received: from mta1.migadu.com (out-14.mta1.migadu.com [95.215.58.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49613655DA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 02:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790303522; cv=none; b=ElHO2+CVr25Na6TuyqU6JcEEbbu1k1/03fW5Imz1AToCrYqQkktQzt37R/xRARHkVLDZ1pl513sCbKh6XqSairRJ26lLFGm9200CmAtAd3O5M56D5TdU3JqCwxVKCvqoS7Wo2fbCH+JcLhu9TxllCECC5epA8JNG56fyEBMO5ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790303522; c=relaxed/simple;
	bh=bZu+je2JPfwqaqOgA9/4AMv6G5hJNl0/HQ6PG7g9Ao4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INtZu28qZG+BxxvEBfh5F+mSEjD92teBKIzt1JCPBWNajr2wm7g1ax6Nhi5J27MnNHyegv2daWeML2ApoMvvYXKmNvsZv3jVeAtgKh8nTpP2Cxt1TmU8lUKtaGgLgZCc0dNPuGu2+q8j8pXQ2lOhRcAdfA20V3fAOhCcNPp+azw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ALgpCI9G; arc=none smtp.client-ip=95.215.58.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ALgpCI9G"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=bZu+je2JPfwqaqOgA9/4AMv6G5hJNl0/HQ6PG7g9Ao4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790303517; v=1; x=1790908317;
 b=ALgpCI9Gsrm+AIva2V46+IEmNz1S7Qj6OcwMNjjxBRqwkrRNKP+XhESUW4PEsmcXJsa8I4gP
 cLbDkLRpKcPPzGDOMVHZquSXnmZ/bpKREUDvl4w6dmnJW2lUm0Tw3Io3o7ozIRZ+82PeMnvxz7s
 IWbOIS8geVWQX4BdPjlYVZVQ=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 25c6c3f62ed55be0;
	Fri, 25 Sep 2026 02:31:57 +0000
X-Mizu-Trace-ID: 25c6c3f62ed55be0
X-Migadu-Flow: FLOW_OUT
Message-ID: <1cffebd0-57b3-4e59-8595-37a0e157b2a2@linux.dev>
Date: Thu, 24 Sep 2026 19:31:53 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] tracing: fgraph: cut the cost of the shadow stack
 retry loop
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
 <20260924164512.451a5d97@fedora>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20260924164512.451a5d97@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 13:45, Steven Rostedt wrote:
> Just an FYI. My wife flew into Europe today and I'll be touring Europe
> with her until Oct 3rd. I may get time to look at patches, but it will
> be very limited. And then LPC starts and who knows when I'll get a
> chance.
>
> Thus I may not be very responsive for the next couple of weeks.

Thx for the reply Steve. I understand it is that time of the year with 
travels and such.
No rush, just wanted to push it out of mailbox, to yours :-)
Besides it might all be moot as Peter's solution is much more elegant 
and efficient (as always).
I will reply to that but don't feel pressed to respond.

Thx,
-Vineet

>
> -- Steve
>
>
> On Tue, 22 Sep 2026 15:55:24 -0700
> Vineet Gupta <vineet.gupta@linux.dev> wrote:
>
>> Turning on function-graph tracing, or attaching a kprobe_multi return
>> probe, hands every thread a shadow stack. alloc_retstack_tasklist()
>> does that 32 tasks at a time, and since for_each_process_thread() has
>> no cursor, every sweep restarts from init_task and re-walks the tasks
>> already served. Total work is quadratic O(N^2) on thread count.
>>
>> On a 60-core Sapphire Rapids machine with 400000 idle threads the 0 -> 1
>> transition takes 227 s, inside a single bpf() syscall for the kprobe_multi
>> case. On Meta fleet this showed up as RCU stalls and softlockup panics.
>>
>> Patch 1 raises the batch to 1024, dividing the sweeps by 32:
>> 227 s -> 7.2 s at 400000 threads. It helps on every preemption model.
>>
>> Patch 2 adds a cond_resched() between sweeps. It is supplementary and
>> separable: a no-op on current x86 and arm64, but on !CONFIG_PREEMPTION
>> builds it takes soft lockups from 3-of-3 runs to 0-of-3. Dropping it
>> leaves patch 1 intact.
>>
>> Neither changes the O(N^2) shape; a cursor-based walk would, but
>> task_struct lifetime makes that considerably more involved.
>>
>> Vineet Gupta (2):
>>    tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE to 1024
>>    tracing: fgraph: Add a cond_resched() to the shadow stack retry loop
>>
>>   include/linux/ftrace.h | 7 ++++++-
>>   kernel/trace/fgraph.c  | 8 ++++++++
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>

