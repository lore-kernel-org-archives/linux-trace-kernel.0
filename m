Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1111F4CB5;
	Thu, 24 Apr 2025 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745480937; cv=none; b=QkcHYywabVvHB4ZO+UIfkbwfTcRxvMsp/RAwDjEbrQ61VT88T5/QpjyM/IQ3gIo9sfmiKON+XejDrSqGIOKLXq/AF0I5dSgqvO80OwPF7Z6MZYv6ms+Evh9NwvcLaL6Xb330fC1bGhqP8XvL5WXdw9kI/uShhQsp9G/SAc7K/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745480937; c=relaxed/simple;
	bh=ar6PJxQCfp8ZAa3ugdAz/W3cAjD/5BbmeHHp3Asx3/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S02QB0v4I9aI/KjfkNZKr2owsl6yKnPG0pl1+j4b7aAFdZjD8/EGga2nNQRmfGWM51SpMEiMNSq+wBXMa8693MDYAdoFTkvwkuzOqRzjkPhz57zr5xnEyE2RaT5YukydSA6HczzNsx+a24SK4EDw4EuoaZO3JSAaBV+mFHmB3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XwUKRY1q; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XwUKRY1q"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745480930; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=vSzEDm0PVZR5+6nReRulGLUiGC7gv59rpmdxNdHwhFY=;
	b=XwUKRY1qF66kQQUh211jyyvaIJWrdquSMSMJtet0GCw708tZzpAvYMaoa27YHa9aZIcjZO1Hdd4ty2EJeqP2ElE7FtdT18xCSBQfW82+B9Gt8CEtzWild1Qgkarnriv6DYhHuetJ4bCa9oIDiLfnybwTo6NvYjrX67klOPGPMMQ=
Received: from 30.74.146.225(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WXyG8sZ_1745480926 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 24 Apr 2025 15:48:47 +0800
Message-ID: <fb932eac-86ce-4f7d-8eed-8dc44f5a40c1@linux.alibaba.com>
Date: Thu, 24 Apr 2025 15:48:45 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] khugepaged: skip collapsing mTHP to smaller
 orders
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com,
 baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org,
 peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com,
 tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz,
 cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250417000238.74567-1-npache@redhat.com>
 <20250417000238.74567-9-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250417000238.74567-9-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/17 08:02, Nico Pache wrote:
> khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
> some pages being unmapped. Skip these cases until we have a way to check
> if its ok to collapse to a smaller mTHP size (like in the case of a
> partially mapped folio).
> 
> This patch is inspired by Dev Jain's work on khugepaged mTHP support [1].
> 
> [1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.com/
> 
> Co-developed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ece39fd71fe6..383aff12cd43 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -625,7 +625,12 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>   		folio = page_folio(page);
>   		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
>   
> -		/* See hpage_collapse_scan_pmd(). */
> +		if (order != HPAGE_PMD_ORDER && folio_order(folio) >= order) {
> +			result = SCAN_PTE_MAPPED_HUGEPAGE;
> +			goto out;
> +		}

Should we also add this check in hpage_collapse_scan_pmd() to abort the 
scan early?
