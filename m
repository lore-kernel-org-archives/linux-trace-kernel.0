Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CD264A65;
	Wed,  8 Apr 2026 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775646135; cv=none; b=bNm8BSMGBiOWUnvS57UGmfVCWNDFDMy3u+WPTYlL9WmXOhzgWZ544ko1gfBvd0T036ZSgd6uwjy6GyO4tIlh9tpEYlo8B7E1J7HSRZgRUnJcxMzUR2ndoVee/ngVijB7bf6yQFGb7BRV2E9EWqnQZ6IHbKvoa/Kkgb5dvjDRhJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775646135; c=relaxed/simple;
	bh=BcjAsJfFFdxOuFJG+yx8h9dEcchCwv67qshCeNpQzVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HcVYniisuoRS9K/E72987FwyQpBA+2pzwMrgQu8ZPejBd+dr/hmbbz0atnle7whcuoAuYaf7nYGA3L8hz+w0lyEtt8SsVTR3cqIaNrJBdvjk1cW/Y6VcGKgITm5iF/AQ3dm7kusxK26Zq1qGePNI/4t2qA7cRzb/1b4KoG0xPH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=j0m/Wl5D; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="j0m/Wl5D"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0959832E3;
	Wed,  8 Apr 2026 04:02:07 -0700 (PDT)
Received: from [10.57.32.88] (unknown [10.57.32.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6DE403F632;
	Wed,  8 Apr 2026 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775646132; bh=BcjAsJfFFdxOuFJG+yx8h9dEcchCwv67qshCeNpQzVY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j0m/Wl5DLNS3bb0LPJygmxr64zm8k47jOHhnUdaH8o4hEg7UUONrE66mssRlJ7NT2
	 6bzBCKlVrr+w2+XGl2eztRQqDLePKhvx7aHRms/5lUbXVIvqBABzatYJU+Jw6NrJnn
	 B0h8Vu2G1rPcddUOVHZq+00sZ9LGtr5cxfhIEmOY=
Message-ID: <9c8ddc37-a236-446b-a85a-261f370d644e@arm.com>
Date: Wed, 8 Apr 2026 12:01:59 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 10/44] KVM: guest_memfd: Add support for
 KVM_SET_MEMORY_ATTRIBUTES2
To: Vishal Annapurve <vannapurve@google.com>,
 Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, ira.weiny@intel.com,
 jmattson@google.com, jthoughton@google.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, tabba@google.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com,
 aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>,
 Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>,
 Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org
References: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
 <20260326-gmem-inplace-conversion-v4-10-e202fe950ffd@google.com>
 <2r4mmfiuisw26qymahnbh2oxqkkrywqev477kc4rlkcyx7tels@c7ple7kdgpo3>
 <CAEvNRgFkusZeKxGctUpTTbYjdi7nZL1ZZar-gT7XRUOCZ2xtpw@mail.gmail.com>
 <CAEvNRgGm9icDK8sK5ZfqHEOEqSbvjwtihE4p9d3vpBq-NfVjmw@mail.gmail.com>
 <CAEvNRgEtigp7+PVDkyu_DH947CUqDt312d+P+hWjjd2fHONiag@mail.gmail.com>
 <yvfwexsub7nrogh67hzcsupbrkzer6a7kbeao5tlq4elrzc2iz@xrwdjd7p32pp>
 <CAGtprH-kgRByFvvCYeWMXtsvpb6qpaWAo8k-3PEnioyPg-LEvA@mail.gmail.com>
Content-Language: en-GB
From: Steven Price <steven.price@arm.com>
In-Reply-To: <CAGtprH-kgRByFvvCYeWMXtsvpb6qpaWAo8k-3PEnioyPg-LEvA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/04/2026 22:50, Vishal Annapurve wrote:
> On Tue, Apr 7, 2026 at 2:09 PM Michael Roth <michael.roth@amd.com> wrote:
>>
>>> TLDR:
>>>
>>> + Think of populate ioctls not as KVM touching memory, but platform
>>>   handling population.
>>> + KVM code (kvm_gmem_populate) still doesn't touch memory contents
>>> + post_populate is platform-specific code that handles loading into
>>>   private destination memory just to support legacy non-in-place
>>>   conversion.
>>> + Don't complicate populate ioctls by doing conversion just to support
>>>   legacy use-cases where platform-specific code has to do copying on
>>>   the host.
>>
>> That's a good point: these are only considerations in the context of
>> actually copying from src->dst, but with in-place conversion the
>> primary/more-performant approach will be for userspace to initial
>> directly. I.e. if we enforced that, then gmem could right ascertain that
>> it isn't even writing to private pages via these hooks and any
>> manipulation of that memory is purely on the part of the trusted entity
>> handling initial encryption/etc.
>>
>> I understand that we decided to keep the option of allowing separate
>> src/dst even with in-place conversion, but it doesn't seem worthwhile if
>> that necessarily means we need to glue population+conversion together in
>> 1 clumsy interface that needs to handle partial return/error responses to
>> userspace (or potentially get stuck forever in the conversion path).
> 
> I think ARM needs userspace to specify separate source and destination
> memory ranges for initial population as ARM doesn't support in-place
> memory encryption. [1]

Indeed - CCA requires KVM to first "delegate" the page (effectively the
shared->private conversion) which will destroy the contents. Then we can
populate the data (but that obviously has to come from elsewhere).

The closest CCA can do to an in-place conversion is for the kernel to
copy the data to another temporary buffer and then the firmware can copy
it back after the delegation. An early version of the CCA Linux patches
did this (long before guest_memfd). However this is slower than it needs
to be (two copies) and difficult to size the temporary buffer. Too small
and you round-trip to the firmware more than you need to, too large and
you waste memory. And, with increasing support for huge pages in
guest_memfd and the CCA firmware (aka RMM), it's also challenging to
preserve huge pages while doing this dance so I want to avoid it if
possible.

> [1] https://lore.kernel.org/kvm/20260318155413.793430-25-steven.price@arm.com/
> 
>>
>> So I agree with Ackerley's proposal (which I guess is the same as what's
>> in this series).
>>
>> However, 1 other alternative would be to do what was suggested on the
>> call, but require userspace to subsequently handle the shared->private
>> conversion. I think that would be workable too.
> 
> IIUC, Converting memory ranges to private after it essentially is
> treated as private by the KVM CC backend will expose the
> implementation to the same risk of userspace being able to access
> private memory and compromise host safety which guest_memfd was
> invented to address.

