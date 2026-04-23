Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5223D8119
	for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776927633; cv=none; b=Bwvi4bxp7c5qN7pLU4xJjcksGVZu1aHu6mBh+jbo3r7dcR0AGx31BHl3XIVh2CqjixdgLpDaEBTMZs7YRaHhw29acG4KXF9jGmeSrOcNA9IfH1j3QpBoJKP0nZn3PkExMbOFlggl2iWesX0WuVGm0K3S9T1sX+A1RWIIWb3lDBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776927633; c=relaxed/simple;
	bh=fr2Dy7vz+z+wrLdzDGn1rkWbs5VAwvGz8Yp7Etv4eYY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=R1M6/E6bDick2T53Txrvm/vBJQAdetIhPRF0a3TwfOfxLq+i9xZwoTEFMhkqu1r/vXfZYu0Oyx4K8hYlu4ye1DRVLVs2+VFSpm3RdW9A7eLLZf7quUCBR2nD4xDI1B+tGHLIfii+tnjlBUbOrl7KqLaSuGSyZFCwKuda/JNRhcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvfuSHdk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvfuSHdk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b4583f0a1aso39808145ad.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Apr 2026 00:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776927630; x=1777532430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/FDcYdMEVgX0UUwJJspOEqoP3UMTSsUAQZWMt+ZF0X8=;
        b=VvfuSHdksmD1OjEEdy1tOW04uqyXDGiFZRvd1Pf4it2iDBT+UWB4IRaVYdSyovzJAk
         SA9JwlqhqsimE15xo0KbYencbDintk2/OMCYHIEPanxyzU4NZGF5HUVE32/ftPT8ihkT
         bFBh/t3KNtP+frpbmBByTu6cGTMvRwmcLpc6dBsF9FdNRigIdPuW30IXAq24UruwkAnd
         gAK8WU+aErVJdbASMNAr4EbM/t3bZHJc0UqO0Y06ntf+kxZPjIXt92Yo4bFuBoJJax5g
         digWTFF4w9OA7Apcx7/0ECWGXWMeUk/XopgbmznSBxCBnoydPaGCR9NzR9Jehxwxh3IA
         ffnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776927630; x=1777532430;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FDcYdMEVgX0UUwJJspOEqoP3UMTSsUAQZWMt+ZF0X8=;
        b=ZrnTGy+X/+gdAlMzl6xIOTbpZqZYca2NeLReASrD09zEQZR6s/jx8L05WMKl6t+BXw
         RiXvqxDfPlN1NSW79Dj1ZxOBNEIR0qQpeVmQPJc34etzjdPHupdF69PjlBVCXpEVbWEL
         mPApsA6w111jYEM4peUSm3tO0bAhvRyj/WW7qVjJbCRAAombKxdm9P7FOgQjbsAbmsN/
         UOVQJyI5hMH0DhAOqUEwRtIfTydUgEd71GsAwyoklb4bmC5FN4skP5YUX22cKUWh65V5
         FMSUggZQyqt7Uqzi6S+Hi6FiUzekNDHDvbsQ6fEC4ezkwG1YAm+7z3HpDkN2tVTVKCVg
         dXpQ==
X-Forwarded-Encrypted: i=1; AFNElJ/N0MrDEPTLkDgfcIWcFOQVZ+kTX+P+Dd9RU5tcKjneJXqnKvOFM8laIR76Ue7eTCQvtwttaFyfrB7GhXThT9ZTWFs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx07xD0kt4c8iiLPnUEk4Gl+L7xtuqppX+T0yliIbXNcgUwL17R
	piDrq44/hPYH7NW+fd9q0O+coe+8nYz8F6AXPieNPeWYTEId9iycC1k9
X-Gm-Gg: AeBDiesWNDi8q/ELb7vDuNSeo5s1zOxqT3opCasYdMrZzTn2Ffkt6azdpR6UHKOxO5Y
	EE6D1IureXega+BQH13APJQVUCmn0GjnCHSDAqrvNB4hFF3Taiuv/g3DfxUolUKdpvkJCZzMcRw
	4PJQm5dbsNKOiB9iG6fRb7dvRE7hc2+MKnMqVcdThyUwVU/REQN9S15dWSeYZk2MZKDtvnpsH/V
	CkhDs956jaK9vhZ5omiv/M6GfQdff2u1Y2wIX0YFBTTQ7LTO2X7KouPm1aME7b5erSD3IsMjB1s
	14dpxSRKmzfY/VyEd2hxo/F4ldL5gqVbmdjMFaUpD+07h11ER/wIMCM3GNXpmr2fng52uNU94MD
	SqUJG7JWpaCaXscIbARqHAb86EHvjnFmPSv4LR+H3r/8UmJpuAXouJ9B8P+sSmmL3MeZeGKGgnT
	zwd2eqjsL9ImwGy32JXeYTgXUdoh9MgR3Tca2P2CRfKI9DkNs=
