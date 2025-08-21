Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234925D558;
	Thu, 21 Aug 2025 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755741240; cv=none; b=M0zQXBw5k7LEUPCrDp7Q/yfjJNoIS/j2YBq10jp0VlwL4biWjuZvGNqAzaaX6AOMDTj5rn/wxw0nC8PUonMVMnQEWF6Q4WYp1wmWoH33XECCnUz5kzIyUURaGWiHxTNYifnvztG8uKjQR0i24RKIpG0Di4gnmL3eQP2b/Ys6Ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755741240; c=relaxed/simple;
	bh=/UTdZdqHBei5IhcazXRZLHdMkGPzNZG0kA6+6pEWIBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nCNwI1tqdQ1NHXN3wCKTkxqo3WSCmQSoAHwmxqIP5lKB4HxUZ5C3kTQzX5x+RNdgw42c3Wk/sNIWLo7vY4YDyymVDSvQ2RrpyVU+pU4e3bt2oK9b3A1/ufmVyCDglip8Z9ShizwdG+Hbzhns5qN/MhnWUtNHL/9+2+FXjwBHdLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4c6mZX4236zYQvSR;
	Thu, 21 Aug 2025 09:53:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 24F2B1A12DF;
	Thu, 21 Aug 2025 09:53:55 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP4 (Coremail) with SMTP id gCh0CgDnrg8xfKZos5eMEQ--.63566S2;
	Thu, 21 Aug 2025 09:53:55 +0800 (CST)
Message-ID: <40bcf20b-e2e6-442f-bfd8-bb7ad6245397@huaweicloud.com>
Date: Thu, 21 Aug 2025 09:53:53 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] ftrace: Fix potential warning in trace_printk_seq
 during ftrace_dump
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@elte.hu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250820090017.2978279-1-wutengda@huaweicloud.com>
 <20250820101054.50c0b8b8@gandalf.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20250820101054.50c0b8b8@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDnrg8xfKZos5eMEQ--.63566S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1rZrWDJr1xZr43Jr15CFg_yoWrCFy8pF
	W3Ka9rJF4kJFsrtrnruF18Cw18t3yrtryUWrZxJw1rJFn8Ar12vr9rKrnIgr93C39xG34a
	yFWjy3srCw12vFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
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
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/



On 2025/8/20 22:10, Steven Rostedt wrote:
> On Wed, 20 Aug 2025 09:00:17 +0000
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
> Hi Tengda!
> 
>> When calling ftrace_dump_one() concurrently with reading trace_pipe,
>> a WARN_ON_ONCE() in trace_printk_seq() can be triggered due to a race
>> condition.
>>
>> The issue occurs because:
>>
>> CPU0 (ftrace_dump)                              CPU1 (reader)
>> echo z > /proc/sysrq-trigger
>>
>> !trace_empty(&iter)
>> trace_iterator_reset(&iter) <- len = size = 0
>>                                                 cat /sys/kernel/tracing/trace_pipe
>> trace_find_next_entry_inc(&iter)
>>   __find_next_entry
>>     ring_buffer_empty_cpu <- all empty
>>   return NULL
>>
>> trace_printk_seq(&iter.seq)
>>   WARN_ON_ONCE(s->seq.len >= s->seq.size)
> 
> Thanks for debugging this code. I do appreciate it.
> 
>>
>> In the context between trace_empty() and trace_find_next_entry_inc()
>> during ftrace_dump, the ring buffer data was consumed by other readers.
>> This caused trace_find_next_entry_inc to return NULL, failing to populate
>> `iter.seq`. At this point, due to the prior trace_iterator_reset, both
>> `iter.seq.len` and `iter.seq.size` were set to 0. Since they are equal,
>> the WARN_ON_ONCE condition is triggered.
>>
>> Add a non-NULL check on the return value of trace_find_next_entry_inc
>> prior to invoking trace_printk_seq, ensuring the `iter.seq` is properly
>> populated before subsequent operations.
>>
> 
> 
>> Furthermore, per the seq_buf specification, the condition len == size
>> indicates a full buffer, which constitutes a valid state. Consequently,
>> the equality check and size - 1 adjustment in WARN_ON_ONCE() are redundant
>> and should be eliminated.
>>
>> Fixes: d769041f8653 ("ring_buffer: implement new locking")
>> Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
>> ---
>>  kernel/trace/trace.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 4283ed4e8f59..61c5d389dbd3 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -10521,8 +10521,8 @@ trace_printk_seq(struct trace_seq *s)
>>  	 * PAGE_SIZE, and TRACE_MAX_PRINT is 1000, this is just
>>  	 * an extra layer of protection.
>>  	 */
>> -	if (WARN_ON_ONCE(s->seq.len >= s->seq.size))
>> -		s->seq.len = s->seq.size - 1;
>> +	if (WARN_ON_ONCE(s->seq.len > s->seq.size))
>> +		s->seq.len = s->seq.size;
>>  
> 
> This should be a separate patch as it has nothing to do with the other
> changes. It's also incorrect, which is why you want to make it a separate
> patch, as now this delays the changes below from being accepted.

Understood. I'll split it off right away and send a v2 with only the
relevant changes.

> 
> Yes, the seq_buf specification states this, but this is not using the
> seq_buf interface. It's adding on to it. The code below that change has:
> 
> 	/* should be zero ended, but we are paranoid. */
> 	s->buffer[s->seq.len] = 0;
> 
> You see, it is updating the buffer. Which means it needs its own check.
> If we don't set len to size - 1, the above write will overflow the buffer.
> 
> -- Steve

Indeed, that was an error on my part. The len field should not account for
the null terminator. Thank you for the correction.

There remains an edge case that concerns me: if size is 0, setting len to
size - 1 would cause an underflow. Should we handle this edge case?

-- Tengda

> 
> 
> 
>>  	/* should be zero ended, but we are paranoid. */
>>  	s->buffer[s->seq.len] = 0;
>> @@ -10617,6 +10617,7 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>>  	 */
>>  
>>  	while (!trace_empty(&iter)) {
>> +		void *ent;
>>  
>>  		if (!cnt)
>>  			printk(KERN_TRACE "---------------------------------\n");
>> @@ -10625,17 +10626,18 @@ static void ftrace_dump_one(struct trace_array *tr, enum ftrace_dump_mode dump_m
>>  
>>  		trace_iterator_reset(&iter);
>>  		iter.iter_flags |= TRACE_FILE_LAT_FMT;
>> +		ent = trace_find_next_entry_inc(&iter);
>>  
>> -		if (trace_find_next_entry_inc(&iter) != NULL) {
>> +		if (ent) {
>>  			int ret;
>>  
>>  			ret = print_trace_line(&iter);
>>  			if (ret != TRACE_TYPE_NO_CONSUME)
>>  				trace_consume(&iter);
>> +
>> +			trace_printk_seq(&iter.seq);
>>  		}
>>  		touch_nmi_watchdog();
>> -
>> -		trace_printk_seq(&iter.seq);
>>  	}
>>  
>>  	if (!cnt)

