Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D752DE713;
	Fri,  4 Jul 2025 03:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751601062; cv=none; b=gSNdcG+eng96mbz5iYtgj51qOMVtlSSLfV1Ih/UFp3Px1DIQU0q+IUa0qEp+XvBOrfr8iYL8lXsvX1PRWAJaMn7cF23RKtLobgw+ym+YnAw3Zw9EtSpJ4yXMq0OiNV9fFRxFe9Og/tOLXy75Dctb0Wq/iF/07w373+P3/mH+/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751601062; c=relaxed/simple;
	bh=3V9zcQPccRID2BUTAEHdKTnEVIk4Av8r1toECQQBgPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkOWVYU9cxCwk48gVDsy0YeNZnYzjdx4X9jArE3vx7SKIOyJq9CRzou4Iezs9/7/im/tiPGRxicE0lNLvWVMvTkCpk8nFja8yAmsNhp7kAO57RBKr+Zd0u1H5XevjHzCEtCUNzpiiHnmxXDLL4WfwKeVSh/8ns3W8kwWoaxHNks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bJJT4HaK; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bJJT4HaK"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751601049; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=yHDmb/fL/3il1yTYD1XOilCS3c3ADIw5upWHt8Gdf8g=;
	b=bJJT4HaKpiDh+nTQo6CDjpot29m4HwxzKSJyTfExTQBlWCpPLR/DOiRpXs0QbQ4p8Y7d6Bctp1bgT/D+kPl/qsBJGTU4h+9frIOzVeLdQv8n1yDwa831oOTob1vsnDkj6vLkJjsOyst8kXV4mI3fpMgoMcITQ5NNzudTAkvANxo=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wh94Dzl_1751601045 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 04 Jul 2025 11:50:46 +0800
Message-ID: <ca0d8c87-2998-48f8-bef6-3e99a92f28e4@linux.alibaba.com>
Date: Fri, 4 Jul 2025 11:50:45 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/15] introduce khugepaged_collapse_single_pmd to
 unify khugepaged and madvise_collapse
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
 <20250702055742.102808-3-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250702055742.102808-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/2 13:57, Nico Pache wrote:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
> 
> Create khugepaged_collapse_single_pmd to increase code reuse and create an
> entry point these two users.
> 
> Refactor madvise_collapse and khugepaged_scan_mm_slot to use the new
> khugepaged_collapse_single_pmd function. This introduces a minor
> behavioral change that is most likely an undiscovered bug. The current
> implementation of khugepaged tests khugepaged_test_exit_or_disable
> before calling khugepaged_pte_mapped_thp, but we weren't doing it in the
> madvise_collapse case. By unifying these two callers madvise_collapse
> now also performs this check.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 95 +++++++++++++++++++++++++------------------------
>   1 file changed, 49 insertions(+), 46 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index f27fe7ca9b86..bf69e81a3d82 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2354,6 +2354,50 @@ static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
>   	return result;
>   }
>   
> +/*
> + * Try to collapse a single PMD starting at a PMD aligned addr, and return
> + * the results.
> + */
> +static int khugepaged_collapse_single_pmd(unsigned long addr,
> +				   struct vm_area_struct *vma, bool *mmap_locked,
> +				   struct collapse_control *cc)
> +{
> +	int result = SCAN_FAIL;
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	if (IS_ENABLED(CONFIG_SHMEM) && !vma_is_anonymous(vma)) {

Seems you still forgot to drop 'IS_ENABLED(CONFIG_SHMEM)' :)
