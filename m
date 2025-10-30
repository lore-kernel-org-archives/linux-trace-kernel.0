Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082037A3A1;
	Thu, 30 Oct 2025 01:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761786967; cv=none; b=hWqgSRdjMm7aPInxw7x96MBlWq5+7NcNqI3er9cB3a8jLZSBhg9pRW5s/2vT+kVYwA8y1YZeaK5V+/Jp20U06D3aXRU4KQbjbRzMIQi9CmXM9TDrX07OXtqGlREpcX3b/678fyFK0HHadUs5A1BbqqkaJKcWFcHLI89M66b8/XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761786967; c=relaxed/simple;
	bh=IthoGz4qJUG6GlLBMePghn2RRVGOaSQuMKeuAbQyz6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dvweliQNDn1hpPcPBSFA8TpOLYdb/ybtwl5Jj1RQsqTYMe5+JwoQJSFgWKijit9qj/JfaaFLGfDXHbA8u8q1Bhgpwq6YWggC+Co+jwN648DcQpUmGedKLxVRLZSTAzHhBCKXI5jRILp0nHsxN3KF/yB5e9a1XLmA/2/H1Uae6AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lODCdK6r; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lODCdK6r"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761786960; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hfAAEiDXRtzE+NZ05S48S2bdZE0MaHUuFgXbP1Eu81w=;
	b=lODCdK6rAqnJOB9e1m8k0f5JG9uIpabFNBYRWMeBJ4ahlhC/XQgfr3hAqRj2b1NZX3Qm+Agow/0d1OX6XKrm7jnDIKbI5/KFSPdbzRFshclqHAZMEit6Sh0JWuTWgJBnjYvOHJoEDauDDhDe7WdUaHaDsYsFhQm1q9sl1uuGjn4=
Received: from 30.74.144.140(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WrHfwfa_1761786955 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Oct 2025 09:15:56 +0800
Message-ID: <5c7aaf9b-a6c0-4670-a244-67948ca86727@linux.alibaba.com>
Date: Thu, 30 Oct 2025 09:15:55 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 06/15] khugepaged: introduce
 collapse_max_ptes_none helper function
To: Nico Pache <npache@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kas@kernel.org, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 pfalcato@suse.de
References: <20251022183717.70829-1-npache@redhat.com>
 <20251022183717.70829-7-npache@redhat.com>
 <5f8c69c1-d07b-4957-b671-b37fccf729f1@lucifer.local>
 <CAA1CXcA4AcHrw18JfAoVygRgUZW3EzsN6RPZVrC=OJwSNu_9HA@mail.gmail.com>
 <e69acbc5-0824-4b07-8744-8d5145e2580b@redhat.com>
 <e66b671f-c6df-48c1-8045-903631a8eb85@lucifer.local>
 <74583699-bd9e-496c-904c-ce6a8e1b42d9@redhat.com>
 <3dc6b17f-a3e0-4b2c-9348-c75257b0e7f6@lucifer.local>
 <b1f8c5e3-0849-4c04-9ee3-5a0183d3af9b@linux.alibaba.com>
 <2ab547d2-584b-48fe-9f43-7c14caa7ab05@lucifer.local>
 <CAA1CXcA1nqt_f+zSOF66eTNWJACCE84hSQn4uNF8CjcBUZ_1oA@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcA1nqt_f+zSOF66eTNWJACCE84hSQn4uNF8CjcBUZ_1oA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/10/30 05:14, Nico Pache wrote:
> On Wed, Oct 29, 2025 at 12:56 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
>>
>> On Wed, Oct 29, 2025 at 10:09:43AM +0800, Baolin Wang wrote:
>>> I finally finished reading through the discussions across multiple
>>> threads:), and it looks like we've reached a preliminary consensus (make
>>> 0/511 work). Great and thanks!
>>
>> Yes we're getting there :) it's a sincere effort to try to find a way to move
>> forwards.
>>
>>>
>>> IIUC, the strategy is, configuring it to 511 means always enabling mTHP
>>> collapse, configuring it to 0 means collapsing mTHP only if all PTEs are
>>> non-none/zero, and for other values, we issue a warning and prohibit mTHP
>>> collapse (avoid Lorenzo's concern about silently changing max_ptes_none).
>>> Then the implementation for collapse_max_ptes_none() should be as follows:
>>>
>>> static int collapse_max_ptes_none(unsigned int order, bool full_scan)
>>> {
>>>          /* ignore max_ptes_none limits */
>>>          if (full_scan)
>>>                  return HPAGE_PMD_NR - 1;
>>>
>>>          if (order == HPAGE_PMD_ORDER)
>>>                  return khugepaged_max_ptes_none;
>>>
>>>          /*
>>>           * To prevent creeping towards larger order collapses for mTHP
>>> collapse,
>>>           * we restrict khugepaged_max_ptes_none to only 511 or 0,
>>> simplifying the
>>>           * logic. This means:
>>>           * max_ptes_none == 511 -> collapse mTHP always
>>>           * max_ptes_none == 0 -> collapse mTHP only if we all PTEs are
>>> non-none/zero
>>>           */
>>>          if (!khugepaged_max_ptes_none || khugepaged_max_ptes_none ==
>>> HPAGE_PMD_NR - 1)
>>>                  return khugepaged_max_ptes_none >> (HPAGE_PMD_ORDER -
>>> order);
>>>
>>>          pr_warn_once("mTHP collapse only supports khugepaged_max_ptes_none
>>> configured as 0 or %d\n", HPAGE_PMD_NR - 1);
>>>          return -EINVAL;
>>> }
>>>
>>> So what do you think?
>>
>> Yeah I think something like this.
>>
>> Though I'd implement it more explicitly like:
>>
>>          /* Zero/non-present collapse disabled. */
>>          if (!khugepaged_max_ptes_none)
>>             return 0;
>>
>>          /* Collapse the maximum number of zero/non-present PTEs. */
>>          if (khugepaged_max_ptes_none == HPAGE_PMD_NR - 1)
>>                  return (1 << order) - 1;
>>
>> Then we can do away with this confusing (HPAGE_PMD_ORDER - order) stuff.
> 
> This looks cleaner/more explicit given the limits we are enforcing!
> 
> I'll go for something like that.
> 
>>
>> A quick check in google sheets suggests my maths is ok here but do correct me if
>> I'm wrong :)
> 
> LGTM!

LGTM. Thanks.
