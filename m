Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0834744C51D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667610; cv=pass; b=aAD8Mg6GMK9QInNgwgTbV19PLG/2Rr5x9eDx1R3ty/9bNwWVww3rK3DC610XU623UyhQ+jAH/LadlE/TfKx1TO1stbGnDzCRyMQQHyqjWrd7qlbcqaJ5H1BzCicLsNwXeNaxuEapqt9I4/nWuKHTOWEZuU7efv5vsIkaLYItvTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667610; c=relaxed/simple;
	bh=2ZRWAWAxzrX6845mpmgaNcKHNz38OJ7/zMOFY8iInqY=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxD28w2nC11z5EQ2AprCyBPj7o6cafZkHqwOoPPj3hyKKXqGonEPESfP6h8LhqWWtabx3OkfnLWvAuk/6sjk2y40Qgx27+opqC9jnxaJMQrJfz396CnW/TFtQAhuz6ilty0X5Wu9UzvmuDG/wbLwxupUK/jlVH+V+MzC0KHLuaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gfPls/ex; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gfPls/ex"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-90a80860d35so48174986d6.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 07:20:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787667606; cv=none;
        d=google.com; s=arc-20260327;
        b=iHTXa+gR6QNgp4jJqY/MUUL5lWOJ302AAzQA1lB591UfRl2PuolfgAlrweOviB6n7U
         Aa0dtIHKFxj1ZlYI2xw4sXsH9llN0CdpjUGLYUhf7Z8RukoJDXHsS2nD2yIiBe9jCHuu
         DmcywSm3wWLjCRbF/emEcEQpDMF0JTIO489fFU5aZBe1UBJI71qkqE4Y9Thb8OMZeXSg
         8Kr2jbTtGGa9PiA2Yt02TftsmrbmVyppmt9PxH59pZXMtjSeP/eu5+8Yp1dGuIQBvph3
         wbJ2ZgW/WpcYiY0KGaHDzl6+krKOlMDvlr8lxJ/mmK3WCuRYfcPO/6na+lAayoNUKQ6n
         9UXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=t88jbvctONs+qHXsNnGi7BlHTFxQ0QLhoZsqurw8Hko=;
        fh=sc36R+ThRHwwTexaUJa3FZGDhVtG16eR0V1DxN4w3VA=;
        b=TFguhe6cS8RYnh96g3M+QNUZY/qGqtIDQSUuudnVTnrj8CeqYJVlsIMRsS5MAuAwdo
         YIWJxuk9ajfMskbGM7S6rPNr4p+Xof56rYelbi17kw8Vd/Ip/C6BZaj6c1V8Cz2mtdsY
         K4S5wysnQM76MbVn2u+21n90+P64/CXMi1/NWNb0+pGojEBX22SYaKu5I52hUTDyU38V
         b2P8NSYPPSaCWLne+LCAGTjxwwUpRcioB/19TW4Kp1tAC8+qx1jOV3mGtTVO6R/bOcjj
         9m/ZGQyiQGuRvdojjNPhpncP7OfjGmhrUojC06y3HFjSQ0TS/nQl1pcPA8JIq2gjeh0w
         OPNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787667606; x=1788272406; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t88jbvctONs+qHXsNnGi7BlHTFxQ0QLhoZsqurw8Hko=;
        b=gfPls/exNze9amRfTWvY9zLHCHV9qPEgJIriy9uU4qsVFhu4UN8pw8WNv4l+FT9FDL
         zOSWKRz5EUj2JNuWZZ7VKqYrOGGSxq/OuRFdxAIwiNNxjeLP4sUixnP2q6GEM3RBCDgs
         wZRph7AmD1cPHGsj+5E40raBsv3mwmZ76X7p1ZGCzNRRQTY4Xgohjvs6rHWQ6fT6NIFE
         QXEYM6VifgQAfg719Mw2jOkPFuhQlb/JlZ+xwSUC/RZMyt9ilMN6mNgiynCUdC8Ciqoj
         iR8vXWHhO/hk0BwCJzmkZQotgOBgGQxIMEVL3eqYW1ojOHnDJoKceTlJYIO0WXKspRsy
         /gKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787667606; x=1788272406;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t88jbvctONs+qHXsNnGi7BlHTFxQ0QLhoZsqurw8Hko=;
        b=BnwttN/M7G0b5Umig0Y4+XLI8GAGe24C3xlIG+90CXYvjHY0+eYYwZdtKgTntQstvS
         7ueFXAlq4EuNmKeoLIc3JDcQ1sDdX3TNgysglhFZVqeX6Ai59zcPNCfK0p/KX9v0lpQ9
         lpYClK33KIomplO1sQHUoLKfAmjKR0U9B6IRYeiaDdXnRzamOW95nM+jPuaGK6T4qXO4
         VOwPeqWLTAJZH074mN/Yl4bDDFCJTXAA/ZYXK0y/mfPm2ZivZVjRHrBL/QMbrjBB3Bhm
         Px8OObNZWxpQ91VRd0sVR7Mmm6/6QcIQUS5/oLvhQSSxlYEjYVz/+oHQfWjDFG0eAeO/
         lnIw==
