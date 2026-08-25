Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3363F58D6;
	Tue, 25 Aug 2026 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787652404; cv=none; b=AdGGRIaNHhOLPtMMlf5MmV2bapKzUSzMUY+UBH26tGURKiJ231vjW2TM1H7Gs1QcZimhkCJVUrydmllN99qb8oKBFi8zc7mGQVZ14Wufx64kBaGpiJZiEhC6rmSPAXw9mMNro0LKnk5P+J2zh8AiqLtVZwxzmLu1wq16DvK+8uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787652404; c=relaxed/simple;
	bh=M9Fm4+dnvq+XgKw9yfXTQV+zqDAuw6hKxuh72y1d/p4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rtz7XvCJhPBZgdEt/4V5Ex26dgl+6bxdD2bMMi5XTskvPQyImMMO2RQdnYSr/MPufB/vPXMuWProAHDsa2DkH3tqFt3xCtUDL9CHBVBzQmDjE9+yo4hiiTSpult50rnr8miEC/kDR2gYuXPlTsxaBjkEPGGg1zuJOiDRW4kUx70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C7jilkaT; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7jilkaT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787652403; x=1819188403;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M9Fm4+dnvq+XgKw9yfXTQV+zqDAuw6hKxuh72y1d/p4=;
  b=C7jilkaT7PA6u27NLvGxTUv9JHE0Gy7tlU4N9LBef0NgcSaY5NGjWIa+
   pYp3iSH9jbXw4M0h6FcOoNkgXHTk2tKurWV4QifXJBwUiG/EHmrGb0Q54
   GIJrFKlzgE2fCgiT798ia+78emrjpFPM5weVX1Kwy7o02Yqd0BwIHKAwy
   ny5oEijdjg87kjv4JAJlAXkLqrYA0VUoPYn46w4uNk32ht2CU5b3/gzjN
   WdotuPcJAEter5uPjP2jUCmIGfsa3vAbgHwzNq/xOl6qS4EcWWdDYTwud
   jBwygOUCgwZZI5wlvo5rTvWaQM7fvwgEe4CCkEfA7mHrxXpuKjGCyngIl
   w==;
X-CSE-ConnectionGUID: D6BW3+vIQ9iU58LkYucGCw==
X-CSE-MsgGUID: kx6bG2/dSSy5SN/+eE0MeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="91797065"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="91797065"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 03:06:42 -0700
X-CSE-ConnectionGUID: T+xKrRR4SkK84ruPBSE65Q==
X-CSE-MsgGUID: shDtClh4RZWx8bZXjoSkTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="266698413"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.240.119]) ([10.124.240.119])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 03:06:28 -0700
Message-ID: <9feadfea-c41c-4105-963a-a3d98421e1c3@intel.com>
Date: Tue, 25 Aug 2026 18:06:25 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 40/41] KVM: selftests: Update
 private_mem_conversions_test to mmap() guest_memfd
To: Ackerley Tng <ackerleytng@google.com>,
 Sean Christopherson <seanjc@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com,
 brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org,
 jmattson@google.com, jthoughton@google.com, michael.roth@amd.com,
 oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com,
 rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com,
 steven.price@arm.com, tabba@google.com, willy@infradead.org,
 wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com,
 pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org,
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
 <20260807-gmem-inplace-conversion-v10-40-2fc18ee6d3ba@google.com>
 <fe1c6359-7371-4ccd-9807-1d81c160d12b@intel.com>
 <aohEz_1JFVDtlSnE@google.com>
 <CAEvNRgF8XE2Xsn-g3qzPxcdfLdvJEc1FZw9LQ+deeXsFpdZsOg@mail.gmail.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <CAEvNRgF8XE2Xsn-g3qzPxcdfLdvJEc1FZw9LQ+deeXsFpdZsOg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/25/2026 5:32 PM, Ackerley Tng wrote:
