Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9890837472F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782380610; cv=pass; b=Ly/o6s4/UqAvXWP3AZv4CTdoNQNZgqOgVt2tpXXqf7X5fmKMVVBgHn+u4Nam68Rq/6J3A8vEIsmq6ki8WiNmHUuo7PlUAI1WWd4x3VECot6YHOOG0qrzS1Drc3bJFiXznx1ZgYBrrLTQjbRS+6fZPGvO6HIbwX6z7qf5iLQmdL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782380610; c=relaxed/simple;
	bh=b8wBEbsUQs0VJH8qRWq+x+Mcifx/55FV07RbPrweSd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=diVqg9Pwv1FVEEeJXsVWOLY4Hn70ru8/0nbqUQFXt1H39IV18gC5xON5t47oJ58R/i5SoD8+LzPgFGlQ+G7VScJ8jbo0VqFoBKQj9SrfLf0jwYxXICA0XltxD2T88Tch6tSAwGcVm4gneu+81PUb3ioOHw3OeroT/y4GaWUiQCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v9hVB61f; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v9hVB61f"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51765331535so168301cf.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 02:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782380607; cv=none;
        d=google.com; s=arc-20260327;
        b=FNpfnUu02IhnL1wQdoYV809GU33uPkb/OmK6+LHA96go8YkjRpV8an2h0pwzmgi7GG
         clwLV+7DxzPq1YmPMyP9Q94Ry/kWn1juxnRn9NeIjkP91I65D57F204rht4NNttvFFuC
         osbkV6VcZ3HX7dnLlOvAO3UyWU+oYzoSqClkQc6H0L5nRkkz5Vj3cVaR8DB4JdI1JWXO
         mY7wX+OyRpXZlrFcQfaIUYMUlPttGUCbZzYw7cpJu5SlvndA0WUPPRMA997WCo+X5Sdx
         HJUu1SCplN/lYrPrn4eRn7kdfkS2pe0J3Q0TYsojoSHxlexHpLiTPpp4IzWUQy/ON5QP
         3xPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gcCzDur02+kpX92XVlxTT3/2MUJYhXNphEvl6EVFGyM=;
        fh=K3yp0Xq1e/+ZJnSc3KSIFKB7XQW8eIUP38UCgyK7TCg=;
        b=rOzgnr0ZApvtuVSpkmYQR0JtKD5iK7TaNLGY4eez1nZfnfgOv2cIrJ7kyfKTFf99Su
         iziSDok38Q+beksEw2BZPPBxBmNuIopKB3K6wMugD1GP9PgX0wvwMu1Zg33rJY3XDrSG
         Jc3vm1rwvtiyPOXaP57mYerL1XLX78XyRmi9zd7z8hcganXUFqm0SoUcK82hL9iwDLP2
         EBVEiGh6vQY5tLBl0YjzHX0PMqZVrDcmIKB1/gCd2HLFy4q2SNJgiu2np5dcoCc2E0xk
         6bKgFu16/jDbm7fVgSybHtW1NWDEpj0r+Kp3ggbJiUOxUHSJNMtkZRFvhSP1uZyF+IB4
         rpgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782380607; x=1782985407; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gcCzDur02+kpX92XVlxTT3/2MUJYhXNphEvl6EVFGyM=;
        b=v9hVB61f9kvt5nrI3rAGQ58d4d6IuMWPEuH+SshnxlqaiBhGrNdX0YFWye4Ela1tGQ
         +5xu/DP6n43SBwfR21mgTCcyQWbxTuNr3D62OE1OOOjcDLNboj+rbvFKbZ2WHf1W514S
         CVsMirjpg49kvxN+rWniE/L8Hp9esFBGP4/kJAI2p77BOgfciuw6vyBRIal2B4PIG4xU
         tNCQkmrCiKarBMvlOqE3nFG2VCsNhwD5a76BJ7SVBC+NvbSSFvfYOlbhqk1++tI8NVkE
         Q8iBXSO2qzgLWPaHePcNHXBJnAbycbgJRU4i1fh+lwDLSbDtTyk+JUHrT2nAPolTPWqZ
         6ViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782380607; x=1782985407;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gcCzDur02+kpX92XVlxTT3/2MUJYhXNphEvl6EVFGyM=;
        b=ZXAxt8t+8PYSKpBmeStsmULT2h9SSftW/L9C9fViVpFe55E9bWFsZef873eNW9UqL7
         jg05HEjG+4kthy/PDcPkqFKGkrXZcc+fKlEwtGJn0ED5kDiKFJjQZwprhK+zyczA6H62
         EJ90lDo+k1X4VSgJ2jQde2R6z2d3Ia4JW3J+ce1fvYwlHp3Zk5kkDcZqjkB7JtxtpQaZ
         Ls6asNPMzs86f4MRSn/+rCt3tphmJNO9qOx+vAUGwmmHjFeUfewKZjV4sboTtmGZXRrz
         sRJjHkj4B2PJsPc9xkoKga9hIxVKMTwwkNRVbOneFz4DbLxFc2TvLVI7jmd2gkXMEOT9
         D18w==
