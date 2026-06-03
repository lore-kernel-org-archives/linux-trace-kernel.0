Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB323A9632;
	Wed,  3 Jun 2026 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453994; cv=none; b=ax5k8q5shLEYn/dR196UDCiUIoM5xar9ZAPykokbcx0zD3sJycxTA8BGO128O+9NfFReFdlsxVG90c4bVx4eZdLBhZdGdE4ZRYJHHoavw2tohwY3Ci+TsASC6CCGCvSWUm3QVvyi/h8vylBWhwp4QH10d2OPKzYKfV9hT5r+9ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453994; c=relaxed/simple;
	bh=dcw6J6XxUYMZByDAwHUqpq/EmR+eZ1hR9fjpYNYOqNc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iAso+daNYXeT6J1tAYBSxd+B4cpGgfA73xxIYUBMKuQvv8ZYkmMeBwz2YZeERjc3w1sAR1uQSgeQXyvs3x04FlnQrorW3NO7ssPK6MFHFO4vUyB47r8/xec8pbM2InfFhtyEg1xlUGVqI+8fzdD+8Tl/9fuTNk4bmybKx8TIFrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=pwX/FwLf; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="pwX/FwLf"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vHfwDEtQrbN077pHZVQUB5kFtwZn5VuD4rouby1Sq5g=;
	b=pwX/FwLf0Z0XWLY+UYZMiEDu+1GHWfGUE1Huc+mqnyYOrAtgLxqd0RgdXNo+FHJh9qG5TIUMi
	E6mb5BguU2Rz9q+HAndfUbJxHJQ7mYX7Mr1xd/82ZssGY7/3eoCkwycweLyjsXKk+0TDtst8NlQ
	FmoI8h8zSR5GTRxLdxsJSI0=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4gVWkj28JwzLlXL;
	Wed,  3 Jun 2026 10:25:17 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id ABD1740575;
	Wed,  3 Jun 2026 10:33:06 +0800 (CST)
Received: from kwepemq500010.china.huawei.com (7.202.194.235) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Jun 2026 10:33:06 +0800
Received: from [10.173.124.160] (10.173.124.160) by
 kwepemq500010.china.huawei.com (7.202.194.235) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Jun 2026 10:33:05 +0800
Subject: Re: [PATCH v8 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
To: "David Hildenbrand (Arm)" <david@kernel.org>, Breno Leitao
	<leitao@debian.org>
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
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4b27467e-935f-5587-2f48-5a794c30a592@huawei.com>
Date: Wed, 3 Jun 2026 10:33:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <21732071-14a1-486a-951c-34de97b7c757@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemq500010.china.huawei.com (7.202.194.235)

On 2026/6/2 17:41, David Hildenbrand (Arm) wrote:
> On 6/2/26 05:08, Miaohe Lin wrote:
>> On 2026/6/1 21:22, David Hildenbrand (Arm) wrote:
>>> On 6/1/26 14:28, Miaohe Lin wrote:
>>>>
>>>> Thanks for your patch.
>>>>
>>>>
>>>> Once shake_page finds a lightweight range-based way to shrink slab, slab pages could be freed
>>>> into buddy and above PageSlab test should be removed then. Maybe add a TODO or XXX here?
>>>>
>>>>
>>>> I'm not sure but is it safe or a common way to test PageReserved, PageSlab,
>>>> PageTable and PageLargeKmalloc without extra page refcnt?
>>>
>>> Checking typed pages in a racy fashion is fine (PageSlab, PageTable,
>>> PageLargeKmalloc).
>>
>> Got it. Thanks.
>>
>>> Checking PageReserved in a racy fashion is fine as well. TESTPAGEFLAG() will
>>> allow checking it on compound pages.
>>
>> It seems PageReserved is not intended to be set on compound pages. I see there are PF_NO_COMPOUND
>> in its definition: PAGEFLAG(Reserved, reserved, PF_NO_COMPOUND).
>>
>>>
>>> For PageLargeKmalloc, we would want to check the head page, though. The page
>>> type is only stored for the head page.
>>
>> Maybe we should check the head page for PageSlab and PageTable too? alloc_slab_page only
>> set PageSlab on the head page and __pagetable_ctor uses __folio_set_pgtable to set PageTable
>> on folio.
>>
>>>
>>> So maybe we want to lookup the compound head (if any) and perform the type
>>> checks against that?
>>
>> Maybe we should or we might miss some pages that could have been handled. And
>> if compound head is required, should we hold an extra page refcnt to guard against
>> possible folio split race?
> 
> Races are fine. We might miss some pages, but that can happen on races either way.
> 
> 
> I'd just do something like
> 
> if (PageReserved(page))
> 	return true;
> 
> head = compound_head(page);

If @head is split just after compound_head. And then @head is freed into buddy and re-allocated as slab
page while @page is still in the buddy. We would panic on this scene as @head is PageSlab. But we were
supposed to successfully handle @page. Or am I miss something?

Thanks.
.

> return PageSlab(head) || ...;
> 	
> 

