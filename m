Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8F5219EB;
	Tue,  8 Jul 2025 06:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751955350; cv=none; b=p/noFvPopP+LQOsYB9TmTDIv6zcyoSLhMzbrjze6fGDCWwZzucnf8dcoNJanNH4p4RzCru8pCI2whiEPFliPaJAhy403cdiimMEmLnlwpJ6x/6CqyanoYEtUHhKSviKMN6DKlfts1ghxp9zP5OBh2NvLU36wuDmgewiGErXFyHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751955350; c=relaxed/simple;
	bh=mbSg54oeCfBlZ8IPSjr+o7H6yLf1p5I8PFKTtzGrV+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fviyF/0Z2Ar5nIlgzok1os+GOqBYJn8VuaCBI5krLs+wLq7O6+GrSZVuj748oWRnZ5XsRnRWudVdU6iF/oTO0peLyMa/6LVMPGVthFzr5LLbusjkOjSfd3zzFZoQQ1/X61HKb2WPDxpQK2We+kinVc1Y+adSMgadF1KjWbMwrI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CD/2dz8C; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CD/2dz8C"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751955344; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=wupd60Oal9Y3QOsXWJFex1COZtG3ybcO2A2WTdS/tRc=;
	b=CD/2dz8CHnUnoRqLxvrPobeLgm8kAFQfK1Fr2priGLVi6y13CWdDCggZiKdTX1VC3E1XS6uvDyI9ZTkgZNKnlJ0OUn4D9ifMDxc8bWWWkDw63Hi96f1pgdmmX6yogzjO2Ejl2XCyojHZK3qEhCCUfrZ7bPDESx/WmWLcMiIX2l4=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WiL4GDP_1751955340 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:15:41 +0800
Message-ID: <854ef84f-20ae-4985-9514-7f0616e0fc85@linux.alibaba.com>
Date: Tue, 8 Jul 2025 14:15:40 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/15] khugepaged: allow madvise_collapse to check all
 anonymous mTHP orders
To: Nico Pache <npache@redhat.com>, Andrew Morton
 <akpm@linux-foundation.org>, david@redhat.com, dev.jain@arm.com,
 Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, baohua@kernel.org,
 willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com,
 usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com,
 anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de,
 will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 rdunlap@infradead.org
References: <20250702055742.102808-1-npache@redhat.com>
 <20250702055742.102808-12-npache@redhat.com>
 <2f6d9541-8083-4d3c-a9c1-cba0d5bf98a0@linux.alibaba.com>
 <20250704141422.359c89146ad69512b9be4902@linux-foundation.org>
 <CAA1CXcDkr8itrXiuVq+Tck1hkRwgq-byXCcM3oHqy1dXOhhTTg@mail.gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <CAA1CXcDkr8itrXiuVq+Tck1hkRwgq-byXCcM3oHqy1dXOhhTTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/7/8 12:37, Nico Pache wrote:
> On Fri, Jul 4, 2025 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>>
>> On Fri, 4 Jul 2025 14:11:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>>
>>> On 2025/7/2 13:57, Nico Pache wrote:
>>>> Allow madvise_collapse to scan/collapse all mTHP orders without the
>>>> strict requirement of needing the PMD-order enabled.
>>>>
>>>> Signed-off-by: Nico Pache <npache@redhat.com>
>>>
>>> I am afraid we should drop this patch from the series, since Hugh
>>> explicitly opposed my modification of the madvise_collapse control logic
>>> in this thread[1].
>>
>> Well it drops easily enough.  I don't know if it compiles yet.
>>
>> Nico, can you confirm that you're OK with the droppage and that the
>> series is still good without this patch?
> Yes that is fine, it shouldn't conflict at all. Although this isn't
> the only patch that will need modification... Ill reply to Baolin
> inline here.
>>
>>> Moreover, since we have not yet clarified how to handle the conflict
>>> between the semantics of madvise_collapse and the THP interfaces, we
>>> should keep the current logic[2] (means madvise_collapse still only
>>> allows PMD collapse).
> Hi Baolin,
> 
> Sorry I saw most of that discussion but missed that point by David.
> 
> We should come to an agreement on what the proper approach is, because
> if not we'll ALWAYS have this problem and NEVER solve it (pun
> intended).
> 
> Jokes aside, if we are leaving MADV_COLLAPSE untouched then I need to
> make some slight modifications to this series so that MADV_COLLAPSE
> never tries anything other than PMD collapse (should be a pretty small
> change). Dropping this commit alone does not achieve that, but rather
> just allows MADV_COLLAPSE to work if PMD is disabled, and one other
> mTHP size is enabled. On second thought this isn't great either as
> MADV_COLLAPSE ignores sysfs, so if you have any mTHP size enabled, it
> will still continue to collapse to other PMD+mTHP sizes... wow this
> really is a mess.

Yes, this is what I mentioned earlier about the conflict between 
MADV_COLLAPSE and mTHP collapse :(

>>> If madvise_collapse is to support mTHP collapse, there will be more
>>> semantic conflicts to discuss.
> I guess a V9 is inevitable, I will drop mTHP support for
> MADV_COLLAPSE, and drop this patch too. I'll let this series sit for a
> week or so to gather reviews (and make sure nothing else is missing).

Sure.
