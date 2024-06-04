Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8844C12B17A;
	Tue,  4 Jun 2024 15:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717513293; cv=none; b=lmiZA/emnC0YfOgyPLlVaSK8U26JqkUGTylPT4x3IeW54xrI+6y01WcSpek4jwWpEXnjHYOMt9RZE9oudxLjArjMvKmBm6LJMbq9mS3Evs2thcbeQWsEPzWI3CTLsj9R01o+hvd1IPlRUGvgQgNRe5CZWjvxe3uaYP/R3pwVFWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717513293; c=relaxed/simple;
	bh=8Jm8F2/dwM9qEQfz+qJAFkEyVXbrXZXBdNIZ5BuXr2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=smxosSMY+/R1r7CqImjJpiq9oNSU7TntGrgqkE+jooMOHqPyaM61MAAFoB0fVjsIozWHVqbid6Q0AWeNJy9DJeIWlzZMaeHsW5C/cID/4gqrR/4RoEcbQUSGeUjbnDkqEkxJZ4881n8JlemVOk4vzbJt3cgQugQN0atGnWo/m8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=JaCfY7qJ; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="JaCfY7qJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1717513289;
	bh=8Jm8F2/dwM9qEQfz+qJAFkEyVXbrXZXBdNIZ5BuXr2k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JaCfY7qJuYVKmFyud562qOCxarYOInMBFZ+zNXkuL8HMrR0owAPl2oirtBuDY7M5S
	 rNnxLtlVwqu95t65+edadHe16ZEsPGfj4smGg+RWtUujg1Pngto+uNnzFP+ky5blIA
	 vlkyr0NSaI0ilAdgKi51KfHdOzPh9Rh2wvSGfsFfr0pcgTjdDJzbykytQkEKkMtVPO
	 4ZlSFH/T66RXHvbFHjcs7ztgi8rA1CzVoCHlOlPnAoYpF/kdpALKWylLFxlEsioh4G
	 HcKFAjZEt7G+r0o/BmU6X/KBU8j5andpQvCoSnt3ud5Mv2f0VSYDzsDGva2qGaVdo+
	 V7gRoS8sz9uOA==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Vtv1h6P9bz132v;
	Tue,  4 Jun 2024 11:01:28 -0400 (EDT)
Message-ID: <419b80da-9cbf-4bb2-aabb-dc04f0fb0f37@efficios.com>
Date: Tue, 4 Jun 2024 11:02:16 -0400
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] tracing/fprobe: Support raw tracepoint events on
 modules
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, don <zds100@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <171723014778.258703.6731294779199848686.stgit@devnote2>
 <171723016594.258703.1629777910752596529.stgit@devnote2>
 <fbfec8d9-d0ed-4384-bbd2-dd5c1e568ed1@efficios.com>
 <20240604084955.29b9440687522a1347e0e7cd@kernel.org>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <20240604084955.29b9440687522a1347e0e7cd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-06-03 19:49, Masami Hiramatsu (Google) wrote:
> On Mon, 3 Jun 2024 15:50:55 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> On 2024-06-01 04:22, Masami Hiramatsu (Google) wrote:
>>> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
>>> Support raw tracepoint event on module by fprobe events.
>>> Since it only uses for_each_kernel_tracepoint() to find a tracepoint,
>>> the tracepoints on modules are not handled. Thus if user specified a
>>> tracepoint on a module, it shows an error.
>>> This adds new for_each_module_tracepoint() API to tracepoint subsystem,
>>> and uses it to find tracepoints on modules.
>>
>> Hi Masami,
>>
>> Why prevent module unload when a fprobe tracepoint is attached to a
>> module ? This changes the kernel's behavior significantly just for the
>> sake of instrumentation.
> 
> I don't prevent module unloading all the time, just before registering
> tracepoint handler (something like booking a ticket :-) ).
> See the last hunk of this patch, it puts the module before exiting
> __trace_fprobe_create().

So at least this is transient, but I still have concerns, see below.

>>
>> As an alternative, LTTng-modules attach/detach to/from modules with the
>> coming/going notifiers, so the instrumentation gets removed when a
>> module is unloaded rather than preventing its unload by holding a module
>> reference count. I would recommend a similar approach for fprobe.
> 
> Yes, since tracepoint subsystem provides a notifier API to notify the
> tracepoint is gone, fprobe already uses it to find unloading and
> unregister the target function. (see __tracepoint_probe_module_cb)

I see.

It looks like there are a few things we could improve there:

1) With your approach, modules need to be already loaded before
attaching an fprobe event to them. This effectively prevents
attaching to any module init code. Is there any way we could allow
this by implementing a module coming notifier in fprobe as well ?
This would require that fprobes are kept around in a data structure
that matches the modules when they are loaded in the coming notifier.

2) Given that the fprobe module going notifier is protected by the
event_mutex, can we use locking rather than reference counting
in fprobe attach to guarantee the target module is not reclaimed
concurrently ? This would remove the transient side-effect of
holding a module reference count which temporarily prevents module
unload.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