X-Forwarded-Encrypted: i=1; AHgh+RoiMfivpiUoJtMo9i3fhAMFynQqG7GZLRx0cM5PPJyziXPiM9VMsRY6d77AtUt1xXnv1Wu0bS9aeYTiesynFti6Y9A=@vger.kernel.org
X-Gm-Message-State: AFuF++k5QLbkrR6i+sA+TVRVwoEPZAGIXXZz+1f+2Eqd/xqfgUyI2IsA
	tmh/iFUNhG8arPESWeQQgfq3nsbtb1apwNFdGpjYl1VZPIHRK39RXq7iN2I1aoEp59MU0do5X3P
	KIT1KY7krlO5NVz/QqvRl3zxTiVp2vB/UJQm+NBfZ
X-Gm-Gg: AR+sD11TUYTgceUQkyWNuVF4fkcDN4ieYzxs9BnbaA75ZTjxh/DC54nNSorx83dyUjo
	+pfSXcIsXkqkpL74T1iN9rc8wvehbAP/jFbBqacbgzrabJiZ6WqaMSzOteoJ4Dklz/dxAsOnvZk
	thvW7fyALxijoFDhuMC3mha2RdLLsusARedRT1SCPNCzG4z8BksZ5mlRbk6N7wezDqfuYPcgSke
	PbPumq1ZmDqUDUecexly2kmubMzWkwyvKl+Qwh1tKCHIGo3tkuw2uyttf6kavAcfiPjAuT/EBqo
	ypUIdNsJFFuYDn4C/7IOPORdCwQtpO7NUmpRC+ssOAQZbo5zMagsEe64EyxUayJKwOo1mYnv7t+
	/pOk=
X-Received: by 2002:a05:6214:5089:b0:8f3:e0ce:611e with SMTP id
 6a1803df08f44-90cb7907bb1mr71992716d6.19.1787667604682; Tue, 25 Aug 2026
 07:20:04 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 07:20:03 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 25 Aug 2026 07:20:03 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <9feadfea-c41c-4105-963a-a3d98421e1c3@intel.com>
References: <20260807-gmem-inplace-conversion-v10-0-2fc18ee6d3ba@google.com>
 <20260807-gmem-inplace-conversion-v10-40-2fc18ee6d3ba@google.com>
 <fe1c6359-7371-4ccd-9807-1d81c160d12b@intel.com> <aohEz_1JFVDtlSnE@google.com>
 <CAEvNRgF8XE2Xsn-g3qzPxcdfLdvJEc1FZw9LQ+deeXsFpdZsOg@mail.gmail.com> <9feadfea-c41c-4105-963a-a3d98421e1c3@intel.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Aug 2026 07:20:03 -0700
X-Gm-Features: AcwNN1UOU0Yq3Ra3mNR1CZsf74y81KeNAw_IC0Ss9JrlNXktfVmaAyZWIEWXWx4
Message-ID: <CAEvNRgGz4OD8J1OeVzAK9kmgEyQsBSMn1ncuEaTbGHesUc-Gsw@mail.gmail.com>
Subject: Re: [PATCH v10 40/41] KVM: selftests: Update private_mem_conversions_test
 to mmap() guest_memfd
