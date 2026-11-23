Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795402037;
	b=ZAntO8HEDsFa1Jt6t/GnqELT/ZDwZupS3uNZfPRxsjt/HWB+swK7c+O3iboGx0RwoZFB
	 BfvWoJZKTWEJG5KkilXT/bXsqjKWh9e8tCUaQ/jXWRoXCm9Gjbegz0ZuBLjCSgACBhqny
	 HbUAkMYo6amV/Aqcb9sXgXZbXnUdLeylQ5om7KnCGq9r+yIij68+B4WpDHEF8K7tiY6Qk
	 RwWICtZ1TRNzLSiSJ/8MmiVZfgbDMiuqd4UzuH5kdmN6Xxn9o0YOeKQmMSAFAwPYEhjR7
	 SM+QHODxJKDytkaFp2tinklAR+OSH2H+oCf4mZBoAsLG6aY5M4wtvmBNZRIYttTSPAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795402037;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:User-Agent:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=T2rqLJojSoswSaxZEdBB1uyrHy1+X1TRGaYYP0bHo6c=;
	b=wrpb84CiKQP2MH2vzmT0bqsN9YZxnmCn51tw2Z7Hiiw0EzxgfQ7Oqq6N0bpsksQvXncV
	 4t2GprdJq3NYA2U2AFl8dasIW2f7yQ/x3FwrcWvaiLcFUl9/A6R2qRnEFSGMG9yBmMxBb
	 rz0xcRfyhkapIlNsL3dyjlO1w43Z7xPjnUX9nM/q/8xAEmTYcNqjdH8UH3uCyVPSklvfT
	 5RwtYByEtIOcXtaaL5nG3plmL1yHGkztgTsb83QVEVfw/M2cixQfCmyz7KWvWakZ+kUZf
	 TCejwuu7OYKdFjKjbmIiLXj5+888yd6CSm/3eo/K4+bRWIdmCyFQO6w2KKPFvhSEqPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=permerror;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B95606A31A;
	Mon, 23 Nov 2026 02:47:16 +0000 (UTC)
Authentication-Results:smtp.subspace.kernel.org; dkim=permerror (bad message/signature format)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC9E1F000C4;
	Mon, 23 Nov 2026 02:47:13 +0000 (UTC)
Authentication-Results:smtp.kernel.org; dkim=permerror (bad message/signature format)
From: None
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Lukas Zobernig <lukas.zobernig@gmail.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Pablo Fraile Alonso <pablo@pablofraile.net>,
	Edgecombe Rick P <rick.p.edgecombe@intel.com>
Subject: [PATCH 0/5] x86/insn, uprobes: Fix opcode map handling for multi-byte, REX2, and VEX/EVEX/XOP instructions
Date: Mon, 23 Nov 2026 11:47:10 +0900
Message-ID: <179540203033.233843.12951034848925983867.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Following up on Pablo Fraile Alonso's report and patch [1], as well as the
additional review points from Sashiko and Rick Edgecombe, this series fixes
the underlying x86 instruction decoder issues and the related opcode-map
assumptions in x86 uprobes.

Originally, the x86 instruction decoder was designed primarily for
instructions typically emitted in the kernel. Since uprobes uses it on
arbitrary user-space instruction encodings, several issues around multi-byte,
REX2, and VEX/EVEX/XOP encodings have surfaced:

1. insn_is_nop() in arch/x86/lib/insn-eval.c mutates insn->opcode.value
   in-place for REX2 M0=1 instructions without updating insn->opcode.nbytes,
   corrupting struct insn for subsequent callers (e.g. uprobe_init_insn()
   and branch_setup_xol_ops()).
2. gen-insn-attr-x86.awk skips emitting INAT_REX2_VARIANT for 0xa1 (JMPABS)
   because the check is placed after 'if (length(flags) == 0) continue'.
3. insn_get_opcode() never checks INAT_NO_REX2 / INAT_REX2_VARIANT or
   invalid REX2 encodings such as REX2 M0=0 + 0x0f or REX2 M0=1 + 0x38/0x3a.
4. insn->opcode.nbytes represents the physical opcode byte count (needed for
   field offset calculations such as insn_offset_modrm()), so REX2 M0=1 and
   VEX/EVEX/XOP instructions all have insn->opcode.nbytes == 1. Callers
   need a helper to determine the logical opcode map; insn_masking_exception()
   also lacked this check and could misidentify non-map-0 0x1f/0x8e opcodes.