At least in the Arm CCA case the "exposure" of the private memory is
only in terms of allowing population - and only before the guest has
run. The host isn't able to access the memory in any direct way after
the memory has been delegated. But the RMM provides this populate method
to copy data into memory (in a measured/controlled manner).

From a CCA perspective the logical flow is to mark the memory as private
and then call the platform-specific function to populate the memory. But
obviously we can fit in a KVM API which is different.

Note that CCA has a specific VM property called 'RIPAS' (Realm IPA
State). This is the guest's view of whether memory exists at a
particular physical address. My current series takes the view that all
guest_memfd memory is private RAM and the guest will have to
specifically request that it is converted to shared. I'm hoping this
series might provide a way for the VMM to configure this (before the
guest starts executing).

Thanks,
Steve

>>
>> One other benefit to Ackerley's/current approach however is that it allows
>> us to potentially keep hugepages intact in the populate path, since
>> prep'ing/encrypting everything while it's in a shared state means gmem will
>> split the hugepage and all the firmware/RMP/etc. data structures will only
>> be able to handle individual 4K pages. I still suspect doing things like
>> encoding the initial 2MB OVMF image as a single hugepage might yield
>> enough benefit to explore this (at some point). So there's some niceness
>> in knowing that Ackerley's approach would allow for that eventually and
>> not require a complete rethink on these same topics.
>>
>> Thanks,
>>
>> Mike
>>
>>>
>>>>>>
>>>>>> [...snip...]
>>>>>>

