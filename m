Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB01D195985;
	Mon, 23 Sep 2024 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090200; cv=none; b=XNZYceyImDVwNw+4r+B9mOMZD0XEVUF6/g31qzbSdlAzSMC1FPfjcSK/V7CL5gy9nYS1S14zeD4eBTDu8pCNt306SPxvYhKM8CBLmxA8v1Ld/Vlb7te5H4AJCQqhD9LWiPuSRdsPCzjhFfslLSA8l1FoK2X6ezW9WSxmdqZkRNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090200; c=relaxed/simple;
	bh=V91hipl91S+w3t5stQOLIg/YqcOv7WdMlL/qqgM5cjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Dee05EQGZwX82jApdeixow6uISUKCPuZpoYevWAcvcrLTgrnI1TiyI4EJ3kWIepMOSUoMlUs2y+S/DRnKz/y/1U0uAN0x9bH4aoul190gbnrStEabBPAvfDnjUIeXhzPzG6AW5yGtBs6hgdj/5bZlleJbFoXlPoAEC7X/OamTEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XC0m54jg8z1SByW;
	Mon, 23 Sep 2024 19:15:49 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D04C140202;
	Mon, 23 Sep 2024 19:16:35 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 23 Sep 2024 19:16:34 +0800
Message-ID: <fac08b4b-6b64-44e6-4c67-e28945f5b763@huawei.com>
Date: Mon, 23 Sep 2024 19:16:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
To: Will Deacon <will@kernel.org>
CC: Catalin Marinas <catalin.marinas@arm.com>, Oleg Nesterov
	<oleg@redhat.com>, <mhiramat@kernel.org>, <peterz@infradead.org>,
	<mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com> <Zu2VdYrLWTJbVOAt@arm.com>
 <b90ce6f1-0d47-2429-5536-a8d5d91d6a70@huawei.com>
 <20240923071856.GA31866@willie-the-truck>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240923071856.GA31866@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/23 15:18, Will Deacon 写道:
> On Mon, Sep 23, 2024 at 09:57:14AM +0800, Liao, Chang wrote:
>> 在 2024/9/20 23:32, Catalin Marinas 写道:
>>> On Fri, Sep 20, 2024 at 04:58:31PM +0800, Liao, Chang wrote:
>>>> 在 2024/9/19 22:18, Oleg Nesterov 写道:
>>>>> On 09/19, Liao Chang wrote:
>>>>>> --- a/arch/arm64/kernel/probes/uprobes.c
>>>>>> +++ b/arch/arm64/kernel/probes/uprobes.c
>>>>>> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>>>>>>  	void *xol_page_kaddr = kmap_atomic(page);
>>>>>>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
>>>>>>
>>>>>> +	if (!memcmp(dst, src, len))
>>>>>> +		goto done;
>>>>>
>>>>> can't really comment, I know nothing about arm64...
>>>>>
>>>>> but don't we need to change __create_xol_area()
>>>>>
>>>>> 	-	area->page = alloc_page(GFP_HIGHUSER);
>>>>> 	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
>>>>>
>>>>> to avoid the false positives?
>>>>
>>>> Indeed, it would be safer.
>>>>
>>>> Could we tolerate these false positives? Even if the page are not reset
>>>> to zero bits, if the existing bits are the same as the instruction being
>>>> copied, it still can execute the correct instruction.
>>>
>>> Not if the I-cache has stale data. If alloc_page() returns a page with
>>> some random data that resembles a valid instruction but there was never
>>> a cache flush (sync_icache_aliases() on arm64), it's irrelevant whether
>>> the compare (on the D-cache side) succeeds or not.
>>
>> Absolutly right, I overlooked the comparsion is still performed in the D-cache.
>> However, the most important thing is ensuring the I-cache sees the accurate bits,
>> which is why a cache flush in necessary for each xol slot.
>>
>>>
>>> I think using __GFP_ZERO should do the trick. All 0s is a permanently
>>> undefined instruction, not something we'd use with xol.
>>
>> Unfortunately, the comparison assumes the D-cache and I-cache are already
>> in sync for the slot being copied. But this assumption is flawed if we start
>> with a page with some random bits and D-cache has not been sychronized with
>> I-cache. So, besides __GFP_ZERO, should we have a additional cache flush
>> after page allocation?
> 
> No, I think Oleg's right. The initial cache maintenance will happen when the
> executable pte is installed. However, we should use __GFP_ZERO anyway
> because I don't think it's a good idea to map an uninitialised page into
> userspace.

I will use __GFP_ZERO for xol page allocation in v2.

> 
> Will
> 

-- 
BR
Liao, Chang
