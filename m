Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B1610E5;
	Thu, 15 May 2025 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747288565; cv=none; b=c+ZTgHRELHxYoVsYh1L1fyh/68jIcwoEmFgW/ap+n25Qj8a2Qsbo40MDrgw07ZsqXVWMnSplZAK9tVqAXRtjJLyc98oKKATHcXdPmOVcNhTO4HKYIcPW0fsUeGKq4kOIBs2TKmTC4mMRkSBqWHFmr4R/fDau7GepMGRUiUdSgo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747288565; c=relaxed/simple;
	bh=uO/Yx379nUrryskwAKLlWmoga7rlHW/DXohFs+M4Tz0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h6b/xo1gwI4lsR0o9kLhSShZIQxUpfISm4FS2V8BDXVOSoHQxdIWGiNS/V1yGFulheVWSrTR6/o0PsUQ3FBb9iF8HZ5xKuGCbNHT0F0jlpCVuICLJvxcnNVJGqa98VG7lHFaI4AONhJNGo5S2ybMMfl7xkeFasm5vub4uKXJOYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=e09ETwba; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="e09ETwba"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747288559; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=HILIMbJqqtRZliu8YocTP5oOqJzv4jTqKfUw91ehmtU=;
	b=e09ETwbaOWeFDwQGydbdKZl++Gw0ZWECNk7f4POiea/AA37wt7MWOLxL/Jscln4n7Y9W6TnVcSjEfjUWW44Cnek8PLB+8PrQpxPZ6xiqTyKWpQBvzz6QNBH28oPeeS+ChGY9gOdFVo/PWnsQNkvcAxJd39FS0GeQWlPAreqrxSg=
Received: from 30.74.144.114(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WapcxTY_1747288232 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 15 May 2025 13:50:34 +0800
Message-ID: <4e00b5df-e9ce-40fa-8da0-9c66fe18bfd7@linux.alibaba.com>
Date: Thu, 15 May 2025 13:50:32 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 02/12] introduce khugepaged_collapse_single_pmd to
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
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-3-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250515032226.128900-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/5/15 11:22, Nico Pache wrote:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
> 
> Create khugepaged_collapse_single_pmd to increase code
> reuse and create an entry point for future khugepaged changes.
> 
> Refactor madvise_collapse and khugepaged_scan_mm_slot to use
> the new khugepaged_collapse_single_pmd function.
> 
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 96 +++++++++++++++++++++++++------------------------
>   1 file changed, 49 insertions(+), 47 deletions(-)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 806bcd8c5185..5457571d505a 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -2353,6 +2353,48 @@ static int khugepaged_scan_file(struct mm_struct *mm, unsigned long addr,
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

I've removed the CONFIG_SHMEM dependency[1], please do not add it again.

[1] 
https://lore.kernel.org/all/ce5c2314e0368cf34bda26f9bacf01c982d4da17.1747119309.git.baolin.wang@linux.alibaba.com/
