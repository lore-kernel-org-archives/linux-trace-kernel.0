Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EAC33D6EE;
	Tue,  4 Aug 2026 21:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785879706; cv=none; b=qJAOrTwMvRbVHQdw2SsLKms6Qiq8Di3GVzuquAb4JFkkaTpFed9NC0/Op6stKCbF6zcBM4zmBRlfNHhZhLrU9629r4KSsmWV5YN3tHiHALo/I7efSofMs+Lp/xnjjDJ6NC964zn/iIA5I71fBStt7l2bcDnKQoThe3SL78l9Fi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785879706; c=relaxed/simple;
	bh=2Ets6xUSgF2SvIGIzBCZqUPBNHDHIma+VZOjrRyJNng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSUOWM6pa6qbTPm2lIJ69fooSTD8F+mEos6MJ2RbvYIMHgMQws9J57H5eA7NTGs5WHSq6aMuSM1ywDjaIKPtNWBqepdfPjvNJ+6y63yBkma/HizABUXYv49N4MXdycxsiC5dDHOuG7HfWdq6dNT1AI9V6Nz6WUpbQRRpE8MnXyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=GpnaBe0o; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="GpnaBe0o"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB2D21476;
	Tue,  4 Aug 2026 14:41:39 -0700 (PDT)
Received: from [10.57.44.180] (unknown [10.57.44.180])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4F683F632;
	Tue,  4 Aug 2026 14:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785879703; bh=2Ets6xUSgF2SvIGIzBCZqUPBNHDHIma+VZOjrRyJNng=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GpnaBe0oRUi1e8OuPU/5aYQXeTdrEzXqu0/FDRYf7ykUgZXs+paTXrrfiAVn8Hkw5
	 LMwuQUvxHsifZW4EMq02B8DUyiI19RuVa4iKcmQB7tjvv33kge4/oNppTpQO0LrYrq
	 cT7nX4IefFiL3fVJDuKi78qo87B3182Np0ul4upg=
Message-ID: <de780cc3-8c43-46f8-b8e6-3ddfe93d753d@arm.com>
Date: Tue, 4 Aug 2026 22:41:32 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 14/41] mm: swap: Introduce lru_add_drain_progressive()
Content-Language: en-GB
To: Sean Christopherson <seanjc@google.com>,
 Ackerley Tng <ackerleytng@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com,
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com,
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 shivankg@amd.com, steven.price@arm.com, tabba@google.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, aneesh.kumar@kernel.org,
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>,
 Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
 "hughd@google.com" <hughd@google.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev
References: <4460e252-b6de-4df3-bea8-0368a9d0f4ff@kernel.org>
 <CAEvNRgEUQSju2tW_1zMk2=QmveZNtmkjjCZdqVBgBD2JPh0k4Q@mail.gmail.com>
 <a823e3d2-8acf-49d9-a812-ac1bb2136d7f@kernel.org>
 <edc3566b-370c-41a0-a71d-2e4a0e1a94f7@kernel.org>
 <CAEvNRgEas_9BEV-cNxXu4_wQx8sR2M4_OaW6DEd4=fszALMV0w@mail.gmail.com>
 <60552bee-3326-4917-b00f-5fb7ba3b8adb@kernel.org>
 <be77c2cb-6e41-4382-9d2f-cd299f634196@kernel.org>
 <anCtzQrUkFSSq8De@google.com>
 <99037993-ee13-4160-8c87-b6642faea554@kernel.org>
 <CAEvNRgHYhKACDfx9ZZy4a-TTS4yWzEJt=Jc92=eXxS15LPnTYg@mail.gmail.com>
 <anJbMf5GBe0Pxh_x@google.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <anJbMf5GBe0Pxh_x@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/08/2026 22:35, Sean Christopherson wrote:
> On Tue, Aug 04, 2026, Ackerley Tng wrote:
>> "David Hildenbrand (Arm)" <david@kernel.org> writes:
>>> Andrew wants to give it some more time in -next, so I'm expecting it to
>>> land for 7.3.
>>>
>>>> 7.2 or 7.3, then I would strongly prefer to base v10 on linux-next (where
>>>> the fix will presumably land soonish), and target 7.4 for in-place
>>>> conversion. Then v10 can be applied against an early 7.3-rcN and we don't
>>>> need to juggle branches (assuming Andrew is ok taking the proposed patch
>>>> through the KVM tree).
>>>
>>> Agreed. We'd also have to get the actual preparation patch into 7.3. I can
>>> send it out and coordinate with Andrew.
>>>
>>
>> Thank you!
>>
>> When we were discussing this earlier at guest_memfd biweekly, before
>> deciding to refactor out a function like lru_cache_drain_for_folio(), we
>> did say that the likelihood of actually draining in practice is low,
>> especially on a machine with heavy load making allocations all the time.
>>
>> I think the threads with Xiaoyao have resolved, I can put v10 out
>> tomorrow. Would it be okay to go with the following from v8, and then
>> clean up later when lru_cache_drain_for_folio() is available?
> 
> No.
> 
>> I'm hoping not to push this back by a full cycle to 7.4,
>   
> Sorry, but we've missed 7.3, irrespective of the lru_cache_drain_for_folio() fix.
> Even if v10 is perfect, applying tomorrow means it will get ~3 business days in
> linux-next before I send pull requests to Paolo.  That's just not enough soak
> time for land a 40+ patch series, even if half of those patches are selftests.
> 
>> and also hold back other series dependent on this one.
> 
> Eh, I don't think there will be meaningful impact in practice.  If v10 is good
> to go, I'll get it applied on 7.3-r1, and will also get an early pull request
> over to Paolo (probably around 7.3-rc4).  I.e. folks can start posting against
> the landed series shortly after rc1, and I'll have a set-in-stone base on which
> to apply more stuff around rc4/rc5.

For the record, Arm CCA KVM support depends on this series and that
being a big series (around 40+ patches), it is an inconvenience for the
Maintainers to make an effort to review the series.  That said,  we are
happy with the way this is progressing and next cycle merge for this
series would be perfect for us.


> 
> And if v10 has issues, then *not* rushing it into 7.3 will likely be the fastest
> path forward.

Absolutely !Like any work, if it is not ready to merge, it is not.

Cheers
Suzuki

