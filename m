Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60DDC1EB9F2
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 09:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996118; cv=none; b=X41l8MqxPDXWeQ+dDuDb+k1F1CdmKFGTvEHBIz7JXYkCyyy2y3d3719sTLo+B/jyXazTHIplS6lJuHAG4Ac3BgkVOguHGS02cL++yVJxQQ0thXfCDCebPlGpww5Z4RPdXtEBafidmlRjQbxTv/oNXfFkTCU97hCwXy2CYlwgbcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996118; c=relaxed/simple;
	bh=ELTIZfPUhLxbEZbkSlSVE+gpbL1zi2Cs3U5SkO7yw9I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MvL0bQllXrifuf8xKarOGUt8oh4jVZ2i96j9Hr/7jpnDyC0MAfdSnjlGnFhouqNMFxJeuZQaiIQIauQcaa2mFN0AJfecIHV2r/ykmZdFGVHpRxnj4PqhoBEx15mzuUjLFWYUGkK16lrj2fKzvkPZWU6Ipo+5BS8J8tKPfkOR+28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hfr7GTaI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hfr7GTaI"
Message-ID: <f21d7c12-e6c7-49b0-8d83-c26946d0d4ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780996114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bk+cuqVkiscfXQOg4Fx57mt0jx9ijz84xEuHbEOrHnY=;
	b=hfr7GTaIOxEAe5xwodnf8gchpVC+CiIkwRdFShplJcUJFtzPmOK1trlHgkVaZMgy9vt+zM
	+j/MS1T1gPELGLosMYUNtpIGnqJcb/YWUD5btv+XufH/GnFFMvuwx5Sdpu1v0Rfj92qnKZ
	GJ7UF+QuxRptHJRUZ9++OfMXio3i5ic=
Date: Tue, 9 Jun 2026 17:08:14 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v8 2/6] mm/memory-failure: surface unhandlable kernel
 pages as -ENOTRECOVERABLE
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Breno Leitao <leitao@debian.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Shuah Khan <shuah@kernel.org>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 "Liam R. Howlett" <liam@infradead.org>
References: <20260527-ecc_panic-v8-0-9ea0cfa16bb0@debian.org>
 <20260527-ecc_panic-v8-2-9ea0cfa16bb0@debian.org>
 <19f968f5-1289-f573-4406-e5c91dcd8923@huawei.com>
 <e3d023f1-ab6e-4424-b304-55f1294480c3@kernel.org>
 <33ef8821-c809-b7d1-ea77-6e8a07a6e784@huawei.com>
 <21732071-14a1-486a-951c-34de97b7c757@kernel.org>
 <4b27467e-935f-5587-2f48-5a794c30a592@huawei.com>
 <aiKXrovzrNN-gExm@gmail.com>
 <f1a742be-80cb-4256-b1f9-e50a0f83cb15@kernel.org>
 <aibN4osY_QF1Rejh@gmail.com>
 <4953bcee-5a0f-2bc5-7295-63e5e7513e8b@huawei.com>
 <f2a4d5c8-3d7d-4fc3-8769-66e0c24866fb@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <f2a4d5c8-3d7d-4fc3-8769-66e0c24866fb@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/6/9 15:09, David Hildenbrand (Arm) wrote:
> On 6/9/26 04:39, Miaohe Lin wrote:
>> On 2026/6/8 22:15, Breno Leitao wrote:
>>> On Fri, Jun 05, 2026 at 11:42:53AM +0200, David Hildenbrand (Arm) wrote:
>>>>
>>>> I mean, any such races can currently already happen one way or the other?
>>>>
>>>> Really, the only way to not get races is to tryget the (compound)page,
>>>> revalidate that the page is still part of the compound page.
>>>>
>>>> I'm not sure if that's really a good idea.
>>>>
>>>> But my memory is a bit vague in which scenarios we already hold a page reference
>>>> here to prevent any concurrent freeing?
>>>
>>> No, we don't hold one here in the case that matters.
>>>
>>> HWPoisonKernelOwned() runs at the very top of get_any_page(), before
>>> try_again: and before __get_hwpoison_page(). The first refcount taken in
>>> the whole path is the folio_try_get() inside __get_hwpoison_page(), which
>>> runs *after* the short-circuit.
>>>
>>> So get_any_page() itself never holds a reference at the check -- the only way
>>> one exists is if the caller passed MF_COUNT_INCREASED (count_increased ==
>>> true).
>>>
>>> So on the MCE/GHES path -- the one this panic option exists for -- no
>>> reference is held when HWPoisonKernelOwned() does its compound_head() +
>>> PageSlab()/PageTable()/PageLargeKmalloc() checks.
>>>
>>> Given that, I'd rather keep it racy and take no refcount than add a
>>> tryget + revalidate purely for this check. As I've said earleir, an operator
>>
>> Would it be acceptable to add a simple recheck? Something like below:
>>
>> retry:
>> head = compound_head(page);
>> PageSlab()/PageTable()/PageLargeKmalloc() checks
>> if (head != compound_head(page))
>> 	goto retry
> 
> Sure. I guess it could still be racy in some weird scenarios where we
> free+allocate+free in-between.

+1, sounds reasonable to me. Still racy, but acceptable here I guess :D
