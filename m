Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793719069;
	b=chBIPbwcfGe/kGuiYuhR61jAVDJxjbIx6vlcMKjO2pqr/fcY11gg6HyNRxrecvAuqjLl
	 0CQ/2WS5Hb6FxP9e7LNTkvw/RyQe+8HvK541mVyG5Oy74ZSXUqvqZrV7vN3ARvBOrYi2G
	 H4TsA7NidL/Lt9d+xhl0u51eqWuD9Bbvxm52zqgLwllBJDDYbEcr8a5FxAGa5skRdThVS
	 1yFJa+Bk3dRktpvCFBAxSAsbYe1hoqr4/TgQs0IEa/BcXdxf/sQq0dh6fx2uNvKkJzj2k
	 0VpbYPzddv/m9nfKLUCHyfnbuxbHPKXX1WHFim60zOdCK1VrAW1gCz5SZ/HZAG6CeFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793719069;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:User-Agent;
	bh=Kv57rrW9AR5Uyx8+S36d+hVUEIxbqmnbUnmaj9pRDPc=;
	b=bX+INJ4EjuFk4/Ww4Z8EnAaMGb+7f/7DZ4dB9iZU6Hok+TtGqQHp6IesZwNiDpVdDosT
	 zi3B416tTP6jjD2Iml/FCmi4KzqXJ6ieJBE7j4/+B1beEofvXCXCbrJzx03xDwYMIq2yT
	 MfrXU6iRoMCoOZnzUJU0zFi6W9dJHmiEyWjDp+XR1uDsQxmrPorH/PFUspVtiWg43OQiu
	 BrUUTRuHKcE83kYXMAdFSS/krgOrc+wvaV3iHgt8FWFJqZa4LNpxFJHvz1eDXy1c5BQQN
	 kxgmqDcZrrSSf/4WEDRb9GSs4PHX7ZmLcrfvB7EvI6BJ6liGJ6FSnTDnvLSnB1q9VFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UTWV8h2n;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66990606A793
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Nov 2026 15:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66990606A793
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=UTWV8h2n
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso2158067a91.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Nov 2026 07:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1793719069; x=1794323869; darn=vger.kernel.org;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kv57rrW9AR5Uyx8+S36d+hVUEIxbqmnbUnmaj9pRDPc=;
        b=UTWV8h2nFTZ0eInmgrs3DEF7YRTvpPFa3wXSTzrgbTJdxS8o6LX18nP95bFPdtGbel
         mhOBG2L0OGKLRHHR5Df5WGSB4ANOi/n6F8HnF4gGjy7OOMbjUQlof9V2g4MRUDoAwbYS
         /cttKPQyPKLAjztUy3DJqrlEkWxeSKvdMeTW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793719069; x=1794323869;
        h=user-agent:content-disposition:content-type:mime-version:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kv57rrW9AR5Uyx8+S36d+hVUEIxbqmnbUnmaj9pRDPc=;
        b=M9Q77cu0czONfBPBFUbafvnXN0lKd5sk3ox4K5iqX6H9gEC//Z4WUEN4FJdNdwrLrE
         sICoIMOykDZjs9ukEDf/ipp9JLpuTkHtN1LopWmiXBh1TRCA/DIf24P8ZQYVrGkQ0nqa
         iipaULCE4l4CRzl/5+nnjvxTpqTfO/krNiiSEyHkxjKvUUSdvmELEjtcGOJnkyhGVmn1
         ECX+n77ijGWDiGG8mfEAlC31QflLIqLVXyRYjTeDasBTAYccds8Jjdm6AUn4QsO73Vk2
         WILlLYvNhRpCyKvLHIbTzfWqYVrapznOP5HixP9enl20eH/jKHM7+e1BpEwY9/nSbf+T
         qLGg==
