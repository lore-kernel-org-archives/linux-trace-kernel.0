Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D031E515;
	Tue, 29 Apr 2025 06:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745909631; cv=none; b=mRJXcYsWE8+2jBSeMSeXSEP24WBUzrnImxbGlg4ouIMUQJHTMpji+xmUF9aBgwx/ZEG2BC9QGNLujFpBZ+kmiqTvTQG3d7sfLn3w4DTzeLC7Aw7zMsMtrqMH5wEkE6vwyCPWfnozP1Q1oAzo/YQqZ6MiZSX+pskFRgl5atCpAZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745909631; c=relaxed/simple;
	bh=MBdaKqBn1GY03DNw516nZuhW1dqrdU482MzlT2PHnEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fM9QagN9tJYdLaf+ze2wB0eO9yBdNXsrT+Bhm6j3h+1w4fs84f4gyc8W2yzz1nPqAxeaXl2CsMDgX+ULBE1nQQIysCZ7T5HkxO4O/K97ocW7AY9Jz+ntDUuQaOsfZ5bgNuVBMLXdVZ6XRe+E0fqPDtYp8Zf56D9PON6HHEYNwuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ye8oFR2V; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Ye8oFR2V"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1745909619; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zKUAIH8fJv5MObC6iQu8Od+JSaRaIcL2RN27u9jfiXM=;
	b=Ye8oFR2VAbOMMNuTDjVVsoOArPoeD6Dymu8KUfSlvuyS+lu/cIxhXaO4NKLLjMMnfGQsQhTG0m6pwD6Kctj3bX/SJkYIU/yGZZeHO0yvAi5ugqShxMFNvt6NtFP6HrUqaGL6q5swXbIx69+S1OC4jviTldn996rjjKkEa+iTRMI=
Received: from 30.74.146.169(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WYcp48f_1745909615 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 29 Apr 2025 14:53:36 +0800
Message-ID: <d64116c5-4851-4658-9b68-fdba3886b4cd@linux.alibaba.com>
Date: Tue, 29 Apr 2025 14:53:35 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/12] khugepaged: skip collapsing mTHP to smaller
 orders
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org,
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
 rdunlap@infradead.org
References: <20250417000238.74567-1-npache@redhat.com>
 <20250417000238.74567-9-npache@redhat.com>
 <fb932eac-86ce-4f7d-8eed-8dc44f5a40c1@linux.alibaba.com>
 <CAA1CXcCEsdW+k96DX3LZ6J4MmNEnugyxCXcHkneqxV4-nahmsg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcCEsdW+k96DX3LZ6J4MmNEnugyxCXcHkneqxV4-nahmsg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/4/28 23:44, Nico Pache wrote:
> On Thu, Apr 24, 2025 at 1:49 AM Baolin Wang
> <baolin.wang@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/4/17 08:02, Nico Pache wrote:
>>> khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
>>> some pages being unmapped. Skip these cases until we have a way to check
>>> if its ok to collapse to a smaller mTHP size (like in the case of a
>>> partially mapped folio).
>>>
>>> This patch is inspired by Dev Jain's work on khugepaged mTHP support [1].
>>>
>>> [1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.com/
>>>
>>> Co-developed-by: Dev Jain <dev.jain@arm.com>
>>> Signed-off-by: Dev Jain <dev.jain@arm.com>
>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>> ---
>>>    mm/khugepaged.c | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
>>> index ece39fd71fe6..383aff12cd43 100644
>>> --- a/mm/khugepaged.c
>>> +++ b/mm/khugepaged.c
>>> @@ -625,7 +625,12 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
>>>                folio = page_folio(page);
>>>                VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
>>>
>>> -             /* See hpage_collapse_scan_pmd(). */
>>> +             if (order != HPAGE_PMD_ORDER && folio_order(folio) >= order) {
>>> +                     result = SCAN_PTE_MAPPED_HUGEPAGE;
>>> +                     goto out;
>>> +             }
>>
>> Should we also add this check in hpage_collapse_scan_pmd() to abort the
>> scan early?
> No I dont think so, we can't abort there because we dont know the
> attempted collapse order, and we dont want to miss potential mTHP
> collapses (by bailing out early and not populating the bitmap).

OK. That makes sense.