To: Xiaoyao Li <xiaoyao.li@intel.com>, Sean Christopherson <seanjc@google.com>
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, tabba@google.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> On 8/25/2026 5:32 PM, Ackerley Tng wrote:
>> Sean Christopherson <seanjc@google.com> writes:
>>
>>> On Fri, Aug 21, 2026, Xiaoyao Li wrote:
>>>> On 8/8/2026 5:53 AM, Ackerley Tng via B4 Relay wrote:
>>>>> From: Ackerley Tng<ackerleytng@google.com>
>>>>>
>>>>> Update the private memory conversions selftest to also test conversions
>>>>> that are done "in-place" via per-guest_memfd memory attributes. In-place
>>>>> conversions require the host to be able to mmap() the guest_memfd so that
>>>>> the host and guest can share the same backing physical memory.
>>>>>
>>>>> This includes several updates, that are conditioned on the system
>>>>> supporting per-guest_memfd attributes (kvm_has_gmem_attributes):
>>>>>
>>>>> 1. Set up guest_memfd requesting MMAP and INIT_SHARED.
>>>>
>>>> If I understand correctly, even with in-place gmem, the model that shared
>>>> memory comes from the userspace_addr and private memory comes from gmem can
>>>> still work without passing GUEST_MEMFD_FLAG_MMAP flag.
>>>>
>>>> Since this model is not prohibited by KVM. I think we should keep the
>>>> testcase for this model to ensure test coverage?
>>>
>>> +1.  Deprecated doesn't mean unsupported.
>>
>> The original test case was for non-in-place conversion, which wasn't
>> removed, it still passes.
>
> It only passes when
>
>    /sys/module/kvm/parameters/gmem_in_place_conversion=n
>
> It fails as below when gmem_in_place_conversion=y
>
> ./tools/testing/selftests/kvm/x86/private_mem_conversions_test
> Random seed: 0x7eace343
>
> ==== Test Assertion Failure ====
>    x86/private_mem_conversions_test.c:46: mem[i] == pattern
>    pid=288745 tid=288747 errno=4 - Interrupted system call
>       1	0x000000000040426a: memcmp_h at private_mem_conversions_test.c:46
>       2	 (inlined by) __test_mem_conversions at
> private_mem_conversions_test.c:356
>       3	0x00007f2ea2c89c01: ?? ??:0
>       4	0x00007f2ea2d0ec3f: ?? ??:0
>    Host expected 0xaa at gpa 0x100000000, got 0x0
>
>> Is the ask to also test, under kvm_has_gmem_attributes aka
>> gmem_in_place_conversion, to have guest_memfd used as purely for private
>> memory and have shared memory taken from somewhere else completely?
>>
>> I can rephrase the changelog and change the code to clarify that this
>> patch is meant to specifically test in-place conversion with MMAP, the
>> intended usage of in-place conversions.
>>
>> The ask to test gmem for private and something else for shared seems
>> like a different test that can be added separately, perhaps in a
>> follow-up series?
>
> I see it as the fix for existing testcase, not another new test. And the
> fix is simple:
> 1. change to use vm_mem_set_memory_attributes() to set memory attribute.
> 2. pass GUEST_MEMFD_FLAG_INIT_SHARED to create the gmem because this
> test expects the initial state of the gfn is shared.
>

I understand now. I worked it out, I should be able to post v11
tomorrow, just need a little bit more testing.

> ---8<----
> diff --git
> a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> index cf50e9a332c5..fbd6c63d21cf 100644
> --- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> @@ -307,7 +307,7 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
>                  vm_guest_mem_fallocate(vm, gpa, size, map_shared);
>
>          if (set_attributes)
> -               vm_set_memory_attributes(vm, gpa, size,
> +               vm_mem_set_memory_attributes(vm, gpa, size,
>                                           map_shared ? 0 :
> KVM_MEMORY_ATTRIBUTE_PRIVATE);
>          run->hypercall.ret = 0;
>   }
> @@ -382,6 +382,7 @@ static void test_mem_conversions(enum
> vm_mem_backing_src_type src_type, u32 nr_v
>          const size_t slot_size = memfd_size / nr_memslots;
>          struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
>          pthread_t threads[KVM_MAX_VCPUS];
> +       u64 gmem_flags = 0;
>          struct kvm_vm *vm;
>          int memfd, i;
>
> @@ -397,7 +398,10 @@ static void test_mem_conversions(enum
> vm_mem_backing_src_type src_type, u32 nr_v
>
>          vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 <<
> KVM_HC_MAP_GPA_RANGE));
>
> -       memfd = vm_create_guest_memfd(vm, memfd_size, 0);
> +       if (kvm_has_gmem_attributes)
> +               gmem_flags = GUEST_MEMFD_FLAG_INIT_SHARED;
> +
> +       memfd = vm_create_guest_memfd(vm, memfd_size, gmem_flags);
>
>          for (i = 0; i < nr_memslots; i++)
>                  vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
