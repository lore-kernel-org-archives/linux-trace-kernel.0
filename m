Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D333D4E5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Mar 2026 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773382368; cv=none; b=R5qQwmTwkTsHQhFUxrSB78Hi5rKI6SSkA9nXCUWeR+5ANEHdOdWJ2nCuM1ub5s29KnIoMPicoFXa+Z7YM0ehhWz9Valmq52FXXcBlXI9fAQZYYEe8gttYvy2iWo6h5vNccDy+J/wQrJKc+3rSwmBxigsZ9X2W2cT5ZnBb9tiGVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773382368; c=relaxed/simple;
	bh=6jLTwJJ6La/XT5hYqS1Mn28fhE67q33wjf2y4GPKqTo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oac7wi5ZZAXoCetihB8QvkRgFbD/mYx38eyeo7GbZc6rC5lfDfuFjzGEdkJxWZMhOTTu40NH6IApdv7fsLmHzblOvLFXwcqvZ6Nui9KYB6cWY+okfEo4Pji9uF7HXYRbaXqSvfPClaAYRi4A6mr1UbkzjSrmKXluZAo0iof5JR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WoALvbo7; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WoALvbo7"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-354490889b6so7914406a91.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 23:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773382367; x=1773987167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9kJoH2qMBOGI1KHefVTQiaQSpz0G/4rWY3svDZEsAos=;
        b=WoALvbo7IccPEcJrsXwQJu1rWB+Zl7Q+hymhMJE0QVh+BzO6OR6UVeFyOwXEQ97uwI
         q7QX6YToBCVgc8m9sS3FCC/CoNk+9e7UzhOhYn8zgmRKzTGJ9oTTQGX2a1hMmS1VVgb7
         VoMyJESm9qf+bjtKiXcDDqmKjOAM9z6Y7d9ko9YnypLYsbaYcssv7BwNkFFP5IyvBcLS
         UeHU6Rws726tBQ5Aj1IgJqk/Vp0Kn82bC8HpWhoH4nVzpiuL/d3P/EAvLpgzwTeu3nPL
         lr5xSr1Kdd4JOMczt44VBXXiWNGmecpZuUVPa8FeWIX6/JBV4kW13u2JqExv3rPEqJhD
         O7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773382367; x=1773987167;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kJoH2qMBOGI1KHefVTQiaQSpz0G/4rWY3svDZEsAos=;
        b=IXmU+EByJ6NNNrgyWmwQJ2pXxZZMLHSCJFkJXp8/FJw0GSSheRelGYi2FkU6Ih94Tl
         Vikm9ktR37GZWTu7RaxWkydZ2sAYknayjw4T0/1x34+266OYTPq0Ck9YB/Ndy8z+rjv4
         YEUdaakGbRbNr1+76VqIQMJwjMMG3l/1USlv/tMhRqHlm2T0sOIESHwCW7mnFhMWQFVh
         arfYfhKSU1CbybSQRcvkrjFukLNJ19SqThCGeb4AHNDqZ4lB2BN4mSRuRnKM3DtX53zO
         zK3gY2bOZUIZRqTwwy8rvbYjVyCZM+2WqtNhcbndTcDqsulfe+vJ9XA2JwAeh/WG49Rr
         yY4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU95I70hv+o416kp/v9O8yxcw2VlhTN8L2ddDm1aqq9ht2+y1Nd0dfGUjzHNPDdS8CTKWVE6Fi700yhrMSiSAmIAtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtNxGEP86NeLyG2O7a+K4HI5RXSWuPeAxol4k3c5DqWPiuqY8T
	WsFpOZ8kPtdtJjVtREM8rXxhRt9Erq5psCSmRXfyPST7M+v61Xpqqq1bOJ3G4w+PJ6LSLwAiwoa
	DzKjw4cVbYuaxcN11dWyjf3UkEA==
X-Received: from pjbsx11.prod.google.com ([2002:a17:90b:2ccb:b0:359:97db:ab44])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2e45:b0:349:9d63:8511 with SMTP id 98e67ed59e1d1-35a22069e33mr1825521a91.25.1773382366345;
 Thu, 12 Mar 2026 23:12:46 -0700 (PDT)
Date: Fri, 13 Mar 2026 06:12:39 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANiqs2kC/x2MywrCMBAAf6Xs2cWQUEWvgh/Qq/SQx9oumm1JJ
 BRK/72pxxmYWSFTYspwb1ZIVDjzJBXMqQE/WhkIOVQGrfRFad3iECkiy/y1ntBPUigdDbqgggv mdm2NhVrPid68/M8v6J4P6Kt0NhO6ZMWPx/RT4llo+cG27eBUK4aJAAAA