X-Received: by 2002:a17:902:da89:b0:2b0:ba14:fc55 with SMTP id d9443c01a7336-2b5f9fa70camr289653425ad.29.1776927629301;
        Thu, 23 Apr 2026 00:00:29 -0700 (PDT)
Received: from ?IPV6:2604:3d08:9582:1100::3781? ([2604:3d08:9582:1100::3781])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2e5cesm220351645ad.25.2026.04.23.00.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2026 00:00:28 -0700 (PDT)
Message-ID: <71da148c-d02c-41f4-80da-b90815ffc313@gmail.com>
Date: Thu, 23 Apr 2026 00:00:25 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Indu Bhagat <ibhagatgnu@gmail.com>
Subject: Re: [PATCH v13 00/18] unwind_deferred: Implement sframe handling
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
 Steven Rostedt <rostedt@kernel.org>, Jens Remus <jremus@linux.ibm.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Andrii Nakryiko <andrii@kernel.org>, "Jose E. Marchesi" <jemarch@gnu.org>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
 Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>,
 Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 ibhagatgnu@gmail.com
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260127150554.2760964-1-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On Tue, Jan 27, 2026 at 7:32 AM Jens Remus <jremus@linux.ibm.com> wrote:
>
> This is the implementation of parsing the SFrame V3 stack trace information
> from an .sframe section in an ELF file.  It's a continuation of Josh's and
> Steve's work that can be found here:
>
>    https://lore.kernel.org/all/cover.1737511963.git.jpoimboe@kernel.org/
>    https://lore.kernel.org/all/20250827201548.448472904@kernel.org/
>
> Currently the only way to get a user space stack trace from a stack
> walk (and not just copying large amount of user stack into the kernel
> ring buffer) is to use frame pointers. This has a few issues. The biggest
> one is that compiling frame pointers into every application and library
> has been shown to cause performance overhead.
>
> Another issue is that the format of the frames may not always be consistent
> between different compilers and some architectures (s390) has no defined
> format to do a reliable stack walk. The only way to perform user space
> profiling on these architectures is to copy the user stack into the kernel
> buffer.
>
> SFrame [1] is now supported in binutils (x86-64, ARM64, and s390). There is
> discussions going on about supporting SFrame in LLVM. SFrame acts more like
> ORC, and lives in the ELF executable file as its own section. Like ORC it
> has two tables where the first table is sorted by instruction pointers (IP)
> and using the current IP and finding it's entry in the first table, it will
> take you to the second table which will tell you where the return address
> of the current function is located and then you can use that address to
> look it up in the first table to find the return address of that function,
> and so on. This performs a user space stack walk.
>
> Now because the .sframe section lives in the ELF file it needs to be faulted
> into memory when it is used. This means that walking the user space stack
> requires being in a faultable context. As profilers like perf request a stack
> trace in interrupt or NMI context, it cannot do the walking when it is
> requested. Instead it must be deferred until it is safe to fault in user
> space. One place this is known to be safe is when the task is about to return
> back to user space.
>
> This series makes the deferred unwind user code implement SFrame format V3
> and enables it on x86-64.
>
> [1]: https://sourceware.org/binutils/wiki/sframe
>
>
> This series applies on top of the tip perf/core branch:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  perf/core
>
> The to be stack-traced user space programs (and libraries) need to be
> built with the recent SFrame stack trace information format V3, as
> generated by the upcoming binutils 2.46 with assembler option --gsframe.
> It can be built from source from the binutils-2_46-branch branch:
>
>   git://sourceware.org/git/binutils-gdb.git  binutils-2_46-branch
>
> Namhyung Kim's related perf tools deferred callchain support can be used
> for testing ("perf record --call-graph fp,defer" and "perf report/script").
>
>
> Changes since v12 (see patch notes for details):
> - Rebase on tip perf/core branch (d55c571e4333).
> - Add support for SFrame V3, including its new flexible FDEs.  SFrame V2
>   is not supported.
>
> Changes since v11 (see patch notes for details):
> - Rebase on tip master branch (f8fdee44bf2f) with Namhyung Kim's
>   perf/defer-callchain-v4 branch merged on top.
> - Adjust to Peter's latest undwind user enhancements.
> - Simplify logic by using an internal SFrame FDE representation, whose
>   FDE function start address field is an address instead of a PC-relative
>   offset (from FDE).
> - Rename struct sframe_fre to sframe_fre_internal to align with
>   struct sframe_fde_internal.
> - Remove unused pt_regs from unwind_user_next_common() and its
>   callers. (Peter)
> - Simplify unwind_user_next_sframe(). (Peter)
> - Fix a few checkpatch errors and warnings.
> - Minor cleanups (e.g. move includes, fix indentation).
>
> Changes since v10:
> - Support for SFrame V2 PC-relative FDE function start address.
> - Support for SFrame V2 representing RA undefined as indication for
>   outermost frames.
>
>
> Patches 1, 4, 11, and 17 have been updated to exclusively support the
> latest SFrame V3 stack trace information format, that is generated by
> the upcoming binutils 2.46 release.  Old SFrame V2 sections get rejected
> with dynamic debug message "bad/unsupported sframe header".
>
> Patches 7 and 8 add support to unwind user (sframe) for outermost frames.
>
> Patches 12-15 add support to unwind user (sframe) for the new SFrame V3
> flexible FDEs.
>
> Patch 16 improves the performance of searching the SFrame FRE for an IP.
>

