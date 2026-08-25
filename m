Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FD0344DAA;
	Tue, 25 Aug 2026 16:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787674447; cv=none; b=NDOHSq7W0PZA756QkiHSyek8SB7AckT1IxMgvV9JVyNTef+9mhhrlZR5KVw0hKBJy15vgNzU9Bu5laxGRpLpsEzsHbSOwz439Z4CSjN+i5q63tDGWI5wEFMjmRbCS8EZ/pdCFaRNqaEQFqUE2TcfCvXu97C97zDHJoD4TRcqJ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787674447; c=relaxed/simple;
	bh=TMHDnAbv6B5815V9xDG8AMy+EDrsmT6X7HPtL1sNbf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WuF3c9f41jSODrtNftk+NS02c8zJJZ8hIZ4ebOMeEdH0lu38IHdXMR9pca8vuERU31BOhaSpPy6AwMrlVwjMkef4hxXdycaWBe+1grcvhhGVYZXRWkYfk+gyGUZZMatQHPi/vvBaZuI4ZQcIbCuBGlDUCDd/ItaWIgGDE7ahxiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MXEqTnb2; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MXEqTnb2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787674446; x=1819210446;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TMHDnAbv6B5815V9xDG8AMy+EDrsmT6X7HPtL1sNbf0=;
  b=MXEqTnb25UP0Vsg45Y8pbLsp5svKOlxSQQu0HY2yabieYGxLqbohJgD9
   LN8zlNGBh8yJ6Ar5/ELkgxPWovsi9MXFyLPS9/c5sjibo46gM3Z8RDGfD
   12elSThHtjdrwlRnvy7Aj7e3p787mWv2SpJep8jtZvC2nWY0pgFxpOyJV
   tGInAh7wFOD/L875D/WttvZsFpeZzCiIylMojYBrXU+SFl/cT4iGpYiDP
   LVV9PvE14bsIptTrzq2E7TEJCptlxuwG8wlKKsa/vl9irwqnLY7eJzi5t
   7c34cuqaSeAvlhjhuCSGrdHwEseQs2s1RWXhfBjuLyssK4AUjDcnGz+p4
   Q==;
X-CSE-ConnectionGUID: f7+4kvrjRP6i3TsV3vnnog==
X-CSE-MsgGUID: RGwmHVhkSK6ZCWdah35jPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="99671148"
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="99671148"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 09:14:03 -0700
X-CSE-ConnectionGUID: 1Z8oyHIvRaCdZRwP1LfjXw==
X-CSE-MsgGUID: /mJMl5yPRFOgp7AaoGyB2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,243,1779174000"; 
   d="scan'208";a="265538212"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 09:13:50 -0700
Message-ID: <7eba513d-cdae-4832-abac-038dcdd88517@intel.com>
Date: Wed, 26 Aug 2026 00:13:47 +0800
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
 Ackerley Tng <ackerleytng@google.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, aik@amd.com,
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
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <aoZZMQ3Uc8yQWPNA@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/20/2026 9:32 AM, Sean Christopherson wrote:
> And vice versa, a PUNCH_HOLE on a SHARED gmem (if userspace is
> using an INIT_SHARED gmem for the shared branch of a memslot) could invalidate the
> PRIVATE mappings (of a different gmem instance).

I'm wondering now how this could happen.

the requirement for PUNCH_HOLE on gmem to trigger mapping invalidation 
is the gmem is bound with the memslot. But how can a memslot bound with 
two gmem instances?
