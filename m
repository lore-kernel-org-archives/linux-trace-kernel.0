Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4450013A86C;
	Fri, 20 Sep 2024 08:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822718; cv=none; b=bv9mSZwzIEPMlD/yjVAAPX3yGvq+aReDXjr6zHH6sm6rQh3iIUvgACbdjnvovPW5J3SzzKF46pRmtZUe+xSYD/GsXK0coPeRg5JOusrbfWAdDD3sBHj1Qa874EBAmO2hondMJmozsliTRSrg9ArjMWMFLZF5NlS/Cyhu8eJjqhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822718; c=relaxed/simple;
	bh=/umz4JPSo/PPCvKDA0j1UJajeC/raPXyTA2p9xmoVZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UBoph2HlrxkWIpORs1wv1G+gKv37g06cFaQ54VLQkyQQZdiuSW968ys66q/SJHqHgipM/2QkPNzAIQubzTnTp8d7La1gBqT11WsS/bZxKJnkHlNw/XBCbGVo+eeiYbvX/7vKndWlSLDKe9+9SP7NWZQjS3Npoty7/ejH0hsnv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X95r06M24zySBk;
	Fri, 20 Sep 2024 16:57:36 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id 632D2180064;
	Fri, 20 Sep 2024 16:58:32 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemd200013.china.huawei.com (7.221.188.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 20 Sep 2024 16:58:31 +0800
Message-ID: <41fdfc47-4161-d2e4-6528-4079b660424f@huawei.com>
Date: Fri, 20 Sep 2024 16:58:31 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
To: Oleg Nesterov <oleg@redhat.com>
CC: <mhiramat@kernel.org>, <peterz@infradead.org>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20240919121719.2148361-1-liaochang1@huawei.com>
 <20240919141824.GB12149@redhat.com>
From: "Liao, Chang" <liaochang1@huawei.com>
In-Reply-To: <20240919141824.GB12149@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200013.china.huawei.com (7.221.188.133)



在 2024/9/19 22:18, Oleg Nesterov 写道:
> On 09/19, Liao Chang wrote:
>>
>> --- a/arch/arm64/kernel/probes/uprobes.c
>> +++ b/arch/arm64/kernel/probes/uprobes.c
>> @@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
>>  	void *xol_page_kaddr = kmap_atomic(page);
>>  	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
>>
>> +	if (!memcmp(dst, src, len))
>> +		goto done;
> 
> can't really comment, I know nothing about arm64...
> 
> but don't we need to change __create_xol_area()
> 
> 	-	area->page = alloc_page(GFP_HIGHUSER);
> 	+	area->page = alloc_page(GFP_HIGHUSER | __GFP_ZERO);
> 
> to avoid the false positives?

Indeed, it would be safer.

Could we tolerate these false positives? Even if the page are not reset
to zero bits, if the existing bits are the same as the instruction being
copied, it still can execute the correct instruction.

> 
> Oleg.
> 
> 

-- 
BR
Liao, Chang
