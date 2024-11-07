Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B71DFDAD;
	Thu,  7 Nov 2024 15:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994850; cv=none; b=UldgZOOT8WZb5kKlfu9n+Eu6l+LMaNR+qpX0+w4q+7bTkkZzFfx4f1z4Ri9J3Hr5dQXR9kvLp7I7S4Ki8Bod3snQAK3LJSAhtC/DR4gF3UQFq9kkqwCdOR8DnV120lS1dSvy0Ei79p91udUEgQIZaM4HI2zFhlskFNMBX+csV9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994850; c=relaxed/simple;
	bh=1nsN4o8Rhv0c/TJl1nsvTqsadFjyeracT4PKFIe6Vp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jh8E8ajgmsU+9CzIBX39Yur/+ERv3W1voxqwVnWNjCIRa17WQqZB2vU6ZHUXv8FqozjHXV6iOrL9QFTW6nm20a3saKNts2tQYynrt8o2AVKiglBq99h0dgcdL9VqI5Q4wZ5rRA7q+mYvCFglLRxOjVDUuvaAUUmAlqi4R8KvSVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=rrqT6gFA; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rrqT6gFA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730994847;
	bh=1nsN4o8Rhv0c/TJl1nsvTqsadFjyeracT4PKFIe6Vp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rrqT6gFAU8ePobmVjSbGnD7Hv4+ydzi6gG5h2d2X01oRETsq2BIPBx6LLUUrvuYnm
	 3ivIma0q1Z9Bkeb86mfJGEIgA1qT5XFO30MU67Fvnaljl5m+DYTjbuV2XlL968CAHG
	 vL9Ijb4LfaPUiylvbGM/y/CgrYMce/Fxih6YyPj3GX5w6y6Gz5vmZM0485oUganLHv
	 dEZa90IE0hhgwk/VCcqrK0/WN5xwc2PLOohH0MQHqiveU/ov4XrJcLFIbGAPPS2k6W
	 K4QKbntC2v7jaz3aPsqgjts8R8wLXnGTuo1IQM7cKrazrtEVwR0Sg93BJe3CyIYVkB
	 dzqw8NJF5f0Hg==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XkmpR0prGzxsy;
	Thu,  7 Nov 2024 10:54:07 -0500 (EST)
Message-ID: <3326c8a1-36c7-476b-8afa-2957f5bd5426@efficios.com>
Date: Thu, 7 Nov 2024 10:52:37 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
To: Marco Elver <elver@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
References: <20241107122648.2504368-1-elver@google.com>
 <5b7defe4-09db-491e-b2fb-3fb6379dc452@efficios.com>
 <CANpmjNPWLOfXBMYV0_Eon6NgKPyDorTxwS4b67ZKz7hyz5i13A@mail.gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <CANpmjNPWLOfXBMYV0_Eon6NgKPyDorTxwS4b67ZKz7hyz5i13A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-07 10:46, Marco Elver wrote:
> On Thu, 7 Nov 2024 at 16:45, Mathieu Desnoyers
> <mathieu.desnoyers@efficios.com> wrote:
>>
>> On 2024-11-07 07:25, Marco Elver wrote:
>>> prctl() is a complex syscall which multiplexes its functionality based
>>> on a large set of PR_* options. Currently we count 64 such options. The
>>> return value of unknown options is -EINVAL, and doesn't distinguish from
>>> known options that were passed invalid args that also return -EINVAL.
>>>
>>> To understand if programs are attempting to use prctl() options not yet
>>> available on the running kernel, provide the task_prctl_unknown
>>> tracepoint.
>>>
>>> Note, this tracepoint is in an unlikely cold path, and would therefore
>>> be suitable for continuous monitoring (e.g. via perf_event_open).
>>>
>>> While the above is likely the simplest usecase, additionally this
>>> tracepoint can help unlock some testing scenarios (where probing
>>> sys_enter or sys_exit causes undesirable performance overheads):
>>>
>>>     a. unprivileged triggering of a test module: test modules may register a
>>>        probe to be called back on task_prctl_unknown, and pick a very large
>>>        unknown prctl() option upon which they perform a test function for an
>>>        unprivileged user;
>>>
>>>     b. unprivileged triggering of an eBPF program function: similar
>>>        as idea (a).
>>>
>>> Example trace_pipe output:
>>>
>>>     test-484     [000] .....   631.748104: task_prctl_unknown: comm=test option=1234 arg2=101 arg3=102 arg4=103 arg5=104
>>>
>>
>> My concern is that we start adding tons of special-case
>> tracepoints to the implementation of system calls which
>> are redundant with the sys_enter/exit tracepoints.
>>
>> Why favor this approach rather than hooking on sys_enter/exit ?
> 
> It's __extremely__ expensive when deployed at scale. See note in
> commit description above.

I suspect you base the overhead analysis on the x86-64 implementation
of sys_enter/exit tracepoint and especially the overhead caused by
the SYSCALL_WORK_SYSCALL_TRACEPOINT thread flag, am I correct ?

If that is causing a too large overhead, we should investigate if
those can be improved instead of adding tracepoints in the
implementation of system calls.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

