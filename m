Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E34620CCD1;
	Thu,  7 Nov 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730997453; cv=none; b=poy7hVGgLK8L6ErUrFr5+eU9mq4w8Ob858rLRYjCNoFt+YyUw4Nsi/5HwEAcW8cxYyfr/z93LQbbNNEUi+8xO5dyumjdttnJ9MNu1GhT10lIxwsMfFqSzjVANhCKUHBzqsJXPP97J80/wBemLb3fh1BRh9UXfjEYxrOjL6sLKTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730997453; c=relaxed/simple;
	bh=PHG4c8liwobcTj/eb5VMEXJU1NYWK0uClCdSzHmJK4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oavB1aVtKSDb83Q59TCOFEghnqZFIXvuMKdHlCE+CdyG3MV1fiQqwJREt6p02rHLBiAsRpEzsabaKoFb9P3MZdZ+2TFACKPUK+Rpj9UW4wiK1VGz/bDzL8WCZ7pBh5BHpFQVsxnFFP7uK9xedT91t5RIa0Fr7VrjqbTAtl0S10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=kafR/THq; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kafR/THq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1730997450;
	bh=PHG4c8liwobcTj/eb5VMEXJU1NYWK0uClCdSzHmJK4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kafR/THqS3d5GPITxfz/xUPbhwZaUxKgAsVnFDj6eL0j8mYLiS7YMMLjMv/KrTrdl
	 vj2ADCXiaO+F7w4B4alH9dq7MD6EKrMf62oAQ7p4HO2K4BGMA0RTs1gQIiv95a64pB
	 J1eUvuKCs6qbz1S0TBb/wRmgxMoDe3W0XN2DBj16YLWchsoR0BerqJ78eKOIkipOSX
	 YFcFm9wOo5Kb2ztsgKKsL43Ss1ObXtO5S5EPosq6klsP5V7x4NLDqXg4J978invr/C
	 rL2izrt1QaRIFW3r5rbkr6rTLKCxRMwFWA3tpDMsYHVsa2Lcy7lsi+hr23Hr6J2+rD
	 qQ+L50Gk5gyUw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XknmV0yXbzy86;
	Thu,  7 Nov 2024 11:37:30 -0500 (EST)
Message-ID: <dc36b163-5626-4d39-bd8f-35dc353bef17@efficios.com>
Date: Thu, 7 Nov 2024 11:36:00 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] tracing: Add task_prctl_unknown tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Marco Elver <elver@google.com>, Kees Cook <keescook@chromium.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
References: <20241107122648.2504368-1-elver@google.com>
 <5b7defe4-09db-491e-b2fb-3fb6379dc452@efficios.com>
 <CANpmjNPWLOfXBMYV0_Eon6NgKPyDorTxwS4b67ZKz7hyz5i13A@mail.gmail.com>
 <3326c8a1-36c7-476b-8afa-2957f5bd5426@efficios.com>
 <20241107110417.7850d68f@gandalf.local.home>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20241107110417.7850d68f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-11-07 11:04, Steven Rostedt wrote:
> On Thu, 7 Nov 2024 10:52:37 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> I suspect you base the overhead analysis on the x86-64 implementation
>> of sys_enter/exit tracepoint and especially the overhead caused by
>> the SYSCALL_WORK_SYSCALL_TRACEPOINT thread flag, am I correct ?
>>
>> If that is causing a too large overhead, we should investigate if
>> those can be improved instead of adding tracepoints in the
>> implementation of system calls.
> 
> That would be great to get better, but the reason I'm not against this
> patch is because prctl() is not a normal system call. It's basically an
> ioctl() for Linux, and very vague. It's basically the garbage system call
> when you don't know what to do. It's even being proposed for the sframe
> work.
> 
> I understand your sentiment and agree. I don't want any random system call
> to get a tracepoint attached to it. But here I'd make an exception.

Should we document this as an "instrumentation good practice" then ?

     When the system call is a multiplexor such as ioctl(2) and prctl(2),
     then instrumenting it with tracepoints within each of the "op" case
     makes sense for overall maintainability.

     For non-multiplexor system calls, using the existing sys_enter/exit
     tracepoints should be favored.

This opens the following question for non-multiplexors system calls:
considering that the overhead of the current sys_enter/exit
instrumentation is deemed to large to use in production, perhaps
we should consider a few alternatives, namely:

A) Modify SYSCALL_DEFINE so it emits a function wrapper with tracepoints
    for each system call enter/exit, except for multiplexors, or

B) Add the plumbing required to allow system call tracing to be
    activated for specific system calls only, more fine-grained than
    the current system-wide for_each_process_thread()
    SYSCALL_WORK_SYSCALL_TRACEPOINT thread flag big hammer.

Another scenario to consider is system calls that have iovec arguments.
Should we add tracepoint within the iovec iteration, or should it target
the entire iovec as input/output at system call enter/exit ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

