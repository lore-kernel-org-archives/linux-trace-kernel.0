Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C6616F858;
	Wed, 19 Feb 2025 16:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739984264; cv=none; b=O1f0qufFDE0dx3aklM4d04xLNiWI8b768njL5iNB/DRTe1XxEb5FWZdX99c+/Nm/CfbLlCIcOU8oBTxKq8gF5UKwf+pqt4W6mV/U+KuCQoby5zhtIGU8J3mhpFJ3e7VqKNITI+uKtYIZqpwQz+xtL3HifQW+lfCscmxTsJ0gi6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739984264; c=relaxed/simple;
	bh=Qko7tDfzPHTpjpXQeBx7drTCMiJyv4ckkGXhqTJkG7M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYU7D3S9BMBbq77n3Kif/NnPVn1H8Eiuv/Skc7dahYCmjQJMdBl0E/LBJ5DX0QAkBfXvKkOqsRRkp/ak7pfgq1cBeJoMuZFjmCCt/vqS+zKUmcF3RqMbhNW7vxx83UYtdP3I4veCYoqzksKvfCOavW43DxbRw1HfmdDdkyPOTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B9E21682;
	Wed, 19 Feb 2025 08:58:00 -0800 (PST)
Received: from [10.57.84.233] (unknown [10.57.84.233])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 509BF3F6A8;
	Wed, 19 Feb 2025 08:57:35 -0800 (PST)
Message-ID: <754acd1f-09ae-4054-90c6-bdf7eb98ee70@arm.com>
Date: Wed, 19 Feb 2025 16:57:33 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 9/9] khugepaged: skip collapsing mTHP to smaller orders
Content-Language: en-GB
To: Nico Pache <npache@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, cl@gentwo.org,
 vbabka@suse.cz, mhocko@suse.com, apopple@nvidia.com,
 dave.hansen@linux.intel.com, will@kernel.org, baohua@kernel.org,
 jack@suse.cz, srivatsa@csail.mit.edu, haowenchao22@gmail.com,
 hughd@google.com, aneesh.kumar@kernel.org, yang@os.amperecomputing.com,
 peterx@redhat.com, ioworker0@gmail.com, wangkefeng.wang@huawei.com,
 ziy@nvidia.com, jglisse@google.com, surenb@google.com,
 vishal.moola@gmail.com, zokeefe@google.com, zhengqi.arch@bytedance.com,
 jhubbard@nvidia.com, 21cnbao@gmail.com, willy@infradead.org,
 kirill.shutemov@linux.intel.com, david@redhat.com, aarcange@redhat.com,
 raquini@redhat.com, dev.jain@arm.com, sunnanyong@huawei.com,
 usamaarif642@gmail.com, audra@redhat.com, akpm@linux-foundation.org,
 rostedt@goodmis.org, mathieu.desnoyers@efficios.com, tiwai@suse.de
References: <20250211003028.213461-1-npache@redhat.com>
 <20250211003028.213461-10-npache@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250211003028.213461-10-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/02/2025 00:30, Nico Pache wrote:
> khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
> some pages being unmapped. Skip these cases until we have a way to check
> if its ok to collapse to a smaller mTHP size (like in the case of a
> partially mapped folio).
> 
> This patch is inspired by Dev Jain's work on khugepaged mTHP support [1].
> 
> [1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.com/
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/khugepaged.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index e2ba18e57064..fc30698b8e6e 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -622,6 +622,11 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>  		folio = page_folio(page);
>  		VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
>  
> +		if (order != HPAGE_PMD_ORDER && folio_order(folio) >= order) {
> +			result = SCAN_PTE_MAPPED_HUGEPAGE;
> +			goto out;
> +		}

One of the key areas where we want to benefit from khugepaged collapsing to mTHP
is when a COW event happens. If the original folio was large, then it becomes
partially mapped due to COW and we want to collapse it again. I think this will
prevent that?

I made some fairly detailed suggestions for what I think is the right approach
in the context of Dev's series. It would be good to get your thoughts on that:

https://lore.kernel.org/lkml/aa647830-cf55-48f0-98c2-8230796e35b3@arm.com/

Thanks,
Ryan

> +
>  		/* See khugepaged_scan_pmd(). */
>  		if (folio_likely_mapped_shared(folio)) {
>  			++shared;