Thanks Jens for your work on this. Apart from some of those minor 
renames you are already planning on doing (as you mentioned in the 
meeting today), the SFrame related bits look OK to me.

Reviewed-by: Indu Bhagat <ibhagatgnu@gmail.com>

> Regards,
> Jens
>
>
> Jens Remus (7):
>   unwind_user: Stop when reaching an outermost frame
>   unwind_user/sframe: Add support for outermost frame indication
>   unwind_user: Enable archs that pass RA in a register
>   unwind_user: Flexible FP/RA recovery rules
>   unwind_user: Flexible CFA recovery rules
>   unwind_user/sframe: Add support for SFrame V3 flexible FDEs
>   unwind_user/sframe: Separate reading of FRE from reading of FRE data
>     words
>
> Josh Poimboeuf (11):
>   unwind_user/sframe: Add support for reading .sframe headers
>   unwind_user/sframe: Store .sframe section data in per-mm maple tree
>   x86/uaccess: Add unsafe_copy_from_user() implementation
>   unwind_user/sframe: Add support for reading .sframe contents
>   unwind_user/sframe: Detect .sframe sections in executables
>   unwind_user/sframe: Wire up unwind_user to sframe
>   unwind_user/sframe: Remove .sframe section on detected corruption
>   unwind_user/sframe: Show file name in debug output
>   unwind_user/sframe: Add .sframe validation option
>   unwind_user/sframe/x86: Enable sframe unwinding on x86
>   unwind_user/sframe: Add prctl() interface for registering .sframe
>     sections
>
>  MAINTAINERS                               |   1 +
>  arch/Kconfig                              |  23 +
>  arch/x86/Kconfig                          |   1 +
>  arch/x86/include/asm/mmu.h                |   2 +-
>  arch/x86/include/asm/uaccess.h            |  39 +-
>  arch/x86/include/asm/unwind_user.h        |  69 +-
>  arch/x86/include/asm/unwind_user_sframe.h |  12 +
>  fs/binfmt_elf.c                           |  48 +-
>  include/linux/mm_types.h                  |   3 +
>  include/linux/sframe.h                    |  60 ++
>  include/linux/unwind_user.h               |  18 +
>  include/linux/unwind_user_types.h         |  46 +-
>  include/uapi/linux/elf.h                  |   1 +
>  include/uapi/linux/prctl.h                |   6 +-
>  kernel/fork.c                             |  10 +
>  kernel/sys.c                              |   9 +
>  kernel/unwind/Makefile                    |   3 +-
>  kernel/unwind/sframe.c                    | 840 ++++++++++++++++++++++
>  kernel/unwind/sframe.h                    |  87 +++
>  kernel/unwind/sframe_debug.h              |  68 ++
>  kernel/unwind/user.c                      | 105 ++-
>  mm/init-mm.c                              |   2 +
>  22 files changed, 1414 insertions(+), 39 deletions(-)
>  create mode 100644 arch/x86/include/asm/unwind_user_sframe.h
>  create mode 100644 include/linux/sframe.h
>  create mode 100644 kernel/unwind/sframe.c
>  create mode 100644 kernel/unwind/sframe.h
>  create mode 100644 kernel/unwind/sframe_debug.h
>
> --
> 2.51.0
>
>
