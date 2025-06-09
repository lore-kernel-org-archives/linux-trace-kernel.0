Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CA436D;
	Mon,  9 Jun 2025 06:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749451216; cv=none; b=H+Kz1fYPxB441QaB5hpPGlZiMLBwMGIPXuzUIEnZNaagtKe5+bZpONN/fEaGl/nLyTlBjLzuzT09OGokryuxLPiUjWTbBaI/dvjvpWhh0lY+9QIgrhk8TRO+1UWFRHrnbIM3rC3pMoMcBAzuE5vVX7HtEZ2tBIJUW/gnqn1GWJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749451216; c=relaxed/simple;
	bh=m55cKIaY9H0hCIMu4Ge688BJ4aclsS1xjVtZL1qxvsY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BpyGtNLNm8XlNb7pAMa9ZWoKQabjtktLzk+Ob6lFm/rAnHok3M44BVIRVUlm5SUG8jZvEMIJE+gSdhQpuYvlgNonW2ZASEyzNdDoK6stw14PFsGJ24qBQypcRgPuexfaCX7HDqEUKM42z3Ci+obGrw2j1/KiVVWx3BKapKMTarU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=b2a6ehIH; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="b2a6ehIH"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749451204; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=o97s10FY+Wv7SzIsnAFoNNPigIWi74HKWMtvTdt5ElI=;
	b=b2a6ehIHTwmdbKjKH4haCWJ2aQbCYnmCuZhj845V9GgTR1dlcFA952HQZ4ejGuwfNx0kXNEmLlOFoMuItNqr8GIzK1lshaFIz3lJtWxeI6AdSFCQkpGvf7ljmBrynmmqCguR/7FhlQC6UqJD/du3PNfzfGVDyviYSMf8HDvFZqs=
Received: from 30.74.144.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdM6nse_1749451199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Jun 2025 14:40:01 +0800
Message-ID: <6bb2a3f5-d10c-4a0a-abd3-d319dc70aec8@linux.alibaba.com>
Date: Mon, 9 Jun 2025 14:39:59 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
To: Dev Jain <dev.jain@arm.com>, Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com,
 Liam.Howlett@oracle.com, ryan.roberts@arm.com, corbet@lwn.net,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org,
 peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org, Bagas Sanjaya <bagasdotme@gmail.com>
References: <20250515032226.128900-1-npache@redhat.com>
 <20250515032226.128900-13-npache@redhat.com>
 <bc8f72f3-01d9-43db-a632-1f4b9a1d5276@arm.com>
 <CAA1CXcDOEdJRvZMu2Fyy4wsdy8k8nj4c45s4JanO9HzyJgyXOw@mail.gmail.com>
 <b09d7553-c3c6-453a-8e3a-86dc4caeb431@arm.com>
 <CAA1CXcB-A9U8GEodPrm3QdndzB2MY7eZHnoojVYU5fi_DJBbcw@mail.gmail.com>
 <4a2c359e-79d9-447b-a43e-164333d08319@linux.alibaba.com>
 <b6de3ecf-a573-4a65-b575-2ba361a6ba98@arm.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <b6de3ecf-a573-4a65-b575-2ba361a6ba98@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/6/9 13:26, Dev Jain wrote:
> 
> On 09/06/25 8:36 am, Baolin Wang wrote:
>>
>>
>> On 2025/6/9 03:50, Nico Pache wrote:
>>> On Sat, Jun 7, 2025 at 8:35 AM Dev Jain <dev.jain@arm.com> wrote:
>>>>
>>>>
>>>> On 07/06/25 6:27 pm, Nico Pache wrote:
>>>>> On Sat, Jun 7, 2025 at 12:45 AM Dev Jain <dev.jain@arm.com> wrote:
>>>>>>
>>>>>> On 15/05/25 8:52 am, Nico Pache wrote:
>>>>>>
>>>>>> Now that we can collapse to mTHPs lets update the admin guide to
>>>>>> reflect these changes and provide proper guidence on how to 
>>>>>> utilize it.
>>>>>>
>>>>>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>>>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>>>>> ---
>>>>>>    Documentation/admin-guide/mm/transhuge.rst | 14 +++++++++++++-
>>>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst 
>>>>>> b/Documentation/admin-guide/mm/transhuge.rst
>>>>>> index dff8d5985f0f..5c63fe51b3ad 100644
>>>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>>>>
>>>>>>
>>>>>> We need to modify/remove the following paragraph:
>>>>>>
>>>>>> khugepaged currently only searches for opportunities to collapse to
>>>>>> PMD-sized THP and no attempt is made to collapse to other THP
>>>>>> sizes.
>>>>> On this version this is currently still true, but once I add Baolin's
>>>>> patch it will not be true. Thanks for the reminder :)
>>>>
>>>> You referenced Baolin's patch in the other email too, can you send 
>>>> the link,
>>>> or the patch?
>>>
>>> He didn't send it to the mailing list, but rather off chain to all the
>>> recipients of this series. You should have it in your email look for
>>>
>>> Subject: "mm: khugepaged: allow khugepaged to check all anonymous mTHP
>>> orders" and "mm: khugepaged: kick khugepaged for enabling
>>> none-PMD-sized mTHPs"
>>
>> You can find them at the following link:
>> https://lore.kernel.org/all/ac9ed6d71b439611f9c94b3506a8ce975d4636e9.1748435162.git.baolin.wang@linux.alibaba.com/
> 
> 
> Thanks! Looks quite similar to my approach.

Sorry, I didn't see your previous patches (if I had, it would have saved 
me a lot of testing time:) ).
