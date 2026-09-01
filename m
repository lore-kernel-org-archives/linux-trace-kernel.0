Received: from mta1.migadu.com (out-140.mta1.migadu.com [95.215.58.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326A38B7BD
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 11:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261131; cv=none; b=QPm5CwnbibNcIPWbJhvT6vxGKuO6qPc/kutAnk1BMWhAofXsIWBzi+fNpPku5PMaee4q5VQCLCzGAbgp9cm7eoq5DvQgr2+Ssog1v+3/xHEuxYN4uTVlJZJZQ777jsgzQ3zwzrMhYxGI9Xuv5BS3veP7fT5X48YZaGowxy0Ybuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261131; c=relaxed/simple;
	bh=CsioD9lZ+yh5tHGXfu+MRuQR2cyaW3t4YdYHU6hudFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buDp2M/TueLB0Roa6CfRcYB9pLnHbSjiVwmi/cD04sq2LhpEPYoS94DR/nUTL5tRnx2oDAOUqSQzvBPKWOsHL1FtytgAxdgE0ncXt4SrB1hqws3jPLtFRuJTX0VYGWQDLpDEq0ifRGOFmmPfX9rFFavZGeH8oXbvDlMFj9eTkVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NLbjeJOs; arc=none smtp.client-ip=95.215.58.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NLbjeJOs"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CsioD9lZ+yh5tHGXfu+MRuQR2cyaW3t4YdYHU6hudFc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788261127; v=1; x=1788865927;
 b=NLbjeJOsJ4qDouuFlN/y5SLMpcRNtCK5Flug9/dOf66fxNnBgTk44GRRRfN6G5+WIdCniWiG
 jE9GaSWrgmNVIaaNpcDp62stJTRpizF4X5JAYjs86fMFUUKUNoYb6lxZ/ZS6NZAGA8lVi3B20fb
 My5mbttsG+LPwydsJMueWq28=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 90acadfdd790d4ef;
	Tue, 01 Sep 2026 11:12:07 +0000
X-Mizu-Trace-ID: 90acadfdd790d4ef
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b5e5aaf7deso7291e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 04:12:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz4KGkcRPh6U4FrnVgdzmb5WrOtqaEPaj8pERNI9NNlG/GH0gcLGMUurpxanafd92G27QJ2psy/EJv0S4ZkF9S/B+M=@vger.kernel.org
X-Gm-Message-State: AFuF++k2sbqATjUKbwgeo72GckwY+qhkWsZA18BnXd0kWR6y5fDYMCki
	8YJnFSgvRUImHnRMEi9oi1Q3Go3nvvRI47FiEV9u7yC3WZ6jwuMjxQX3s5GnBUMEXgUDUCBLBd1
	8jRB7d4m2GM7cm4jsPfheyOS5o6Ztra4QrbWqYhZA
X-Received: by 2002:a05:6512:b8d:b0:5aa:79d6:b559 with SMTP id
 2adb3069b0e04-5b5fefc86c9mr146222e87.0.1788261126243; Tue, 01 Sep 2026
 04:12:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com> <20260830-gmem-inplace-conversion-v12-44-85e5fd25252a@google.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-44-85e5fd25252a@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 1 Sep 2026 12:11:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTz+nwFCn66MG2QjiB84_OyOoJowTHr-Ru2uSEpvO+yLCg@mail.gmail.com>
X-Gm-Features: AcwNN1Ub9J3hFyuS9Dks6Hz8-OwxznQ12Dvlx31FuOxfKnRbAtrjNgxw2UfRugY
Message-ID: <CA+EHjTz+nwFCn66MG2QjiB84_OyOoJowTHr-Ru2uSEpvO+yLCg@mail.gmail.com>
Subject: Re: [PATCH v12 44/45] KVM: selftests: Update private_mem_conversions_test
 for in-place conversions
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
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, tarunsahu@google.com, 
	Randy Dunlap <rdunlap@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Aug 2026 at 01:25, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Ackerley Tng <ackerleytng@google.com>
>
> Update private_mem_conversions_test for in-place conversions. In-place
> conversions support is detected in selftests with kvm_has_gmem_attributes.
>
> With in-place conversions, specifying userspace_addr from some other memory
> provider that is not the guest_memfd associated with the memslot is a user
> error, since KVM will only use both shared and private memory from the
> guest_memfd.
>
> Hence, when kvm_has_gmem_attributes, only test in-place conversions with
> single backing, where guest_memfd provides both shared and private memory.
>
> For single backing, guest_memfd must be created with
> GUEST_MEMFD_FLAG_MMAP. Initialize the guest_memfd as shared to align with
> how memory would default to shared when shared/private state was tracked at
> the VM level (the test expects this, it was written for
> non-in-place-conversions).
>
> When handling a hypercall to set attributes, use
> vm_mem_set_memory_attributes() to send the ioctl to the guest_memfd instead
> of the VM.
>
> When testing in-place conversions (single-backing), don't allow the user to
> configure src_type, since src_type will be ignored. Don't use src_type to
> determine alignment for rounding up per-cpu test memory size, since
> guest_memfd's backing page size is always the system PAGE_SIZE.
>
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  .../kvm/x86/private_mem_conversions_test.c         | 57 +++++++++++++++++-----
>  1 file changed, 44 insertions(+), 13 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c b/tools/testing/selftests/kvm/x86/private_mem_conversions_test.c
> index cf50e9a332c5b..33b610383693b 100644
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
> @@ -352,8 +355,21 @@ static void *__test_mem_conversions(void *__vcpu)
>                                 size_t nr_bytes = min_t(size_t, vm->page_size, size - i);
>                                 u8 *hva = addr_gpa2hva(vm, gpa + i);
>
> -                               /* In all cases, the host should observe the shared data. */
> -                               memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
> +                               if (kvm_has_gmem_attributes &&
> +                                   uc.args[0] == SYNC_PRIVATE) {
> +                                       TEST_EXPECT_SIGBUS(READ_ONCE(*hva));
> +                               } else {
> +                                       /*
> +                                        * If not testing in-place conversion
> +                                        * (dual backing), the host should
> +                                        * always observe shared data, since the
> +                                        * shared memory is a separate page.
> +                                        *
> +                                        * For SYNC_SHARED, test that the host
> +                                        * can see shared memory.
> +                                        */
> +                                       memcmp_h(hva, gpa + i, uc.args[3], nr_bytes);
> +                               }
>
>                                 /* For shared, write the new pattern to guest memory. */
>                                 if (uc.args[0] == SYNC_SHARED)
> @@ -369,20 +385,29 @@ static void *__test_mem_conversions(void *__vcpu)
>         }
>  }
>
> +/* Align each vCPU's chunk of memory naturally to the size of the backing store. */
> +static size_t compute_per_cpu_size(enum vm_mem_backing_src_type src_type)
> +{
> +       size_t alignment;
> +
> +       if (kvm_has_gmem_attributes)
> +               alignment = getpagesize();
> +       else
> +               alignment = get_backing_src_pagesz(src_type);
> +
> +       return align_up(PER_CPU_DATA_SIZE, max_t(size_t, SZ_2M, alignment));
> +}
> +
>  static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_vcpus,
>                                  u32 nr_memslots)
>  {
> -       /*
> -        * Allocate enough memory so that each vCPU's chunk of memory can be
> -        * naturally aligned with respect to the size of the backing store.
> -        */
> -       const size_t alignment = max_t(size_t, SZ_2M, get_backing_src_pagesz(src_type));
> -       const size_t per_cpu_size = align_up(PER_CPU_DATA_SIZE, alignment);
> +       const size_t per_cpu_size = compute_per_cpu_size(src_type);
>         const size_t memfd_size = per_cpu_size * nr_vcpus;
>         const size_t slot_size = memfd_size / nr_memslots;
>         struct kvm_vcpu *vcpus[KVM_MAX_VCPUS];
>         pthread_t threads[KVM_MAX_VCPUS];
>         struct kvm_vm *vm;
> +       u64 gmem_flags;
>         int memfd, i;
>
>         const struct vm_shape shape = {
> @@ -397,12 +422,16 @@ static void test_mem_conversions(enum vm_mem_backing_src_type src_type, u32 nr_v
>
>         vm_enable_cap(vm, KVM_CAP_EXIT_HYPERCALL, (1 << KVM_HC_MAP_GPA_RANGE));
>
> -       memfd = vm_create_guest_memfd(vm, memfd_size, 0);
> +       gmem_flags = 0;
> +       if (kvm_has_gmem_attributes)
> +               gmem_flags = GUEST_MEMFD_FLAG_MMAP | GUEST_MEMFD_FLAG_INIT_SHARED;
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
> @@ -462,6 +491,8 @@ int main(int argc, char *argv[])
>         while ((opt = getopt(argc, argv, "hm:s:n:")) != -1) {
>                 switch (opt) {
>                 case 's':
> +                       TEST_ASSERT(!kvm_has_gmem_attributes,
> +                                   "src_type is only configurable when testing without in-place conversion");
>                         src_type = parse_backing_src_type(optarg);
>                         break;
>                 case 'n':
>
> --
> 2.55.0.897.gb25b4bd76c-goog
>
>
