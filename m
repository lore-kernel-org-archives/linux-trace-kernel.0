Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E1374197
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368350; cv=none; b=o/BF0PPQ0J3wqCbhJAJKemyy0ov9Y36+vwp89OBrzFukcQCETYxN5Faw6nTGExf2QE57CHVU8T/f+Nn/UIZ6zrho0OD+UxbsKZTPedDUMvTXDqhkSdhDPHIJgEFoKdj/0cinwLO0yTYRqNa6Xl8LU1WOkDlGsFz93NoThZohXO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368350; c=relaxed/simple;
	bh=nCCsq+ltIsdaXwDBzz7XNCu5ikwtb6mcMp6nTD/8nUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UtzQql82fxqKTSiz5uuXCIMNtj2bJbJqKEvRzue69Ji4oWbQOHRROWi6SRW7xZghXlzY4QezHW74gOUpSW/l3ORq9uA0LXOMFkicCmRicsX5aqOE1kSTeMw64VDV8u84XIkKR9cnRUXsVzxUcgM3SQIY1AA+MVWOz7XJfzBvThY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vNeTSR5J; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vNeTSR5J"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ba054e0304so55772405ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 May 2026 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779368348; x=1779973148; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6A/WkImBLvFQtcCerZuF0HISLRf2xh2w4ZLFxLCX4+s=;
        b=vNeTSR5JPbEo10JKP2KMs3y9nFjiSqdVB1ENtWEpq1c9R+17rT4WM8tgfMmxRwaPZf
         n7B+qP+pEkXZ7zBj5au08+vP3FIAUs/s3FWCD797zA6bZlHD/nPAdaAVeJkLt+yYdSxx
         ez0fZPdsg0DPhKJ0EnU/ZPae+4unt5n05rFevPxtqSBCvSn9hVE+jcLVH21AKHb5ScfP
         hcWQeatS2T2mdTMyhcwi/9oucX9j2DaMbbIXuSchTvdLZpdelF3CgrlvfGyVZhL0f7d+
         InFSw8y73c8AQuALmdBISP8SngbKHaa6wBvnev+8mulY2FpBOUwjQtmBc5Qps5H/XKaw
         VLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779368348; x=1779973148;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6A/WkImBLvFQtcCerZuF0HISLRf2xh2w4ZLFxLCX4+s=;
        b=XuMqQpync/dk9MgIE2tkVGCOrht092y2HEcJT7xNlbf3dggFeVKr2yXH3LBAHrkXsB
         mBGNMswN0N/SUofdlerGyD4/VE3ZUngrlgN8RGfa1QWhbStUzZF7on8THyZU9dd1azib
         RWwOoa+jSItA4jP6Gj+07KWSFq6ZWf9abnvu0MwOtU+hD0OMfmgLz+3V53f/JgTj93b6
         wB6m8DwKun5e0Bdi1Xf+gVSHBVnQ31A1IQcOEo95+wKfxn+l2shdTzDybuAE6pdPTmVQ
         PRDsUUFXMVwO2ZLZxJi0xdg3bpkQwVpIcU+8B5j17sppqd7aRcTlm3I6bPE+qJnaifI7
         +uiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/MHSmKbUiiGvX06bJL2qcPxn5s6gwu0vhhcvrAgC5RpbM/tabsWwzcVz18BAGx2yxP4CB+VLzpbnsd7BhLc5ylbDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa87ymSntIFpTzsMXC4ZeJdYygt06jt2OktHHI8WmRj8VwDTa3
	XM+DeFQoa9R7Rplj/iPksZvuvhGJ0ZJWrGxcMYSEC4+BaRczynzKj5uL/6Rp2A4Y6w7lAnPqJrS
	5o59+tg==
X-Received: from plbl6.prod.google.com ([2002:a17:902:eb06:b0:2bd:7dc:3354])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e74f:b0:2b0:4f16:22f7
 with SMTP id d9443c01a7336-2bea229c3e5mr27900055ad.16.1779368347626; Thu, 21
 May 2026 05:59:07 -0700 (PDT)
Date: Thu, 21 May 2026 05:59:06 -0700
In-Reply-To: <CA+EHjTxcadguOfOo7RpJVtAzcY5JAFZTbrAT_wcN6akMi8gCUg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4@google.com>
 <20260507-gmem-inplace-conversion-v6-16-91ab5a8b19a4@google.com> <CA+EHjTxcadguOfOo7RpJVtAzcY5JAFZTbrAT_wcN6akMi8gCUg@mail.gmail.com>
Message-ID: <ag8BmtzxTlcuA_zy@google.com>
Subject: Re: [PATCH v6 16/43] KVM: guest_memfd: Use actual size for
 invalidation in kvm_gmem_release()