X-Forwarded-Encrypted: i=1; AFNElJ/4IMW0Uk87YK+c39lX2iLaHR5/p9Dupitp32c4TcfBMwneWHl1BiWWEx7jqHMOy463k2w4faCMq7hNw6RpmrUKubc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL7mNeOyrX1rquP9AVhxZwroC2JID/AXdd9o0VqciDR57VLwbv
	H/v17MjbQVYwo5Y/9iPUj2FE7w2qy6VOKbnKmPaBZwYLfdqoCnXwquQmA1l3Gjnxia4qlgSKeNF
	5Shx5+K6NiAnnaLqdkv7dqLqymO3WiyqdbZpbcTls
X-Gm-Gg: AfdE7ckghoyl462G3WldS419tRkdvKs11K0nhiXqk/rOIIcWCS9kxdaZ2L300pL5KLB
	5shK8YSH3bytVW04nVf+Zb1Loz9hy2v2Bh6d706guM8k7hHN7m36u/7VjxyVt9CyqZbxyAXD8Mc
	/pYlQ1WUsMmjiE8zBF5eAEjDS+j5XoeA7Em3htJLHIy0UOR/QrNUQp+LLAtO9pREVJp5IkXUbLB
	J5G1C39tQIDybymoHHkFgn16vH7ckTE1Np2cQUWDygCsaVdWfDL8i/bGAfvZMY8+ceFpE0LxhEI
	wBKO/tt6
X-Received: by 2002:a05:622a:1f96:b0:516:cc18:4760 with SMTP id
 d75a77b69052e-51a709958aamr6605881cf.21.1782380606888; Thu, 25 Jun 2026
 02:43:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618-gmem-inplace-conversion-v8-0-9d2959357853@google.com> <20260618-gmem-inplace-conversion-v8-45-9d2959357853@google.com>
In-Reply-To: <20260618-gmem-inplace-conversion-v8-45-9d2959357853@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 25 Jun 2026 10:43:00 +0100
X-Gm-Features: AVVi8CeAgnQFawLrHeIHW8UXEeBJMVi8lMuxnjDgguWeUrHnouPWU4zA8KvTsuw
Message-ID: <CA+EHjTyddaEbaa8ohd-2uLbT=dpxPn92s0UULbckHyoCXtZMgA@mail.gmail.com>
Subject: Re: [PATCH v8 45/46] KVM: selftests: Update private_mem_conversions_test
 to mmap() guest_memfd
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	jmattson@google.com, jthoughton@google.com, michael.roth@amd.com, 
	oupton@kernel.org, pankaj.gupta@amd.com, qperret@google.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, shivankg@amd.com, 
	steven.price@arm.com, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, forkloop@google.com, pratyush@kernel.org, 
	suzuki.poulose@arm.com, aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
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
	Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Jun 2026 at 01:32, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Update the private memory conversions selftest to also test conversions
