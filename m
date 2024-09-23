Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC07944E;
	Mon, 23 Sep 2024 11:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090182; cv=none; b=tfJ8KJ7oQ3Z7TvP4tFXINU89u1nFJRnhPFdrmclV62VGodI6WH19HJvA84EOH/u/cAAOiks7c49vdlMbASUR3K5J9ii9PjH6qVuphO28ErlnNrDEEt6TkSoFSus1aT5J5AvEkp6mjk/v8bPbh7qatVG5L5SYaqBjzi6NJ00pcZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090182; c=relaxed/simple;
	bh=rLuSuMI7eCvefXhH8bL5ECCipo0DZ7ujNwOng5gl/bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GSK3HonELq+8OUCsbUZ8yvjrf7SVHs9sPraYaj+V9gp1dPSFdoD/mCdCj0U2tIZGwpbpw+pqtdI+e9V80gqm+v94A1x+HgJtqgJBl73y2Avg5e0n6jOvxd5xXGGZxvQ2u0FNIya7WxV53yrR05PcYsl+vvHrTTLwhrGIPx3cJ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XC0md2Hsyz1ylyY;
	Mon, 23 Sep 2024 19:16:17 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 1786F140138;
	Mon, 23 Sep 2024 19:16:16 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 23 Sep 2024 19:16:15 +0800
Message-ID: <ec36e8f7-3a16-e42f-51c7-94c5c2acbb55@huawei.com>
Date: Mon, 23 Sep 2024 19:16:15 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
To: Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>
CC: Catalin Marinas <catalin.marinas@arm.com>, <mhiramat@kernel.org>,
	<peterz@infradead.org>, <mark.rutland@arm.com>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
 <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com> <Zu2VdYrLWTJbVOAt@arm.com>
 <20240920173223.GA20847@redhat.com> <20240922140910.GA31288@willie-the-truck>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240922140910.GA31288@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/22 22:09, Will Deacon 写道:
> On Fri, Sep 20, 2024 at 07:32:23PM +0200, Oleg Nesterov wrote:
>> On 09/20, Catalin Marinas wrote:
>>>
>>> On Fri, Sep 20, 2024 at 04:58:31PM +0800, Liao, Chang wrote:
>>>>
>>>>
>>>> 在 2024/9/19 22:18, Oleg Nesterov 写道:
>>>>> On 09/19, Liao Chang wrote:
>>>>>>
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
>> But shouldn't the page fault paths on arm64 flush I-cache ?
>>
>> If alloc_page() returns a page with some random data that resembles a valid
>> instruction, user-space can't execute this instruction until
>> special_mapping_fault() installs the page allocated in __create_xol_area().
>>
>> Again, I know nothing about arm64/icache/etc, I am just curious and trying
>> to understand...
> 
> We defer the icache maintenance until set_pte_at() time, where we call
> __sync_icache_dcache() if we're installing a present, executable user
> eintry. That also elides the maintenance if PG_arch_1 is set (i.e. the
> kernel only takes responsibility for the freshly allocated page).

The newly allocated page should always have PG_arch_1 cleared, correct? Is it
possible for alloc_page() to return a page with PG_arch_1 set in the current
arm64 kernel?

> 
> Will
> 
>>
>> Oleg.
>>

-- 
BR
Liao, Chang
