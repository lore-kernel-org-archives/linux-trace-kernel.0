Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0217494;
	Mon,  8 Sep 2025 03:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757300753; cv=none; b=d2LPKjvKyA6hahBcrxq9NjzyOeClPAunEMpu5pl5hdAP4EUGiUVB+GqLnoH4uZDbQXv3u5vupj+ogJjHJUC7qxrDSDX+d+rc9IHKkoPxnThkOps5mWAF2pRtSjsFUOIzyhWm3GluWRrKUNU1UW246GT7u/15VO0LIKw/Q6x9LVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757300753; c=relaxed/simple;
	bh=ZeAba/8iHPIdPczuLNtg9WZ2+y9oI+CjD0xHcRnDX0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DHFOYrNFKlPtjl5F0JDlkyFurat5Ni7Pv0sznpDuVx6y+SaAoB9W1EbeGizggo/NjAXN9N7LEok3dwmN6eQcbmtWafPQ+tQBZ5xf0bzpCx9ngjTVyK5LNxZVHyOnndOdT9l+MHVkqJIoyGOjtcfiwI2+1zpKYg96ESJd+Y5Ehcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4cKrx0351Cz3tZZW;
	Mon,  8 Sep 2025 10:48:20 +0800 (CST)
Received: from kwepemf100007.china.huawei.com (unknown [7.202.181.221])
	by mail.maildlp.com (Postfix) with ESMTPS id B09A418005F;
	Mon,  8 Sep 2025 10:47:11 +0800 (CST)
Received: from [10.67.109.184] (10.67.109.184) by
 kwepemf100007.china.huawei.com (7.202.181.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 8 Sep 2025 10:47:11 +0800
Message-ID: <f1cb1d05-d4da-4a5f-a7b2-0316feda71ff@huawei.com>
Date: Mon, 8 Sep 2025 10:47:10 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Fix missing errno when zero parser->idx in
 trace_pid_write
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, Pu Lehui
	<pulehui@huaweicloud.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <20250821071721.3609109-1-pulehui@huaweicloud.com>
 <e3c22d00-1a0c-45e0-bc76-955d367ab4d1@huawei.com>
 <20250905153926.68b47107@gandalf.local.home>
From: Pu Lehui <pulehui@huawei.com>
In-Reply-To: <20250905153926.68b47107@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf100007.china.huawei.com (7.202.181.221)


On 2025/9/6 3:39, Steven Rostedt wrote:
> On Wed, 3 Sep 2025 12:15:16 +0800
> Pu Lehui <pulehui@huawei.com> wrote:
> 
>> As for this fault injection syzkaller issue, shall we need to silence
>> it? How about the below fix?
> 
> I usually don't care about fault injections because it causes "faults" that
> would only happen if the system was about to crash. But anyway..

agree!

> 
>>
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index e6b50b416e63..c17c031e7917 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -834,7 +834,11 @@ int trace_pid_write(struct trace_pid_list
>> *filtered_pids,
>>                   /* copy the current bits to the new max */
>>                   ret = trace_pid_list_first(filtered_pids, &pid);
>>                   while (!ret) {
>> -                       trace_pid_list_set(pid_list, pid);
>> +                       ret = trace_pid_list_set(pid_list, pid);
>> +                       if (ret) {
>> +                               trace_parser_put(&parser);
>> +                               return ret;
>> +                       }
> 
> make it:
> 
> 			if (ret < 0)
> 				goto out;
> 
>>                           ret = trace_pid_list_next(filtered_pids, pid +
>> 1, &pid);
>>                           nr_pids++;
>>                   }
> 
> And put the out label just before the trace_parser_put().
> 
> Oh, and add one space before the "out:" label. That makes diffs of patches
> show the function when changes are after the label and not the label itself.

Looks like an interesting ops. Will do

> 
> -- Steve
> 
