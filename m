Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EADC2AF1B;
	Fri,  7 Nov 2025 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762484963; cv=none; b=opuLrHI9OpCc9P5GMHUWPA0QKhckV9M5DY/K+3W5d4FMaFJRuD2Qe3/JNB6+IpCK33OwLNruyOWSBaAE3JaMJvHjmxqFrYpl9qaVxXyj52D+yF7axPLwik38I+o9yZ39sYIdd+s3qKFTyL/hvGmsMAwns/y0lCjZhDgog8FIiBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762484963; c=relaxed/simple;
	bh=ClcAAJTTbFRg4nNGcEwjH09m1GfJy+3ADIF1d5aIvrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QV/f7tgLMhIQm7hI/LOdJt2kagkdvZ8mcfdYboucCtJ3cmx3qp361hxRiSDVm5C53Qp/Tgq/K8dCjB6pybsgp0hSI+onlAzIKUoKz5Cj96GmtEbJln9mA1X2vaXpS9xl2qYU7hVKwSAhK4Vk2MK3m3OioEWFg297fgyXSmSmiAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A435514BF;
	Thu,  6 Nov 2025 19:09:12 -0800 (PST)
Received: from [10.164.136.34] (unknown [10.164.136.34])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 316A13F63F;
	Thu,  6 Nov 2025 19:09:05 -0800 (PST)
Message-ID: <1c05c28a-a4f7-4562-8799-6f08a03bd3eb@arm.com>
Date: Fri, 7 Nov 2025 08:39:03 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 mm-new 07/15] khugepaged: generalize
 collapse_huge_page for mTHP collapse
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Nico Pache <npache@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com,
 ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org,
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
 <20251022183717.70829-8-npache@redhat.com>
 <7b6b5c6b-0298-47c1-ae48-17d603401bac@lucifer.local>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <7b6b5c6b-0298-47c1-ae48-17d603401bac@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> ----------[snip]------------
>
>> +
>> +		spin_lock(pmd_ptl);
> We're duplicating this in both branches, why not do outside if/else?
>
>> +		WARN_ON_ONCE(!pmd_none(*pmd));
> Hmm so the PMD entry will still always be empty on mTHP collapse? Surely we
> could be collapsing more than one mTHP into an existing PTE table no? I may
> be missing something here/confused :)

After this code path isolates the PTE table, we don't want any other code path
doing "Hey, I see an empty PMD, let's install a PTE table here". One of the
reasons why all the heavy locking is required here.

Also, I want to ask a question about WARN vs BUG_ON: suppose that the
race I described above occurs. After khugepaged isolates the PTE table, someone
faults in a PTE table there, and eventually writes data in the underlying folios.
Then the buggy khugepaged nukes out that table and installs a new one, installing
an mTHP folio which had old data. How do we decide whether such a condition is
worthy of a BUG_ON (leading to system crash) vs letting this pass with WARN?


>
> ------------[snip]----------
>
