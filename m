Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D67D285CAB;
	Fri, 29 Aug 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456154; cv=none; b=MAS1NKnwUKm9IZe3MlX4oeYozfkOrybUROrgBOjPj2qCm1d8LfyUcUdiVcz9KgXqimEwKTh2hBAeLws04UaRsi1JH4wq0nfX+zP09WTQTOCt61kjU8WNhRmV8GL2wX3s9CXBMlLnnPJGvkmhwyDNpD2O6cwKpStEg/++9hAwQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456154; c=relaxed/simple;
	bh=saNq597WfeDglag5mqqqm7y1w9j+DVQ19b4Ai1zb8Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jt/43W8xPvAmk+pNCXZRBk55cTHJfsJQrS4u7JXrnv117CMJK7GPHxsR8Sij1WbtBMPGsmgqRUMyuyPCxQUEP3FgagNLMS4u+blEbWX8apyaWcJ1iyccNbRDexI45BRTW4XVDQAs9tjBdZRnRhSRmmCyvSkEhLvxNfkaDx+gN5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cCrys1VmSzKHNMx;
	Fri, 29 Aug 2025 16:29:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E5BEA1A125A;
	Fri, 29 Aug 2025 16:29:08 +0800 (CST)
Received: from [10.67.108.244] (unknown [10.67.108.244])
	by APP4 (Coremail) with SMTP id gCh0CgB3wY3TZLFo6Ui3Ag--.45960S3;
	Fri, 29 Aug 2025 16:29:08 +0800 (CST)
Message-ID: <436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
Date: Fri, 29 Aug 2025 16:29:07 +0800
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
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
 <20250819135008.5f1ba00e@gandalf.local.home>
From: Luo Gengkun <luogengkun@huaweicloud.com>
In-Reply-To: <20250819135008.5f1ba00e@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3wY3TZLFo6Ui3Ag--.45960S3
X-Coremail-Antispam: 1UD129KBjvJXoWxGw13Cw4fJw4UXw4rXrWfuFg_yoW5XryrpF
	yfKwsrKF4UWryjy3ZrZw10qa4rKr4UXryxGFn5Wr1fX3yY9rn8XFWxKwsY9FyUWry7Aw1S
	yw4Utr9xWr15ZwUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/


On 2025/8/20 1:50, Steven Rostedt wrote:
> On Tue, 19 Aug 2025 10:51:52 +0000
> Luo Gengkun <luogengkun@huaweicloud.com> wrote:
>
>> Both tracing_mark_write and tracing_mark_raw_write call
>> __copy_from_user_inatomic during preempt_disable. But in some case,
>> __copy_from_user_inatomic may trigger page fault, and will call schedule()
>> subtly. And if a task is migrated to other cpu, the following warning will
> Wait! What?
>
> __copy_from_user_inatomic() is allowed to be called from in atomic context.
> Hence the name it has. How the hell can it sleep? If it does, it's totally
> broken!
>
> Now, I'm not against using nofault() as it is better named, but I want to
> know why you are suggesting this change. Did you actually trigger a bug here?

yes, I trigger this bug in arm64.

>
>> be trigger:
>>          if (RB_WARN_ON(cpu_buffer,
>>                         !local_read(&cpu_buffer->committing)))
>>
>> An example can illustrate this issue:
>>
>> process flow						CPU
>> ---------------------------------------------------------------------
>>
>> tracing_mark_raw_write():				cpu:0
>>     ...
>>     ring_buffer_lock_reserve():				cpu:0
>>        ...
>>        cpu = raw_smp_processor_id()			cpu:0
>>        cpu_buffer = buffer->buffers[cpu]			cpu:0
>>        ...
>>     ...
>>     __copy_from_user_inatomic():				cpu:0
>>        ...
>>        # page fault
>>        do_mem_abort():					cpu:0
> Sounds to me that arm64 __copy_from_user_inatomic() may be broken.
>
>>           ...
>>           # Call schedule
>>           schedule()					cpu:0
>> 	 ...
>>     # the task schedule to cpu1
>>     __buffer_unlock_commit():				cpu:1
>>        ...
>>        ring_buffer_unlock_commit():			cpu:1
>> 	 ...
>> 	 cpu = raw_smp_processor_id()			cpu:1
>> 	 cpu_buffer = buffer->buffers[cpu]		cpu:1
>>
>> As shown above, the process will acquire cpuid twice and the return values
>> are not the same.
>>
>> To fix this problem using copy_from_user_nofault instead of
>> __copy_from_user_inatomic, as the former performs 'access_ok' before
>> copying.
>>
>> Fixes: 656c7f0d2d2b ("tracing: Replace kmap with copy_from_user() in trace_marker writing")
> The above commit was intorduced in 2016. copy_from_user_nofault() was
> introduced in 2020. I don't think this would be the fix for that kernel.
>
> So no, I'm not taking this patch. If you see __copy_from_user_inatomic()
> sleeping, it's users are not the issue. That function is.
>
> -- Steve
>
>
I noticed that in most places where __copy_from_user_inatomic() is used,
it is within the pagefault_disable/enable() section. When pagefault_disable()
is called, user access methods will no sleep. So I'm going to send a v2patch which use pagefault_disable/enable()to fix this problem. -- Gengkun

>
>> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>

