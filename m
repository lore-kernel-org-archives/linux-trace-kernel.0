Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B9913C806;
	Thu,  9 May 2024 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715218752; cv=none; b=IGeDeIEVOgYzItvyXrI5ZSc/21U4p5bsw8Faf5ty7nYBEhAAxR0WyGamDht8oolBd/wLBcK4ZB8C6IsoXtMliB2O/XJYUd4GMDkaOg8aWsJHxnqe/vg70KL1DeGYq1mAPQ0Pw8CtN2FnnXw/OEuGZnmF85CPsopweqdHT4Q1CKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715218752; c=relaxed/simple;
	bh=uV0uxdDdrSHErql95GNjG6bFDTq9DwASFsBPqw/Z8Is=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hBTrMCguq/WivIA1mxYgo4IDiDQWRGRB7uMV0hk+8mmtifAf/A64AZeimBPukEmLOt9SMGbxAm1pOOJtAj05KScdos4iNom+H14vS2BKeffPIF6zGmsrl0voaXpdqs2288h/t7AbKC8nMZxSuDR2G45nkzU/lceTTFU+lWxLlZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VZZN16X0zzvSYj;
	Thu,  9 May 2024 09:35:45 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id A97FD180A9F;
	Thu,  9 May 2024 09:39:06 +0800 (CST)
Received: from [10.67.111.172] (10.67.111.172) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 9 May 2024 09:39:06 +0800
Message-ID: <b5aeabea-b077-2b16-4bcc-dd4dd8d8e6e9@huawei.com>
Date: Thu, 9 May 2024 09:39:06 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3] ftrace: Fix possible use-after-free issue in
 ftrace_location()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
CC: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
	<mathieu.desnoyers@efficios.com>, <Markus.Elfring@web.de>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
References: <20240401125543.1282845-1-zhengyejian1@huawei.com>
 <20240417032830.1764690-1-zhengyejian1@huawei.com>
 <20240502170743.15a5ff1c@gandalf.local.home>
From: Zheng Yejian <zhengyejian1@huawei.com>
In-Reply-To: <20240502170743.15a5ff1c@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)

On 2024/5/3 05:07, Steven Rostedt wrote:
> On Wed, 17 Apr 2024 11:28:30 +0800
> Zheng Yejian <zhengyejian1@huawei.com> wrote:
> 
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index da1710499698..e05d3e3dc06a 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -1581,7 +1581,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
>>   }
>>   
>>   /**
>> - * ftrace_location_range - return the first address of a traced location
>> + * ftrace_location_range_rcu - return the first address of a traced location
> 
> kerneldoc comments are for external functions. You need to move this down
> to ftrace_location_range() as here you are commenting a local static function.

I'll do it in v4.

> 
> But I have to ask, why did you create this static function anyway? There's
> only one user of it (the ftrace_location_range()). Why didn't you just
> simply add the rcu locking there?

Yes, the only-one-user function looks ugly.
At first thought that ftrace_location_range() needs to a lock, I just do like that,
no specital reason.

> 
> unsigned long ftrace_location_range(unsigned long start, unsigned long end)
> {
> 	struct dyn_ftrace *rec;
> 	unsigned long ip = 0;
> 
> 	rcu_read_lock();
> 	rec = lookup_rec(start, end);
> 	if (rec)
> 		ip = rec->ip;
> 	rcu_read_unlock();
> 
> 	return ip;
> }
> 
> -- Steve
> 
> 
>>    *	if it touches the given ip range
>>    * @start: start of range to search.
>>    * @end: end of range to search (inclusive). @end points to the last byte
>> @@ -1592,7 +1592,7 @@ static struct dyn_ftrace *lookup_rec(unsigned long start, unsigned long end)
>>    * that is either a NOP or call to the function tracer. It checks the ftrace
>>    * internal tables to determine if the address belongs or not.
>>    */
>> -unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>> +static unsigned long ftrace_location_range_rcu(unsigned long start, unsigned long end)
>>   {
>>   	struct dyn_ftrace *rec;
>>   
>> @@ -1603,6 +1603,16 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>>   	return 0;
>>   }
>>   
>> +unsigned long ftrace_location_range(unsigned long start, unsigned long end)
>> +{
>> +	unsigned long loc;
>> +
>> +	rcu_read_lock();
>> +	loc = ftrace_location_range_rcu(start, end);
>> +	rcu_read_unlock();
>> +	return loc;
>> +}
> 

