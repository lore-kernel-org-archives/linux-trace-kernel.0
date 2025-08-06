Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E24431;
	Wed,  6 Aug 2025 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754463552; cv=none; b=LPBvORwYhbLyPWoH8QHeor9+ZevVDUGs8zCgDLF+YqtjV7tUi3GMqWpec0ND67807amNt+n1KNZ8h5J/KgvTzfPP3FvcnRzJhubtGfTWYreqTPjzSkmx/GlXgMkXE3zGUQluyDPuvAtdSZk2I5q77t2HIqZAoG1sJbGd+oBneMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754463552; c=relaxed/simple;
	bh=PQA6tx73WkR8H83aszz/kuFGQzKimpkkN8xSyRo+0T8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OPRYl2UK2Cw5Wd93clecqfCWiY9uECRGTkM47NH7j0Z4GR7M+qsn53hogfc1NYL8vBzhLCjsHR+qjcJfK6rvK0yXKrOlKXwsvlm/EGA6/7lZlOFYvxw7moGK6YCYgU9Zl1IXo9KkD6weYG+8k29J7OQG/k07WbSCdeJGjUnIfa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxh3Y3KfRzKHMqJ;
	Wed,  6 Aug 2025 14:59:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 827591A0359;
	Wed,  6 Aug 2025 14:59:04 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP4 (Coremail) with SMTP id gCh0CgAX3w80_ZJoSpv5Cg--.21910S2;
	Wed, 06 Aug 2025 14:59:01 +0800 (CST)
Message-ID: <63f8a8d8-9f5e-49ac-8420-0a6dff638ea1@huaweicloud.com>
Date: Wed, 6 Aug 2025 14:59:00 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Zero-initialize parser->buffer to avoid OOB
 access
Content-Language: en-US
From: Pu Lehui <pulehui@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20250805151203.1214790-1-pulehui@huaweicloud.com>
 <20250805111903.3114427b@gandalf.local.home>
 <acf17610-e427-4b78-949f-2b1d03400d5f@huaweicloud.com>
In-Reply-To: <acf17610-e427-4b78-949f-2b1d03400d5f@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgAX3w80_ZJoSpv5Cg--.21910S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtr1fGr1kJF4fCr43Jr48Crg_yoW7Aw1fpF
	Z5KFZ7KrW7KFs2yr42qr1kJFy8Xw15J34UGF1kJa4FvFsrtr1jgrW7Wr1q9w17CrW8JrWU
	Jr1F9rW29r1UXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/8/6 11:14, Pu Lehui wrote:
> 
> 
> On 2025/8/5 23:19, Steven Rostedt wrote:
>> On Tue,  5 Aug 2025 15:12:03 +0000
>> Pu Lehui <pulehui@huaweicloud.com> wrote:
>>
>>> From: Pu Lehui <pulehui@huawei.com>
>>>
>>> When the length of the string written to set_ftrace_filter exceeds
>>> FTRACE_BUFF_MAX, the following KASAN alarm will be triggered:
>>>
>>> BUG: KASAN: slab-out-of-bounds in strsep+0x18c/0x1b0
>>> Read of size 1 at addr ffff0000d00bd5ba by task ash/165
>>>
>>> CPU: 1 UID: 0 PID: 165 Comm: ash Not tainted 
>>> 6.16.0-g6bcdbd62bd56-dirty #3 NONE
>>> Hardware name: linux,dummy-virt (DT)
>>> Call trace:
>>>   show_stack+0x34/0x50 (C)
>>>   dump_stack_lvl+0xa0/0x158
>>>   print_address_description.constprop.0+0x88/0x398
>>>   print_report+0xb0/0x280
>>>   kasan_report+0xa4/0xf0
>>>   __asan_report_load1_noabort+0x20/0x30
>>>   strsep+0x18c/0x1b0
>>>   ftrace_process_regex.isra.0+0x100/0x2d8
>>>   ftrace_regex_release+0x484/0x618
>>>   __fput+0x364/0xa58
>>>   ____fput+0x28/0x40
>>>   task_work_run+0x154/0x278
>>>   do_notify_resume+0x1f0/0x220
>>>   el0_svc+0xec/0xf0
>>>   el0t_64_sync_handler+0xa0/0xe8
>>>   el0t_64_sync+0x1ac/0x1b0
>>>
>>> The reason is that trace_get_user will fail when processing a string
>>> longer than FTRACE_BUFF_MAX, but not set the end of parser->buffer
>>> to 0. Then an oob access will be triggered in ftrace_regex_release->
>>> ftrace_process_regex->strsep->strpbrk. We can solve this problem by
>>> zero-initializing parser->buffer.
>>>
>>> Fixes: 8c9af478c06b ("ftrace: Handle commands when closing 
>>> set_ftrace_filter file")
>>
>> Fix one bug then create another!!!
>>
>>> Signed-off-by: Pu Lehui <pulehui@huawei.com>
>>> ---
>>>   kernel/trace/trace.c | 5 +----
>>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>>
>>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>>> index 4283ed4e8f59..97e66cbd3617 100644
>>> --- a/kernel/trace/trace.c
>>> +++ b/kernel/trace/trace.c
>>> @@ -1776,7 +1776,7 @@ int trace_parser_get_init(struct trace_parser 
>>> *parser, int size)
>>>   {
>>>       memset(parser, 0, sizeof(*parser));
>>> -    parser->buffer = kmalloc(size, GFP_KERNEL);
>>> +    parser->buffer = kzalloc(size, GFP_KERNEL);
>>>       if (!parser->buffer)
>>>           return 1;
>>> @@ -1860,13 +1860,10 @@ int trace_get_user(struct trace_parser 
>>> *parser, const char __user *ubuf,
>>>       /* We either got finished input or we have to wait for another 
>>> call. */
>>>       if (isspace(ch) || !ch) {
>>> -        parser->buffer[parser->idx] = 0;
>>>           parser->cont = false;
>>>       } else if (parser->idx < parser->size - 1) {
>>>           parser->cont = true;
>>>           parser->buffer[parser->idx++] = ch;
>>> -        /* Make sure the parsed string always terminates with '\0'. */
>>> -        parser->buffer[parser->idx] = 0;
>>
>> The returned buffer is expected to end with a '0'. This now removes 
>> that if
>> the idx is the length of the parser.
> 
> Hi Steven,
> 
> Not really, if the idx is the length of the parser, which also mean that 
> the length of user string is parser->size, then it will goto fail branch 
> [0]. And with this patch, it will also terminates with '\0'.
> 
> Link: 
> https://elixir.bootlin.com/linux/v6.16/source/kernel/trace/trace.c#L1903 
> [0]
> 

Hi Steven,

After a while of thinking, I think we should limit the use of 
parser->buffer when trace_get_user fails to parse. And I sent a new 
version [0]. Hope that will be fine.

Link: 
https://lore.kernel.org/all/20250806070109.1320165-1-pulehui@huaweicloud.com/ 
[0]

>>
>>>       } else {
>>>           return -EINVAL;
>>>       }
>>
>> The real fix would be:
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index d0b1964648c1..422224a55f1d 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -815,7 +815,7 @@ int trace_pid_write(struct trace_pid_list 
>> *filtered_pids,
>>       loff_t pos;
>>       pid_t pid;
>> -    if (trace_parser_get_init(&parser, PID_BUF_SIZE + 1))
>> +    if (trace_parser_get_init(&parser, PID_BUF_SIZE))
>>           return -ENOMEM;
>>       /*
>> @@ -1776,7 +1776,7 @@ int trace_parser_get_init(struct trace_parser 
>> *parser, int size)
>>   {
>>       memset(parser, 0, sizeof(*parser));
>> -    parser->buffer = kmalloc(size, GFP_KERNEL);
>> +    parser->buffer = kmalloc(size + 1, GFP_KERNEL);
>>       if (!parser->buffer)
>>           return 1;
>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>> index 05447b958a1a..a3ce88a48947 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
>> @@ -1507,7 +1507,7 @@ ftrace_event_write(struct file *file, const char 
>> __user *ubuf,
>>       if (ret < 0)
>>           return ret;
>> -    if (trace_parser_get_init(&parser, EVENT_BUF_SIZE + 1))
>> +    if (trace_parser_get_init(&parser, EVENT_BUF_SIZE))
>>           return -ENOMEM;
>>       read = trace_get_user(&parser, ubuf, cnt, ppos);
>>
>> -- Steve