From: Sean Christopherson <seanjc@google.com>
To: Fuad Tabba <tabba@google.com>
Cc: ackerleytng@google.com, aik@amd.com, andrew.jones@linux.dev, 
	binbin.wu@linux.intel.com, brauner@kernel.org, chao.p.peng@linux.intel.com, 
	david@kernel.org, ira.weiny@intel.com, jmattson@google.com, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, liam@infradead.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
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
Content-Type: text/plain; charset="us-ascii"

On Thu, May 21, 2026, Fuad Tabba wrote:
> Hi Ackerley,
> 
> On Thu, 7 May 2026 at 21:22, Ackerley Tng via B4 Relay
> <devnull+ackerleytng.google.com@kernel.org> wrote:
> >
> > From: Ackerley Tng <ackerleytng@google.com>
> >
> > __kvm_gmem_invalidate_begin() and __kvm_gmem_invalidate_end() actually do
> > not specially handle -1ul. -1ul is used as a huge number, which legal
> > indices do not exceed, and hence the invalidation works as expected.
> >
> > Since a later patch is going to make use of the exact range, calculate the
> > size of the guest_memfd inode and use it as the end range for invalidating
> > SPTEs.
> >
> > Signed-off-by: Ackerley Tng <ackerleytng@google.com>
> 
> Want to look at what Sashiko has to say? Seems to be a real issue:
> 
> https://sashiko.dev/#/patchset/20260507-gmem-inplace-conversion-v6-0-91ab5a8b19a4%40google.com?part=16
> 
> If I understand correctly, the fix should simple: use
> check_add_overflow() to validate the offset and size parameters in
> kvm_gmem_bind()
> 
>    int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
>              unsigned int fd, loff_t offset)
>    {
>        loff_t size = slot->npages << PAGE_SHIFT;
>    +    loff_t end;
>        unsigned long start, end_index;
>        struct gmem_file *f;
> ...
>    -    if (offset < 0 || !PAGE_ALIGNED(offset) ||
>    -        offset + size > i_size_read(inode))
>    +    if (offset < 0 || !PAGE_ALIGNED(offset) ||
>    +        check_add_overflow(offset, size, &end) ||

Eww, TIL I'm not a fan of check_add_overflow().  Burying an out-param in an
if-statement is nasty.

>    +        end > i_size_read(inode))

This is all rather silly.  @offset and and @slot->npages are fundamentally
unsigned values.   I don't see any reason to convert them to signed values, only
to convert them *back* to unsigned values (when stored in start/end, because xarrays
operate on "unsigned long" indices).

i_size_read() obviously has to return a positive value, so can't we just do this?

diff --git virt/kvm/guest_memfd.c virt/kvm/guest_memfd.c
index a35a55571a2d..9c6dbb54e800 100644
--- virt/kvm/guest_memfd.c
+++ virt/kvm/guest_memfd.c
@@ -640,9 +640,9 @@ int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args)
 }
 
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-                 unsigned int fd, loff_t offset)
+                 unsigned int fd, u64 offset)
 {
-       loff_t size = slot->npages << PAGE_SHIFT;
+       u64 size = slot->npages << PAGE_SHIFT;
        unsigned long start, end;
        struct gmem_file *f;
        struct inode *inode;
@@ -664,8 +664,7 @@ int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
 
        inode = file_inode(file);
 
-       if (offset < 0 || !PAGE_ALIGNED(offset) ||
-           offset + size > i_size_read(inode))
+       if (!PAGE_ALIGNED(offset) || offset + size > i_size_read(inode))
                goto err;
 
        filemap_invalidate_lock(inode->i_mapping);
diff --git virt/kvm/kvm_mm.h virt/kvm/kvm_mm.h
index 9fcc5d5b7f8d..3cb5ef86d0d9 100644
--- virt/kvm/kvm_mm.h
+++ virt/kvm/kvm_mm.h
@@ -72,7 +72,7 @@ int kvm_gmem_init(struct module *module);
 void kvm_gmem_exit(void);
 int kvm_gmem_create(struct kvm *kvm, struct kvm_create_guest_memfd *args);
 int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
-                 unsigned int fd, loff_t offset);
+                 unsigned int fd, u64 offset);
 void kvm_gmem_unbind(struct kvm_memory_slot *slot);
 #else
 static inline int kvm_gmem_init(struct module *module)
@@ -80,9 +80,8 @@ static inline int kvm_gmem_init(struct module *module)
        return 0;
 }
 static inline void kvm_gmem_exit(void) {};
-static inline int kvm_gmem_bind(struct kvm *kvm,
-                                        struct kvm_memory_slot *slot,
-                                        unsigned int fd, loff_t offset)
+static inline int kvm_gmem_bind(struct kvm *kvm, struct kvm_memory_slot *slot,
+                               unsigned int fd, u64 offset)
 {
        WARN_ON_ONCE(1);
        return -EIO;