> that are done "in-place" via per-guest_memfd memory attributes. In-place
> conversions require the host to be able to mmap() the guest_memfd so that
> the host and guest can share the same backing physical memory.
>
> This includes several updates, that are conditioned on the system
> supporting per-guest_memfd attributes (kvm_has_gmem_attributes):
>
> 1. Set up guest_memfd requesting MMAP and INIT_SHARED.
>
> 2. With in-place conversions, the host's mapping points directly to the
>    guest's memory. When the guest converts a region to private, host access
>    to that region is blocked. Update the test to expect a SIGBUS when
>    attempting to access the host virtual address (HVA) of private memory.
>
> 3. Use vm_mem_set_memory_attributes(), which chooses how to set memory
>    attributes based on whether kvm_has_gmem_attributes.
>
> Restrict the test to using VM_MEM_SRC_SHMEM because guest_memfd's required
> mmap() flags and page sizes happens to align with those of
> VM_MEM_SRC_SHMEM. As long as VM_MEM_SRC_SHMEM is used for src_type,
> vm_mem_add() works as intended.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  .../kvm/x86/private_mem_conversions_test.c         | 44 ++++++++++++++++++----
>  1 file changed, 36 insertions(+), 8 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> index 289ad10063fca..4308c67952310 100644
> --- a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> +++ b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> @@ -306,9 +306,12 @@ static void handle_exit_hypercall(struct kvm_vcpu *vcpu)
>         if (do_fallocate)
>                 vm_guest_mem_fallocate(vm, gpa, size, map_shared);
>
> -       if (set_attributes)
> -               vm_set_memory_attributes(vm, gpa, size,
> -                                        map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE);
> +       if (set_attributes) {
> +               u64 attrs = map_shared ? 0 : KVM_MEMORY_ATTRIBUTE_PRIVATE;
> +
> +               vm_mem_set_memory_attributes(vm, gpa, size, attrs);
> +       }
> +
>         run->hypercall.ret = 0;
>  }
>
> @@ -352,8 +355,20 @@ static void *__test_mem_conversions(void *__vcpu)
>                                 size_t nr_bytes = min_t(size_t, vm->page_size, size - i);
>                                 u8 *hva = addr_gpa2hva(vm, gpa + i);
>
> -                               /* In all cases, the host should observe the shared data. */
> -                               memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
> +                               /*
> +                                * When using per-guest_memfd memory attributes,
> +                                * i.e. in-place conversion, host accesses will
> +                                * point at guest memory and should SIGBUS when
> +                                * guest memory is private.  When using per-VM
> +                                * attributes, i.e. separate backing for shared
> +                                * vs. private, the host should always observe
> +                                * the shared data.
> +                                */
> +                               if (kvm_has_gmem_attributes &&
> +                                   uc.args[0] == SYNC_PRIVATE)
> +                                       TEST_EXPECT_SIGBUS(READ_ONCE(*hva));
> +                               else
> +                                       memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
>
>                                 /* For shared, write the new pattern to guest memory. */
>                                 if (uc.args[0] == SYNC_SHARED)
> @@ -382,6 +397,7 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_v
>         const size_t slot_size = memfd_size / nr_memslots;
>         struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
>         pthread_t threads[KVM_MAX_VCPUS];
> +       u64 gmem_flags;
>         struct kvm_vm *vm;
>         int memfd, i;
>
> @@ -397,12 +413,17 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_v
>
>         vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
>
> -       memfd = vm_create_guest_memfd(vm, memfd_size, 0);
> +       if (kvm_has_gmem_attributes)
> +               gmem_flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
> +       else
> +               gmem_flags = 0;
> +
> +       memfd = vm_create_guest_memfd(vm, memfd_size, gmem_flags);
>
>         for (i = 0; i < nr_memslots; i++)
>                 vm_mem_add(vm, src_type, BASE_DATA_GPA + slot_size * i,
>                            BASE_DATA_SLOT + i, slot_size / vm->page_size,
> -                          KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, 0);
> +                          KVM_MEM_GUEST_MEMFD, memfd, slot_size * i, gmem_flags);
>
>         for (i = 0; i < nr_vcpus; i++) {
>                 gpa_t gpa =  BASE_DATA_GPA + i * per_cpu_size;
> @@ -452,17 +473,24 @@ static void usage(const char *cmd)
>
>  int main(int argc, char *argv[])
>  {
> -       enum vm_mem_backing_src_type src_type = DEFAULT_VM_MEM_SRC;
> +       enum vm_mem_backing_src_type src_type;
>         u32 nr_memslots = 1;
>         u32 nr_vcpus = 1;
>         int opt;
>
>         TEST_REQUIRE(kvm_check_cap(KVM_CAP_VM_TYPES) & BIT(KVM_X86_SW_PROTECTED_VM));
>
> +       src_type = kvm_has_gmem_attributes ? VM_MEM_SRC_SHMEM :
> +                                            DEFAULT_VM_MEM_SRC;
> +
>         while ((opt = getopt(argc, argv, "hm:s:n:")) != -1) {
>                 switch (opt) {
>                 case 's':
>                         src_type = parse_backing_src_type(optarg);
> +                       TEST_ASSERT(!kvm_has_gmem_attributes ||
> +                                   src_type == VM_MEM_SRC_SHMEM,
> +                                   "Testing in-place conversions, only %s mem_type supported\n",
> +                                   vm_mem_backing_src_alias(VM_MEM_SRC_SHMEM)->name);
>                         break;
>                 case 'n':
>                         nr_vcpus = atoi_positive("nr_vcpus", optarg);
>
> --
> 2.55.0.rc0.738.g0c8ab3ebcc-goog
>
>
