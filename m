Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E8B30E85B;
	Mon,  8 Jun 2026 02:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780884692; cv=none; b=joyuh8C4aTscfQv9T6AJK0jB17HIbIIW7yN0j7itmWSxxX303AX3PJCfHHEi2BbgeIhp3A2rcAIlbu2uH4Lqkqq8hcYTnlAgFJWqFkcNFYQxJXF6i/nVFrnYym7vwtxj/4QuVyp4eG9mZlZVaHqu585sn5IsPmZzsPMYFex1vEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780884692; c=relaxed/simple;
	bh=s3j+q6tQy7Gfo9gGUfAPP6WdpTaB/eHCDTW14g+rxpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OMbT5atOOCIi06m3q6OTjFB/YxSrKHKKX1ufvUCKy0rRGvifUh8SgKu1TN85XIp7gKTeapT4DgB+ACC18dnDxa5ivXRfaq4DAr62g7r1OKUbuNRmWSeQXT/bZ2qm14AZznR0DVQ8dIXV7UXyqsuWKJHbHI3UlT5GSFwKzrRNtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gYZmS2SCnzYQtgL;
	Mon,  8 Jun 2026 09:52:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AB9BF40593;
	Mon,  8 Jun 2026 09:52:38 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgCH239lICZq2zMSBA--.313S2;
	Mon, 08 Jun 2026 09:52:38 +0800 (CST)
Message-ID: <679a1c8f-1e4d-4ae5-83e1-d0068e6de1a6@huaweicloud.com>
Date: Mon, 8 Jun 2026 09:52:37 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rethook: Use tsk->on_cpu to check task execution state
To: Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Alexei Starovoitov <ast@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260525132253.1889726-1-wutengda@huaweicloud.com>
 <20260526123719.482f07a3843e207e22d95378@kernel.org>
 <94179dab-ffb7-4fab-af45-b20bfb686ab3@huaweicloud.com>
 <20260601084001.9566b443746447ec2bb1a9fb@kernel.org>
 <20260604093445.GF3126523@noisy.programming.kicks-ass.net>
 <20260605224341.c926299d613b6102912c9a3f@kernel.org>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20260605224341.c926299d613b6102912c9a3f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCH239lICZq2zMSBA--.313S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrWfAFy3JrW5XFW3CFW7urg_yoW8KrW8pF
	ZxK3W5Ka1DJw4xtry7urs3Jr15Grs7G3y3Ga4DC34UA3WDZ34Iqrs7Kw4Y9a4UWr4DCw42
	vrWUX397uan7AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUwxhLUUUUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2026/6/5 21:43, Masami Hiramatsu wrote:
> On Thu, 4 Jun 2026 11:34:45 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Mon, Jun 01, 2026 at 08:40:01AM +0900, Masami Hiramatsu wrote:
>>
>>> Peter, is it OK to drop @rq from task_on_cpu()? 
>>
>> Sure.
>>
>>> Then we can use it from rethook.
>>
>> Well, it is in sched/sched.h, which is an internal header, and no you
>> cannot use that header in rethook.
> 
> Ah, OK. Hmm, then we should not use it. Maybe ->on_cpu is also internal
> state?
> 
>>
>> But lets step back first, what is the actual problem here, why are we
>> looking at ->on_cpu at all?
> 
> Tengda, can you explain it?
> I think you want to take a stacktrace on !current process, and
> rethook_find_ret_addr() is rejected i the task is running state.
> 
> But if you can share actual situation what you need, it is
> helpful for us to understand.
> 
> Thank you,
> 
> 


Sure.

Background: We are verifying the support of live patches for functions that
have a kretprobe. The specific verification method is as follows:

We construct a function foo() that calls bar():

void bar(void)
{
    for (;;) {
        schedule();
    }
}

void foo(void)
{
    bar();
}

A kretprobe is attached to bar():

echo 'r:rp1 bar' > /sys/kernel/tracing/kprobe_events
echo 1 > /sys/kernel/tracing/events/kprobes/rp1/enable

Then foo() is triggered. The expected behavior is that bar() will call
schedule() and yield the CPU.

After that, the live patch is activated to attempt replacing the implementation
of foo(). The expectation is that this should succeed.

However, in reality, because the task that called schedule() is still in the
RUNNING state, the condition task_is_running(tsk) inside rethook_find_ret_addr()
is not satisfied, causing the function to return early. This, in turn,
prevents stack_trace_save_tsk_reliable() from determining the stack as
reliable, leading to a failure in activating the live patch.

**Not sure if this is correct:**

We believe that after a task voluntarily calls schedule(), when the stack
is expected to be reliable, it is a safe time to activate a live patch.
Additionally, a similar tsk->on_cpu check can be found elsewhere in the
kernel (See task_on_another_cpu() in arch/x86/include/asm/unwind.h).
Therefore, we propose changing the task_is_running(tsk) condition to
tsk->on_cpu.

Thanks,
Tengda

