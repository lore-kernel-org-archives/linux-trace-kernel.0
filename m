Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEFF353ED1
	for <linux-trace-kernel@vger.kernel.org>; Mon,  2 Feb 2026 22:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770071425; cv=none; b=bDyJK8zcvlgzFkSwPclQHotf5Eh+/uq5oEHX2s5TY+ubRYTh1v6vyUuc2lX2fi5ZoFAlQVHwudVvt9v1rMEAkbHn1FWMFwmoW7/Vz1b3Ar12qnBgMw9tZsKo3/bQZBNO8hr+kDlBlzYLKgF6zUqsCEzR4IRpOHFiNg0b55nyYN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770071425; c=relaxed/simple;
	bh=uSbCIOBOEf0Jbc1TJu+Uo31WNZmK8IMWR8LoTzKYbHI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JBHGqNO+omAVrcEEazIm7cJggxON1ApHFx11Pc5GckuXO5JiJDJXiHEGLZQn3fP7kQhgV7JCYlAfgZXM6u7av3P+REXBjG/gwY1LTwTK8rW7SRe/0j2DXgbV0GyWHK8NlFghJE1o+EA+ehkTY/gfwRES3h9CVVpNV9cREs40OMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VhVKhscF; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VhVKhscF"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3545dbb7f14so1865318a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 02 Feb 2026 14:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770071423; x=1770676223; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zTHZdye+hOtZPjhoVi1/P3piDNtewPIJyZBVqqIicdA=;
        b=VhVKhscFBRcjyWXd4ZbEO+3iv3xVOA2HsrLH0awdshxYzlBSaU+NhELpUkGdjgtwUY
         ph/k+MNvzUErKehkZfVXZxNxOEcmpFL2+q/sw7pP3nTagIBAud6gqAaxQXD8+b+5lhR7
         K6Bu7mVwPvqS7t7aFzhIIryvHg9Nt8yOuM0o9ER+FIUbM65+hEISRIg1Dmkhzv3nowoV
         BkMVjz0Z9XIY4vylL0gSvJcYIMH2JbaPZXoSaR2nniBi9HswyiZpu2IPE231O47vG/0N
         Ij4H0QMMMiOzLVSmdHOoKlxapBL6hq773YDM0v9ZmoQb4uX25ELFGcgYU2Gjrv81LBMq
         3auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770071423; x=1770676223;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zTHZdye+hOtZPjhoVi1/P3piDNtewPIJyZBVqqIicdA=;
        b=bM050LWsle8uKuLZPzuqtf5YFdHaHM00mGtP2NDH9BYRGQGxYy3kiRu4FRgYYbGQlE
         hZL9PqFMNYYFLCi4R8P6VWgATqH5ctQWpNP9HmCm5S2fARj1WY/L595LfzhNzj3HXzhm
         3ZT1xYVvYgUJaQvYja+g/DCS6FKwZ+yq2iTmquqLIb44yK6V0nuyOVWcmouemHwjbF4q
         rHXA+Ggf03jIBwyYIcRco/f1j2ulzrS+KKERatY3lcE7wv/r0Z4CgjDuC6XGuAJL2Pic
         v7MjL9dH06x5WiIucPsmti7Pr1KwEcjfnxVql4ZwC5NQ+zrUkyx3XWaB+rIGTXNSu21z
         uocQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDY5c6LNonSszysZJvlWggFqEnk63ULPgh7S7ZLOgnTV2M8uoqoPAR307Yd+jI79EL/OmOVBEgt8Y0lYHwP8MhQ80=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeFNCgTcEkVnm4ED25nrMCY1q9UKeBXIQaEWCjRVs2KSMIRs/u
	5MBAU0ewkGGFnohSe7dJ2mVh5a5znejkHjI7ZRznb4BFDVqPqoG6c9c2tQeiRPKsUOcxwbbsewS
	+dyPMWudOjxl1jyHNox8Yxg82vw==
