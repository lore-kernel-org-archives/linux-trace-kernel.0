Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2C2620DE;
	Thu, 22 May 2025 09:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747906781; cv=none; b=lrS/UlKBiab27xqD7QxHGLyCHUVgjUd1bsc8T/86zFHkbgu+4D63Y96IUvn37Qa6G9Ev44iykQ3sbr5sLOag8gI5cD9Db2JCsIVz95gBzaXi7VL9NrjnmCFxdPSF2y3f6qwZqfiqgCX0gZ8XQLn8HTEnKvig1NBg3ABX/afSATo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747906781; c=relaxed/simple;
	bh=puZ1Oa9pAogZNg5hFYutdx+3Wzy6JNYFbojwWGjESfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MPIQS/KA1ExVkmS462DAi2pFJXre1/+r+HrCh8maERnVNeUJuhhRV6mqPLpF1lGVcU9PYPiyMITLG/gMmBeMYHLrLL6UuYZ8YkcfzmVegLga5EySWOSuD7U7JIKH3CEHx09h7SV9L+lQPwTBDocBgFYpdxd6+4vhD+Yzo5BVd/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=L7W9B8BC; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="L7W9B8BC"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747906770; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=eq52ZTiE586FJQkx6x0iygDvQMrob1T/ZEeu27iZI3Q=;
	b=L7W9B8BCPhL4jE+X4qIz+T6SHhOwzKq5rSxsuiWJ9zGrMKH6K++LbZietS6pdp3p18tPVQ7Dk1Xk3QeNTdXuuOOmjCRJuoqn38Yzy/DxffWanAhoNnulE6/vm0ZpNpnZqSuMRVD7RU5S1o+EAIJ1ulUANbdSYMXhEqep0hb6m/0=
Received: from 30.74.113.135(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WbVRfy2_1747906766 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 22 May 2025 17:39:27 +0800
Message-ID: <1f00fdc3-a3a3-464b-8565-4c1b23d34f8d@linux.alibaba.com>
Date: Thu, 22 May 2025 17:39:26 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Nico Pache <npache@redhat.com>, David Rientjes <rientjes@google.com>,
 zokeefe@google.com
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
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
 jglisse@google.com, surenb@google.com, hannes@cmpxchg.org, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-7-npache@redhat.com>
 <9c54397f-3cbf-4fa2-bf69-ba89613d355f@linux.alibaba.com>
 <CAA1CXcC9MB2Nw4MmGajESfH8DhAsh4QvTj4ABG3+Rg2iPi087w@mail.gmail.com>
 <ed1d1281-ece3-4d2c-8e58-aaeb436d3927@linux.alibaba.com>
 <CAA1CXcAWcahkxzsvK_bcWei6or_gKBjt+97dqhuSem8N7cBAQw@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcAWcahkxzsvK_bcWei6or_gKBjt+97dqhuSem8N7cBAQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/21 18:23, Nico Pache wrote:
> On Tue, May 20, 2025 at 4:09 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>> Sorry for late reply.
>>
>> On 2025/5/17 14:47, Nico Pache wrote:
>>> On Thu, May 15, 2025 at 9:20 PM Baolin Wang
>>> <baolin.wang@linux.alibaba.com> wrote:
>>>>
>>>>
>>>>
>>>> On 2025/5/15 11:22, Nico Pache wrote:
>>>>> khugepaged scans anons PMD ranges for potential collapse to a hugepage.
>>>>> To add mTHP support we use this scan to instead record chunks of utilized
>>>>> sections of the PMD.
>>>>>
>>>>> khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
>>>>> that represents chunks of utilized regions. We can then determine what
>>>>> mTHP size fits best and in the following patch, we set this bitmap while
>>>>> scanning the anon PMD. A minimum collapse order of 2 is used as this is
>>>>> the lowest order supported by anon memory.
>>>>>
>>>>> max_ptes_none is used as a scale to determine how "full" an order must
>>>>> be before being considered for collapse.
>>>>>
>>>>> When attempting to collapse an order that has its order set to "always"
>>>>> lets always collapse to that order in a greedy manner without
>>>>> considering the number of bits set.
>>>>>
>>>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>>>
>>>> Sigh. You still haven't addressed or explained the issues I previously
>>>> raised [1], so I don't know how to review this patch again...
>>> Can you still reproduce this issue?
>>
>> Yes, I can still reproduce this issue with today's (5/20) mm-new branch.
>>
>> I've disabled PMD-sized THP in my system:
>> [root]# cat /sys/kernel/mm/transparent_hugepage/enabled
>> always madvise [never]
>> [root]# cat /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
>> always inherit madvise [never]
>>
>> And I tried calling madvise() with MADV_COLLAPSE for anonymous memory,
>> and I can still see it collapsing to a PMD-sized THP.
> Hi Baolin ! Thank you for your reply and willingness to test again :)
> 
> I didn't realize we were talking about madvise collapse-- this makes
> sense now. I also figured out why I could "reproduce" it before. My
> script was always enabling the THP settings in two places, and I only
> commented out one to test this. But this time I was doing more manual
> testing.
> 
> The original design of madvise_collapse ignores the sysfs and
> collapses even if you have an order disabled. I believe this behavior
> is wrong, but by design. I spent some time playing around with madvise
> collapses with and w/o my changes. This is not a new thing, I
> reproduced the issue in 6.11 (Fedora 41), and I think its been
> possible since the inception of madvise collapse 3 years ago. I
> noticed a similar behavior on one of my RFC since it was "breaking"
> selftests, and the fix was to reincorporate this broken sysfs
> behavior.

OK. Thanks for the explanation.

> 7d8faaf15545 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage collapse")
> "This call is independent of the system-wide THP sysfs settings, but
> will fail for memory marked VM_NOHUGEPAGE."
> 
> The second condition holds true (and fails for VM_NOHUGEPAGE), but I
> dont know if we actually want madvise_collapse to be independent of
> the system-wide.

This design principle surprised me a bit, and I failed to find the 
reason in the commit log. I agree that "never should mean never," and we 
should respect the THP/mTHP sysfs setting. Additionally, for the 
'shmem_enabled' sysfs interface controlled for shmem/tmpfs, THP collapse 
can still be prohibited through the 'deny' configuration. The rules here 
are somewhat confusing.

> So I'll ask the authors
> +David Rientjes +zokeefe@google.com
> Was this brought up as a concern when this feature was first
> introduced, was there any pushback, what was the outcome of the
> discussion if so?
> I can easily fix this and it would further simplify the code (by
> removing the is_khugepaged and friends). As David H. has brought up in
> other discussions around similar topics, never should mean never, is
> this the only exception we should allow?

I don't think we need this exception, unless there is some solid reason.
