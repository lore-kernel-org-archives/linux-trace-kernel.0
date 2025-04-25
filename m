Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56979231A24;
	Fri, 25 Apr 2025 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745567311; cv=none; b=WHc7GjRsyAbt2OT41hNEMkI6au/GWeKUCRtAUo0XQWydN09dLywVhtkIZk5T92dfFyi4aO8aHvS24bKVa7GxGEZzJsfmd54S6sG/N9S19ETf/5/eIfKrZ/SWdathayS9/cDt3em5L98n7i8cKtP/xqwmLSKnjBvipoEx7P5O6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745567311; c=relaxed/simple;
	bh=YnEpPztQNr6UuVmesYTUsH7gLnmph2csh6CrR/0qMrg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G20ABElhKkNU+CrHb1G8B7yxAZN86g8GnNBN+Tc6B+zA/VGR++tJH5LVOIezgN5E/E2LDN89RoB9hwidWQofYqyf0BaRNhH+LnMp6d0Et+2zt89Bxtyp/cht7MR1j/Ncr+fN1K6hUwpWRXHr699Y3eFoOxCbMleTw6FawHUNhFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F8VbZHlp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n9I5gL7g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F8VbZHlp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n9I5gL7g"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745567308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4P0Aw3eZoa0FulHYWqMBdxsMo9p8Z3uWhaSpWyOSyT4=;
	b=F8VbZHlp271cEXfeXxekFb49gl/ui3AHtALLYRd8KhLigGlsRErPEA4cDPbwboWvWmjgTx
	cMDlteZ7JKnZeH58+N3NRFzhDRfeff5SLqnOjXDKIaLsh4FsL7H38uiH4xwGmX9mEoJcc0
	Aa1S3Hhznx2R9O29ivw/n7nGR8JXOYSjFG+0xnhUAbIZVlGjNJznQGJLB3L3wL1ULkKQ7x
	+2V77Js5EvY/DY7uxnCl4G//CCKJfHCz8AX+7ixAun/34/tBBbvyZMM64ZN2Gw6rO29lAb
	ZXockAY9gSRU5PjBnnflpwCewvSjDHs4XUOoyZbMw+XPvvEPRsuuvIfoZWXwTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745567308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4P0Aw3eZoa0FulHYWqMBdxsMo9p8Z3uWhaSpWyOSyT4=;
	b=n9I5gL7gc2B5B8L/6ARiy4BT6/2luDLxjXbxkD2aSGG8FVIpdp88+GGQh0Qw97/BuZfJjn
	5rMHFHhr74IIoRDg==
To: Nam Cao <namcao@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 20/22] rv: Add rtapp_sleep monitor
In-Reply-To: <84ecxgit04.fsf@jogness.linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
 <c23cb5ef10310f978c3f90f07c2dbb9b042e8b01.1745390829.git.namcao@linutronix.de>
 <c321c7350ec10f9f358695acd765d2dbd067eeb2.camel@redhat.com>
 <20250425063456.NBE35YHR@linutronix.de>
 <84ecxgit04.fsf@jogness.linutronix.de>
Date: Fri, 25 Apr 2025 09:54:27 +0206
Message-ID: <84a584isvo.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-04-25, John Ogness <john.ogness@linutronix.de> wrote:
>>> perf stat -e rv:error_sleep stress-ng --cpu-sched 1 -t 10s
>>>   -- shows several errors --
>>
>> This one is a monitor's bug.
>>
>> The monitor mistakenly sees the task getting woken up, *then* sees it going
>> to sleep.
>>
>> This is due to trace_sched_switch() being called with a stale 'prev_state'.
>> 'prev_state' is read at the beginning of __schedule(), but
>> trace_sched_switch() is invoked a bit later. Therefore if task->__state is
>> changed inbetween, 'prev_state' is not the value of task->__state.
>>
>> The monitor checks (prev_state & TASK_INTERRUPTIBLE) to determine if the
>> task is going to sleep. This can be incorrect due to the race above. The
>> monitor sees the task going to sleep, but actually it is just preempted.
>
> If I understand this correctly, trace_sched_switch() is reporting
> accurate state transition information, but by the time it is reported
> that state may have already changed (in which case another
> trace_sched_switch() occurs later).
>
> So in this example, the task did go to sleep. Why do you think it was
> preempted instead?

On 2025-04-25, Gabriele Monaco <gmonaco@redhat.com> wrote:
> Peter's fix [1] landed on next recently, I guess in a couple of days
> you'll get it on the upstream tree and you may not see the problem.

Ah, thanks for pointing that out!

> [1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=8feb053d53194382fcfb68231296fdc220497ea6
