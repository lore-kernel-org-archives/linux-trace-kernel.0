Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000F315D3E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563865; cv=none; b=ATsXjYpM3oc/Qt9Cpgn9R9VCguxTSqphVpxik04Fk/wUyVfU43G4UNcheMqxY0EeMFkVld4K9BS2+AxN5Lhw2SaWwgHK2TKPSoIuxDXogGEffGvY4JreUN+ntoxh1ImhFyW6Nr5aqhOdJrGY9SCcR2owtU11h4UcOM4enPgH8XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563865; c=relaxed/simple;
	bh=hyHHU3KevU1bPZ0Pz3Z5wuGltsbom7bIL/N/qi4jWOo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SADFQrbfyWwovVlk2F6xeU9s6VngL1KSimKG82YRkKmN2Xoe7zL4Eugvph73aUUys4J0qpn1JglWQpylpQWotI5l5HjzxKCDz0YWPaT/ArSGGSEjjpfexvrHA1Z/vlZdoY0ruol8Pi9SdhFGgykpeQbMHV/Riz95gs/9HOSJ/aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4mufUjU; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4mufUjU"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-82a6906e35fso2987141b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 15:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774563864; x=1775168664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BL72lrNf2QkltPBVeRaNAZDLGH/Oti/Xx+2x3+YF24k=;
        b=Y4mufUjUlVwPxbLMP7pjZY4VN30P9hZhIHUrdrkrkck65G4xrN0VTTd12xdlaHMvl5
         juTEkE+1aIz6TkFL4d8xYqu7bSWs9UXybUxVe05WMkCBXtcPI1Yv2/SoH6Tf1s7qEqhU
         LRRQU9nJA16M7O8peSnu+WezoUGoi+TbfA0Q/oc3yd7XEJ76speivJ7dcNSxyWmWwTec
         dZbuyO6urJQIkY+6kLZM4O3FDXyf/bc9L/2danRvGucpYMTnfa5e2/v1pGNUNZEAzeIC
         xUBDPbrjVRUOeS6cgN7cdbhrmtll8lI5tyGYDQggXUp+8rhySXz/d0ONEvT81SbPBcqc
         l56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563864; x=1775168664;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BL72lrNf2QkltPBVeRaNAZDLGH/Oti/Xx+2x3+YF24k=;
        b=QSASOwz9OapVdJYzV6a8L2b2LVelllAqrEY2ZZa8OIoeg7RXmKsRl7OGHI157TX102
         Gh1D1/JDxEAfX46+TLwSyX4myj44fQ3X3uGF1fwIADr6ESIusOVO0P2WubHdPuOb0Hlt
         gFGC2yG7DxaFvPi7fI3Xv1E5zbE71p9oyxXEj7IRWXWuyFEpK6EI7ZZCU08ZcRH2Yars
         ZO2S3cjOqGqRVhtyrotZQNIowe7V4gADSxJ2vxtT3BADtgJeBs8Cg2u7oG/QTakENr2X
         b3pYTuh0hS87XeL/k8uFGtEgLOp113Se+GTw/xgWMW19q5xxr4GkMBKoKLIOFQZFd9G/
         WlYw==
X-Forwarded-Encrypted: i=1; AJvYcCVkRtVmME4akT0g80KOQ/NsLVXvJ2O0OhhFRoVzGHW3AjfpO9zQGKMka6HjKqOHNhCZ+VidyzHOYtBtPBTUWyFvbGo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz83lR3XugNukH0p5kCfSPj7Cjy/Hr4Y1PxIEckJQBH/CHryS07
	JVBPP6wAL/OO34ENbybw8V6j21T1KukB+JApaSowlsy85t6zjPYdvI8QUIyj+Ey4/ES4VXbH70P
	27PwXp9Ydp1Us10yiV/FsL1HY/Q==
X-Received: from pfch17.prod.google.com ([2002:a05:6a00:1711:b0:829:9111:d582])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:4507:b0:824:b03f:2f65 with SMTP id d2e1a72fcca58-82c86327803mr2542565b3a.7.1774563863167;
 Thu, 26 Mar 2026 15:24:23 -0700 (PDT)