X-Received: from pjbgn7.prod.google.com ([2002:a17:90a:c787:b0:349:8a6d:dfd1])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:6c3:b0:352:cd58:c8ce with SMTP id 98e67ed59e1d1-3543b3e4ba3mr11808970a91.32.1770071422709;
 Mon, 02 Feb 2026 14:30:22 -0800 (PST)
Date: Mon,  2 Feb 2026 14:29:38 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <cover.1769725905.git.ackerleytng@google.com>
Subject: [RFC PATCH v2 00/37] guest_memfd: In-place conversion support
From: Ackerley Tng <ackerleytng@google.com>
To: kvm@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Cc: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	bp@alien8.de, brauner@kernel.org, chao.p.peng@intel.com, 
	chao.p.peng@linux.intel.com, chenhuacai@kernel.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, hpa@zytor.com, 
	ira.weiny@intel.com, jgg@nvidia.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, maobibo@loongson.cn, mathieu.desnoyers@efficios.com, 
	maz@kernel.org, mhiramat@kernel.org, michael.roth@amd.com, mingo@redhat.com, 
	mlevitsk@redhat.com, oupton@kernel.org, pankaj.gupta@amd.com, 
	pbonzini@redhat.com, prsampat@amd.com, qperret@google.com, 
	ricarkol@google.com, rick.p.edgecombe@intel.com, rientjes@google.com, 
	rostedt@goodmis.org, seanjc@google.com, shivankg@amd.com, shuah@kernel.org, 
	steven.price@arm.com, tabba@google.com, tglx@linutronix.de, 
	vannapurve@google.com, vbabka@suse.cz, willy@infradead.org, wyihan@google.com, 
	yan.y.zhao@intel.com, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="UTF-8"

Here's a second revision of guest_memfd In-place conversion support.

In this version, other than addressing comments from RFCv1 [1], the largest
change is that guest_memfd now does not avoid participation in LRU; it
participates in LRU by joining the unevictable list (no change from before this
series).

While checking for elevated refcounts during shared to private conversions,
guest_memfd will now do an lru_add_drain_all() if elevated refcounts were found,
before concluding that there are true users of the shared folio and erroring
out.

I'd still like feedback on these points, if any:

1. Having private/shared status stored in a maple tree (Thanks Michael for your
   support of using maple trees over xarrays for performance! [5]).
2. Having a new guest_memfd ioctl (not a vm ioctl) that performs conversions.
3. Using ioctls/structs/input attribute similar to the existing vm ioctl
   KVM_SET_MEMORY_ATTRIBUTES to perform conversions.
4. Storing requested attributes directly in the maple tree.
5. Using a KVM module-wide param to toggle between setting memory attributes via
   vm and guest_memfd ioctls (making them mututally exclusive - a single loaded
   KVM module can only do one of the two.).

This series is based on kvm/next as at 2026-01-21, and here's the tree for your
convenience:

https://github.com/googleprodkernel/linux-cc/commits/guest_memfd-inplace-conversion-v2

The "Don't set FGP_ACCESSED when getting folios" patch from RFCv1 is still
useful but no longer related to conversion, and was posted separately [6].

Older series:

+ RFCv1 is at [1]
+ Previous versions of this feature, part of other series, are available at
  [2][3][4].

[1] https://lore.kernel.org/all/cover.1760731772.git.ackerleytng@google.com/T/
[2] https://lore.kernel.org/all/bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com/
[3] https://lore.kernel.org/all/20250117163001.2326672-6-tabba@google.com/
[4] https://lore.kernel.org/all/b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com/
[5] https://lore.kernel.org/all/20250529054227.hh2f4jmyqf6igd3i@amd.com/
[6] https://lore.kernel.org/all/20260129172646.2361462-1-ackerleytng@google.com/

