Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA063EFD34
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773860934; cv=none; b=esmFJM0OhR8Bkxw1San1cFoEmDxXgWD9JkVMaoIwMlw3LgeroMKT1AgIbML4Rx2NsC2ZReheqQrR2DIq3J+MMJcy4sOoNLbu/69d8yzsGvxQMwvysZYKcwF/gEZr6IlfNtmaiv+xBkXOF7zvb5gGPnoWFryrSZeeVz06npdc2ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773860934; c=relaxed/simple;
	bh=kSP8f+EFeZqq/yt7CxcU+u1gw3rFxQ/0Ql60j3rS71o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Le1DqNTZDf6bsEZcr/OIK264j4WHb6E5IS6AtFb0gxZPBb/FZzfcQxhZNXD6BrcSUAKLJfq+xY167xH32rQAtDZzjjEQNp8k+8mcaFdHroF2C+bFOE3i87LQogQbz7v/zKbmPFjsSM7idkJKabLEf8ZKMEc2Dq35k8l1X8Z1XfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC2a0uCQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC2a0uCQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773860932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f9mKVwa6vsUmWHqI0OSFKEaOfvWTxQGO1i2JeECq6pA=;
	b=DC2a0uCQPgv6mZwXJLFUjA8WN25gM26p7EDHuSGiQAKGyT8qeVI7QOgGnnScswnoxR4WPt
	8FEeTjneOOUwXHJpO3pL2l/sHibFwLEIHkXuA9RQnKBVY5h70VzreFvR/EHdO0Y0eSN6VI
	t1kiXyN4Giey2DAfkHi3drxVwXZ4ULM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-GT0oQ2BrPqO8zyxCKXPmMQ-1; Wed, 18 Mar 2026 15:08:51 -0400
X-MC-Unique: GT0oQ2BrPqO8zyxCKXPmMQ-1
X-Mimecast-MFC-AGG-ID: GT0oQ2BrPqO8zyxCKXPmMQ_1773860931
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-89c3f19d4faso7350036d6.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Mar 2026 12:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773860931; x=1774465731;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9mKVwa6vsUmWHqI0OSFKEaOfvWTxQGO1i2JeECq6pA=;
        b=hW6XzN+QS7siqYPP5FSC3SBgckGLCsfDdwfvlbIFRrAGmzZAezEnLduet2bPkPqWmS
         ewkHsFg4KMdLXeAYcjU4zkGom3zL23Qwil0AMXwqxf/RFMn2QJfezz9c1xAfIm8U7ZLD
         pIcUmh6WNBCLXAlcjzZqr2v+4HJYMSM3i4ODK1gJ87kutyDOeKJdrOHZyK80gFaysNLL
         xVOF5tsm54fqLbnE+FuiTxH2xMw4REaKIkpoFbuUodtDrNRUJ4d7PvD4F5+ofYsfHu3P
         GLOCF1ns8btjV/GHnMzU5Pbmd4anqu4NYf5zjsTsKpQHqb2U+cXkaGyufMr3skXOXdSJ
         cM2w==
X-Forwarded-Encrypted: i=1; AJvYcCU3RzDvLoxi2vSfRqu1B6XlTTGv38V4aV/qAl0WnNGpsjeGH4Q1dEIxRxI73WbHAeKgPRbjLKXHm/y0H54gWkC2yac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoZgHD1wF3aMMxdanlxRU2rkG3wI2y3JYBZLg/91pifDWmmzEF
	mu8M5sHUFzKKYOx89c2ehbTD2WkVFKoVn+g0cU8AxhOUUeiOkDCPN0KUSeuNBWa/601xAK1tqCF
	FGH8Y/vgvrrUW3ec8ikzEy2QENTSYrVlJfts2dgYwuJB8c38vGM8wCRmTxOECxeot5Ywh56iPjA
	==