Date: Thu, 26 Mar 2026 15:24:09 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAAmyxWkC/3WOTQ6CMBSEr0Le2mppRcSViYkHcGtY9OcBjbQlL
 WkwhLsL7F3OZL6ZmSFiMBjhls0QMJlovFvF+ZCB6oRrkRi9amCUXShjBWktWmLc0AuFRHmXMGw
 MkZpqqXlVFlzASg8BGzPtzW94PR9Qr6YUEYkMwqluK/0ke3I4jVu+M3H04bsfSXyn9k2e87+bi RNKikblTJQU1bW6t963PR6Vt1Avy/IDuIOvYt8AAAA=
X-Change-Id: 20260225-gmem-inplace-conversion-bd0dbd39753a
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774563861; l=10415;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=hyHHU3KevU1bPZ0Pz3Z5wuGltsbom7bIL/N/qi4jWOo=; b=SDVWlzJcpxISVwqOVOCgwwa+YC0UDPLDcSLkwYAyQaCK6yKAR8SuXc9BrH/WMDNBwTtDusyIC
 SdvlK3rvjp4BhmvKLQQSqUcLHSD9J2SVOM6/u8ZuDk7xkSMfAo0WgWK
X-Mailer: b4 0.14.3
Message-ID: <20260326-gmem-inplace-conversion-v4-0-e202fe950ffd@google.com>
Subject: [PATCH RFC v4 00/44] guest_memfd: In-place conversion support
From: Ackerley Tng <ackerleytng@google.com>
To: aik@amd.com, andrew.jones@linux.dev, binbin.wu@linux.intel.com, 
	brauner@kernel.org, chao.p.peng@linux.intel.com, david@kernel.org, 
	ira.weiny@intel.com, jmattson@google.com, jroedel@suse.de, 
	jthoughton@google.com, michael.roth@amd.com, oupton@kernel.org, 
	pankaj.gupta@amd.com, qperret@google.com, rick.p.edgecombe@intel.com, 
	rientjes@google.com, shivankg@amd.com, steven.price@arm.com, tabba@google.com, 
	willy@infradead.org, wyihan@google.com, yan.y.zhao@intel.com, 
	forkloop@google.com, pratyush@kernel.org, suzuki.poulose@arm.com, 
	aneesh.kumar@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
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
	Wei Xu <weixugc@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

This is RFC v4 of guest_memfd in-place conversion support.

Up till now, guest_memfd supports the entire inode worth of memory being
used as all-shared, or all-private. CoCo VMs may request guest memory to be
converted between private and shared states, and the only way to support
that currently would be to have the userspace VMM provide two sources of
backing memory from completely different areas of physical memory.

pKVM has a use case for in-place sharing: the guest and host may be
cooperating on given data, and pKVM doesn't protect data through
encryption, so copying that given data between different areas of physical
memory as part of conversions would be unnecessary work.

This series also serves as a foundation for guest_memfd huge page
support. Now, guest_memfd only supports PAGE_SIZE pages, so if two sources
of backing memory are used, the userspace VMM could maintain a steady total
memory utilized by punching out the pages that are not used. When huge
pages are available in guest_memfd, even if the backing memory source
supports hole punching within a huge page, punching out pages to maintain
the total memory utilized by a VM would be introducing lots of
fragmentation.

In-place conversion avoids fragmentation by allowing the same physical
memory to be used for both shared and private memory, with guest_memfd
tracks the shared/private status of all the pages at a per-page
granularity.

The central principle, which guest_memfd continues to uphold, is that any
guest-private page will not be mappable to host userspace. All pages will
be mmap()-able in host userspace, but accesses to guest-private pages (as
tracked by guest_memfd) will result in a SIGBUS.

This series introduces a guest_memfd ioctl (not kvm, vm or vcpu, but
guest_memfd ioctl) that allows userspace to set memory
attributes (shared/private) directly through the guest_memfd. This is the
appropriate interface because shared/private-ness is a property of memory
and hence the request should be sent directly to the memory provider -
guest_memfd.

