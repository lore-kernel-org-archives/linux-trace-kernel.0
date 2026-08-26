Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C227A916;
	Wed, 26 Aug 2026 02:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787711356; cv=none; b=glX44Gpu5h16r+LT68wvLaOCjtYhi0aSYwAReHM2f93z7IJSzUSI4iMAhsGox+xZR/VTovpZohWhsp+wOEMFZhn2f7mgSvSh+KxAnTK4P9vnnlsKdFge3vJV95Sx/jt6xq4w1fUW5NR126Wh1spEZeAOWzKZXf1vcBzXjZbitY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787711356; c=relaxed/simple;
	bh=jytyOnxKug/0HATBzAcgvdrubIDuZNK62vbz3KdkDXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YPtk9L3eq72BuMi2dAL99mF7TAgi+vytkUM+rI09h3W877NfpVt0Vp8ymZhJGj/t9Ks4sf+wzk/EPeSBZ5tYhd1tQtX3/U5xQpHdlA7FjJfgCGJfuyOkgm/hNr2SL9mEsQTvUQiihkYAzcNoL06vnV+pzuO5xGWmvFzXPa2k6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nApoZJxN; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nApoZJxN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787711354; x=1819247354;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jytyOnxKug/0HATBzAcgvdrubIDuZNK62vbz3KdkDXw=;
  b=nApoZJxNXYyTDTiH5CICg3HDPLf+O04N5d2GZgaXZDcs9Q8mBGVcEO3+
   GXawumBfDduaIqaisOjQk3nXii52wZJRsIJJGYqhUJa+XL6Xtm6IY8jpH
   tk8pm2SA3XlZ2PTqlKPL7jsCIDZcNXM6Mgnc16R94U3ctisWrKXvIp715
   F2HicfSQyQGRbtbKWydTuiamI44pkDENLVhUNxWcZjSnIzwaVJiIzxz4z
   C+5+MjiLqIAmWB8rTw0+eeXPFJtAs8lS3UCJdHqLbi272e0BxPc8u+6k9
   r7P4rL37B89MNjseqtbqpxyESNpA/P15UJx574agBpHZQpBYE6lM+mvVq
   g==;
X-CSE-ConnectionGUID: eVOArsj0SFKZffg3JEXCEQ==
X-CSE-MsgGUID: LT1/xKYMTY6CxzVkvgD1jw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="98522510"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="98522510"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 19:29:13 -0700
X-CSE-ConnectionGUID: Kq9+eMnnQVKhBINXbsGToA==
X-CSE-MsgGUID: f17Ncq3BQG6gkWw4k95B4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="266865838"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 19:28:59 -0700
Message-ID: <ba8d0441-b52f-4357-b2e7-1e352aa385a2@intel.com>
Date: Wed, 26 Aug 2026 10:28:56 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/41] KVM: guest_memfd: Filter both shared and
 private when invalidating
To: Sean Christopherson <seanjc@google.com>,
 Michael Roth <michael.roth@amd.com>
Cc: Ackerley Tng <ackerleytng@google.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, jmattson@google.com, jthoughton@google.com,
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com,
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com,
 steven.price@arm.com, tabba@google.com, willy@infradead.org,
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com,
 pratyush@kernel.org, aneesh.kumar@kernel.org, liam@infradead.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
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
 Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mm@kvack.org, linux-coco@lists.linux.dev
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-9-2fc18ee6d3ba@google.com>
 <13ca60c6-e154-4397-8092-09f861e90fe0@kernel.org>
 <cbf5f7ca-a960-4fb8-a760-2d2794eb6864@arm.com>
 <CAEvNRgGOyQHnF_b8dk8E0d7_=CcwXtYUdU3ko7Qbep+_O7UC0Q@mail.gmail.com>
 <aoZZMQ3Uc8yQWPNA@google.com>
 <7eba513d-cdae-4832-abac-038dcdd88517@intel.com>
 <meww2a2uf3yeevsfpicyrlg3hch2x4bsdqv2lsv3vfjxg4qzes@co5eogmhkxrk>
 <ao3lOu8-wpGTs2wd@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <ao3lOu8-wpGTs2wd@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/26/2026 2:55 AM, Sean Christopherson wrote:
> On Tue, Aug 25, 2026, Michael Roth wrote:
>> On Wed, Aug 26, 2026 at 12:13:47AM +0800, Xiaoyao Li wrote:
>>> On 8/20/2026 9:32 AM, Sean Christopherson wrote:
>>>> And vice versa, a PUNCH_HOLE on a SHARED gmem (if userspace is
>>>> using an INIT_SHARED gmem for the shared branch of a memslot) could invalidate the
>>>> PRIVATE mappings (of a different gmem instance).
>>>
>>> I'm wondering now how this could happen.
>>>
>>> the requirement for PUNCH_HOLE on gmem to trigger mapping invalidation is
>>> the gmem is bound with the memslot. But how can a memslot bound with two
>>> gmem instances?
>>
>> I think this is for when userspace uses an mmap'able guest_memfd instance
>> to handle shared memory, and a 'normal' guest_memfd instance for private
>> memory. Each instance is bound to the same memslot/GPA range, and
>> KVM_SET_MEMORY_ATTRIBUTES handles switching between the 2.

What I didn't figure out is exactly how the two gmem instances are bound 
to the same memslot.

The case I can imagine is

1. create gmem1 with GUEST_MEMFD_FLAG_MMAP and 
GUEST_MEMFD_FLAG_INIT_SHARED, and get fd1. mmap the returned fd1 to get 
a hva.

2. create gmem2 to get a fd2.

3. call KVM_SET_USER_MEMORY_REGION2 with KVM_MEM_GUEST_MEMFD flag. Pass 
the @hva from 1) to 'userspace_addr' field and pass the gmem fd2 to 
'guest_memfd' field.

However, with this case, only gmem2 is bound to the memslot while gmem1 
is not. Following PUNCH_HOLE on gmem1 doesn't invalidate any mappings 
because the f->bindings of it is empty.

Do I miss anything?

