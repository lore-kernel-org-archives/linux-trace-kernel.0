Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F01BE6F;
	Mon, 26 Aug 2024 02:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640965; cv=none; b=Uy7HxZ5nyCfcVOBwxeKq3y7+91QIOuBbHaJT7qaxQmqBjjD//hhJKJXOlJtnkSM4y5iS2DrGpLAZ7ZzVXniLUQuCAl+cE4kN+OQZEtRQPV+IX4uzQGBdGNXCyU5thX+14egoxsOUdwI8+WOrGJAKCDDjfLkZpcd2z3v4SMOzHNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640965; c=relaxed/simple;
	bh=Mife1Uam8Oe+LV0jJsBd34x76Yz1AxEmv1UyTdiz3yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jMdiC4vOpz1mtAH474NBWIWG5kOb5pg63WA2YgXTeD0EpFrsv6U3d0C94G5nJFX36ZH20SpuAgZAwp/yuhMv1tmxUWGFnPhrC/hCXUjgqE6z345FciruXrT1L8xG4KXmtlLUfLMIJcCe6pZ5u7F0SAdfGTDqCn092DY3+liyEMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WsZzz6xYDz4f3l26;
	Mon, 26 Aug 2024 10:55:43 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 50C861A0359;
	Mon, 26 Aug 2024 10:55:59 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4W+7stmqBjxCg--.7877S3;
	Mon, 26 Aug 2024 10:55:59 +0800 (CST)
Message-ID: <e3eea04f-7240-b659-c294-b657fcef4b06@huaweicloud.com>
Date: Mon, 26 Aug 2024 10:55:58 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing: Mitigate possible softlockup in __tracing_open()
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240824030343.3218618-1-zhengyejian@huaweicloud.com>
 <20240826000531.5ff4cc3c3d6a48ecc26069dd@kernel.org>
Content-Language: en-US
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20240826000531.5ff4cc3c3d6a48ecc26069dd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3n4W+7stmqBjxCg--.7877S3
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW8KrW8JryfZF1UGrWrGrg_yoW8uF4DpF
	WaqFWDKa1DXw45J392vF18uFyav34xtFy7GFWUCw4fAry5Gr9Iqr9Fga1YgF47Ar9ak34S
	yFWakw1Du34jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21lc7CjxVAaw2AF
	wI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1D
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVb
	kUUUUU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

On 2024/8/25 23:05, Masami Hiramatsu (Google) wrote:
> On Sat, 24 Aug 2024 11:03:43 +0800
> Zheng Yejian <zhengyejian@huaweicloud.com> wrote:
> 
>> In __tracing_open(), when max latency tracers took place on the cpu,
>> the time start of its buffer would be updated, then event entries with
>> timestamps being earlier than start of the buffer would be skipped
>> (see tracing_iter_reset()).
>>
>> Softlockup will occur if the kernel is non-preemptible and too many
>> entries were skipped in the loop that reset every cpu buffer, so add
>> cond_resched() to avoid it.
>>
>> Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
>> ---
>>   kernel/trace/trace.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index ebe7ce2f5f4a..88faa95b457b 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -4706,6 +4706,15 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
>>   		for_each_tracing_cpu(cpu) {
>>   			ring_buffer_read_start(iter->buffer_iter[cpu]);
>>   			tracing_iter_reset(iter, cpu);
>> +			/*
>> +			 * When max latency tracers took place on the cpu, the time start
>> +			 * of its buffer would be updated, then event entries with timestamps
>> +			 * being earlier than start of the buffer would be skipped
>> +			 * (see tracing_iter_reset()). Softlockup will occur if the kernel
>> +			 * is non-preemptible and too many entries were skipped in the loop,
>> +			 * so add cond_resched() to mitigate it.
>> +			 */
>> +			cond_resched();
> 
> OK, but why we cond_resched() only here? Another tracing_iter_reset() in
> s_start() does not cause the soft lockups in the same situation?
> 

Sorry for the late reply.

__tracing_open() is called when trace file is being opened,
s_start() is called when trace file is being read. Normally,
we read immediately after open at which tracing_iter_reset() was
just called, softlockup may be not that easily triggered in
s_start(), do we need cond_resched() there?



> Thank you,
> 
> 
>>   		}
>>   	} else {
>>   		cpu = iter->cpu_file;
>> -- 
>> 2.25.1
>>
>>
> 
> 

-- 
Thanks,
Zheng Yejian