X-Gm-Gg: ATEYQzxM2n8IYxuLxjHUAgSDZSLOBlc4b9Tw99IXPd9PbNXXc15l06xBT3gLOeSOfcR
	YgT7KNrji3DXzzUKdctEcbJd590yBJG8qPEFzpTkjC+9deylCeTrVDxXO4AFtxrrT40nOaTOrV3
	RLsiBShH1Vi+Vp9U8rVJEDEyG0DdT0v3e0pZdXQujxd6vyIOqSq2TWkJ5xDSxI9e7gBb5c2mWZG
	zQBL+KqLn8hak4f/M+tPI8FKJ3aliV8yA8C4f6Ktx5K9ld0lZ3EYNPeS2v1+Z/3xQMp5jDqH8GH
	0RoDgqHpAqB6hTkyDyWOxF4OBqBocLOlpjIOS2E0DkCmKzD5ysb2wco5/Q1W4zKNoyzlXq4SzrD
	gLXROYqg/hxJ8ntDWGleBaXcYBrwHijr/CcO+xKCgCBWD/+HaAVpCf/cvhqii
X-Received: by 2002:ad4:5762:0:b0:899:ff66:814f with SMTP id 6a1803df08f44-89c7743a5efmr10892776d6.21.1773860930507;
        Wed, 18 Mar 2026 12:08:50 -0700 (PDT)
X-Received: by 2002:ad4:5762:0:b0:899:ff66:814f with SMTP id 6a1803df08f44-89c7743a5efmr10891856d6.21.1773860929913;
        Wed, 18 Mar 2026 12:08:49 -0700 (PDT)
Received: from [192.168.10.111] (c-76-154-99-94.hsd1.co.comcast.net. [76.154.99.94])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c6b7df8c0sm32931796d6.0.2026.03.18.12.08.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2026 12:08:49 -0700 (PDT)
Message-ID: <1adffe75-cc91-4c55-bde7-9406bf656c72@redhat.com>
Date: Wed, 18 Mar 2026 13:08:45 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable v15 13/13] Documentation: mm: update the admin
 guide for mTHP collapse
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, david@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com,
 akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net,
 hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com,
 jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com,
 kas@kernel.org, lance.yang@linux.dev, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com,
 shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com,
 thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com,
 vbabka@suse.cz, vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
 will@kernel.org, willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com,
 Bagas Sanjaya <bagasdotme@gmail.com>
References: <20260226031741.230674-1-npache@redhat.com>
 <20260226032706.234519-1-npache@redhat.com>
 <638caee3-af71-47c7-bdc8-a905d3143387@lucifer.local>
From: Nico Pache <npache@redhat.com>
In-Reply-To: <638caee3-af71-47c7-bdc8-a905d3143387@lucifer.local>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qN5SgGtsVGg4tGjeaGlcK4mJv4ueKMONziYciUZSyqY_1773860931
X-Mimecast-Originator: redhat.com
Content-Language: en-US, en-ZM
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/17/26 5:02 AM, Lorenzo Stoakes (Oracle) wrote:
> On Wed, Feb 25, 2026 at 08:27:06PM -0700, Nico Pache wrote:
>> Now that we can collapse to mTHPs lets update the admin guide to
>> reflect these changes and provide proper guidance on how to utilize it.
>>
>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>> Signed-off-by: Nico Pache <npache@redhat.com>
> 
> LGTM, but maybe we should mention somewhere about mTHP's max_ptes_none
> behaviour?

IIRC we decided to strictly leave that out of the manual. I used to have it in
here. @david?

