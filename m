Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A515396587
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615072; cv=none; b=s0a3bsiXmcwagTx24nZXW8JJbFgAxVKbxHKgxy6SO7aij0emukPLyM7Qh8oeauQyE6S3Kl2bBgyxNEVRCr8nxIfwPqXvSyl46Nfj527BHCG8zPjjlm9FAbxNYyDUAcKyMm8SLHJGiGtPm+d2Q+/FnfYDJjW3fLMI8D0+3N9NvhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615072; c=relaxed/simple;
	bh=5MQPiO1wTJMLsFP0C/BxMo/zUUn1c6tWFdw1xLKaZHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U0fekde61XUukQ+yGtEIV5tKUAFyV7ZMoY2mTkKremezHHtTv6Cd33hPs4jRq0ZNh/6CJf1RqfO3e4E1Wjy0Hl8tCkZqR28emygLqPGUPjK0KhF45hCet6yakjluU5lGoHeFcb26XkxjJoL8Zwx5vqSbFn3PXA9i1hurtvO0Gv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oqRpAleq; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oqRpAleq"
Message-ID: <397cea12-e0ba-4cf5-a411-26f44bc17d01@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783615067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kH1X0cSd/Ei4lOYRMpCOeyTmVtOq360EQdFXbcEO7e0=;
	b=oqRpAleqW6R4MUd/rPCufTq5FoD8n5Iyze8tvw9ZTkBwgP+G8XMEmkyJ6eKVeKrv7UBNxb
	7q1IyF98zM6pM6zjDnNi9ceDlBkSCXAaoz7vfsEfYgFBKHzshIsF4bx/QcFgE8KSk1Q/Vm
	SJksJjHuzUCy5UqkAWuSCBmsx4kCUn8=
Date: Fri, 10 Jul 2026 00:37:36 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] rv/reactors: fix lockdep "Invalid wait context" in
 rv_react()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1781541556.git.wen.yang@linux.dev>
 <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
 <20260623112942-4943fc6a-c1d5-4eed-a91f-66b3a034caa7@linutronix.de>
 <3c53f741559f834986e976b524c5ded90bbd5627.camel@redhat.com>
 <20260708174123-e5f98837-3d81-43ca-8ede-bb5f09e8ffba@linutronix.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <20260708174123-e5f98837-3d81-43ca-8ede-bb5f09e8ffba@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/8/26 23:47, Thomas Weißschuh wrote:
> On Mon, Jul 06, 2026 at 04:02:08PM +0200, Gabriele Monaco wrote:
>> On Tue, 2026-06-23 at 11:38 +0200, Thomas Weißschuh wrote:
>>> This now allows reactors to take (raw) spinlocks. The original idea was
>>> to not allow that as a reactor can be called from LD_WAIT_FREE context.
>>> So I am not sure this is the right fix. Not that I have a better one
>>> available right now.
>>
>> As far as I understand it, LD_WAIT_FREE is fairly impossible to apply on
>> preemptible code (here we see it hit by an interrupt).
>>
>> Since we kind of have to allow raw spinlock to avoid this (even if we don't take
>> them explicitly), why wouldn't a reactor ever be allowed to take raw spinlocks?
>>
>> Technically it wouldn't be wrong to take locks from RV monitors, although most
>> monitors don't do it explicitly.
>> If we ever happen to take the wrong lock explicitly from a reactor triggered by
>> a nasty event (e.g. sched_switch), I believe lockdep would still be complaining
>> down that path, so we probably don't need to be too strict in rv_react().
>>
>> Obviously we don't want to disable interrutps for LD_WAIT_FREE to hold either.
>>
>> Am I missing something?
> 
> No, I was just very confused.
> Let's go ahead with this.
> 
> 

Hi,

How about a context-sensitive approach, eg:

   NMI/hardirq (interrupts masked, scheduler cannot run):
     Keep LD_WAIT_FREE.  The false positive cannot arise in this path,
     and the original constraint against raw spinlocks is preserved where
     it is meaningful.

   task/softirq/PREEMPT_RT irq thread (preemptible):
     Raise to LD_WAIT_SPIN.  Raw spinlocks become permitted — as Gabriele
     note, this is a necessary consequence of any fix in this path.


like this:


+       static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map,        LD_WAIT_SPIN);
+       static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map_atomic, LD_WAIT_FREE);
+       struct lockdep_map *map;
...
+       map = (in_nmi() || in_hardirq()) ? &rv_react_map_atomic : 
&rv_react_map;

-       lock_map_acquire_try(&rv_react_map);
+       lock_map_acquire_try(map);
...
         monitor->react(msg, args);
-       lock_map_release(&rv_react_map);
+       lock_map_release(map);


--
Best wishes,
Wen


