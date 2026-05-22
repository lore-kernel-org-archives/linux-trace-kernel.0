Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014463AFAF9;
	Fri, 22 May 2026 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779462795; cv=none; b=JYO+nA7zKLdA33QGJIoBuiBCNRsvIy8gaGXxUTISzsdxC5YmJRKL8a5dQRmTvT1LIxFId/dJpAMKAZMZPZsIvNk8fvFmm+ibtLe8jO362xarYpuN29q4+Znxc/zOwJgDFK/0I46d1DPvwy4uqe9VbSbpHJs9OsdCCAdarL4l0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779462795; c=relaxed/simple;
	bh=aXv5l+5Y7dbG0ypH66F34Cq8ZzaM4rvCnbNmdzNds0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMsJeDByI0fJgDiLO4pVJ1nHvycVZOhmG6Gfk6qfckirQBnBJe7WpjsHCOfK2PndHsEMviBbvtizZEpxNfM3LcYduIxuPlpEioQ2CbpQiGRHP9X833YwEG/Dv+DjyN93APzTy8bnYzJLLh//TC74Ph7PXVcAtIefFFsu86ON5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4Mm/jjj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4Mm/jjj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F43D1F000E9;
	Fri, 22 May 2026 15:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779462793;
	bh=FwmdH4Y6VTSDIKPcMv3e/jCQbBDrDMuGZ7Y1gLKOyec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B4Mm/jjjRaPcrfjt/1sddtWIF9oDFwkJhy8uNkcNzcagpwMifGf2KPjwymhlleHHR
	 5HNK7OwvDNBjLXWEPj9af7MgZHlRmxoDL/qwZ6cnJpskQCnW8hmazLs3TgKNXxvYRm
	 lzyGT97VT41Aou7m8eUL2m8iVb+IDoxlQptJ68bYSA07TITB8nQAaZVcWoP+Mk26vZ
	 bLb26fqEsceq7r/CYFNa82Lom/VqDZHBcUsCjshccRZjl0eWlBE2RtmRR0fOmB1UzY
	 H8/UBpzdN+qRqIo5BSb7gjwCFSwuoaK8UFaubsMzkK05bAGTjupZDSvZHyhHMwzNOL
	 1LQly0acqtMaA==
Message-ID: <bd622950-62cf-4b57-b3ac-89635f28fa4f@kernel.org>
Date: Fri, 22 May 2026 17:13:01 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
Content-Language: en-US
To: Nico Pache <npache@redhat.com>, linux-doc@vger.kernel.org,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Cc: aarcange@redhat.com, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com,
 catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net,
 dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com,
 gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz,
 jackmanb@google.com, jannh@google.com, jglisse@google.com,
 joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev,
 liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com,
 matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com,
 peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com,
 rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com,
 rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com,
 shivankg@amd.com, sunnanyong@huawei.com, surenb@google.com,
 thomas.hellstrom@linux.intel.com, tiwai@suse.de, usamaarif642@gmail.com,
 vbabka@suse.cz, vishal.moola@gmail.com, wangkefeng.wang@huawei.com,
 will@kernel.org, willy@infradead.org, yang@os.amperecomputing.com,
 ying.huang@linux.alibaba.com, ziy@nvidia.com, zokeefe@google.com
References: <20260522150009.121603-1-npache@redhat.com>
 <CAA1CXcCoDU_pnp0SmMzRi8wPGB1OBjbbokevq2X_03X1vpWtOw@mail.gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <CAA1CXcCoDU_pnp0SmMzRi8wPGB1OBjbbokevq2X_03X1vpWtOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/22/26 17:07, Nico Pache wrote:
> On Fri, May 22, 2026 at 8:59 AM Nico Pache <npache@redhat.com> wrote:
>>  include/trace/events/huge_memory.h         |  34 +-
>>  mm/huge_memory.c                           |  11 +
>>  mm/khugepaged.c                            | 634 ++++++++++++++++-----
>>  5 files changed, 584 insertions(+), 172 deletions(-)
>>
>>
>> base-commit: 6c8cb505a5634594b3ea159fd1c71bce2acf3346
> 
> Whoops I manually changed the coverletter subject to reflect that this
> in on mm-hotfixes-unstable but never updated the others...

But why? That branch is for hotfixes that would go to the current 7.1-rcX
series. mm-unstable would be the correct one for this, AFAICT.

> Hopefully that is ok. Just a small mistake. Base commit is referenced here.
> 
> -- Nico
> 
> 
>> --
>> 2.54.0
>>
> 