X-Change-Id: 20260225-gmem-inplace-conversion-bd0dbd39753a
X-Developer-Key: i=ackerleytng@google.com; a=ed25519; pk=sAZDYXdm6Iz8FHitpHeFlCMXwabodTm7p8/3/8xUxuU=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773382364; l=10749;
 i=ackerleytng@google.com; s=20260225; h=from:subject:message-id;
 bh=6jLTwJJ6La/XT5hYqS1Mn28fhE67q33wjf2y4GPKqTo=; b=TVC5sVfChj6/Qi4neLLDvvRGE6Wv9Rt992E8IUuFi9rGngGrAXraI2dmVoDFP5O3H1h0d/EsW
 wWRxu0+w/hOBaK6JILUwNt7nNWAQBb5O4jKE76hTO8bRdXaMsT7oVzx
X-Mailer: b4 0.14.3
Message-ID: <20260313-gmem-inplace-conversion-v3-0-5fc12a70ec89@google.com>
Subject: [PATCH RFC v3 00/43] guest_memfd: In-place conversion support
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
	Shuah Khan <shuah@kernel.org>, Vishal Annapurve <vannapurve@google.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Vlastimil Babka <vbabka@kernel.org>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
Content-Type: text/plain; charset="utf-8"

Hi,

(Here's the motivation for this series, which I realized was missing from
the earlier revisions of this series)

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

I'm intending RFC (v3) as a basis for discussion of flags/content
modes (name TBD) to allow userspace to request guarantees on how the memory
contents will look like after setting memory attributes. The last 6 patches
implement content mode support. These patches will be reordered, and some
of them could be absorbed into earlier patches, in later revisions.

Here are the discussion points I can think of (please add on):

1. (Might hopefully resolve soon?) Should ZERO be supported on shared to
   private conversions? Discussion is at [6].

2. Do we need a CAP for userspace to query the flags/modes supported?

   It seems like there won't be anything dynamic about the flags/modes
   supported.

   The userspace code can check what platform it is running on, and then
   decide ZERO or PRESERVE based on the platform:

   If the VM is running on TDX, it would want to specify ZERO all the
   time. If the VM were running on pKVM it would want to specify PRESERVE
   if it wants to enable in-place sharing, and ZERO if it wants to zero the
   memory.

   If someday TDX supports PRESERVE, then there's room for discovery of
   which algorithm to choose when running the guest. Perhaps that's when
   the CAP should be introduced?

3. What do people think of the structure of how various content modes are
   checked for support or applied? I used overridable weak functions for
   architectures that haven't defined support, and defined overrides for
   x86 to show how I think it would work. For CoCo platforms, I only
   implemented TDX for illustration purposes and might need help with the
   other platforms. Should I have used kvm_x86_ops? I tried and found
   myself defining lots of boilerplate.

4. enum for ZERO and PRESERVE?

   Pros:

   * No way to define both ZERO and PRESERVE (make impossible states
     unrepresentable)
       * e.g. enum kvm_device_type in __u32 type in struct
         kvm_create_device
       * But maybe someday some modes can be used together?
   * Content modes is a defined axis/aspect of setting memory attributes,
     having a separate field avoids having different axes of configuration
     in one field. e.g. MAP_HUGETLB for mmap() is on a different axis from
     MAP_PRIVATE for example
       * I just used flags for this RFC since it's the most common
         approach.

TODOs:

+ Let architectures override content mode handlers on a per-inode basis
  since per-folio overrides means even no-ops, like ZERO on TDX, would
  require iterating all the folios.

Also, in RFC v3, TEST_EXPECT_SIGBUS() is updated to assert that the default
signal handler is installed, so that developers get a clear, explicit
failure if/when something goes wrong.

This series is based on kvm/next, and here's the tree for your convenience:

https://github.com/googleprodkernel/linux-cc/commits/guest_memfd-inplace-conversion-v3

Older series:

+ RFCv2 is at [5]
+ RFCv1 is at [4]
+ Previous versions of this feature, part of other series, are available at
  [1][2][3].