5. In arch/x86/kernel/uprobes.c, bit 0x0f in good_insns_{32,64} bypassed
   good_2byte_insns, and uprobe_init_insn(), branch_setup_xol_ops(),
   arch_uprobe_analyze_insn(), and riprel_analyze() assumed map-0 or 1-byte
   REX encodings, causing misidentification of AVX/VEX instructions such as
   VZEROUPPER (c5 f8 77), VPSHUFD (c5 f9 70), VPOR (c5 f9 eb), and VCMPPS
   (c5 f8 c2), as well as REX2 prefix corruption in riprel_analyze().

Patch overview:
- Patch 1: Fix insn_is_nop() not to mutate struct insn.
- Patch 2: Fix gen-insn-attr-x86.awk to emit INAT_REX2_VARIANT.
- Patch 3: Reject invalid REX2 encodings in insn_get_opcode().
- Patch 4: Add insn_opcode_map() / insn_last_opcode() helpers and fix
           insn_masking_exception().
- Patch 5: Fix opcode validation, branch/fixup analysis, and REX2 RIP-rel
           handling in arch/x86/kernel/uprobes.c.

Notes:
- checkpatch.pl reports warnings on patch 5 for using -ENOTSUPP and -ENOSYS
  in arch/x86/kernel/uprobes.c. Those match the existing error code
  conventions of uprobe_init_insn() and branch_setup_xol_ops() across
  uprobes; cleaning up error codes across uprobes should be done separately
  and is intentionally left out of scope for this fix series.
- Auditing whether Group 15 (0f ae: lfence/mfence/sfence, fxsave/fxrstor,
  CET instructions, etc.) should be enabled in good_2byte_insns (as raised
  by Rick Edgecombe) is also left for a separate follow-up discussion/patch.
- Uprobes should audit the three-byte opcodes and provide good_3bytes1_insns
  and good_3byte2_insns bit table if needed.

Testing:
- insn_decoder_test on vmlinux .text (7,926,007 instructions): 0 errors
- insn_sanity (64-bit and 32-bit, 1,000,000 random insns each): 0 errors
- Host unit tests covering REX2 (valid/invalid), JMPABS, VEX2, POP/MOV SS
- QEMU (KVM, -cpu host) uprobe runtime test verifying rejection of 8
  disallowed/invalid encodings (0f 05, 0f 0b, REX2 M0=0+0f/e8/a1,
  REX2 M0=1+05, 10-byte REX2 M0=1, EVEX map 4) and clean XOL/emulation
  execution + trace hits for 7 allowed instructions (bswap, nop10,
  vzeroupper, vcmpps, vpshufd, vpor, crc32).

[1] https://lore.kernel.org/r/20261116-x86-uprobes-two-byte-opcode-v1-1-2b6dbabead52@pablofraile.net

Thank you,

---
Masami Hiramatsu (5):
  x86/insn-eval: Do not mutate struct insn in insn_is_nop()
  x86/insn: Fix gen-insn-attr-x86.awk to emit INAT_REX2_VARIANT
  x86/insn: Reject invalid REX2 encodings in insn_get_opcode()
  x86/insn: Add insn_opcode_map() helper and fix insn_masking_exception()
  uprobes/x86: Fix opcode validation and analysis for multi-byte, REX2, and VEX/EVEX/XOP instructions

 arch/x86/include/asm/inat.h                | 10 +++
 arch/x86/include/asm/insn.h                | 43 +++++++++++++
 arch/x86/kernel/uprobes.c                  | 97 +++++++++++++++++++++---------
 arch/x86/lib/insn-eval.c                   | 17 ++++--
 arch/x86/lib/insn.c                        | 16 +++++
 arch/x86/tools/gen-insn-attr-x86.awk       |  6 +-
 tools/arch/x86/include/asm/inat.h          | 10 +++
 tools/arch/x86/include/asm/insn.h          | 43 +++++++++++++
 tools/arch/x86/lib/insn.c                  | 16 +++++
 tools/arch/x86/tools/gen-insn-attr-x86.awk |  6 +-
 10 files changed, 225 insertions(+), 39 deletions(-)

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
