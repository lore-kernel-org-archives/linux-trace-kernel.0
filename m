Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6858B1A841C;
	Sat,  6 Sep 2025 02:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757127513; cv=none; b=GChzP8iubG1YvxNBoVW1rnS0ayJlwwKwGyc2IfEof9MPOOg/arcq1j6iwXp0aR7shAhs+MW0bAqE98GnYLATTN2iaV1vA293v3Riqe7sGzre4H+8gNbLzMMTbk6fDjgdIVr68iSxghlS1c3c0qGeLDXXSchER199ZaYfAMrddiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757127513; c=relaxed/simple;
	bh=BR7AZm0ueoFOlG4zYEazaHx31PCYTwxVD+hG2a9IOk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=eYMnMe9PNIZIABEyBQTdYmrvW2qF+SNbTr75UYnkoHBYl0uF9Oyic6+FiOdA3zBbZXE9Dp6AbVfgUtofkbLgcxWENXEHjMLvTTgrJ2qpXQS2jOsjMQ5Xf+f6SgjnJLcI56py5RXFq+jKy4NGmvOYomSZCTwcvrHUjqE35al0NBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cJdDW6KKjztTTS;
	Sat,  6 Sep 2025 10:57:31 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id C6F111402EA;
	Sat,  6 Sep 2025 10:58:27 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 6 Sep 2025 10:58:26 +0800
Message-ID: <54df95d3-e8fe-4aa2-966d-bd580cdf2b86@huawei.com>
Date: Sat, 6 Sep 2025 10:58:25 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] tracing/osnoise: fix null-ptr-deref in
 bitmap_parselist
To: Steven Rostedt <rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
	<tglozar@redhat.com>, <yuehaibing@huawei.com>, <zhangchangzhong@huawei.com>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20250905032544.231962-1-wangliang74@huawei.com>
 <20250905184456.084d1ff3@gandalf.local.home>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <20250905184456.084d1ff3@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/9/6 6:44, Steven Rostedt 写道:
> On Fri, 5 Sep 2025 11:25:44 +0800
> Wang Liang <wangliang74@huawei.com> wrote:
>
> Hi Wang,
>
> FYI, the tracincg subsystem requires capital subject:
>
>    tracing/osnoise: Fix null-ptr-deref in bitmap_parselist()
>
> And parenthesis for function names.


Thanks for your guide, it is clear and helpful!

>> A crash was observed with the following output:
>>
>> BUG: kernel NULL pointer dereference, address: 0000000000000010
>> Oops: Oops: 0000 [#1] SMP NOPTI
>> CPU: 2 UID: 0 PID: 92 Comm: osnoise_cpus Not tainted 6.17.0-rc4-00201-gd69eb204c255 #138 PREEMPT(voluntary)
>> RIP: 0010:bitmap_parselist+0x53/0x3e0
>> Call Trace:
>>   <TASK>
>>   osnoise_cpus_write+0x7a/0x190
>>   vfs_write+0xf8/0x410
>>   ? do_sys_openat2+0x88/0xd0
>>   ksys_write+0x60/0xd0
>>   do_syscall_64+0xa4/0x260
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>   </TASK>
>>
>> This issue can be reproduced by below code:
>>
>> fd=open("/sys/kernel/debug/tracing/osnoise/cpus", O_WRONLY);
>> write(fd, "0-2", 0);
>>
>> When user pass 'count=0' to osnoise_cpus_write(), kmalloc() will return
>> ZERO_SIZE_PTR (16) and cpulist_parse() treat it as a normal value, which
>> trigger the null pointer dereference. Add check for the parameter 'count'.
>>
>> Fixes: 17f89102fe23 ("tracing/osnoise: Allow arbitrarily long CPU string")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   kernel/trace/trace_osnoise.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
>> index fd259da0aa64..edf5178d0317 100644
>> --- a/kernel/trace/trace_osnoise.c
>> +++ b/kernel/trace/trace_osnoise.c
>> @@ -2322,6 +2322,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
>>   	int running, err;
>>   	char *buf __free(kfree) = NULL;
>>   
>> +	if (count < 1)
>> +		return -EINVAL;
> Sending a count of 0 is not invalid. This should simply return 0;
>
> -- Steve


Ok. I will correct it and send a v2 patch later.

------
Best regards
Wang Liang

>> +
>>   	buf = kmalloc(count, GFP_KERNEL);
>>   	if (!buf)
>>   		return -ENOMEM;
>