> Sean Christopherson <seanjc@google.com> writes:
> 
>> On Fri, Aug 21, 2026, Xiaoyao Li wrote:
>>> On 8/8/2026 5:53 AM, Ackerley Tng via B4 Relay wrote:
>>>> From: Ackerley Tng<ackerleytng@google.com>
>>>>
>>>> Update the private memory conversions selftest to also test conversions
>>>> that are done "in-place" via per-guest_memfd memory attributes. In-place
>>>> conversions require the host to be able to mmap() the guest_memfd so that
>>>> the host and guest can share the same backing physical memory.
>>>>
>>>> This includes several updates, that are conditioned on the system
>>>> supporting per-guest_memfd attributes (kvm_has_gmem_attributes):
>>>>
>>>> 1. Set up guest_memfd requesting MMAP and INIT_SHARED.
>>>
>>> If I understand correctly, even with in-place gmem, the model that shared
>>> memory comes from the userspace_addr and private memory comes from gmem can
>>> still work without passing GUEST_MEMFD_FLAG_MMAP flag.
>>>
>>> Since this model is not prohibited by KVM. I think we should keep the
>>> testcase for this model to ensure test coverage?
>>
>> +1.  Deprecated doesn't mean unsupported.
> 
> The original test case was for non-in-place conversion, which wasn't
> removed, it still passes.

It only passes when

   /sys/module/kvm/parameters/gmem_in_place_conversion=n

It fails as below when gmem_in_place_conversion=y

./tools/testing/selftests/kvm/x86/private_mem_conversions_test
Random seed: 0x7eace343

==== Test Assertion Failure ====
   x86/private_mem_conversions_test.c:46: mem[i] == pattern
   pid=288745 tid=288747 errno=4 - Interrupted system call
      1	0x000000000040426a: memcmp_h at private_mem_conversions_test.c:46
      2	 (inlined by) __test_mem_conversions at 
private_mem_conversions_test.c:356
      3	0x00007f2ea2c89c01: ?? ??:0
      4	0x00007f2ea2d0ec3f: ?? ??:0
   Host expected 0xaa at gpa 0x100000000, got 0x0

> Is the ask to also test, under kvm_has_gmem_attributes aka
> gmem_in_place_conversion, to have guest_memfd used as purely for private
> memory and have shared memory taken from somewhere else completely?
> 
> I can rephrase the changelog and change the code to clarify that this
> patch is meant to specifically test in-place conversion with MMAP, the
> intended usage of in-place conversions.
> 
> The ask to test gmem for private and something else for shared seems
> like a different test that can be added separately, perhaps in a
> follow-up series?

I see it as the fix for existing testcase, not another new test. And the 
fix is simple:
1. change to use vm_mem_set_memory_attributes() to set memory attribute.
2. pass GUEST_MEMFD_FLAG_INIT_SHARED to create the gmem because this 
test expects the initial state of the gfn is shared.

---8<----
diff --git 
a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c 
b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
index cf50e9a332c5..fbd6c63d21cf 100644
--- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
+++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
@@ -307,7 +307,7 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
                 vm_guest_mem_fallocate(vm, gpa, size, map_shared);

         if (set_attributes)
-               vm_set_memory_attributes(vm, gpa, size,
+               vm_mem_set_memory_attributes(vm, gpa, size,
                                          map_shared ? 0 : 
KVM_MEMORY_ATTRIBUTE_PRIVATE);
         run->hypercall.ret = 0;
  }
@@ -382,6 +382,7 @@ static void test_mem_conversions(enum 
vm_mem_backing_src_type src_type, u32 nr_v
         const size_t slot_size = memfd_size / nr_memslots;
         struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
         pthread_t threads[KVM_MAX_VCPUS];
+       u64 gmem_flags = 0;
         struct kvm_vm *vm;
         int memfd, i;

@@ -397,7 +398,10 @@ static void test_mem_conversions(enum 
vm_mem_backing_src_type src_type, u32 nr_v

         vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << 
KVM_HC_MAP_GPA_RANGE));

-       memfd = vm_create_guest_memfd(vm, memfd_size, 0);
+       if (kvm_has_gmem_attributes)
+               gmem_flags = GUEST_MEMFD_FLAG_INIT_SHARED;
+
+       memfd = vm_create_guest_memfd(vm, memfd_size, gmem_flags);

         for (i = 0; i < nr_memslots; i++)
                 vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
