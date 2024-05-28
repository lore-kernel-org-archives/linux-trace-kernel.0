Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9388213C67D;
	Tue, 28 May 2024 08:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885738; cv=none; b=t/NfctrccjjshZZwAo47570nQ66FA4MRT9eI2esBKAvf9agBNNub+NGvAbyxxZ0+/TUcv883gSqnNx9FhPMPEeqqLzLWMCDHo2RZax5O369ocsiL2hH3m8vPn6fu6om3agPYj8GEou67AgeIu84b5jwZJhh/ytXF4jyXZkxSxbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885738; c=relaxed/simple;
	bh=6tLri2pEFjfAp0kWhBiSqF77STHOqDPuVw+K04apsJc=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=QQlZxBj5G0M7X0+AD70Md8yh003dF3n6Nzvljq6vHRACLIKFIZxKuDHWrySsb1/HK4UhJb0MQos9K5LfnK3MIpF7Iuddg5BPQfVeJK8J0YfIniOUf9u68gYgawx+eXFM8LVttwuBHKTGoIVMWvRtZYCVcy8/63WduE+3PjKVjTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VpQrp2M27zxQvK;
	Tue, 28 May 2024 16:38:18 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 41D6A180AA5;
	Tue, 28 May 2024 16:42:06 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 16:42:05 +0800
Subject: Re: [linus:master] [mm] d99e3140a4:
 BUG:KCSAN:data-race_in_folio_remove_rmap_ptes/print_report
To: David Hildenbrand <david@redhat.com>, kernel test robot
	<oliver.sang@intel.com>, Matthew Wilcox <willy@infradead.org>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@suse.cz>,
	Luis Chamberlain <mcgrof@kernel.org>, Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>, <linux-mm@kvack.org>,
	<linux-trace-kernel@vger.kernel.org>
References: <202405281431.c46a3be9-lkp@intel.com>
 <8aba80ed-7b3e-4c8c-99e8-d8a2e0b112fc@redhat.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <4b0d996a-7499-6fce-ee19-3357f8d323cd@huawei.com>
Date: Tue, 28 May 2024 16:42:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <8aba80ed-7b3e-4c8c-99e8-d8a2e0b112fc@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/5/28 15:43, David Hildenbrand wrote:
> Am 28.05.24 um 09:11 schrieb kernel test robot:
>>
>>
>> Hello,
>>
>> kernel test robot noticed "BUG:KCSAN:data-race_in_folio_remove_rmap_ptes/print_report" on:
>>
>> commit: d99e3140a4d33e26066183ff727d8f02f56bec64 ("mm: turn folio_test_hugetlb into a PageType")
>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
>>
>> [test failed on linus/master      c760b3725e52403dc1b28644fb09c47a83cacea6]
>> [test failed on linux-next/master 3689b0ef08b70e4e03b82ebd37730a03a672853a]
>>
>> in testcase: trinity
>> version: trinity-i386-abe9de86-1_20230429
>> with following parameters:
>>
>>     runtime: 300s
>>     group: group-04
>>     nr_groups: 5
>>
>>
>>
>> compiler: gcc-13
>> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
>>
>> (please refer to attached dmesg/kmsg for entire log/backtrace)
>>
>>
>> we noticed this issue does not always happen. we also noticed there are
>> different random KCSAN issues for both this commit and its parent. but below
>> 4 only happen on this commit with not small rate and keep clean on parent.
>>
> 
> Likely that's just a page_type check racing against concurrent
> mapcount changes.
> 
> In __folio_rmap_sanity_checks() we check
>     VM_WARN_ON_FOLIO(folio_test_hugetlb(folio), folio);
> 
> To make sure we don't get hugetlb folios in the wrong rmap code path. That
> can easily race with concurrent mapcount changes, just like any other
> page_type checks that end up in folio_test_type/page_has_type e.g., from
> PFN walkers.
> 
> Load tearing in these functions shouldn't really result in false positives
> (what we care about), but READ_ONCE shouldn't hurt or make a difference.
> 
> 
> From b03dc9bf27571442d886d8da624a4e4f737433f2 Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 28 May 2024 09:37:20 +0200
> Subject: [PATCH] mm: read page_type using READ_ONCE
> 
> KCSAN complains about possible data races: while we check for a
> page_type -- for example for sanity checks -- we might concurrently
> modify the mapcount that overlays page_type.
> 
> Let's use READ_ONCE to avoid laod tearing (shouldn't make a difference)
> and to make KCSAN happy.
> 
> Note: nothing should really be broken besides wrong KCSAN complaints.
> 
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202405281431.c46a3be9-lkp@intel.com
> Signed-off-by: David Hildenbrand <david@redhat.com>

LGTM. Thanks for fixing.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

