Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77676219EB;
	Tue,  8 Jul 2025 06:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955572; cv=none; b=rzvISAd90zz6gcf/hXAqC4baCKUc7KDIVBY5jZKRlY4U4cXfLj/JgaHCtQexcdCovT1XRu4G5NM7iEzY/E2rNNyLc9LJQrGO+7FEBVisjltcBu5qZB+bfzIVyxb+oGzswpk3r+sk9Bi7uY7WzUAFH9oXg5xVUkknfbJp2E4QW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955572; c=relaxed/simple;
	bh=fdKst7IRAsqsenZliJt+GWMMOBmwKJwlNY3fqlSVZkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d4+mS7PweKbbILQYj9iAo2EcuzYadQHRUYKwvTKoFGBIyhB4h0tYLBSfBPv+YYfw9RjobNW5uJMTrryFPmsu1PJ1mueudxpt1PLcHS3U2X0raarVED3fvm1TYSR4GqF9sKX2YYEaHGcan5U43RWyTPoeLEZ+Knqics/S0Wvrj6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mcR6ytGf; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mcR6ytGf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751955566; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qIRx+HCehqqza2IJhsneJV4WjfRLShJN2Hjm8Xb7L4M=;
	b=mcR6ytGfjlZqBSdQlw2EshP17cFillFU1uZpHPvB1K09ZpkARvtetnsxNjsvXJ48TGFgoanB32ts36Wb9OLIq6GlZckOUDo/bwTlAZ8iXUmtZhOhKEcjx9lpHz3Y2nov6DqBkzND0nfCgIb4wu18bCcJ/zCH+khgEDI1tRsJpCc=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WiLFdgJ_1751955558 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:19:23 +0800
Message-ID: <e6a18289-1417-4f47-a919-bb5a8ddc1579@linux.alibaba.com>
Date: Tue, 8 Jul 2025 14:19:18 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/15] khugepaged: generalize alloc_charge_folio()
To: Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com,
 corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com,
 vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com,
 yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com,
 aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250702055742.102808-1-npache@redhat.com>
 <20250702055742.102808-5-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250702055742.102808-5-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/2 13:57, Nico Pache wrote:
> From: Dev Jain <dev.jain@arm.com>
> 
> Pass order to alloc_charge_folio() and update mTHP statistics.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   include/linux/huge_mm.h |  2 ++
>   mm/huge_memory.c        |  4 ++++
>   mm/khugepaged.c         | 17 +++++++++++------
>   3 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 4d5bb67dc4ec..a6ea89fdaee6 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -125,6 +125,8 @@ enum mthp_stat_item {
>   	MTHP_STAT_ANON_FAULT_ALLOC,
>   	MTHP_STAT_ANON_FAULT_FALLBACK,
>   	MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> +	MTHP_STAT_COLLAPSE_ALLOC,
> +	MTHP_STAT_COLLAPSE_ALLOC_FAILED,
>   	MTHP_STAT_ZSWPOUT,
>   	MTHP_STAT_SWPIN,
>   	MTHP_STAT_SWPIN_FALLBACK,
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ce130225a8e5..69777a35e722 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -614,6 +614,8 @@ static struct kobj_attribute _name##_attr = __ATTR_RO(_name)
>   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLBACK);
>   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc, MTHP_STAT_COLLAPSE_ALLOC);
> +DEFINE_MTHP_STAT_ATTR(collapse_alloc_failed, MTHP_STAT_COLLAPSE_ALLOC_FAILED);
>   DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
>   DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
>   DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> @@ -679,6 +681,8 @@ static struct attribute *any_stats_attrs[] = {
>   #endif
>   	&split_attr.attr,
>   	&split_failed_attr.attr,
> +	&collapse_alloc_attr.attr,
> +	&collapse_alloc_failed_attr.attr,
>   	NULL,
>   };

Sorry, I forgot to mention that you should update the 
'Documentation/admin-guide/mm/transhuge.rst' file for these new statistics.
