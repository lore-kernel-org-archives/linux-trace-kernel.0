Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E08462;
	Wed, 13 Aug 2025 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755056909; cv=none; b=gqDhA+Z8SdnI00p45WFwq330Cf/zev/nMfTBP2CZ60nhSH5HBCdil5xSHU02esSd14mHl2t1JEj+R1P+A0ekGDwZXp0TPGnKsQJY+38u/Df9FZlXCSqJQq6WeGfrKkD9LvtPGbP3onvpfjoo6hLJTWJmrTY3DJYxSYCuxRxYvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755056909; c=relaxed/simple;
	bh=SnN0Z/SHpOjfpRepzSQsa2MnHFe2VkpOH80abZi1T1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I9mKt6W4Z6QdqppiOdWVouUwxyA+pBIbVDkk5LcMt0H7X7JePVVdzDP0qmEqyCdbsSLmCWF92KC59zNUrHUCQ3i2S0vj/Gbp4ZZX3XjySYcXvruKUGjLinq6w/79LiW3p0r1NeU7PEmhBtL/1ffTPZ/iUSpWSy9r4GyRfOQylGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c1vVH4vVgzKHMbW;
	Wed, 13 Aug 2025 11:48:23 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id EA4B41A13B5;
	Wed, 13 Aug 2025 11:48:22 +0800 (CST)
Received: from [10.67.109.184] (unknown [10.67.109.184])
	by APP3 (Coremail) with SMTP id _Ch0CgBXz9kFC5xoh4nEDQ--.26062S2;
	Wed, 13 Aug 2025 11:48:22 +0800 (CST)
Message-ID: <83c1747d-1e8e-45e9-a6a4-619bad4db1d4@huaweicloud.com>
Date: Wed, 13 Aug 2025 11:48:21 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: Limit access to parser->buffer when
 trace_get_user failed
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 pulehui@huawei.com
References: <20250806070109.1320165-1-pulehui@huaweicloud.com>
 <20250812143812.3df42a3c@gandalf.local.home>
From: Pu Lehui <pulehui@huaweicloud.com>
In-Reply-To: <20250812143812.3df42a3c@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgBXz9kFC5xoh4nEDQ--.26062S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZF1xArW8Aw13trWxArWxCrg_yoW5Xr45pa
	45KFs7JwsFqFWIyr40qr1kGa40q34rKryUGa1rJa4Yyr9FyrnF9rWxur9I9w1ftr18G3y7
	AF4Yvr4jkr12qFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/



On 2025/8/13 2:38, Steven Rostedt wrote:
> On Wed,  6 Aug 2025 07:01:09 +0000
> Pu Lehui <pulehui@huaweicloud.com> wrote:
> 
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index 4283ed4e8f59..138212f4ecde 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -1814,9 +1814,11 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>>   	if (!*ppos)
>>   		trace_parser_clear(parser);
>>   
>> +	parser->fail = false;
> 
> This should be set when the parser is initialized.

Hi Steven,

parser->fail will always be set `false` when the parser is initialized, 
as trace_parser_get_init will do `memset(parser, 0, sizeof(*parser))`.

I will remove this in next.

> 
>> +
>>   	ret = get_user(ch, ubuf++);
>>   	if (ret)
>> -		return ret;
>> +		goto fail;
>>   
>>   	read++;
>>   	cnt--;
>> @@ -1830,7 +1832,7 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>>   		while (cnt && isspace(ch)) {
>>   			ret = get_user(ch, ubuf++);
>>   			if (ret)
>> -				return ret;
>> +				goto fail;
>>   			read++;
>>   			cnt--;
>>   		}
>> @@ -1848,12 +1850,14 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>>   	while (cnt && !isspace(ch) && ch) {
>>   		if (parser->idx < parser->size - 1)
>>   			parser->buffer[parser->idx++] = ch;
>> -		else
>> -			return -EINVAL;
>> +		else {
>> +			ret = -EINVAL;
>> +			goto fail;
>> +		}
>>   
>>   		ret = get_user(ch, ubuf++);
>>   		if (ret)
>> -			return ret;
>> +			goto fail;
>>   		read++;
>>   		cnt--;
>>   	}
>> @@ -1868,11 +1872,15 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
>>   		/* Make sure the parsed string always terminates with '\0'. */
>>   		parser->buffer[parser->idx] = 0;
>>   	} else {
>> -		return -EINVAL;
>> +		ret = -EINVAL;
>> +		goto fail;
>>   	}
>>   
>>   	*ppos += read;
>>   	return read;
>> +fail:
>> +	parser->fail = true;
> 
> Should have a helper function called: trace_parser_fail(parser) and use
> that.

Alright! Will make it next version.

> 
> -- Steve
> 
> 
>> +	return ret;
>>   }
>>   
>>   /* TODO add a seq_buf_to_buffer() */
>> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
>> index 1dbf1d3cf2f1..5072bb25a860 100644
>> --- a/kernel/trace/trace.h
>> +++ b/kernel/trace/trace.h
>> @@ -1292,6 +1292,7 @@ bool ftrace_event_is_function(struct trace_event_call *call);
>>    */
>>   struct trace_parser {
>>   	bool		cont;
>> +	bool		fail;
>>   	char		*buffer;
>>   	unsigned	idx;
>>   	unsigned	size;
>> @@ -1299,7 +1300,7 @@ struct trace_parser {
>>   
>>   static inline bool trace_parser_loaded(struct trace_parser *parser)
>>   {
>> -	return (parser->idx != 0);
>> +	return !parser->fail && parser->idx != 0;
>>   }
>>   
>>   static inline bool trace_parser_cont(struct trace_parser *parser)