Ackerley Tng (19):
  KVM: guest_memfd: Update kvm_gmem_populate() to use gmem attributes
  KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
  KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
  KVM: guest_memfd: Handle lru_add fbatch refcounts during conversion
    safety check
  KVM: selftests: Update framework to use KVM_SET_MEMORY_ATTRIBUTES2
  KVM: selftests: Test using guest_memfd for guest private memory
  KVM: selftests: Test basic single-page conversion flow
  KVM: selftests: Test conversion flow when INIT_SHARED
  KVM: selftests: Test indexing in guest_memfd
  KVM: selftests: Test conversion before allocation
  KVM: selftests: Convert with allocated folios in different layouts
  KVM: selftests: Test precision of conversion
  KVM: selftests: Test that truncation does not change shared/private
    status
  KVM: selftests: Test conversion with elevated page refcount
  KVM: selftests: Reset shared memory after hole-punching
  KVM: selftests: Provide function to look up guest_memfd details from
    gpa
  KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
  KVM: selftests: Update private_mem_conversions_test to mmap()
    guest_memfd
  KVM: selftests: Add script to exercise private_mem_conversions_test

Sean Christopherson (18):
  KVM: guest_memfd: Introduce per-gmem attributes, use to guard user
    mappings
  KVM: Rename KVM_GENERIC_MEMORY_ATTRIBUTES to KVM_VM_MEMORY_ATTRIBUTES
  KVM: Enumerate support for PRIVATE memory iff kvm_arch_has_private_mem
    is defined
  KVM: Stub in ability to disable per-VM memory attribute tracking
  KVM: guest_memfd: Wire up kvm_get_memory_attributes() to per-gmem
    attributes
  KVM: guest_memfd: Enable INIT_SHARED on guest_memfd for x86 Coco VMs
  KVM: Move KVM_VM_MEMORY_ATTRIBUTES config definition to x86
  KVM: Let userspace disable per-VM mem attributes, enable per-gmem
    attributes
  KVM: selftests: Create gmem fd before "regular" fd when adding memslot
  KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
  KVM: selftests: Add support for mmap() on guest_memfd in core library
  KVM: selftests: Add selftests global for guest memory attributes
    capability
  KVM: selftests: Add helpers for calling ioctls on guest_memfd
  KVM: selftests: Test that shared/private status is consistent across
    processes
  KVM: selftests: Provide common function to set memory attributes
  KVM: selftests: Check fd/flags provided to mmap() when setting up
    memslot
  KVM: selftests: Update pre-fault test to work with per-guest_memfd
    attributes
  KVM: selftests: Update private memory exits test work with per-gmem
    attributes

 Documentation/virt/kvm/api.rst                |  72 ++-
 arch/x86/include/asm/kvm_host.h               |   2 +-
 arch/x86/kvm/Kconfig                          |  15 +-
 arch/x86/kvm/mmu/mmu.c                        |   4 +-
 arch/x86/kvm/x86.c                            |  13 +-
 include/linux/kvm_host.h                      |  53 +-
 include/trace/events/kvm.h                    |   4 +-
 include/uapi/linux/kvm.h                      |  17 +
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/guest_memfd_conversions_test.c        | 486 ++++++++++++++++++
 .../testing/selftests/kvm/guest_memfd_test.c  |  57 +-
 .../testing/selftests/kvm/include/kvm_util.h  | 128 ++++-
 .../testing/selftests/kvm/include/test_util.h |  31 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    | 130 +++--
 tools/testing/selftests/kvm/lib/test_util.c   |   7 -
 .../selftests/kvm/pre_fault_memory_test.c     |   2 +-
 .../kvm/x86/private_mem_conversions_test.c    |  48 +-
 .../kvm/x86/private_mem_conversions_test.py   | 152 ++++++
 .../kvm/x86/private_mem_kvm_exits_test.c      |  36 +-
 virt/kvm/Kconfig                              |   4 +-
 virt/kvm/guest_memfd.c                        | 399 +++++++++++++-
 virt/kvm/kvm_main.c                           | 104 +++-
 23 files changed, 1590 insertions(+), 176 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/guest_memfd_conversions_test.c
 create mode 100755 tools/testing/selftests/kvm/x86/private_mem_conversions_test.py

--
2.53.0.rc1.225.gd81095ad13-goog
