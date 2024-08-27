Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808F9610C;
	Tue, 27 Aug 2024 01:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724722203; cv=none; b=TlgGCmDgQsOZUZrlLXDqyyN8Dk0oyLwllNL54wuuiOU4df7TKIQBGzFVOVwtJZI/xHzMsWC+vpCVMVgDRUkUjD81KQR/W2pvOHY0SmXln2UuBXDwy8I+oHGGoKVhm5HHCAM0GLemVnsnC3iHLYSzdD7x2wigIu/2A9iUcnWmGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724722203; c=relaxed/simple;
	bh=AwEMRZS7uuGOhCya3oTw6TWV0lBfRhLq3lMKHrvR1YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZaKLue56tSCTs2mdCWcn1I7zMChL5NVGXuklSccat0cs0UMSlxELIjN/j0leZNl3+/tSlQCgiqBKxcXrz7DxRwGe+i2Ybr5vsNj0ojA5o0FR0y6wXrUpjk9a3M2XWG6CYTwSdNMsWomj8KNYaud03rn7wZJKSX+lkzgNNo8mihg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Wt92F6PvTz4f3js0;
	Tue, 27 Aug 2024 09:29:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 62EB21A06D7;
	Tue, 27 Aug 2024 09:29:56 +0800 (CST)
Received: from [10.67.111.172] (unknown [10.67.111.172])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4UTLM1mLqpKCw--.50484S3;
	Tue, 27 Aug 2024 09:29:56 +0800 (CST)
Message-ID: <d3c2ecfd-6590-dc17-4ea5-d80872d01016@huaweicloud.com>
Date: Tue, 27 Aug 2024 09:29:55 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] tracing: Mitigate possible softlockup in __tracing_open()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20240824030343.3218618-1-zhengyejian@huaweicloud.com>
 <20240826103522.390faa85@gandalf.local.home>
Content-Language: en-US
From: Zheng Yejian <zhengyejian@huaweicloud.com>
In-Reply-To: <20240826103522.390faa85@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBnj4UTLM1mLqpKCw--.50484S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw13Kw1fXrW3Zw45CF1kGrg_yoW8ZFWkpF
	4YqFW2kanrWw45Jws2vr1ruFyjv3yftFy7CFW7Cw4rAry5Wryaqr90ga1agF47ArySk343
	tFWYkwnruryjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

On 2024/8/26 22:35, Steven Rostedt wrote:
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
> This is the wrong place to put this. If the problem is with
> tracing_iter_reset(), then add it there.
> 
> 	while (ring_buffer_iter_peek(buf_iter, &ts)) {
> 		if (ts >= iter->array_buffer->time_start)
> 			break;
> 		entries++;
> 		ring_buffer_iter_advance(buf_iter);
> 		/* This could be a big loop */
> 		cond_resched();

Do resched check every event peek, I'm afraid there will
be too many 're-schedule'.

> 	}
> 
> -- Steve
> 
> 
> 
>>   		}
>>   	} else {
>>   		cpu = iter->cpu_file;
> 

-- 
Thanks,
Zheng Yejian