> 
> Anyway with that addressed:
> 
> Reviewed-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>
> 
>> ---
>>  Documentation/admin-guide/mm/transhuge.rst | 48 +++++++++++++---------
>>  1 file changed, 28 insertions(+), 20 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>> index eebb1f6bbc6c..67836c683e8d 100644
>> --- a/Documentation/admin-guide/mm/transhuge.rst
>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>> @@ -63,7 +63,8 @@ often.
>>  THP can be enabled system wide or restricted to certain tasks or even
>>  memory ranges inside task's address space. Unless THP is completely
>>  disabled, there is ``khugepaged`` daemon that scans memory and
>> -collapses sequences of basic pages into PMD-sized huge pages.
>> +collapses sequences of basic pages into huge pages of either PMD size
>> +or mTHP sizes, if the system is configured to do so.
>>
>>  The THP behaviour is controlled via :ref:`sysfs <thp_sysfs>`
>>  interface and using madvise(2) and prctl(2) system calls.
>> @@ -219,10 +220,10 @@ this behaviour by writing 0 to shrink_underused, and enable it by writing
>>  	echo 0 > /sys/kernel/mm/transparent_hugepage/shrink_underused
>>  	echo 1 > /sys/kernel/mm/transparent_hugepage/shrink_underused
>>
>> -khugepaged will be automatically started when PMD-sized THP is enabled
>> +khugepaged will be automatically started when any THP size is enabled
>>  (either of the per-size anon control or the top-level control are set
>>  to "always" or "madvise"), and it'll be automatically shutdown when
>> -PMD-sized THP is disabled (when both the per-size anon control and the
>> +all THP sizes are disabled (when both the per-size anon control and the
>>  top-level control are "never")
>>
>>  process THP controls
>> @@ -264,11 +265,6 @@ support the following arguments::
>>  Khugepaged controls
>>  -------------------
>>
>> -.. note::
>> -   khugepaged currently only searches for opportunities to collapse to
>> -   PMD-sized THP and no attempt is made to collapse to other THP
>> -   sizes.
>> -
>>  khugepaged runs usually at low frequency so while one may not want to
>>  invoke defrag algorithms synchronously during the page faults, it
>>  should be worth invoking defrag at least in khugepaged. However it's
>> @@ -296,11 +292,11 @@ allocation failure to throttle the next allocation attempt::
>>  The khugepaged progress can be seen in the number of pages collapsed (note
>>  that this counter may not be an exact count of the number of pages
>>  collapsed, since "collapsed" could mean multiple things: (1) A PTE mapping
>> -being replaced by a PMD mapping, or (2) All 4K physical pages replaced by
>> -one 2M hugepage. Each may happen independently, or together, depending on
>> -the type of memory and the failures that occur. As such, this value should
>> -be interpreted roughly as a sign of progress, and counters in /proc/vmstat
>> -consulted for more accurate accounting)::
>> +being replaced by a PMD mapping, or (2) physical pages replaced by one
>> +hugepage of various sizes (PMD-sized or mTHP). Each may happen independently,
>> +or together, depending on the type of memory and the failures that occur.
>> +As such, this value should be interpreted roughly as a sign of progress,
>> +and counters in /proc/vmstat consulted for more accurate accounting)::
>>
>>  	/sys/kernel/mm/transparent_hugepage/khugepaged/pages_collapsed
>>
>> @@ -308,16 +304,19 @@ for each pass::
>>
>>  	/sys/kernel/mm/transparent_hugepage/khugepaged/full_scans
>>
>> -``max_ptes_none`` specifies how many extra small pages (that are
>> -not already mapped) can be allocated when collapsing a group
>> -of small pages into one large page::
>> +``max_ptes_none`` specifies how many empty (none/zero) pages are allowed
>> +when collapsing a group of small pages into one large page::
>>
>>  	/sys/kernel/mm/transparent_hugepage/khugepaged/max_ptes_none
>>
>> -A higher value leads to use additional memory for programs.
>> -A lower value leads to gain less thp performance. Value of
>> -max_ptes_none can waste cpu time very little, you can
>> -ignore it.
>> +For PMD-sized THP collapse, this directly limits the number of empty pages
>> +allowed in the 2MB region. For mTHP collapse, only 0 or (HPAGE_PMD_NR - 1)
>> +are supported. Any other value will emit a warning and no mTHP collapse
>> +will be attempted.
>> +
>> +A higher value allows more empty pages, potentially leading to more memory
>> +usage but better THP performance. A lower value is more conservative and
>> +may result in fewer THP collapses.
>>
>>  ``max_ptes_swap`` specifies how many pages can be brought in from
>>  swap when collapsing a group of pages into a transparent huge page::
>> @@ -337,6 +336,15 @@ that THP is shared. Exceeding the number would block the collapse::
>>
>>  A higher value may increase memory footprint for some workloads.
>>
>> +.. note::
>> +   For mTHP collapse, khugepaged does not support collapsing regions that
>> +   contain shared or swapped out pages, as this could lead to continuous
>> +   promotion to higher orders. The collapse will fail if any shared or
>> +   swapped PTEs are encountered during the scan.
>> +
>> +   Currently, madvise_collapse only supports collapsing to PMD-sized THPs
>> +   and does not attempt mTHP collapses.
>> +
>>  Boot parameters
>>  ===============
>>
>> --
>> 2.53.0
>>
> 

