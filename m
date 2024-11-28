Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76A4192D77;
	Thu, 28 Nov 2024 14:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732804032; cv=none; b=ubE8JKagj4gXiBeUkwbb7u9QjCNp3tCAW+S2cIZ/O8hkXIHNpQnfXdp0joFVdIkpco+AwuL9/AY1BTqPUmt6whZkwd2m0z6esWWLh9aQkHE0virYzZTSZnuNP9hnYF9aZPIzMLiu/k9pZ2ft4yqnxzHGn1rFHqmgPhPs9JkKnxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732804032; c=relaxed/simple;
	bh=EfQQHvGhTD42fJCMocAmYACbr6mr5voTdkVtUR8QiYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FJ5yHw/z1F4hbhh68dPtQocK/YnswloYLoT8gznBfSv/gc7I6n6kjloSUqhm5oL7BOiq7FGbYEzCB0lxojoBM9p40cAFXBgf3MvsqWabs9u5/p+Nf0q+N+E2ouilcf9AZgx4Gn9xPL9/mIUGWAIzqLIbcl0kidaOKdS+aMqSLqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=BOWJjEva; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="BOWJjEva"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1732804022;
	bh=EfQQHvGhTD42fJCMocAmYACbr6mr5voTdkVtUR8QiYw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BOWJjEvaqoHhRv6RQEt2YcyIEBZs8LmI0lcL4f4iiRMq3iJqDsxuG3knGI9FSQPln
	 Z+NlbDUTckXC1FoY8ApZfRKriLDrsFdXaokYm+MoQlK7hS849vRPT+qNaqRh85BCAR
	 T2r+h/kQC00yQc7cuBHilc1ndQplJmZauHELEmVa98j79D+AwsAaPTEemoyHy8B0mF
	 4beSnRKLuY+3PTcF+G/zqOVHSrVBnsdkiM0Tin0QxNjyhvlOAAgOPWh4BxBSuzauyF
	 0CMHgjmi3rpOMEIxHnYJySJzbzO2/F3uZ+/T6zWePfH+rfyRm1sevVAASuBa5LkOuB
	 h1iyuvKE/JuDw==
Received: from [172.16.0.134] (96-127-217-162.qc.cable.ebox.net [96.127.217.162])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4XzdtG6J8rzjYj;
	Thu, 28 Nov 2024 09:27:02 -0500 (EST)
Message-ID: <62cb12cb-d3b6-4ad1-b9e6-c49b642eaeb4@efficios.com>
Date: Thu, 28 Nov 2024 09:27:01 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add WARN_ON_ONCE for syscall_nr check
To: Tao Chen <chen.dylane@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20241128115319.305523-1-chen.dylane@gmail.com>
 <20241128074623.063bf253@rorschach.local.home>
 <8d4796dc-ef5b-43d8-8ec0-3891b7994428@gmail.com>
Content-Language: en-US
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <8d4796dc-ef5b-43d8-8ec0-3891b7994428@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024-11-28 08:15, Tao Chen wrote:
> 在 2024/11/28 20:46, Steven Rostedt 写道:
>> On Thu, 28 Nov 2024 19:53:19 +0800
>> Tao Chen <chen.dylane@gmail.com> wrote:
>>
>>> Now, x86_64 kernel not support to trace syscall for ia32 syscall.
>>> As a result, there is no any trace output when tracing a ia32 task.
>>> Like unreg_event_syscall_enter, add a WARN_ON_ONCE judgment for
>>> syscall_nr in perf_syscall_enter and ftrace_syscall_enter to give
>>> some message.
>>
>> So on a system that has "panic_on_warn" set and they trace a 32 bit
>> system call, it will cause their system to crash. Is that the intended
>> behavior?
>>
>> WARN*() is for self testing the kernel to detect real bugs, not to
>> inform users that something isn't supported.
>>
>> BIG NAK!
>>
>> -- Steve
> 
> Hi, Steve, thank you for your reply, as you say, so what about 
> pr_warn_once api just to print something ?
> 

I understand that explicitly enabling a system call and observing
that ia32 system calls are just not traced by ftrace and perf can
be surprising for end users. But printing a warning on the tracing
path for an unimplemented tracing feature is just wrong.

Also, AFAIU the warning will trigger if an ia32 program issues any
system call when any unrelated system call tracing is enabled,
including non-compat syscalls.

If you want to check something and return an error, it would
be in tracefs where the users interact with files that represent
ia32 system calls to try to list/enable them. However, given the
exposed files have nothing that mention whether they apply to
non-compat or compat system calls, it's understandable that an
end user would think all system calls are traced, including
compat system calls. So I'm not sure how to solve that in ftrace/perf
without actually implementing the missing feature the way the
tracefs ABI is exposed.

If your end goal is to trace ia32 system call, you may want to try the
lttng-modules kernel tracer [1], which has supported compat system call
tracing for the past 12 years (at least since lttng-modules 2.0).

Thanks,

Mathieu

[1] https://lttng.org/

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