RFC v4 integrates comments from RFC v3:

+ ZERO is not supported on shared to private conversions
+ Adds KVM_CAP_GUEST_MEMFD_SET_MEMORY_ATTRIBUTES2_FLAGS to enumerate
  supported content modes for a given VM, or all supported content modes if
  no VM is provided
+ Uses flags and not values to specify content modes for conversion
+ Allows architectures to override the content mode application for the
  entire range rather than per-folio: so if actions can be skipped, folio
  iteration can be skipped entirely.
+ Addresses comments from Sashiko [7]

I would like feedback on:

+ Content modes: 0 (MODE_UNSPECIFIED), ZERO, and PRESERVE. Is that all
  good, or does anyone think there is a use case for something else?
+ Should the content modes apply even if no attribute changes are required?
    + See notes added in "KVM: guest_memfd: Apply content modes while
      setting memory attributes"
    + Possibly related: should setting attributes be allowed if some
      sub-range requested already has the requested attribute?
+ Structure of how various content modes are checked for support or
  applied? I used overridable weak functions for architectures that haven't
  defined support, and defined overrides for x86 to show how I think it would
  work. For CoCo platforms, I only implemented TDX for illustration purposes
  and might need help with the other platforms. Should I have used
  kvm_x86_ops? I tried and found myself defining lots of boilerplate.
+ The use of private_mem_conversions_test.sh to run different options in
  private_mem_conversions_test. If this makes sense, I'll adjust the
  Makefile to have private_mem_conversions_test tested only via the script.

TODOs

+ Address locking issue when kvm_gmem_get_attribute() is called from
  kvm_mmu_zap_collapsible_spte(). In this path, KVM's MMU lock is held
  while guest_memfd tries to take filemap_invalidate_lock while looking up
  the attributes xarray.
+ Move guest_memfd_conversions_test.c to only be compiled and tested for
  x86, since it depends so heavily on KVM_X86_SW_PROTECTED_VM's as a
  testing vehicle

This series is based on kvm/next, and here's the tree for your convenience:

https://github.com/googleprodkernel/linux-cc/commits/guest_memfd-inplace-conversion-v4

Older series:

+ RFCv3 is at [6]
+ RFCv2 is at [5]
+ RFCv1 is at [4]
+ Previous versions of this feature, part of other series, are available at
  [1][2][3].

[1] https://lore.kernel.org/all/bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com/
[2] https://lore.kernel.org/all/20250117163001.2326672-6-tabba@google.com/
[3] https://lore.kernel.org/all/b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com/
[4] https://lore.kernel.org/all/cover.1760731772.git.ackerleytng@google.com/T/
[5] https://lore.kernel.org/all/cover.1770071243.git.ackerleytng@google.com/T/
[6] https://lore.kernel.org/r/20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com
[7] https://sashiko.dev/#/patchset/20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89%40google.com

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
Ackerley Tng (26):
      KVM: guest_memfd: Update kvm_gmem_populate() to use gmem attributes
      KVM: guest_memfd: Only prepare folios for private pages
      KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
      KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
      KVM: guest_memfd: Handle lru_add fbatch refcounts during conversion safety check
      KVM: guest_memfd: Introduce default handlers for content modes
      KVM: guest_memfd: Apply content modes while setting memory attributes
      KVM: x86: Add support for applying content modes
      KVM: Add CAP to enumerate supported SET_MEMORY_ATTRIBUTES2 flags
      KVM: selftests: Update framework to use KVM_SET_MEMORY_ATTRIBUTES2
      KVM: selftests: Test using guest_memfd for guest private memory
      KVM: selftests: Test basic single-page conversion flow
      KVM: selftests: Test conversion flow when INIT_SHARED
      KVM: selftests: Test conversion precision in guest_memfd
      KVM: selftests: Test conversion before allocation
      KVM: selftests: Convert with allocated folios in different layouts
      KVM: selftests: Test that truncation does not change shared/private status
      KVM: selftests: Test conversion with elevated page refcount
      KVM: selftests: Test that conversion to private does not support ZERO
      KVM: selftests: Support checking that data not equal expected
      KVM: selftests: Test that not specifying a conversion flag scrambles memory contents
      KVM: selftests: Reset shared memory after hole-punching
      KVM: selftests: Provide function to look up guest_memfd details from gpa
      KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
      KVM: selftests: Update private_mem_conversions_test to mmap() guest_memfd
      KVM: selftests: Add script to exercise private_mem_conversions_test

