Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA30362156
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784050804; cv=none; b=PXkeUyTabL+pf3k0Q9LX1yzMHVjltpepbquM8EuEArPzUk8c23dPD9aHiv/rgjBvJJNElrhBlJxjHa+sXiRZA+umDxD3M1fK380bmi9jrT8/3vYkrk8a6wi/vexQy/xPG6X8O2RFSfESvaSqiswodqpQ4A7rXMF5ZJE4pW3Jlho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784050804; c=relaxed/simple;
	bh=m4U5GNUNoys0mvOyCVW5BCqFf3DdRSZ+TTLXoxU5FHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TNZBZ6wqXBH7erZ+qlkDF47u8JAkooUtP5qub5XB+OcfWJeoBbRA/j9OkRWdzPB27dKe4I1IrAehgWjiX+NskvtjNjOz1uz7jgQANJGz4EGmimSyCnnoMQEGPrwlmy00ZpAJGSNF01ecj6mqWDi7q2fu5cRDfhAFr6HeHSwi3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mNA/zQwH; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mNA/zQwH"
Message-ID: <39e4acbc-3e1b-412e-b6b8-c93f4e2c62ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784050788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfyaNZciLntWE3fThJkhuKyR6aA7p0+f8coqjxSjCFg=;
	b=mNA/zQwHaQGfFFtnGDSg+LlcvtbzFcjyiwF9mM1Gk8SFnGK44OuXvlQYHLDArKr4oG2dkU
	LrMDBMxeHNlyaroEcx8LyJ3dOG/2SHi7gbgL6AKLuC89qQRRW+7LcULqEXL/URQAqJYJD5
	MArx3HOcGGem6Ty9HKS5/T0EeRN1a6Q=
Date: Wed, 15 Jul 2026 01:39:19 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] rv/reactors: fix lockdep "Invalid wait context" in
 rv_react()
To: Nam Cao <namcao@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1781541556.git.wen.yang@linux.dev>
 <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
 <20260623112942-4943fc6a-c1d5-4eed-a91f-66b3a034caa7@linutronix.de>
 <3c53f741559f834986e976b524c5ded90bbd5627.camel@redhat.com>
 <20260708174123-e5f98837-3d81-43ca-8ede-bb5f09e8ffba@linutronix.de>
 <397cea12-e0ba-4cf5-a411-26f44bc17d01@linux.dev> <87y0fkdojp.fsf@yellow.woof>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Wen Yang <wen.yang@linux.dev>
In-Reply-To: <87y0fkdojp.fsf@yellow.woof>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 7/10/26 02:07, Nam Cao wrote:
> Wen Yang <wen.yang@linux.dev> writes:
>> How about a context-sensitive approach, eg:
>>
>>     NMI/hardirq (interrupts masked, scheduler cannot run):
>>       Keep LD_WAIT_FREE.  The false positive cannot arise in this path,
>>       and the original constraint against raw spinlocks is preserved where
>>       it is meaningful.
>>
>>     task/softirq/PREEMPT_RT irq thread (preemptible):
>>       Raise to LD_WAIT_SPIN.  Raw spinlocks become permitted — as Gabriele
>>       note, this is a necessary consequence of any fix in this path.
> 
> I don't get the point. Unless the lock's type is also context-sensitive,
> the reactors still cannot use raw spin locks.
> 

Correct, and that is intentional. The patch is not about enabling raw
spinlocks in callbacks; it is about fixing a false positive in 
preemptible context while preserving LD_WAIT_FREE where it is still 
meaningful.

The lockdep check (kernel/locking/lockdep.c:4901) is:

     if (next_outer > curr_inner)  /* BUG: Invalid wait context */

The false positive in preemptible context:

     rv_react_map (inner = LD_WAIT_FREE = 1)  -->  held by override map
     timer interrupt
       __schedule
          rq->__lock (outer = LD_WAIT_SPIN = 2)
             2 > 1   --->  BUG (while callback itself took no spinlock)

In NMI/hardirq context interrupts are masked; __schedule cannot run, so
rq->__lock is never acquired in this path.  The false positive cannot
arise there, and LD_WAIT_FREE keeps raw spinlocks forbidden:

     raw_spinlock_t (outer = LD_WAIT_SPIN = 2)
     rv_react_map_atomic (inner = LD_WAIT_FREE = 1)
     2 > 1  →  BUG   (intended: hardirq callbacks must be lock-free)


The commit message's "raw spinlocks in callbacks are permitted as a
necessary consequence" is imprecise -- that applies to the preemptible
path only.  I will correct it in v2.


--
Best wishes,
Wen




