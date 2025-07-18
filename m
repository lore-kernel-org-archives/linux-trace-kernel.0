Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF291BC2A;
	Fri, 18 Jul 2025 02:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804901; cv=none; b=QFOT1xAqOYLu6eVQ/QzRLCMptHyAgyEoXTFNavvJw8MzlFt8GqcsUpMz9V0oXnJouPFeNqWrS0RYJBE55OmGoNsNpGxeLjPagz/SBkl7KfOWepWYfcW4Fh7ISiPepe7vwMJFT38AWPZHREzdgMrPftXKA3Au19u8sDb2fmDwcuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804901; c=relaxed/simple;
	bh=KXiYzDb/12B8ZKzq05chDYOX4Fw7SGPOEPy7EA2MF24=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R1r0vewB2nEk7krhSc43r2BTj/rqg+FILPVClRPIMlDXyJJ0BvFLuMZHYypYfuiWmi6cVolLe86Nwtl3XQAqJYV+xw0Zd/Ox500M7b0/YFDxbWTcICAEXugLUbVm3Y/zgl5a0EYVd4IG2wT7kNziHvFuxdzoSpjLr8TjVOFed1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=AhhKwz80; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="AhhKwz80"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752804896; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=8jLJM3I7MXzt5ywvPrJqc6L2LFY2+2u42CbPGeXe8wI=;
	b=AhhKwz80ghHB8L+TGf836Ycj/c3TPWwTR05BIPl9VSg90uVtf+AXls/U5/dJx2wqixDzFJWmYfErU/9Cuv1uIkJqxnBsi1X3cFEePRNrxFlhjwqgF1JdIZ35lL+aE3qw6rb7/Tq6DFoLgmzgH4+3xisfxsKFLx6I/mZnlZHEx78=
Received: from 30.74.144.111(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WjAe3gk_1752804891 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 18 Jul 2025 10:14:52 +0800
Message-ID: <85b2cfd8-4aeb-4e98-8065-b6594783de62@linux.alibaba.com>
Date: Fri, 18 Jul 2025 10:14:51 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 09/14] khugepaged: avoid unnecessary mTHP collapse
 attempts
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
 rdunlap@infradead.org, hughd@google.com
References: <20250714003207.113275-1-npache@redhat.com>
 <20250714003207.113275-10-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250714003207.113275-10-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/7/14 08:32, Nico Pache wrote:
> There are cases where, if an attempted collapse fails, all subsequent
> orders are guaranteed to also fail. Avoid these collapse attempts by
> bailing out early.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>   mm/khugepaged.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
> 
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index a701d9f0f158..7a9c4edf0e23 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1367,6 +1367,23 @@ static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long address,
>   				collapsed += (1 << order);
>   				continue;
>   			}

After doing more testing, I think you need to add the following changes 
after patch 8.

Because when collapsing mTHP, if we encounter a PTE-mapped large folio 
within the PMD range, we should continue scanning to complete that PMD, 
in case there is another mTHP that can be collapsed within that PMD range.

+                       if (ret == SCAN_PTE_MAPPED_HUGEPAGE)
+                               continue;

> +			/*
> +			 * Some ret values indicate all lower order will also
> +			 * fail, dont trying to collapse smaller orders
> +			 */
> +			if (ret == SCAN_EXCEED_NONE_PTE ||
> +				ret == SCAN_EXCEED_SWAP_PTE ||
> +				ret == SCAN_EXCEED_SHARED_PTE ||
> +				ret == SCAN_PTE_NON_PRESENT ||
> +				ret == SCAN_PTE_UFFD_WP ||
> +				ret == SCAN_ALLOC_HUGE_PAGE_FAIL ||
> +				ret == SCAN_CGROUP_CHARGE_FAIL ||
> +				ret == SCAN_COPY_MC ||
> +				ret == SCAN_PAGE_LOCK ||
> +				ret == SCAN_PAGE_COUNT)
> +				goto next;
> +			else

Nit: the 'else' statement can be dropped.

> +				break;
>   		}
>   
>   next:

