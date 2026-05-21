Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBC93CD8C7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 12:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779365550; cv=pass; b=WsPqX4GqqtLI3Q8v76m2gd50vNxqjkuWbyqNCSgwOcRBRljvCF/F4gYc/X8VgsK23Lu/8w0UKhTBzuFw0pB9RvPdF6nkP2Q5Wl81cix79JU2/qda3tUJ1Dxf2Ql7SFq6Zu595hG9LpSZC5dRSzIN5A+Kbo1EBluC6bcyQovdPK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779365550; c=relaxed/simple;
	bh=mUWTvSyqIoqkETcgZuIds2FYkJwuokmb9q2VYy+exYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hzu6NFgBMTMAI6/+POrPOUByNUzEh8+TkeYp4N5/e9RsTHQ7giqLfV+tNJLG9bgIHzR4RD2xvHeRy4UacN8ZdftXI97DdtK31f2HYVEBoh4PDAiCMENCFLVlcmcruPyaVjWD/nTKpTbqRRAEiXfIlwHgeDIZ1uBOtKCRYONW8Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eSxUwN2U; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eSxUwN2U"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-515548f390fso5041cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 05:12:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779365547; cv=none;
        d=google.com; s=arc-20240605;
        b=O9FOOvYT9zLxHo4UGBgxUOV1C5XJRDBphql3lJsoSySim00TB2me16A2/+ZfMph7pS
         mwFM8HBSkntLNCPVScSu5Z4ISC3IUxUJobyaYRkGRaxv8836DTOcy8dQfNg1xGLpMhno
         hbrQBDTdxgMXmEqzR3FMJX2FD1OLpA4Wn24YK21pAFEoR6doZ8RH4bvTIeGCyx4z8r7i
         4Y8VbmwIr+T5kKcV8ixy9FbW0+sIXOfW93OO5IlGesX4OGjcjG3FPQ6SFVDzsbuCj6as
         Wx7iQwcrC1K45SgXtLrUl5tphhFQdOQDBf6o6WHYEebFOOyjzB03pLIyCfIs3eRx0pS1
         12RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=F1wmmG0cNegB4E+dlRzmEOWoIo3QXb0mRCuTWAZdGJs=;
        fh=/V8McUCMlY3BAA60tlEBMqQxwiT0Z/UBkgBEpm+qjgk=;
        b=aDeKhg8YVLI8DfoFfb1GP2ZK9MJcivb3QLpHw5/BpkAm1mUo3DIBWJAsCYWTAwl1Xm
         +8OWLy0WYxc3JHFtkA3t4zkmAJJkoP2ia1jrsimYHqhgB5O/damZSb2lx9+gaEQImIl7
         +CuDX0BSS8T500c6SxyD2ot9KL6cIDBb92vqSyayLYiwaM70319BunLA13gxntGaZldG
         Pi3pnO7vOHLphsuIaJO0IAUBcsXd8A/neo1X4duA3HFQgrvMKlpFCNsZv7EQwdSpfJaC
         8e+T0U4f1/aPWpUrVyTtif38L2CsiS//JMRMMwcdVKewm3qYgD0fPUHEtoo+SlXXAPhj
         azMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779365547; x=1779970347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F1wmmG0cNegB4E+dlRzmEOWoIo3QXb0mRCuTWAZdGJs=;
        b=eSxUwN2UUN0gARyiwlHRhjFeTgTwoYSX6HnwV3HJBMWWPGKbRBBm8GoVr5jIuqOxxT
         KLvP6ZUdR4xTql4y8w669ChBS76GV5GjN6JhPBx4/0Y/Gm4pdN64oH5Nbk5V3iAqmZ26
         CSmQP/S/dnUovh/Mt3TredUArYrIjoVsofJhWHXfP9ECgMjtCvUNRAN+aaLzfWVFk19I
         ObfdSkGwq5zPKDUOlnkfNi5cyGa5akLiCDtta8BKEhh0SCgkqPMvDL5EcjZBkjetHE/x
         iWvwetxUqdI8bYADuRlHhVdXqTAXPP5D4yZ0BPu3qE/FWSAdee6DWPWbrnSXdnJEWZoO
         kOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779365547; x=1779970347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1wmmG0cNegB4E+dlRzmEOWoIo3QXb0mRCuTWAZdGJs=;
        b=mj/2woxBvivWb1qSCvRacje1yror0ILZ2lTRG943jXc6R2LcnLIlWbhdt8Dr8SLga+
         9+zQid2lBDAtfjpM1McQD4Hg+MxZpVDqDqczE/d2pZ7g2ShCft0BBK9rB2GVhmoLykTx
         pJoN0RkJ9H4cSc+F+WYS45Adxv6OHirSN9vrlirR/STXvm3b1r8Sa+e6smcIdmRzbes2
         twmmrmf/XKF3cZIRBh6bTsHCO6TmVu0aGJEarZuvfOtEWnjmmjKo6cUCutRkbG+wU3MV
         iJfFpofL4GRW3544EeHM3P1Rgfa3rW/85H7vQSl6JBcrJPLXpzqRKSkKM2qobo7vjETt
         GHOg==
