Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389714A4F0;
	Tue,  9 Jun 2026 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972770; cv=none; b=YvZSsK299BDLlPiYs5yLDC67BUOdYo6EJ5frdvYqLqJZAwm1OrWY+CDOWHDfVGQX/NxtEX/H6Az/3c9ggNb8PRtFlw+OIxs2PkL7InU1IVwYBCrwDzHOysNND1cNNVgMKa4IhmQ3ZKDYkBB8BUPzbG8uHux+q8cNdIsBeZGJUGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972770; c=relaxed/simple;
	bh=vzdTQlRHvXBtfIlvsJDtPDa3vYd7r9SNEh4wl0vmZMQ=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=b0+82L63u7DHmdOhfSBtdlrkx3ew66xGIWHzAhEffL6RpIqVgCbz2swy4W8TWxqq7zqN8A2/I6iXKMzcBcr9ZMf71qkcuRpi3HsEk9scbX0/Y1JwhZII15kOCQ4aIS5vKeyHdR/KBYe5MVfee3wA5U3enUx/unVPYg1VnWRvoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=TjAn0LW9; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="TjAn0LW9"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=BtlygfYK5ZWM60nS1lbLJPtb40nPfh/c6avQxVCJIow=;
	b=TjAn0LW9zPesqYG48M58ZA86DLn9aCGiPpV8lYTfGKl/80+2Y6G284eU1iW+QJDF6X0Y25+Ey
	jeJ58Srr9xJ8MXSzFpaF+5L8tjs1ov2Q4iNAxrZWIfUdNhpmxdnQQRotp0akqHhiuppgywBvEgS
	P6STz6TQKtOMYtM6UnrQig8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4gZCbC4gMvzpTKY;
	Tue,  9 Jun 2026 10:31:35 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 2BDB24056D;
	Tue,  9 Jun 2026 10:39:24 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 10:39:23 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Jun 2026 10:39:22 +0800
Subject: Re: [PATCH v8 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
To: Breno Leitao <leitao@debian.org>, "David Hildenbrand (Arm)"
	<david@kernel.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <kernel-team@meta.com>, Lance Yang
	<lance.yang@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, "Lorenzo
 Stoakes" <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport
	<rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
	<mhocko@suse.com>, Shuah Khan <shuah@kernel.org>, Naoya Horiguchi
	<nao.horiguchi@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, Mathieu Desnoyers
	<mathieu.desnoyers@efficios.com>, Jonathan Corbet <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Liam R. Howlett" <liam@infradead.org>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
 <20260527-ecc_panic-v8-2-9ea0cfa16bb0@debian.org>
 <19f968f5-1289-f573-4406-e5c91dcd8923@huawei.com>
 <e3d023f1-ab6e-4424-b304-55f1294480c3@kernel.org>
 <33ef8821-c809-b7d1-ea77-6e8a07a6e784@huawei.com>
 <21732071-14a1-486a-951c-34de97b7c757@kernel.org>
 <4b27467e-935f-5587-2f48-5a794c30a592@huawei.com>
 <aiKXrovzrNN-gExm@gmail.com>
 <f1a742be-80cb-4256-b1f9-e50a0f83cb15@kernel.org>
 <aibN4osY_QF1Rejh@gmail.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4953bcee-5a0f-2bc5-7295-63e5e7513e8b@huawei.com>
Date: Tue, 9 Jun 2026 10:39:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aibN4osY_QF1Rejh@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/8 22:15, Breno Leitao wrote:
> On Fri, Jun 05, 2026 at 11:42:53AM +0200, David Hildenbrand (Arm) wrote:
>> On 6/5/26 11:35, Breno Leitao wrote:
>>> On Wed, Jun 03, 2026 at 10:33:04AM +0800, Miaohe Lin wrote:
>>>> On 2026/6/2 17:41, David Hildenbrand (Arm) wrote:
>>>>>
>>>>> Races are fine. We might miss some pages, but that can happen on races either way.
>>>>>
>>>>>
>>>>> I'd just do something like
>>>>>
>>>>> if (PageReserved(page))
>>>>> 	return true;
>>>>>
>>>>> head = compound_head(page);
>>>>
>>>> If @head is split just after compound_head. And then @head is freed into buddy and re-allocated as slab
>>>> page while @page is still in the buddy. We would panic on this scene as @head is PageSlab. But we were
>>>> supposed to successfully handle @page. Or am I miss something?
>>>
>>> You're right that it is racy, but I think it is an acceptable race here.
>>>
>>
>> I mean, any such races can currently already happen one way or the other?
>>
>> Really, the only way to not get races is to tryget the (compound)page,
>> revalidate that the page is still part of the compound page.
>>
>> I'm not sure if that's really a good idea.
>>
>> But my memory is a bit vague in which scenarios we already hold a page reference
>> here to prevent any concurrent freeing?
> 
> No, we don't hold one here in the case that matters.
> 
> HWPoisonKernelOwned() runs at the very top of get_any_page(), before
> try_again: and before __get_hwpoison_page(). The first refcount taken in
> the whole path is the folio_try_get() inside __get_hwpoison_page(), which
> runs *after* the short-circuit.
> 
> So get_any_page() itself never holds a reference at the check -- the only way
> one exists is if the caller passed MF_COUNT_INCREASED (count_increased ==
> true).
> 
> So on the MCE/GHES path -- the one this panic option exists for -- no
> reference is held when HWPoisonKernelOwned() does its compound_head() +
> PageSlab()/PageTable()/PageLargeKmalloc() checks.
> 
> Given that, I'd rather keep it racy and take no refcount than add a
> tryget + revalidate purely for this check. As I've said earleir, an operator

Would it be acceptable to add a simple recheck? Something like below:

retry:
head = compound_head(page);
PageSlab()/PageTable()/PageLargeKmalloc() checks
if (head != compound_head(page))
	goto retry

Thanks both.
.

> who enabled it has chosen to crash rather than run on corrupted memory;
> mis-attributing one such rare, genuinely-poisoned page is within that contract.
> .
> 