[1] https://lore.kernel.org/all/bd163de3118b626d1005aa88e71ef2fb72f0be0f.1726009989.git.ackerleytng@google.com/
[2] https://lore.kernel.org/all/20250117163001.2326672-6-tabba@google.com/
[3] https://lore.kernel.org/all/b784326e9ccae6a08388f1bf39db70a2204bdc51.1747264138.git.ackerleytng@google.com/
[4] https://lore.kernel.org/all/cover.1760731772.git.ackerleytng@google.com/T/
[5] https://lore.kernel.org/all/cover.1770071243.git.ackerleytng@google.com/T/
[6] https://lore.kernel.org/all/CAEvNRgFUc+9xCoN9Yo5NThHrvbccWAhPwp9nNM2fvx7QqrcJsg@mail.gmail.com/

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
Ackerley Tng (25):
      KVM: guest_memfd: Update kvm_gmem_populate() to use gmem attributes
      KVM: Introduce KVM_SET_MEMORY_ATTRIBUTES2
      KVM: guest_memfd: Add support for KVM_SET_MEMORY_ATTRIBUTES2
      KVM: guest_memfd: Handle lru_add fbatch refcounts during conversion safety check
      KVM: selftests: Update framework to use KVM_SET_MEMORY_ATTRIBUTES2
      KVM: selftests: Test using guest_memfd for guest private memory
      KVM: selftests: Test basic single-page conversion flow
      KVM: selftests: Test conversion flow when INIT_SHARED
      KVM: selftests: Test indexing in guest_memfd
      KVM: selftests: Test conversion before allocation
      KVM: selftests: Convert with allocated folios in different layouts
      KVM: selftests: Test precision of conversion
      KVM: selftests: Test that truncation does not change shared/private status
      KVM: selftests: Test conversion with elevated page refcount
      KVM: selftests: Reset shared memory after hole-punching
      KVM: selftests: Provide function to look up guest_memfd details from gpa
      KVM: selftests: Make TEST_EXPECT_SIGBUS thread-safe
      KVM: selftests: Update private_mem_conversions_test to mmap() guest_memfd
      KVM: selftests: Add script to exercise private_mem_conversions_test
      KVM: guest_memfd: Introduce default handlers for content modes
      KVM: guest_memfd: Apply content modes while setting memory attributes
      KVM: x86: Add support for applying content modes
      KVM: x86: Support content mode ZERO for TDX
      KVM: selftests: Allow flags to be specified in set_memory_attributes functions
      KVM: selftests: Update tests to use flag-enabled library functions

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
      KVM: selftests: Update private memory exits test work with per-gmem attributes

 Documentation/virt/kvm/api.rst                     | 112 ++++-
 arch/x86/include/asm/kvm_host.h                    |   2 +-
 arch/x86/kvm/Kconfig                               |  15 +-
 arch/x86/kvm/mmu/mmu.c                             |   4 +-
 arch/x86/kvm/x86.c                                 |  86 +++-
 include/linux/kvm_host.h                           |  62 ++-
 include/trace/events/kvm.h                         |   4 +-
 include/uapi/linux/kvm.h                           |  21 +
 tools/testing/selftests/kvm/.gitignore             |   1 +
 tools/testing/selftests/kvm/Makefile.kvm           |   1 +
 .../selftests/kvm/guest_memfd_conversions_test.c   | 496 +++++++++++++++++++++
 tools/testing/selftests/kvm/guest_memfd_test.c     |  57 ++-
 tools/testing/selftests/kvm/include/kvm_util.h     | 136 +++++-
 tools/testing/selftests/kvm/include/test_util.h    |  32 +-
 tools/testing/selftests/kvm/lib/kvm_util.c         | 130 +++---
 tools/testing/selftests/kvm/lib/test_util.c        |   7 -
 .../testing/selftests/kvm/pre_fault_memory_test.c  |   2 +-
 .../kvm/x86/private_mem_conversions_test.c         |  54 ++-
 .../kvm/x86/private_mem_conversions_test.py        | 152 +++++++
 .../selftests/kvm/x86/private_mem_kvm_exits_test.c |  36 +-
 virt/kvm/Kconfig                                   |   3 +-
 virt/kvm/guest_memfd.c                             | 488 +++++++++++++++++++-
 virt/kvm/kvm_main.c                                | 104 ++++-
 23 files changed, 1831 insertions(+), 174 deletions(-)
---
base-commit: d2ea4ff1ce50787a98a3900b3fb1636f3620b7cf
change-id: 20260225-gmem-inplace-conversion-bd0dbd39753a

Best regards,
--
Ackerley Tng <ackerleytng@google.com>