X-Forwarded-Encrypted: i=1; AFNElJ+3ZqLw5tAgbqUVLwoktD00KCTR3Ixc71SZfJNVSrAuTg0QEHqyuNW0qRkjq7ouzbmbUOtsW8UeV0l9X2yPkEiPfGw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkt87EAWlGIJ/VlRSb42DFs0e2mCUm042ldxSf912HaH3uC4TV
	niSDxMMICoQLFt4Ppk42mR2vwbcp6gSGyfUFukQ2MpFycTgCDNEVVNqudzgRtW5mvrz1e2Bu61z
	iKbQJHmFhgCMMKwh3hnPDgTn1UJhm6c0qN9JI/cwJ
X-Gm-Gg: Acq92OHQnhzJUxj/AOlryrgawAVg2NbvvoiQlg1Zy5iRwjLgv1zTEvRi2UDsLb8AK5j
	WUso8RJgUCBGbjnl4TSSh4O5Pjut7s5ZmuLiE4m5dQzClVifsYQOElWSo3Eqo6uvOnd42FQ+4/9
	/7G4Lfe3azt8/GNB/BKDFaXchqyzzQ9GFb7GrD9GcQSTyUh+rTz87IOSC8fQqiq6OCQf+rMrP7L
	Mh64c3ywvq50Zzu6QFr5rlySwypneKPJjmgQuTItDFOCP4ngIA0bs3jyRgM0rt1DaJ+8m/6KWBs
	fyoaXMFsgGD/OByQuPFE3LL18efJTg==
X-Received: by 2002:a05:622a:995:b0:514:c25e:c164 with SMTP id
 d75a77b69052e-516c545d403mr10074811cf.10.1779365546829; Thu, 21 May 2026
 05:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com> <20260507-gmem-inplace-conversion-v6-23-91ab5a8b19a4@google.com>
In-Reply-To: <20260507-gmem-inplace-conversion-v6-23-91ab5a8b19a4@google.com>
From: Fuad Tabba <tabba@google.com>
Date: Thu, 21 May 2026 13:11:49 +0100
X-Gm-Features: AVHnY4I9MwIePcJowBi5yVnmSFDQMJen-Uv4dVyPJ1sLPspDsU0lqTAnhNGKza0
Message-ID: <CA+EHjTyftaGzz5-NgZGHZvgvuKDCBVSuhSsWSQ=niP_giotk7w@mail.gmail.com>
Subject: Re: [PATCH v6 23/43] KVM: selftests: Create gmem fd before "regular"
 fd when adding memslot
