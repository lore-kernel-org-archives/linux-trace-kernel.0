Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBF2701C8;
	Mon,  9 Jun 2025 03:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749438740; cv=none; b=uMgRaizXnuSUrIFSLkwI/bmQJT0VriItncs4lsk2urS/TsoXudlQBQX72wU5t/pEW7Tph8aWzXDutm+VkIAMG4aAfAt6ZFO2eIIF+Iui1jzEIseqQZWN2RXYm6nBA5sW3Oymdx/SwSE+qReHsGoNRCde6HlTIJKD2fKIxQkacsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749438740; c=relaxed/simple;
	bh=dDrMQ92LuLGu55pFGVPF5AMJ71MKlzo/xb2Mi66ibTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ebsWsQIHgyOpmoZjLZCsJaz5S6XZoAgEDg/7btKdft9BBo7nlWReNuuyICzfiO3GeP+fMaPAHdKVVJioDyK+D7Gjl7YDt6uDbgSCc+c65uuyMV4DA+OSoi4WGxUkQglYB9h6zJ1vn5jNVR/YJudUnD1NUPUg+xx+fgukOv7X5nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=hbain1Vd; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="hbain1Vd"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749438728; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=D4pMAoDuYGVY/y/srg/WEDjx+BfgvSMCUgZlsMgt/Ck=;
	b=hbain1Vdj7xorIGvIBqBRxwg0OMHYcQrJsEpzIi3BWXQAMAs1jak91L3bybDxVuKY3Kr7M1VvfeX8inQt8uJGGKM2n3zg0GcFy1qp6zWzMKuP6IGDg6c5sZiBeMlPQWIoR+N4H2SepO+enz0agItrjQmQqgMuME9gmzovH/GdWE=
Received: from 30.74.144.144(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WdK.fGG_1749438403 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Jun 2025 11:06:44 +0800
Message-ID: <4a2c359e-79d9-447b-a43e-164333d08319@linux.alibaba.com>
Date: Mon, 9 Jun 2025 11:06:42 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 12/12] Documentation: mm: update the admin guide for
 mTHP collapse
To: Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>
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
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcB-A9U8GEodPrm3QdndzB2MY7eZHnoojVYU5fi_DJBbcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/6/9 03:50, Nico Pache wrote:
> On Sat, Jun 7, 2025 at 8:35 AM Dev Jain <dev.jain@arm.com> wrote:
>>
>>
>> On 07/06/25 6:27 pm, Nico Pache wrote:
>>> On Sat, Jun 7, 2025 at 12:45 AM Dev Jain <dev.jain@arm.com> wrote:
>>>>
>>>> On 15/05/25 8:52 am, Nico Pache wrote:
>>>>
>>>> Now that we can collapse to mTHPs lets update the admin guide to
>>>> reflect these changes and provide proper guidence on how to utilize it.
>>>>
>>>> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
>>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>>> ---
>>>>    Documentation/admin-guide/mm/transhuge.rst | 14 +++++++++++++-
>>>>    1 file changed, 13 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation/admin-guide/mm/transhuge.rst
>>>> index dff8d5985f0f..5c63fe51b3ad 100644
>>>> --- a/Documentation/admin-guide/mm/transhuge.rst
>>>> +++ b/Documentation/admin-guide/mm/transhuge.rst
>>>>
>>>>
>>>> We need to modify/remove the following paragraph:
>>>>
>>>> khugepaged currently only searches for opportunities to collapse to
>>>> PMD-sized THP and no attempt is made to collapse to other THP
>>>> sizes.
>>> On this version this is currently still true, but once I add Baolin's
>>> patch it will not be true. Thanks for the reminder :)
>>
>> You referenced Baolin's patch in the other email too, can you send the link,
>> or the patch?
> 
> He didn't send it to the mailing list, but rather off chain to all the
> recipients of this series. You should have it in your email look for
> 
> Subject: "mm: khugepaged: allow khugepaged to check all anonymous mTHP
> orders" and "mm: khugepaged: kick khugepaged for enabling
> none-PMD-sized mTHPs"

You can find them at the following link:
https://lore.kernel.org/all/ac9ed6d71b439611f9c94b3506a8ce975d4636e9.1748435162.git.baolin.wang@linux.alibaba.com/
