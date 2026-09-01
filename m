Received: from mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CE830D419
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788260620; cv=none; b=TuTd66RZmtuNj1G4o5G7YSFsIvinnCjXsKhL6X8+KxNRRiNQgspEy9K4AGu8oq5jjE/1nnrUMRlZbfzTHEtlMX+j19bH8UAx8ggrCwRXIzPNtIfFtqbZNlY4o+Z7SV/w024q4LuHvQHLVTU8v5EFutASOpZ5pMrEVqbaYqv9qOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788260620; c=relaxed/simple;
	bh=WyDimoZKuyTxJfpwGX971Wvc9+oQiBDBINkGgnAGP8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFipnln4yyYmewJBneHqvbGEU80U4InZTHYJUJv8ZDFkhST8Aza2LEGNEzlaDEVdET0thZPkI2CkwNKj+LGkDxWZqmWgrpI3yxGbNcpXjASlBDoHqM5+JQtuXXZ7/WCoAhiOf7FHSlsWKIZT3V5BLIMc0AxV3Va2fb5t+OFtK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O1XEK0Ed; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O1XEK0Ed"
X-Envelope-To: linux-trace-kernel@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WyDimoZKuyTxJfpwGX971Wvc9+oQiBDBINkGgnAGP8g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788260617; v=1; x=1788865417;
 b=O1XEK0EdJO7PahxJiqjEvK+6CBMFCnENvw9OlT8LtME9EHGanaXvcPCMoE1Ryag852STaBFx
 0MFRPMT4bqBoXOi+un/80AccdVKPrqyifeyY2MtQUL2jzUuAoLAha9yaXQ7qZva8AuO2Po/Ru/3
 CILpE2m4JfPOGeerdHlo0pLY=
X-Envelope-To: linux-trace-kernel@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 716bd3faa3cd199a;
	Tue, 01 Sep 2026 11:03:37 +0000
X-Mizu-Trace-ID: 716bd3faa3cd199a
X-Migadu-Flow: FLOW_OUT
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5b2a8173142so4673e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 04:03:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxxm7MSFSgRlnINeL+I7kogNVswvuf4kkXb6DqdxUEXeqeCq+h8mnzSH7IRLUVErNnn2abixl4WoEKVBeunoXmL0ls=@vger.kernel.org
X-Gm-Message-State: AFuF++k7R4hXTuskbSL+ttU93r2M2ZhfrhfRPfjDqoNApy3TBx8JsVrK
	V2cXL4kYGG9HHChQrfTsFoARuY4FTP0sO7BMVrufi/5Z69mEumfcJ8o6w4HMYqeW3HTsik/QXj8
	PPtaWdJFZmYMDcgnhq/hegrEM9xgBC0LS3ON7W0PZ
X-Received: by 2002:a05:6512:b8d:b0:5b2:8963:e5d4 with SMTP id
 2adb3069b0e04-5b600a42bd7mr115293e87.5.1788260614031; Tue, 01 Sep 2026
 04:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-gmem-inplace-conversion-v12-0-85e5fd25252a@google.com> <20260830-gmem-inplace-conversion-v12-43-85e5fd25252a@google.com>
In-Reply-To: <20260830-gmem-inplace-conversion-v12-43-85e5fd25252a@google.com>
From: Fuad Tabba <fuad.tabba@linux.dev>
Date: Tue, 1 Sep 2026 12:03:00 +0100
X-Gmail-Original-Message-ID: <CA+EHjTy8-Otz2NpetF=GsgZ=PQ10KHuHhGKtDmi8NG9skDZP_g@mail.gmail.com>
X-Gm-Features: AcwNN1XpQa0y8jS48DZXcNiZMD0Nb3-aLRIoorwIpEndtCPmsJSxZZnT6oLYZmg
Message-ID: <CA+EHjTy8-Otz2NpetF=GsgZ=PQ10KHuHhGKtDmi8NG9skDZP_g@mail.gmail.com>
Subject: Re: [PATCH v12 43/45] KVM: selftests: Set up page size and alignment
 independently for guest_memfd
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
> Currently, vm_mem_add derives the backing source page size, alignment
> padding, and mmap size from the backing source type upfront before checking
> if guest_memfd is being mmapped.
>
> With shared memory also mmap()-ed from guest_memfd, the alignment of the
> mmap-ed address needs to respect guest_memfd's backing page size.
>
> Refactor the backing store setup to configure the backing source page
> size, alignment, mmap flags, and mmap offset directly for guest_memfd
> when it is mmapped, ignoring the backing source type.
>
> Skip hugepage validation and anonymous memory madvise calls when mmapping
> from guest_memfd, since those are not applicable when mmapping guest_memfd.
>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <fuad.tabba@linux.dev>

Cheers,
/fuad


> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 74 ++++++++++++++++++------------
>  1 file changed, 45 insertions(+), 29 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index cac5624e99774..3f559f207408f 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1034,11 +1034,12 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>  {
>         int ret;
>         struct userspace_mem_region *region;
> -       size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
> -       int mmap_flags = vm_mem_backing_src_alias(src_type)->flag;
>         size_t mem_size = npages * vm->page_size;
> -       off_t mmap_offset = 0;
> -       size_t alignment = 1;
> +       size_t backing_src_pagesz;
> +       off_t mmap_offset;
> +       bool is_gmem_mmap;
> +       size_t alignment;
> +       int mmap_flags;
>
>         TEST_REQUIRE_SET_USER_MEMORY_REGION2();
>
> @@ -1090,19 +1091,31 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>         /* Allocate and initialize new mem region structure. */
>         region = calloc(1, sizeof(*region));
>         TEST_ASSERT(region != NULL, "Insufficient Memory");
> -       region->mmap_size = mem_size;
>
> -       /*
> -        * When using THP mmap is not guaranteed to returned a hugepage aligned
> -        * address so we have to pad the mmap. Padding is not needed for HugeTLB
> -        * because mmap will always return an address aligned to the HugeTLB
> -        * page size.
> -        */
> -       if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
> -               alignment = max(backing_src_pagesz, alignment);
> +       is_gmem_mmap = (flags & KVM_MEM_GUEST_MEMFD) &&
> +                      (gmem_flags & GUEST_MEMFD_FLAG_MMAP);
> +
> +       if (is_gmem_mmap) {
> +               backing_src_pagesz = getpagesize();
> +               alignment = 1;
> +               mmap_flags = MAP_SHARED;
> +               mmap_offset = gmem_offset;
> +       } else {
> +               backing_src_pagesz = get_backing_src_pagesz(src_type);
> +               /*
> +                * When using THP mmap is not guaranteed to returned a hugepage aligned
> +                * address so we have to pad the mmap. Padding is not needed for HugeTLB
> +                * because mmap will always return an address aligned to the HugeTLB
> +                * page size.
> +                */
> +               alignment = src_type == VM_MEM_SRC_ANONYMOUS_THP ? backing_src_pagesz : 1;
> +               mmap_flags = vm_mem_backing_src_alias(src_type)->flag;
> +               mmap_offset = 0;
> +       }
>
>         TEST_ASSERT_EQ(gpa, align_up(gpa, backing_src_pagesz));
>
> +       region->mmap_size = mem_size;
>         /* Add enough memory to align up if necessary */
>         if (alignment > 1)
>                 region->mmap_size += alignment;
> @@ -1129,10 +1142,8 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>         }
>
>         region->fd = -1;
> -       if (flags & KVM_MEM_GUEST_MEMFD && gmem_flags & GUEST_MEMFD_FLAG_MMAP) {
> +       if (is_gmem_mmap) {
>                 region->fd = kvm_dup(gmem_fd);
> -               mmap_flags = MAP_SHARED;
> -               mmap_offset = gmem_offset;
>         } else if (backing_src_is_shared(src_type)) {
>                 region->fd = kvm_memfd_alloc(region->mmap_size,
>                                              src_type == VM_MEM_SRC_SHARED_HUGETLB);
> @@ -1141,22 +1152,27 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>         region->mmap_start = __kvm_mmap(region->mmap_size, PROT_READ | PROT_WRITE,
>                                         mmap_flags, region->fd, mmap_offset);
>
> -       TEST_ASSERT(!is_backing_src_hugetlb(src_type) ||
> -                   region->mmap_start == align_ptr_up(region->mmap_start, backing_src_pagesz),
> -                   "mmap_start %p is not aligned to HugeTLB page size 0x%lx",
> -                   region->mmap_start, backing_src_pagesz);
> -
>         /* Align host address */
>         region->host_mem = align_ptr_up(region->mmap_start, alignment);
>
> -       /* As needed perform madvise */
> -       if ((src_type == VM_MEM_SRC_ANONYMOUS ||
> -            src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
> -               ret = madvise(region->host_mem, mem_size,
> -                             src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
> -               TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
> -                           region->host_mem, mem_size,
> -                           vm_mem_backing_src_alias(src_type)->name);
> +       if (!is_gmem_mmap) {
> +               TEST_ASSERT(!is_backing_src_hugetlb(src_type) ||
> +                           region->mmap_start ==
> +                           align_ptr_up(region->mmap_start, backing_src_pagesz),
> +                           "mmap_start %p is not aligned to HugeTLB page size 0x%lx",
> +                           region->mmap_start, backing_src_pagesz);
> +
> +               /* As needed perform madvise */
> +               if ((src_type == VM_MEM_SRC_ANONYMOUS ||
> +                    src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
> +                       int advice = src_type == VM_MEM_SRC_ANONYMOUS ?
> +                                    MADV_NOHUGEPAGE : MADV_HUGEPAGE;
> +
> +                       ret = madvise(region->host_mem, mem_size, advice);
> +                       TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
> +                                   region->host_mem, mem_size,
> +                                   vm_mem_backing_src_alias(src_type)->name);
> +               }
>         }
>
>         region->backing_src_type = src_type;
>
> --
> 2.55.0.897.gb25b4bd76c-goog
>
>