X-Forwarded-Encrypted: i=1; AKwUvBwuKcjIfsNVYS+usJtu9hpzL+SJ38ZGNuSHSiul9d119UzP8mZP/HxKH04J0mr8lfs4o8PjUhqFllPMwMx0zseW5uc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Qkro38zotc5elGm1CY0GP7iS1hdPR3HnRIL9OqV+H8++v37Af
	pM4SYOsGMuoQkX88wxVQB2T9fsYH+jvVRiiEnZyoWj52/CwhW0Ts8DfeSM3e1j0h5d0=
X-Gm-Gg: AYBFou28lbtXfMNFn72WgMWdlci2KuXVre8ys7UgO9gii65DTiXB5I+0V9JLKD4JYdF
	gzcyha/MZZTYa2DSJ3JGh4yaREkxkO7PfRpct3CqMSMy8soI/qZkd8LOW6v29OJElGg8CtcuQ8V
	dqcOhrd2IqeTYpwuH+aIM01grsSNlz0CYyrCXK7tNQJP7mKwWkFq1+4te1OTBgZFvZg+pCIPooA
	uEGcXWs6H0AwgOBIfBwgYwId/V/EmjB2X48o4Z7BWo+i0fgxbMxyCc/kpkSkjK7ktpcs2ENMrnc
	YaTMoqo3tyE3ZZHFC7gerFMdHF1QangwR9eHuqcisswmX09NZQfCoClnN+h9RdcrsC36gyAsiHD
	dt3d+qdffq9DPTx4NuGi5vKPGAPEWsegB+coI4a6wNvKfEeWkc3N6zq2clJij84MBpJAd0rejb9
	gKN5A3jRTmxyhZr34MlX9hSjBC7JPTtJpGfc0x4CTumJpv7rW7lUeW7fWV/ohXHA/rbEumWft+o
	tRfSelEdbHH6jREWuo+cE/z7OS0SJCx1NACOAtD+BzJKq0HbV5uMK5jl0M1Qb/0m8fFYSy5Nhyz
	GktVmVafVwnQ1HfQrX9J0cl3lm/MXXsLKxRJUcNDiKurmdMIOmT0LGQx74PF/kfofvRD/kRHOyf
	qs6koyVl4V9K31AgcUD7ZZLu4ewYMKStMFBsRz/Bfze6GIxcvXjy0glPkmryqJr0DkFLkX7vNh5
	ZFcA8HqLkuqQc/lsQIEw==
X-Received: by 2002:a17:90b:3f84:b0:3ab:b39f:41da with SMTP id 98e67ed59e1d1-3ae89776af6mr10813768a91.11.1793719068633;
        Tue, 03 Nov 2026 07:17:48 -0800 (PST)
