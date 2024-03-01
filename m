Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951656B7A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Mar 2024 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326974; cv=none; b=eSCOkXjYtjJ7EyRN/OsqvLu+M+1AqEodthKDfG8MHoAwbMCnYLFv5Sn9ar6fxpRShtxXNkG/CzYlROZcDIHcYOOgOt6xVMh7EX085okTYEzHLfKEWaW1aEjrsPRdBiayOPeGOwREI20wlo0nkkm3APU4I1x9JOTHQ//InAouvpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326974; c=relaxed/simple;
	bh=JP8gu5UENU6mJQHg17EqcXuGMt1BqsvT7243NQmMnuk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CtWvmjWTf4Itr2aRWC6QdGj9RHqQtIbcskCdjkohrzGNDcobc6aeqUEWtBodhSCsy7e7Skckwec8gWgUSczEi0pFg9SZYkQ+4nbhhKZWWLbwjqs6m2hggrGH+QnjFWA7GE55yhuZS6IT/Vp13SRPlkWb7TxCOfeYfXYd5TZYVFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:db22:6af9:7d18:6ee8])
	by laurent.telenet-ops.be with bizsmtp
	id tZ2e2B0051TWuYv01Z2e2j; Fri, 01 Mar 2024 22:02:44 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1T-0024g2-5S;
	Fri, 01 Mar 2024 22:02:38 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rgA1d-00D8qw-V1;
	Fri, 01 Mar 2024 22:02:37 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-sh@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/20] sh: Fix missing prototypes
Date: Fri,  1 Mar 2024 22:02:14 +0100
Message-Id: <cover.1709326528.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series fixes several "no previous prototype for <foo>"
warnings when building a kernel for SuperH.

Known issues:
  - The various warnings about cache functions are not yet fixed, but
    I didn't want to hold off the rest of this series,
  - sdk7786_defconfig needs "[PATCH/RFC] locking/spinlocks: Make __raw_*
    lock ops static" [1],
  - Probably there are more warnings to fix, I didn't build all
    defconfigs.

This has been boot-tested on landisk and on qemu/rts7751r2d.

Thanks for your comments!

[1] https://lore.kernel.org/linux-sh/c395b02613572131568bc1fd1bc456d20d1a5426.1709325647.git.geert+renesas@glider.be

Geert Uytterhoeven (20):
  sh: pgtable: Fix missing prototypes
  sh: fpu: Add missing forward declarations
  sh: syscall: Add missing forward declaration for sys_cacheflush()
  sh: tlb: Add missing forward declaration for handle_tlbmiss()
  sh: return_address: Add missing #include <asm/ftrace.h>
  sh: traps: Add missing #include <asm/setup.h>
  sh: hw_breakpoint: Add missing forward declaration for
    arch_bp_generic_fields()
  sh: boot: Add proper forward declarations
  sh: ftrace: Fix missing prototypes
  sh: nommu: Add missing #include <asm/cacheflush.h>
  sh: math-emu: Add missing #include <asm/fpu.h>
  sh: dma: Remove unused dmac_search_free_channel()
  sh: sh2a: Add missing #include <asm/processor.h>
  sh: sh7786: Remove unused sh7786_usb_use_exclock()
  sh: smp: Fix missing prototypes
  sh: kprobes: Merge arch_copy_kprobe() into arch_prepare_kprobe()
  sh: kprobes: Make trampoline_probe_handler() static
  sh: kprobes: Remove unneeded kprobe_opcode_t casts
  sh: dwarf: Make dwarf_lookup_fde() static
  [RFC] sh: dma: Remove unused functionality

 arch/sh/boot/compressed/cache.c         |   3 +
 arch/sh/boot/compressed/cache.h         |  10 ++
 arch/sh/boot/compressed/misc.c          |   8 +-
 arch/sh/boot/compressed/misc.h          |   9 ++
 arch/sh/drivers/dma/dma-api.c           | 143 ------------------------
 arch/sh/include/asm/dma.h               |   7 --
 arch/sh/include/asm/fpu.h               |   3 +
 arch/sh/include/asm/ftrace.h            |  10 ++
 arch/sh/include/asm/hw_breakpoint.h     |   2 +
 arch/sh/include/asm/syscalls.h          |   1 +
 arch/sh/include/asm/tlb.h               |   4 +
 arch/sh/kernel/cpu/sh2a/opcode_helper.c |   2 +
 arch/sh/kernel/cpu/sh4a/setup-sh7786.c  |  14 ---
 arch/sh/kernel/dwarf.c                  |   2 +-
 arch/sh/kernel/kprobes.c                |  13 +--
 arch/sh/kernel/return_address.c         |   2 +
 arch/sh/kernel/smp.c                    |   4 +-
 arch/sh/kernel/traps.c                  |  10 +-
 arch/sh/kernel/traps_32.c               |   1 +
 arch/sh/math-emu/math.c                 |   2 +
 arch/sh/mm/nommu.c                      |   2 +
 arch/sh/mm/pgtable.c                    |   4 +-
 arch/sh/mm/tlbex_32.c                   |   1 +
 23 files changed, 68 insertions(+), 189 deletions(-)
 create mode 100644 arch/sh/boot/compressed/cache.h
 create mode 100644 arch/sh/boot/compressed/misc.h

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
