Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C7B1C1F0D;
	Tue,  2 Sep 2025 03:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756784866; cv=none; b=kDQSU11l893Tl4jyS0yw2xzOajY99H89S3phTe9X6EXziUhER0YZkZ9NUAHyi/QsstmRRVXGNU4Hb596Z35Hl9mr4h8nHheIPrOGut1+v5bAieFIcsA1FNP9Nw2i+3H+5bNMS+6bwOe3kz1kLw5u/dAl8APadEv5yZG+Cgz5xgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756784866; c=relaxed/simple;
	bh=L4bvL7NVFqZCfjF05fgpoSFQ/PhLhaAoIak7Jz4dAeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvBCgHK67/D0KQqbJdGMYdEZOPgseO1ija06NfS02eJ6YX4Pb1MIbkxTri6V3r1sxw9t/0pmV4mk6XedWG59+9HOUFwfKGPSbhfOU9aXtjEFiHaC7KyVvneLC54z/Z+1LNXW8ZxylL/WDgGFlJa00q6ipldfzVjktM0Fd9+D/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cGBX570X6zKHN7m;
	Tue,  2 Sep 2025 11:47:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id CC8A51A1195;
	Tue,  2 Sep 2025 11:47:33 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgCn8IzUaLZou5poBA--.16810S3;
	Tue, 02 Sep 2025 11:47:33 +0800 (CST)
Message-ID: <cc6eb973-d82b-4afc-83fb-a2c28cc79d36@huaweicloud.com>
Date: Tue, 2 Sep 2025 11:47:32 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault during
 preempt_disable
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
 <20250819135008.5f1ba00e@gandalf.local.home>
 <436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
 <20250829082604.1e3fd06e@gandalf.local.home>
 <20250902005645.8c6436b535731a4917745c5d@kernel.org>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <20250902005645.8c6436b535731a4917745c5d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCn8IzUaLZou5poBA--.16810S3
X-Coremail-Antispam: 1UD129KBjvJXoWxurW8tF17XF1xCr4UJry3XFb_yoWrGr4xpr
	yfKa9rKF45X34jywsFvw10qryUtr4UXry8Wr1kGF18W34q9rn8XFWxKw48uFWUWr9rJw1S
	yw4UXr9xWr15Za7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/9/1 23:56, Masami Hiramatsu (Google) wrote:
> On Fri, 29 Aug 2025 08:26:04 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> [ Adding arm64 maintainers ]
>>
>> On Fri, 29 Aug 2025 16:29:07 +0800
>> Luo Gengkun <luogengkun@huaweicloud.com> wrote:
>>
>>> On 2025/8/20 1:50, Steven Rostedt wrote:
>>>> On Tue, 19 Aug 2025 10:51:52 +0000
>>>> Luo Gengkun <luogengkun@huaweicloud.com> wrote:
>>>>   
>>>>> Both tracing_mark_write and tracing_mark_raw_write call
>>>>> __copy_from_user_inatomic during preempt_disable. But in some case,
>>>>> __copy_from_user_inatomic may trigger page fault, and will call schedule()
>>>>> subtly. And if a task is migrated to other cpu, the following warning will
>>>> Wait! What?
>>>>
>>>> __copy_from_user_inatomic() is allowed to be called from in atomic context.
>>>> Hence the name it has. How the hell can it sleep? If it does, it's totally
>>>> broken!
>>>>
>>>> Now, I'm not against using nofault() as it is better named, but I want to
>>>> know why you are suggesting this change. Did you actually trigger a bug here?
>>> yes, I trigger this bug in arm64.
>> And I still think this is an arm64 bug.
> I think it could be.
>
>>>>   
>>>>> be trigger:
>>>>>           if (RB_WARN_ON(cpu_buffer,
>>>>>                          !local_read(&cpu_buffer->committing)))
>>>>>
>>>>> An example can illustrate this issue:
> You've missed an important part.
>
>>>>> process flow						CPU
>>>>> ---------------------------------------------------------------------
>>>>>
>>>>> tracing_mark_raw_write():				cpu:0
>>>>>      ...
>>>>>      ring_buffer_lock_reserve():				cpu:0
>>>>>         ...
> 	preempt_disable_notrace(); --> this is unlocked by ring_buffer_unlock_commit()
>
>>>>>         cpu = raw_smp_processor_id()			cpu:0
>>>>>         cpu_buffer = buffer->buffers[cpu]			cpu:0
>>>>>         ...
>>>>>      ...
>>>>>      __copy_from_user_inatomic():				cpu:0
> So this is called under preempt-disabled.
>
>>>>>         ...
>>>>>         # page fault
>>>>>         do_mem_abort():					cpu:0
>>>> Sounds to me that arm64 __copy_from_user_inatomic() may be broken.
>>>>   
>>>>>            ...
>>>>>            # Call schedule
>>>>>            schedule()					cpu:0
> If this does not check the preempt flag, it is a problem.
> Maybe arm64 needs to do fixup and abort instead of do_mem_abort()?

My kernel was built without CONFIG_PREEMPT_COUNT, so the preempt_disable()
does nothing more than act as a barrier. In this case, it can pass the
check by schedule(). Perhaps this is another issue?

>
>>>>> 	 ...
>>>>>      # the task schedule to cpu1
>>>>>      __buffer_unlock_commit():				cpu:1
>>>>>         ...
>>>>>         ring_buffer_unlock_commit():			cpu:1
>>>>> 	 ...
>>>>> 	 cpu = raw_smp_processor_id()			cpu:1
>>>>> 	 cpu_buffer = buffer->buffers[cpu]		cpu:1
> 	preempt_enable_notrace(); <-- here we enable preempt again.
>
>>>>> As shown above, the process will acquire cpuid twice and the return values
>>>>> are not the same.
>>>>>
>>>>> To fix this problem using copy_from_user_nofault instead of
>>>>> __copy_from_user_inatomic, as the former performs 'access_ok' before
>>>>> copying.
>>>>>
>>>>> Fixes: 656c7f0d2d2b ("tracing: Replace kmap with copy_from_user() in trace_marker writing")
>>>> The above commit was intorduced in 2016. copy_from_user_nofault() was
>>>> introduced in 2020. I don't think this would be the fix for that kernel.
>>>>
>>>> So no, I'm not taking this patch. If you see __copy_from_user_inatomic()
>>>> sleeping, it's users are not the issue. That function is.
>
> BTW, the biggest difference between __copy_from_user() and
>   __copy_from_user_inatomic() is `might_fault()` and `should_fail_usercopy()`.
> The latter is a fault injection, so we can ignore it. But since
> the `might_fail()` is NOT in __copy_from_user_inatomic(), it is designed
> not to cause fault as Steve said?
>
> Thank you,
>