Sean Christopherson (18):
      KVM: guest_memfd: Introduce per-gmem attributes, use to guard user mappings
      KVM: Rename KVM_GENERIC_MEMORY_ATTRIBUTES to KVM_VM_MEMORY_ATTRIBUTES
      KVM: Enumerate support for PRIVATE memory iff kvm_arch_has_private_mem is defined
      KVM: Stub in ability to disable per-VM memory attribute tracking
      KVM: guest_memfd: Wire up kvm_get_memory_attributes() to per-gmem attributes
      KVM: guest_memfd: Enable INIT_SHARED on guest_memfd for x86 Coco VMs
      KVM: Move KVM_VM_MEMORY_ATTRIBUTES config definition to x86
      KVM: Let userspace disable per-VM mem attributes, enable per-gmem attributes
      KVM: selftests: Create gmem fd before "regular" fd when adding memslot
      KVM: selftests: Rename guest_memfd{,_offset} to gmem_{fd,offset}
      KVM: selftests: Add support for mmap() on guest_memfd in core library
      KVM: selftests: Add selftests global for guest memory attributes capability
      KVM: selftests: Add helpers for calling ioctls on guest_memfd
      KVM: selftests: Test that shared/private status is consistent across processes
      KVM: selftests: Provide common function to set memory attributes
      KVM: selftests: Check fd/flags provided to mmap() when setting up memslot
      KVM: selftests: Update pre-fault test to work with per-guest_memfd attributes
      KVM: selftests: Update private memory exits test to work with per-gmem attributes

 Documentation/virt/kvm/api.rst                     | 136 ++++-
 arch/x86/include/asm/kvm_host.h                    |   2 +-
 arch/x86/kvm/Kconfig                               |  15 +-
 arch/x86/kvm/mmu/mmu.c                             |   4 +-
 arch/x86/kvm/x86.c                                 | 114 ++++-
 include/linux/kvm_host.h                           |  77 ++-
 include/trace/events/kvm.h                         |   4 +-
 include/uapi/linux/kvm.h                           |  22 +
 mm/swap.c                                          |   2 +
 tools/testing/selftests/kvm/Makefile.kvm           |   5 +
 .../selftests/kvm/guest_memfd_conversions_test.c   | 552 ++++++++++++++++++++
 tools/testing/selftests/kvm/guest_memfd_test.c     |  57 ++-
 tools/testing/selftests/kvm/include/kvm_util.h     | 144 +++++-
 tools/testing/selftests/kvm/include/test_util.h    |  34 +-
 .../selftests/kvm/kvm_has_gmem_attributes.c        |  17 +
 tools/testing/selftests/kvm/lib/kvm_util.c         | 130 +++--
 tools/testing/selftests/kvm/lib/test_util.c        |   7 -
 tools/testing/selftests/kvm/lib/x86/sev.c          |   2 +-
 .../testing/selftests/kvm/pre_fault_memory_test.c  |   4 +-
 .../kvm/x86/private_mem_conversions_test.c         |  55 +-
 .../kvm/x86/private_mem_conversions_test.sh        | 128 +++++
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c |  38 +-
 virt/kvm/Kconfig                                   |   3 +-
 virt/kvm/guest_memfd.c                             | 562 ++++++++++++++++++++-
 virt/kvm/kvm_main.c                                | 116 ++++-
 25 files changed, 2047 insertions(+), 183 deletions(-)
---
base-commit: d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
change-id: 20260225-gmem-inplace-conversion-bd0dbd39753a

Best regards,
-- 
Ackerley Tng <ackerleytng@google.com>

