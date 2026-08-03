Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAF333C183;
	Mon,  3 Aug 2026 15:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785772434; cv=none; b=GDfSq/Mi6PeqO58ioZ5rWaIDL/Ex8zoa1eMMiyGLzdhr0mMgohD7Jgb5Y6cClhK23BFOc7o5dF1816tRA2uz1zj9TxDPQztRA97bB63yZnnwe8u2c4jcSlRXC0n4Fmw+4P5PwMa1088Af/3M8+4iAlD7++1qki3b67o5oGNO93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785772434; c=relaxed/simple;
	bh=bipZvbkqUPc5n72uKORzyVnSydHD9nn566F6fsSOJZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRI+KpDcU0rLiF9CekrzoS04B+tO8SS/4jflRAtXSRyxMDTKUDNX2n2Bjq1KeLDOCnx4qpqddnlQfNGXpMwZEEtTEiqRPQacEwjtDzz940SFYIZzk/j9LrHm9r3C4k73K9i6InzeB9pboTpXQZNFRF23q2u1PLVrVdocwlBOhIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FV1tr54R; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FV1tr54R"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08DE61476;
	Mon,  3 Aug 2026 08:53:48 -0700 (PDT)
Received: from [10.2.197.99] (ewhatever.cambridge.arm.com [10.2.197.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A7CA3F66F;
	Mon,  3 Aug 2026 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785772432; bh=bipZvbkqUPc5n72uKORzyVnSydHD9nn566F6fsSOJZk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FV1tr54R+0e6tXlM27sqOKgR2cBmb4FKaia/3O3OP4s3hKmWPkEG7IS8+OLthX9KX
	 GrYX0Lf2cSfDp5MfswPlbM3sUOONHqIqdrKUH+g+vk3O9IYEduMfGaEbAWs9TEbxZI
	 EQn85U0teStXlYCFKD+VYERDRlEcXckmGvAmfDr0=
Message-ID: <e14e022d-3fec-4edb-9458-47b31b26e0f5@arm.com>
Date: Mon, 3 Aug 2026 16:53:41 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 10/41] KVM: guest_memfd: Add base support for
 KVM_SET_MEMORY_ATTRIBUTES2
To: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev,
 binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com,
 david@kernel.org, jmattson@google.com, jthoughton@google.com,
 michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com,
 qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com,
 shivankg@amd.com, steven.price@arm.com, tabba@google.com,
 willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com,
 forkloop@google.com, pratyush@kernel.org, aneesh.kumar@kernel.org,
 liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>,
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
 Peter Xu <peterx@redhat.com>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
 linux-coco@lists.linux.dev
References: <20260728-gmem-inplace-conversion-v9-0-35f9aec2aed2@google.com>
 <20260728-gmem-inplace-conversion-v9-10-35f9aec2aed2@google.com>
Content-Language: en-US
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20260728-gmem-inplace-conversion-v9-10-35f9aec2aed2@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2026 01:35, Ackerley Tng via B4 Relay wrote:
> From: Ackerley Tng <ackerleytng@google.com>
> 
> Add a new ioctl (and matching struct), KVM_SET_MEMORY_ATTRIBUTES2, using
> the same base ioctl number (0xd2), but with R/W semantics for the kernel
> instead of just read semantics.  "Officially" documenting that KVM writes
> to the payload will allow KVM to support partial/incremental conversions,
> instead of all-or-nothing updates (which requires complex unwinding), by
> recording the failing offset if an error occurs.
> 
> Opportunistically add a new struct as well, even though KVM could squeeze
> the error offset into "struct kvm_memory_attributes", as there's no cost to
> doing so in practice.  Pad the struct with a pile of extra space to try and
> avoid ending up with "struct kvm_memory_attributes3" in the future.  Use
> the same layout for the fields that common to version 1 of the struct,
> e.g. to ease upgrading userspace, and to provide flexibility if KVM ever
> adds support for KVM_SET_MEMORY_ATTRIBUTES2 at VM scope.
> 
> Introduce KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES to advertise the
> availability of the KVM_SET_MEMORY_ATTRIBUTES2 ioctl.
> 
> Update the KVM API documentation to define the new ioctl and its behavior,
> and add the necessary UAPI definitions and capability checks.
> 
> The process of setting memory attributes has a clear point of no return
> because, for CoCo VMs, zapping stage 2 page tables is a destructive
> operation. Unlike regular VMs, where re-faulting pages into the stage 2
> page tables merely incurs a performance penalty, CoCo guests must
> (re-):accept pages after every fault. To preserve CoCo security guarantees,
> guests will not accept pages they did not explicitly request faults
> for. Consequently, during memory conversions, any operation that could
> cause the process to abort must be completed before the stage 2 page tables
> are zapped.
> 
> Zap only the ranges that are not already in the requested state to avoid
> inadvertently destroying (CoCo) data. ARM CCA guests will try to mark the
> entire DRAM as private at boot. If there are no shared pages at all, the
> to-private conversion can be skipped, but the existence of a single shared
> page would require the conversion process to proceed, and if it proceeds,
> zapping both shared and private pages would destroy data and break the
> guest.
> 
> Co-developed-by: Vishal Annapurve <vannapurve@google.com>
> Signed-off-by: Vishal Annapurve <vannapurve@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Reviewed-by: Fuad Tabba <tabba@google.com>
> Reviewed-by: Binbin Wu <binbin.wu@linux.intel.com>
> Suggested-by: Michael Roth <michael.roth@amd.com>
> Tested-by: Shivank Garg <shivankg@amd.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>


Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

