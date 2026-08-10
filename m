Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66663370AD9;
	Mon, 10 Aug 2026 09:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786354084; cv=none; b=hnlLOluHDfRUHQziYQR8sge9Li1J52vN3X5a1PEtCa4waPuHi+V6A+7WMINYoBcndlkomaLNOXdnmGyrQcS5/ssYqgyBugYTLWFllbbbRnIntLpWEPvco6r0Dvr1vtwXoMAoNp7pAyKYumggo625w14whj2SNztigHaE4Zg/jMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786354084; c=relaxed/simple;
	bh=qoA3XI8F3Cxg2eTG6eSEWkySa1FEqeP1PJP9e6aPetY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acXe88UxlOE6E4ISKI/59AWsijYTwJH2/envt4hK8BOFV6aWUgoWFl7taIlVQ5DQIGe9tQu96Yo4CacLo24TuwZsrICBQ8TnKV7GCcJL+oDYYuzjo3ycOOSIop7GPltQ4yoYfHcOWLsNYon5uAqCI4JfyFkDNyUqozx4t8dWdjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fQ7asZA9; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fQ7asZA9"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56C0E1516;
	Mon, 10 Aug 2026 02:27:56 -0700 (PDT)
Received: from [10.57.41.8] (unknown [10.57.41.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61A663F632;
	Mon, 10 Aug 2026 02:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786354080; bh=qoA3XI8F3Cxg2eTG6eSEWkySa1FEqeP1PJP9e6aPetY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=fQ7asZA9TSR7rlnnqyFO3tF9naXEDqkDPBAG48dXb9rvJJsp5voGcLR8/+ng8tsD1
	 ySkAhmHrgrqAdTfgQyMCw/7Qy0Uoc6JGZMxmsHW0nqrXYvU1rJ42hbzZdNXGdkjVMj
	 e+ACXCwdWeOFkiApz5x4o8ppB8Nedq0yuR5JI29M=
Message-ID: <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com>
Date: Mon, 10 Aug 2026 10:27:49 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/41] KVM: guest_memfd: Filter both shared and
 private when invalidating
Content-Language: en-GB
To: "David Hildenbrand (Arm)" <david@kernel.org>, ackerleytng@google.com,
 aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com,
 brauner@kernel.org, chao.p.peng@linux.intel.com, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 tabba@google.com, willy@infradead.org, wyihan@google.com,
 yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org,
 aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson
 <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
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
 Peter Xu <peterx@redhat.com>, tarunsahu@google.com,
 Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-9-2fc18ee6d3ba@google.com>
 <13ca60c6-e154-4397-8092-09f861e90fe0@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <13ca60c6-e154-4397-8092-09f861e90fe0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/08/2026 10:06, David Hildenbrand (Arm) wrote:
> On 8/7/26 23:52, Ackerley Tng via B4 Relay wrote:
>> From: Ackerley Tng <ackerleytng@google.com>
>>
>> Before conversion, a guest_memfd could be either all shared, or all
> 
> You mean "in-place conversion support" ?

Not necessarily. This is supposed to be :

"At creation, ...

> 
>> private, configured at creation time using the INIT_SHARED flag. Hence,
>> when zapping pages from stage 2 page tables, guest_memfd can filter which
>> to zap based on the initial shared/private state.
>>
>> With conversion, guest_memfd tracks shared/private state on a per-page
> 
> Same here.
> 
>> level, so a range can contain both private and shared pages. Zap both
>> private and shared pages for simplicity.
>>
>> An alternative would be to iterate guest_memfd attributes and only zap both
>> if shared and private pages exist within the range. Setting both the shared
>> and private filters lets the zapping logic do that iteration instead.
> 
> I mean, we just want to zap anything that belongs to guest_memfd, independent of
> shared vs. private, really?
> 
> IOW, it's not about shared vs. private, but really about zapping anything that
> belongs to guest_memfd.

Correct. But we want to control what we "zap" (invalidate range) when we
do the "conversion". e.g., if some ranges are already private, we don't
want to zap those pages, as they might have some data "populated" by the
VMM. For more context:

https://lore.kernel.org/all/114e2488-97ed-4740-a8e8-1edd991f26c5@arm.com

Suzuki


> 
> So, couldn't there just be a KVM_FILTER_GMEM thingy instead?
> 
> But I didn't quite digest how these filters are used.
> 
> I can see that kvm_gfn_range_filter_to_root_types() does some magic to them, but
> I am not a KVM MMU expert to know what KVM_MIRROR_ROOTS would mean.
> 

