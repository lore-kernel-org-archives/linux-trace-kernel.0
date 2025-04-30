Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1224C1B5EB5;
	Wed, 30 Apr 2025 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746007968; cv=none; b=pzQ+mVJFMdYpPe77gzNtVoX7OVtAOP1reEuNdfBAJWF4NrjUQOrHj0Ijb1cP8IuZrCqCi3ftv81jHEIhVFyt+2PV0dtqtbb6rqsRRloww2mAyUzsmEMsWl6scl2VBKJi6gLq27oDH+oNSr2AaXckV6M/pazIl7+rhk4LSExe1F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746007968; c=relaxed/simple;
	bh=bSbjHd5fpmwuxfDGYWijAmxsLNypiafgTKyiPu9nVsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LHGNnHL4okktSGKu7E1LinNozd4+yyjgeU26ZbwJZne9UTjnVUXtl4GqtGBM/sxJkYYg5+hSkhsY4BET3RmeZi2rGetNRvD+ZBkURxF9LxL+bbt26C3Nn++pc28VFlYVIzjDoMAQ2qAOIspQT4hQTCFMFJuMomf5UtnDuIEYgM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OvV51h+L; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OvV51h+L"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746007957; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=jWF4Fc/9faHdX2BfnWYsn6epFHIXAYKUNdSnF1XgcMQ=;
	b=OvV51h+LHWRbSC4cTIToEvPpbDzomXgEftvwug39L+n5/OJxF30Pl3yhZ3HRE5QkJhj9X6MemjHVYaA93zUts3YaFP1OmadiNcL+BzlWu5Gm4Nv3988JHQsGVKfhOQnGnMgEpHfQqXLhi7xkBY2c28NM4YvNCqnjt9Firz+EUuw=
Received: from 30.74.146.9(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WYoKRf3_1746007953 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Apr 2025 18:12:34 +0800
Message-ID: <ba59d6aa-ade3-4440-a0ed-ef276b45f9d2@linux.alibaba.com>
Date: Wed, 30 Apr 2025 18:12:33 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 09/12] khugepaged: avoid unnecessary mTHP collapse
 attempts
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
 rdunlap@infradead.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
References: <20250428181218.85925-1-npache@redhat.com>
 <20250428181218.85925-10-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250428181218.85925-10-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/29 02:12, Nico Pache wrote:
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
> index 86d1153ce9e8..5e6732cccb86 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1365,6 +1365,23 @@ static int khugepaged_scan_bitmap(struct mm_struct *mm, unsigned long address,
>   				collapsed += (1 << order);
>   				continue;
>   			}
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
> +				break;

Better to merge this patch into patch 6, which can be helped to 
understand your logic.
