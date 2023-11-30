Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE9F20DCF
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UraiEC+0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0995C433C7;
	Thu, 30 Nov 2023 12:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701346544;
	bh=1NPXRHfCmv3muigvSa8lBUFSABkyhpUQba/UEEWr/rM=;
	h=From:To:Cc:Subject:Date:From;
	b=UraiEC+0QfcuybZdyWf77r8dRXNuwqKPlsmovyA/HvHKNSE2PDXUCtfDBU8T68jqW
	 zxEKr4hNGcnDOaPXu4C4xhfi7mP5vO+f09oHk4/lej/LLoB6WRdZw3jZvmrbiyF3u1
	 And2p+iR8RhiMbB1QbhwONyweWsjl/QRfK+uA51E2i/GyaDi7anOFcRdyHT2Z8sjmi
	 mpGED66jC56FrIQO0aSqBzezxrvITqL5riM9hDjkARae3MWYZ1iS6j4z0sV2PqwXB9
	 ZvT5apIey29b7b8eA04UgAvV/wEH2ePnTo8UCSwxB0gq54z3vMhY3a58/T9VyzcKaO
	 F9zd6U4HJufEw==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Song Shuai <suagrfillet@gmail.com>,
	Guo Ren <guoren@kernel.org>,
	linux-riscv@lists.infradead.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	songshuaishuai@tinylab.org
Subject: [PATCH v12 for-next 0/4] riscv: ftrace: Miscellaneous ftrace improvements
Date: Thu, 30 Nov 2023 13:15:27 +0100
Message-Id: <20231130121531.1178502-1-bjorn@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Björn Töpel <bjorn@rivosinc.com>

NB! Song told me that he would not have the time work on this series,
so I picked it up.

This series includes a three ftrace improvements for RISC-V:

1. Do not require to run recordmcount at build time (patch 1)
2. Simplification of the function graph functionality (patch 2)
3. Enable DYNAMIC_FTRACE_WITH_DIRECT_CALLS (patch 3 and 4)

The series has been tested on Qemu/rv64 virt/Debian sid with the
following test configs:
  CONFIG_FTRACE_SELFTEST=y
  CONFIG_FTRACE_STARTUP_TEST=y
  CONFIG_SAMPLE_FTRACE_DIRECT=m
  CONFIG_SAMPLE_FTRACE_DIRECT_MULTI=m
  CONFIG_SAMPLE_FTRACE_OPS=m

All tests pass.


Cheers,
Björn


Changes in v12:
- Massaged the commit messages a bit.
- Squashed the samples patches, so that the rv32 support is included
  from the start.
- Minor whitespace changes in the mcount-dyn.S.
- Minor style changes.

Changes in v11:
https://lore.kernel.org/linux-riscv/20230627111612.761164-1-suagrfillet@gmail.com/

- append a patch that makes the DIRECT_CALL samples support RV32I in
  this series fixing the rv32 build failure reported by Palmer
- validated with ftrace boottime selftest and manual sample modules test
  in qemu-system for RV32I and RV64I

Changes in v10:
https://lore.kernel.org/all/20230511093234.3123181-1-suagrfillet@gmail.com/

- add Acked-by from Björn Töpel in patch 2 and patch 4 
- replace `move` with `mv` in patch3 
- prettify patch 2/4 with proper tabs

Changes in v9:
https://lore.kernel.org/linux-riscv/20230510101857.2953955-1-suagrfillet@gmail.com/

1. add Acked-by from Björn Töpel in patch 1

2. rebase patch2/patch3 on Linux v6.4-rc1

  - patch 2: to make the `SAVE_ABI_REGS` configurable, revert the
    modification of mcount-dyn.S from commit (45b32b946a97 "riscv:
entry: Consolidate general regs saving/restoring")

  - patch 3: to pass the trace_selftest, add the implement of
    `ftrace_stub_direct_tramp` from commit (fee86a4ed536 "ftrace:
selftest: remove broken trace_direct_tramp") ; and fixup the context
conflict in Kconfig 

Changes in v8:
https://lore.kernel.org/linux-riscv/20230324033342.3177979-1-suagrfillet@gmail.com/
 - Fix incorrect address values in the 4nd patch 
 - Rebased on v6.3-rc2

Changes in v7:
https://lore.kernel.org/linux-riscv/20230112090603.1295340-1-guoren@kernel.org/
 - Fixup RESTORE_ABI_REGS by remove PT_T0(sp) overwrite.
 - Add FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY [1]
 - Fixup kconfig with HAVE_SAMPLE_FTRACE_DIRECT &
   HAVE_SAMPLE_FTRACE_DIRECT_MULTI

Changes in v6:
https://lore.kernel.org/linux-riscv/20230107133549.4192639-1-guoren@kernel.org/
 - Replace 8 with MCOUNT_INSN_SIZE
 - Replace "REG_L a1, PT_RA(sp)" with "mv a1, ra"
 - Add Evgenii Shatokhin comment

Changes in v5:
https://lore.kernel.org/linux-riscv/20221208091244.203407-1-guoren@kernel.org/
 - Sort Kconfig entries in alphabetical order.

Changes in v4:
https://lore.kernel.org/linux-riscv/20221129033230.255947-1-guoren@kernel.org/
 - Include [3] for maintenance. [Song Shuai]

Changes in V3:
https://lore.kernel.org/linux-riscv/20221123153950.2911981-1-guoren@kernel.org/
 - Include [2] for maintenance. [Song Shuai]

[1]: https://lore.kernel.org/linux-riscv/CAAYs2=j3Eak9vU6xbAw0zPuoh00rh8v5C2U3fePkokZFibWs2g@mail.gmail.com/T/#t
[2]: https://lore.kernel.org/lkml/20221120084230.910152-1-suagrfillet@gmail.com/
[3]: https://lore.kernel.org/linux-riscv/20221123142025.1504030-1-suagrfillet@gmail.com/ 


Song Shuai (4):
  riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
  riscv: ftrace: Make function graph use ftrace directly
  riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
  samples: ftrace: Add RISC-V support for SAMPLE_FTRACE_DIRECT[_MULTI]

 arch/riscv/Kconfig                          |   4 +
 arch/riscv/include/asm/ftrace.h             |  18 +-
 arch/riscv/kernel/ftrace.c                  |  30 ++-
 arch/riscv/kernel/mcount-dyn.S              | 198 ++++++++++++++++----
 samples/ftrace/ftrace-direct-modify.c       |  35 ++++
 samples/ftrace/ftrace-direct-multi-modify.c |  41 ++++
 samples/ftrace/ftrace-direct-multi.c        |  25 +++
 samples/ftrace/ftrace-direct-too.c          |  28 +++
 samples/ftrace/ftrace-direct.c              |  24 +++
 9 files changed, 348 insertions(+), 55 deletions(-)


base-commit: 3ca112b71f35dd5d99fc4571a56b5fc6f0c15814
-- 
2.40.1

