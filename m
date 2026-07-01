Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91D240BCCE;
	Wed,  1 Jul 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782904070; cv=none; b=iAiCYDOwdMC5Fk8lvbbDtVzSIV843u61DFo5MU77MF+OFGnaIbGVBUFvbrmQBkQYFtoSAKpii1qkYCRBjuXpQjqgohTdjDiMlODhcAptRsnKh4uy6jmQp4iXoIf5wKEPoAcWuOFQOgtidp+5V90yfUyxLLK98vpTo0wDV9kJhRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782904070; c=relaxed/simple;
	bh=hCvnNk/pEx9Q3BuA3GT3urPlvNsb9ZGbJEO+TxrHDhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISrNKXq/pgcspmDOaD6vqghancW5wO0j1g1oXIIcH7YQ7L6uw0liZdMNqwM/8jb+ys7O1IL+d1alxdidV6SBxUwBgeJAFTfi+7XXNdcU58nWX3UFtu4OlG+Tu8Ky/okdRC3R+mvLVlNw85S1s1sUG+4KOtZwKW2R/uEFm8KVhbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNtiPidL; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNtiPidL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782904069; x=1814440069;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hCvnNk/pEx9Q3BuA3GT3urPlvNsb9ZGbJEO+TxrHDhk=;
  b=LNtiPidLDPr2cCEfm6nmkpfeRNI4QV3/W9S1PF5JTllnEv0I5stLmP7R
   qJuecNfxVWxxeXE1ZFI90KMcIRSlQa2fjEy+w3ivHinUaseH7HJYePVui
   YMP73yvTHQM8rC+OltN8X/9K5IctoVX+GfNQFQi/Aa0Ib0PIFcGVluWQZ
   fs3D5IUYSOR+IoI313VcgY4t4gi/6mrajCQ33iaotHUCevuI03XwGAUs8
   iXhqpbLpaR7r6hCZIdOhv9n2w1m/MV0nytJ+yUQykx+VtdMs5KWiGNLoR
   /bEUEmcL4nrfExvkAcvK50aiXyP87Y2TJO1Fl2xhVQYMZJTtOPxRBC6oo
   w==;
X-CSE-ConnectionGUID: hFZnprObTNePX2nhndIJYw==
X-CSE-MsgGUID: SfODCpYrQSa2FJ7OeXRYNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="87546077"
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="87546077"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:07:48 -0700
X-CSE-ConnectionGUID: qj8BVJ/XRI6zgtwRVeHuag==
X-CSE-MsgGUID: hj6+vDsNStmOM/iX4E14dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,141,1779174000"; 
   d="scan'208";a="248074941"
Received: from unknown (HELO [10.239.158.49]) ([10.239.158.49])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 04:07:34 -0700
Message-ID: <25fdb77d-20f6-4b3a-8b3a-dbba0dc47046@intel.com>
Date: Wed, 1 Jul 2026 19:07:31 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 24/46] KVM: guest_memfd: Make in-place conversion the
 default\
To: Sean Christopherson <seanjc@google.com>, Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, aik@amd.com,
 andrew.jones@linux.dev, binbin.wu@linux.intel.com, brauner@kernel.org,
 chao.p.peng@linux.intel.com, david@kernel.org, jmattson@google.com,
 jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org,
 pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com,
 rientjes@google.com, shivankg@amd.com, steven.price@arm.com,
 tabba@google.com, willy@infradead.org, wyihan@google.com,
 forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com,
 aneesh.kumar@kernel.org, liam@infradead.org,
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
 Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com>
 <20260618-gmem-inplace-conversion-v8-24-9d2959357853@google.com>
 <aji/2svhcc84rn5w@yzhao56-desk.sh.intel.com>
 <CAEvNRgHYTFnHbsLLgMTCSitmnp1_j9Pomikm9qmpGTh1w8YE5Q@mail.gmail.com>
 <ajx5Vrz9ma--hrGH@google.com> <ajyJhZcgfYFtGfS2@yzhao56-desk.sh.intel.com>
 <aj0Jf30PS2f7x1nt@yzhao56-desk.sh.intel.com> <aj087H1UWSFxbShR@google.com>
 <aj3H2sxymOYTWTnE@yzhao56-desk.sh.intel.com> <aj7NwCRwWEfLK-gQ@google.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aj7NwCRwWEfLK-gQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/2026 3:06 AM, Sean Christopherson wrote:
> On Fri, Jun 26, 2026, Yan Zhao wrote:
>> My first impression of gmem_in_place_conversion=true was that it enforces gmem
>> in-place conversion. However, it actually only enforces per-gmem private/shared
>> attribute.
>> My worry was that people might think it's a kernel bug if userspace can still
>> have shared memory from other sources after they configured
>> gmem_in_place_conversion=true.
> Ah, I see where you're coming from.  FWIW, truly enforcing in-place conversion
> is flat out impossible.  E.g. userspace can simply replace the memslot, at which
> point the memory effectively reverts to shared.

would something like below enforce the in-place conversion?

Userspace can create a memslot without gmem fd, but that memslot can 
only serve as shared memory and cannot be converted. So it doesn't 
violate the in-place conversion.

--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2122,6 +2122,8 @@ static int kvm_set_memory_region(struct kvm *kvm,
         new->flags = mem->flags;
         new->userspace_addr = mem->userspace_addr;
         if (mem->flags & KVM_MEM_GUEST_MEMFD) {
+               if (gmem_in_place_conversion)
+                       new->flags |= KVM_MEMSLOT_GMEM_ONLY;
                 r = kvm_gmem_bind(kvm, new, mem->guest_memfd, 
mem->guest_memfd_offset);
                 if (r)
                         goto out;