To: ackerleytng@google.com
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jthoughton@google.com, 
	michael.roth@amd.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	qperret@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	shivankg@amd.com, steven.price@arm.com, willy@infradead.org, 
	wyihan@google.com, yan.y.zhao@intel.com, forkloop@google.com, 
	pratyush@kernel.org, suzuki.poulose@arm.com, aneesh.kumar@kernel.org, 
	liam@infradead.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song <baohua@kernel.org>, 
	Axel Rasmussen <axelrasmussen@google.com>, Yuanchu Xie <yuanchu@google.com>, 
	Wei Xu <weixugc@google.com>, Youngjun Park <youngjun.park@lge.com>, 
	Qi Zheng <qi.zheng@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 7 May 2026 at 21:23, Ackerley Tng via B4 Relay
<devnull+ackerleytng.google.com@kernel.org> wrote:
>
> From: Sean Christopherson <seanjc@google.com>
>
> When adding a memslot associated a guest_memfd instance, create/dup the
> guest_memfd before creating the "normal" backing file.  This will allow
> dup'ing the gmem fd as the normal fd when guest_memfd supports mmap(),
> i.e. to make guest_memfd the _only_ backing source for the memslot.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Ackerley Tng <ackerleytng@google.com>

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

> ---
>  tools/testing/selftests/kvm/lib/kvm_util.c | 45 +++++++++++++++---------------
>  1 file changed, 23 insertions(+), 22 deletions(-)
>
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index 2a76eca7029d3..df73b23a4c66a 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1054,6 +1054,29 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>         if (alignment > 1)
>                 region->mmap_size += alignment;
>
> +       if (flags & KVM_MEM_GUEST_MEMFD) {
> +               if (guest_memfd < 0) {
> +                       u32 guest_memfd_flags = 0;
> +
> +                       TEST_ASSERT(!guest_memfd_offset,
> +                                   "Offset must be zero when creating new guest_memfd");
> +                       guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
> +               } else {
> +                       /*
> +                        * Install a unique fd for each memslot so that the fd
> +                        * can be closed when the region is deleted without
> +                        * needing to track if the fd is owned by the framework
> +                        * or by the caller.
> +                        */
> +                       guest_memfd = kvm_dup(guest_memfd);
> +               }
> +
> +               region->region.guest_memfd = guest_memfd;
> +               region->region.guest_memfd_offset = guest_memfd_offset;
> +       } else {
> +               region->region.guest_memfd = -1;
> +       }
> +
>         region->fd = -1;
>         if (backing_src_is_shared(src_type))
>                 region->fd = kvm_memfd_alloc(region->mmap_size,
> @@ -1083,28 +1106,6 @@ void vm_mem_add(struct kvm_vm *vm, enum vm_mem_backing_src_type src_type,
>
>         region->backing_src_type = src_type;
>
> -       if (flags & KVM_MEM_GUEST_MEMFD) {
> -               if (guest_memfd < 0) {
> -                       u32 guest_memfd_flags = 0;
> -                       TEST_ASSERT(!guest_memfd_offset,
> -                                   "Offset must be zero when creating new guest_memfd");
> -                       guest_memfd = vm_create_guest_memfd(vm, mem_size, guest_memfd_flags);
> -               } else {
> -                       /*
> -                        * Install a unique fd for each memslot so that the fd
> -                        * can be closed when the region is deleted without
> -                        * needing to track if the fd is owned by the framework
> -                        * or by the caller.
> -                        */
> -                       guest_memfd = kvm_dup(guest_memfd);
> -               }
> -
> -               region->region.guest_memfd = guest_memfd;
> -               region->region.guest_memfd_offset = guest_memfd_offset;
> -       } else {
> -               region->region.guest_memfd = -1;
> -       }
> -
>         region->unused_phy_pages = sparsebit_alloc();
>         if (vm_arch_has_protected_memory(vm))
>                 region->protected_phy_pages = sparsebit_alloc();
>
> --
> 2.54.0.563.g4f69b47b94-goog
>
>
