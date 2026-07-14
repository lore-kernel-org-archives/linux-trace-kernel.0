Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29D2FF147;
	Tue, 14 Jul 2026 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784024194; cv=none; b=eeIXaMf4LaaYfmNlX97etdjLsr7uPpwqRTMvpfTEYM9PBfwAaSJYxYkdmCIfUomDxIIef//K4qzkajcwKC5+7e+uuPzERxFCk5A7mSt84oPe+tNjNoKb6GPonGHfBk5/5u9CEBeELGmScEQEJzcXF5hGwfs5nRAhIt+z8XonEOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784024194; c=relaxed/simple;
	bh=jjf+ggSgfRLi2weKyGR6wKofMt7Nt5pS9u3fmkkVlKA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUJna8zjeg/KYFJ2BwOqiYgOLOJyYrxELdWiQ2qyZSH+/GtshWQW7+5xf/XYqwAzwppgwFUWHoHm7MxxKu0JXWY9zMxOW9Gny3Mb5y+pA20RXl4CQRMPWDkyroU6/bOmHzDRvaMqwk8QpNQu0EorW8Eo2zfh762It9EAu8T+gao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gzwF85FCCzYQtt4;
	Tue, 14 Jul 2026 18:16:12 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id D298840590;
	Tue, 14 Jul 2026 18:16:27 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with UTF8SMTPA id Syh0CgDnyyd6DFZqS2nHBA--.49254S2;
	Tue, 14 Jul 2026 18:16:27 +0800 (CST)
Message-ID: <059bee5e-6852-4afb-a993-dd5ddcd86d3e@huaweicloud.com>
Date: Tue, 14 Jul 2026 18:16:26 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Add mutex to trace_parser to fix concurrent
 write races
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260713134640.708323-1-wutengda@huaweicloud.com>
 <20260713153624.48fc4be4@robin>
 <ae69656e-fc50-4049-94f9-d460c2e1d5b8@huaweicloud.com>
 <20260713221318.63f741ad@gandalf.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260713221318.63f741ad@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnyyd6DFZqS2nHBA--.49254S2
X-Coremail-Antispam: 1UD129KBjvJXoW3XFW5Cw1kJw4kXry3tF1kXwb_yoW7XFykp3
	yrKF97tF4DtF409r1Ig3W8ur10g345JryUGFn5KryYy3Z8ZF129FyakFs8uF17C3s7J34a
	vr4Y9345KrWDZ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7UUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/7/14 10:13, Steven Rostedt wrote:
> On Tue, 14 Jul 2026 09:50:55 +0800
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>>>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>>>> index f93e34dd2328..ef47e5659283 100644
>>>> --- a/kernel/trace/ftrace.c
>>>> +++ b/kernel/trace/ftrace.c
>>>> @@ -5842,6 +5842,8 @@ ftrace_regex_write(struct file *file, const char __user *ubuf,
>>>>  	/* iter->hash is a local copy, so we don't need regex_lock */
>>>>  
>>>>  	parser = &iter->parser;
>>>> +
>>>> +	guard(mutex)(&parser->lock);
>>>>  	read = trace_get_user(parser, ubuf, cnt, ppos);  
>>>
>>> Why are the other users of trace_get_user() not a problem? If
>>> anything, trace_get_user() should have a lockdep assert to make sure
>>> the lock is held.
>>>
>>> I think we need to add a lockdep assertion in all the callers that use
>>> the parser and we need to make sure it's taken by every user.
>>>
>>> -- Steve  
>>
>> Other places that use trace_get_user():
>>
>> ftrace_event_write
>>     trace_parser_get_init
>>     trace_get_user
>>
>> trace_pid_write
>>     trace_parser_get_init
>>     trace_get_user
>>
>> In both of these cases, the parser is allocated via trace_parser_get_init()
>> before use and freed immediately after, with no multi-threaded sharing.
>>
>> However, ftrace_graph_write() and ftrace_regex_write() are different.
>> The parser used by these two functions is allocated at open() time and
>> retrieved from struct file at write() time. Userspace can have multiple
>> threads invoking write() concurrently, e.g.:
>>
>>     r0 = openat(AT_FDCWD, path, O_WRONLY | O_CREAT | O_TRUNC |
>>                 O_NOCTTY | O_NONBLOCK, 0);
>>     r1 = dup(r0);
>>     write(r1, data1, len1);        /* thread 1 */
>>     pwrite64(r1, data2, len2, offset); /* thread 2 */
>>
>> Without proper synchronization in trace_get_user(), the parser state
>> becomes undefined.
>>
>> We have locally reproduced a slab-out-of-bounds issue with syzkaller [1],
>> which appears to be caused by this race.
>>
>> Regarding the fix, adding a lockdep assertion to trace_get_user() does
>> not seem necessary. As mentioned above, ftrace_event_write() and
>> trace_pid_write() do not involve concurrency, so they do not require
>> locking, and thus do not need a lockdep assertion.
> 
> So basically you want to add this inherit coupling between a user of
> "parser" and the "parser" itself? That is just bad design. You created a
> lock within the trace_parser struct to be used by a single instance but not
> all instances.
> 

You're right. That coupling is indeed bad.

> It is either added for all users or this is fixed by something else. Yeah,
> for now the other users of trace_get_user() do not need locking, but what
> happens the usage changes where it adds concurrency? Then it becomes a bug
> again. Right?
> 
> If one place needs to hold the parser->lock when calling trace_get_user()
> and trace_parser_loaded(), then all places should hold that lock. Or we
> just need to redesign it better.
> 
> Yes, this fixes a race condition when user space does something stupid (and
> this is something that requires admin privileges). But if we are going to
> fix it, might as well do it properly.
> 
> If the issue is only with ftrace, then make the lock part of ftrace and not
> the parser. Don't create a lock in parser that is determined by how one
> uses it whether the user needs to take the lock or not.
> 

Yes, the issue at hand is currently limited to ftrace internals,
specifically in ftrace_graph_write() and ftrace_regex_write(). I did
consider moving the lock out of the parser and confining it within
ftrace.c, but the approaches I came up with so far all seem less than
ideal. Let me outline them below.

_Approach 1_: Add a global lock at the ftrace.c file level, and hold it
in the relevant write entry points for mutual exclusion.

The obvious downside here is that both of the aforementioned functions are
called by multiple tracefs file write hooks. A single global mutex would
cause unnecessary blocking between writes to different files. On the other
hand, introducing multiple global mutexes (one per file) would scatter the
lock definitions and make maintenance harder.

  ftrace_graph_write() is used by:
    - set_graph_function
    - set_graph_notrace

  ftrace_regex_write() is used by:
    - set_ftrace_filter
    - set_ftrace_notrace

_Approach 2_: Move the lock into structures such as ftrace_graph_data
or ftrace_iterator, both of which already embed a trace_parser.

While this does fix the problem, it feels somewhat redundant. We would be
defining essentially the same lock in multiple places just to serialize
access to the parser. Right now that would mean two definitions, but in the
future, depending on how many parser users need concurrency control, it
could grow further.

_Approach 3_: As you suggested earlier, build on v1 but add proper lockdep
assertions to enforce that the parser lock is held by all callers,
regardless of how the parser is used.

Approach 3 seems cleaner and more straightforward.

Do you happen to have a better suggestion in mind? I'm open to other
approaches if we can keep the design clean and maintainable.

Thanks,
Tengda