Received: from localhost ([116.86.153.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c62984bsm4849760a91.9.2026.11.03.07.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 07:17:47 -0800 (PST)
Date: Tue, 3 Nov 2026 23:17:43 +0800
From: Chris Down <chris@chrisdown.name>
To: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Kees Cook <kees@kernel.org>,
	Andrey Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Shuah Khan <shuah@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>, linux-mm@kvack.org,
	linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: [PATCH v2 0/8] mseal sysmap: Choose system mapping sealing at boot
Message-ID: <cover.1793718940.git.chris@chrisdown.name>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.3.3 (9073d26d) (2026-06-12)

System mapping sealing is currently a build time choice. Hosts which
want it and hosts which need to move or unmap these mappings therefore
need separate kernels, which is not ideal. Let's allow the administrator
to choose at boot time.

v2:

- Skip destructive vDSO tests on unsealed 32-bit x86 mappings
- Move the sysmap tests into selftests/mm (Lorenzo)
- Use shared vm_util helpers in the sysmap tests (Lorenzo)
- Use PROCMAP_QUERY for the vDSO lookup (Lorenzo)
- Keep test changes in separate patches (Lorenzo)
- Put the enforcement tests before the kernel changes (Lorenzo)
- Move MSEAL_SYSTEM_MAPPINGS to mm/Kconfig (Lorenzo)
- Remove VM_SEALED_SYSMAP (Lorenzo)
- Seal mappings in __install_special_mapping() (Lorenzo)
- Leave a sealed uprobe trampoline mapped if optimisation fails
- Replace the boolean parameter with no_mseal_sys_mappings (Lorenzo)
- Drop MSEAL_SYSTEM_MAPPINGS_DEFAULT_ON (Lorenzo)
- Drop the CHECKPOINT_RESTORE dependency (Lorenzo)
- Document the software which sealing breaks (Lorenzo)
- Keep Kconfig default-n regardless of CHECKPOINT_RESTORE (Andrei)
- Retain sealing by default when built in, with no_mseal_sys_mappings as
  the boot-time opt-out (Lorenzo)
- Explain the security rationale (Lorenzo)
- Describe the Meta/Reverie use case (Lorenzo)
- Skip general checks on unsealed kernels (Lorenzo)
- Add expect_sealed for strict CI checks (Jeff)
- Use the existing -T filter to exclude strict checks when needed (Jeff)
- Test that no_mseal_sys_mappings leaves mappings unsealed (Jeff)
- Add the vDSO mprotect() enforcement test (Jeff)

v1: https://lore.kernel.org/r/cover.1793094611.git.chris@chrisdown.name

Chris Down (8):
  selftests/mm: Move sysmap_is_sealed into mm
  selftests/mm: Skip sysmap_is_sealed when system mappings aren't sealed
  selftests/mm: Test that the seal on system mappings is enforced
  mm/mseal: Move MSEAL_SYSTEM_MAPPINGS to mm/Kconfig
  uprobes/x86: Leave sealed trampolines in place on optimisation failure
  mm/mseal: Seal system mappings in __install_special_mapping()
  mm/mseal: Add no_mseal_sys_mappings boot parameter
  selftests/mm: Check that no_mseal_sys_mappings unseals system mappings

 .../admin-guide/kernel-parameters.txt         |   7 +
 Documentation/userspace-api/mseal.rst         |  12 +-
 arch/arm64/kernel/vdso.c                      |   9 +-
 arch/loongarch/kernel/vdso.c                  |   3 +-
 arch/riscv/kernel/vdso.c                      |   2 +-
 arch/s390/kernel/vdso.c                       |   2 +-
 arch/x86/entry/vdso/vma.c                     |   5 +-
 arch/x86/kernel/uprobes.c                     |   2 +-
 include/linux/mm.h                            |   6 -
 init/Kconfig                                  |   5 +-
 kernel/events/uprobes.c                       |   2 +-
 lib/vdso/datastore.c                          |   2 +-
 mm/Kconfig                                    |  23 ++
 mm/mseal.c                                    |  12 +
 mm/vma.c                                      |   2 +
 mm/vma.h                                      |   8 +
 security/Kconfig                              |  21 --
 tools/testing/selftests/Makefile              |   1 -
 tools/testing/selftests/mm/Makefile           |   1 +
 tools/testing/selftests/mm/config             |   1 +
 tools/testing/selftests/mm/run_vmtests.sh     |   6 +
 tools/testing/selftests/mm/sysmap_is_sealed.c | 259 ++++++++++++++++++
 tools/testing/selftests/mm/vm_util.c          |   5 +
 tools/testing/selftests/mm/vm_util.h          |   1 +
 .../mseal_system_mappings/.gitignore          |   2 -
 .../selftests/mseal_system_mappings/Makefile  |   6 -
 .../selftests/mseal_system_mappings/config    |   1 -
 .../mseal_system_mappings/sysmap_is_sealed.c  | 119 --------
 28 files changed, 345 insertions(+), 180 deletions(-)
 create mode 100644 tools/testing/selftests/mm/sysmap_is_sealed.c
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/.gitignore
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/Makefile
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/config
 delete mode 100644 tools/testing/selftests/mseal_system_mappings/sysmap_is_sealed.c


base-commit: 734a9da61a5bc5d82b496a86bacc097d11dc6871
-- 
2.54.0

