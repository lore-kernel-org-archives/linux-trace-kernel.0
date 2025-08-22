Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6725281732;
	Fri, 22 Aug 2025 01:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825990; cv=none; b=e5SvA2iiK5u3z4nwlCtsFtxuTAsxpF3xEdFW0BSpGJflKhlwkBKoA862IxwrUoUHyzzhzRVmQlPk7lxL2+JDe0LwwaXR5ETf2QP+dlBGKghDTPcbPTO5mddbIypNjRPR1vrOvcII9Q2YZry5TIYBy+rNBm90YnwWjuzlW5Udw8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825990; c=relaxed/simple;
	bh=dL+tNK8irqmkqr5Oj7Gsu1orlNCurPKsma4kH5E3iZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QL6K6uUlXgYYgA7XdSnj6ntNcjgC0/VFi4YlB9/h6+t1iTFDb81fGSR7yaQQZnGcZrge2EAEbiys+akaDFslP3qjWB7NjJNkuYk4F3pw0xBkjNMRDCNbkHBqAQ4DWEYN6PaSuqD9EqzoWEJOHryznORI7HsSxT9C8WL7GOoghd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c7MwJ0hx5zKHMtV;
	Fri, 22 Aug 2025 09:26:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 93D721A1989;
	Fri, 22 Aug 2025 09:26:23 +0800 (CST)
Received: from [10.67.110.36] (unknown [10.67.110.36])
	by APP2 (Coremail) with SMTP id Syh0CgDX5LY+x6donji7EQ--.56706S2;
	Fri, 22 Aug 2025 09:26:23 +0800 (CST)
Message-ID: <84a2f916-47c5-4c6f-9d36-771f60db35fc@huaweicloud.com>
Date: Fri, 22 Aug 2025 09:26:22 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] ftrace: Fix potential warning in
 trace_printk_seq during ftrace_dump
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ingo Molnar <mingo@elte.hu>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250821021120.2986553-1-wutengda@huaweicloud.com>
 <20250821110503.5f5c3156@gandalf.local.home>
Content-Language: en-US
From: Tengda Wu <wutengda@huaweicloud.com>
In-Reply-To: <20250821110503.5f5c3156@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDX5LY+x6donji7EQ--.56706S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AryDXF4rZFW5tw1kGw4xCrg_yoW8Aw1Dpr
	yfKFZrAFZ5JFWUtF1I9r1jyF1xt34ftry7Grs8Jr1rXrsxAryI9ryIyrnagryfA3s8Gr9a
	yF4Yy34Uuw17XFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2025/8/21 23:05, Steven Rostedt wrote:
> On Thu, 21 Aug 2025 02:11:20 +0000
> Tengda Wu <wutengda@huaweicloud.com> wrote:
> 
>  tested this and was writing the change log for the pull request when I
> realized an issue.
> 
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 4283ed4e8f59..b4cec22753ea 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
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
> 
> Why do we need "ent"?
> 
> 
>>  			int ret;
>>  
>>  			ret = print_trace_line(&iter);
>>  			if (ret != TRACE_TYPE_NO_CONSUME)
>>  				trace_consume(&iter);
>> +
>> +			trace_printk_seq(&iter.seq);
> 
> Isn't just moving trace_printk_seq() enough?
> 
> The code is no different with or without the "ent" as "ent" is not used in
> the if block.
> 
> -- Steve

I apologize, as this is a trace left over from the initial patch modification
process. While working with the original code, I added an `if (ent)` branch
directly to trace_printk_seq and later realized it could be merged with the
previous `if (ent)` branch. However, I forgot to remove the now-redundant ent
after the merge. 

I will correct this immediately and resend a new version.

-- Tengda



> 
> 
>>  		}
>>  		touch_nmi_watchdog();
>> -
>> -		trace_printk_seq(&iter.seq);
>>  	}
>>  
>>  	if (!cnt)

