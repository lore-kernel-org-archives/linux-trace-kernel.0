Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35059213E61;
	Wed, 30 Apr 2025 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000767; cv=none; b=CIjiCmPHVDx10GDjvenbPuV8VECTPb1jY2m5GgYOz9rMIIusI3lroL6Y9SA/UAyHtBDFcxgsFhvgPc108NjfzkB4IQlmh/9ld420SNgEXpcmba1L49n4y3cMrzkdHSk9hS+tUMi5aPJXCJWZ2TbV7sNhNbrG7GV+VbRs3FuFZ2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000767; c=relaxed/simple;
	bh=eYjJVlbjzgOWV8shL1yP8v5QxCIcMf22qMSX7tujK78=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iPvQZg4xjgo8u69OnR3+EaS2HZBHjDzYZ3FIYbU3t1//Mss6tgtjETuNUtoy98aMOsJj8kc8cdqN1Y6e6EJ87T3+eUOxFfnaDUBdVKIFR8KvO0jKykcZmwIvc74AGY4gc3pAwxXQ3s0Gm9szE5C/egq/azp83uXM/p8AIQ9Gj1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oI8Zpn62; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oI8Zpn62"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1746000755; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=y2Qj5eYrvgpkeWNMhAvuv8X9LmuKQMYme0a5Fz4OeB8=;
	b=oI8Zpn62ir4XFfsxNcZLfYl8ZFSm4tZe8PKILMEOPqmscHkyxBBoDjaIJsFuO55tJf+X90Z/Z7lliwSSnFACUsWSXkfOuSOcYsbcPiMBqlMx/clTl2PlRMHde+sogm56AyVkRHn/pEaHOhiQec99h18BK+HmUyXg8aIuoSw+6qk=
Received: from 30.74.146.9(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WYnk338_1745999810 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 30 Apr 2025 15:56:51 +0800
Message-ID: <1df9f019-632f-4497-8320-e34ba66c1b62@linux.alibaba.com>
Date: Wed, 30 Apr 2025 15:56:48 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/12] introduce khugepaged_collapse_single_pmd to
 unify khugepaged and madvise_collapse
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
 <20250428181218.85925-3-npache@redhat.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250428181218.85925-3-npache@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/4/29 02:12, Nico Pache wrote:
> The khugepaged daemon and madvise_collapse have two different
> implementations that do almost the same thing.
> 
> Create khugepaged_collapse_single_pmd to increase code
> reuse and create an entry point for future khugepaged changes.
> 
> Refactor madvise_collapse and khugepaged_scan_mm_slot to use
> the new khugepaged_collapse_single_pmd function.
> 
> Signed-off-by: Nico Pache <npache@redhat.com>

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
