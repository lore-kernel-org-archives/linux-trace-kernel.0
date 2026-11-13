Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794556916;
	b=10eLZbaivPJrYLJ/iP2psQuZWIRTWPfx5GECo5rlkdWqXiThEte19k33ofdo7C1fjjfd
	 Y8vwjLbtYYKDzruE+6S3VNG0h+u9q+bQV5R48+ONfgZmBAysryQDUp89zXQteIkMQCemf
	 AX7WYDxnb1OW+kCRJSb7vEXPiQ5U3tc5BxjV6UJ6vtIb5DWLEfKU/zIqrflRIa9YpYqn1
	 ZLrbXECujEAGytx6w2h+RQgaV5RWUEf2wQ9XzoQUZG//O6lxJZnxpKFGMYWjrlQeh3/ZT
	 /Gu/LC6ale1QuS18RJqqEN2TM6vbevasskNnyrV0NTgkuZt+Vle/5Cvmn91UxGw9OiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794556916;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RrQMo72s+xgTZAWBkOU75OLuzem9hLNhClg/oTwezaQ=;
	b=AlVc0eHGxXT5iGI7qR7pK6ejCyyqD7ZaHU1kTp1hG1/ZFmm4N0SFh4Syzzc4KuspnA1D
	 fpTS6y4gyU+JCJHPBIe9J6QpVtn32/UsUTF1fli3FHrCleBjKMNmsKMFd3Bz59xV7RjBh
	 O2SF5hPY8Ev37s3Bv7t0f1uKZ0a0MglV03AvUB3M5zLyEKxQiduu8tEQBwSQw1gGoW9GU
	 rYRvJZWrzfKJpZCLAYx+/Mb4X7ihkWV/LnXoLmo9wCjyIQSzwHYKhTBgZwyd1HtccsABV
	 7pcvGzFJGeZ0TQuBS9zWyVbLBbQAynBM4McfYXY9ZrTPIJIoQbhJwmiWKqFYYDjTftA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeKTHACT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C38606A323
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 08:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QeKTHACT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD9C1F000CC
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 08:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794556915;
	bh=RrQMo72s+xgTZAWBkOU75OLuzem9hLNhClg/oTwezaQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QeKTHACTYHIFSPBdhentnM3wnMLyZiyfIekMxgX8Joz83E0526Xft3HspX66uonu9
	 k7MozHPco67q99fIqnYmW2p9OSLlID9OTa7VAz1MhK1HiK8J6zcmx7GB3VGHNoJ/wL
	 Rk9erisG26nhWJif18i+BJQYot/oMD1w3gg9o6tBlY08VdknKvEim8XCWATKV0kG7s
	 ZXwG8UGYIYKzANaK9EuJWQAwAHMfncUuDopKFjrYMPXcn0uVWZvvHEVUvwUhyD5Y+2
	 m9TBo7WrPYQLqzJ6Pluhad+D9uVA9yh8xHHiXf0GXTRlyEj7y5/aVaUtTzBUFGJhKT
	 KdeM11nPbz3qQ==
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-49134c8509fso680907f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 00:01:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEx9cdbvnsKR1Ia7d47CgcOtS0SYA3Akt+4jlr/UKFruHYw6PhtmAmq2XwOrCfWRiS6sXbt165kRYP2IEVOWsTibQ0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8un1x9XfvGwMioXpgWhJrpBAfHDIGRsN38YE9PtmSwGWx720YB
	gjtYtlXEH1uFyyhkgLOM6nttr4/fziOuONHegyX6yMXVHEXANvVGjcMSd6w8pqe7xesgBQ4k07l
	/6bRIJrpoE65aLJm+qNs0bgaRPoZsepU=
X-Received: by 2002:a5d:453b:0:b0:48b:59f:db9c with SMTP id
 ffacd0b85a97d-49c739100cdmr2561600f8f.53.1794556914005; Fri, 13 Nov 2026
 00:01:54 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-probes-in-lrsc-v3-0-a95089852a17@mobileye.com> <20261112-probes-in-lrsc-v3-2-a95089852a17@mobileye.com>
In-Reply-To: <20261112-probes-in-lrsc-v3-2-a95089852a17@mobileye.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 13 Nov 2026 16:01:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTY5ODDH6XV2h1v+T7Sn5BK3L9x-Q_Qb_EXNmdCor5rPA@mail.gmail.com>
X-Gm-Features: AclHuK_ujmzCHnR7WjROZe4Msg_0UtNudrf7SWsOa8YGl6ANc7NWr5Zym5umOmk
Message-ID: <CAJF2gTTY5ODDH6XV2h1v+T7Sn5BK3L9x-Q_Qb_EXNmdCor5rPA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv: probes: reject probes inside an LR/SC sequence
To: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Pekka Enberg <penberg@kernel.org>, 
	=?UTF-8?Q?Patrick_St=C3=A4hlin?= <me@packi.ch>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 6:02=E2=80=AFPM Vladimir Kondratiev
<vladimir.kondratiev@mobileye.com> wrote:
>
> A kprobe or uprobe replaces an instruction with a breakpoint. The trap
> clears the hart's reservation, so if the breakpoint sits on the lr, on
> the sc, or on any instruction between them, the sc fails, the loop
> branches back to the lr and the probe fires again. The sequence never
> completes.
>
> This has always been possible on RISC-V, because cmpxchg and the
> conditional atomics are LR/SC loops. arm64 has the same problem and
> rejects probes inside an exclusive-load/store-exclusive region.
>
> On the other hand, if lr is not paired with sc, breakpoit at lr or
> after it is OK. lr/wrs sequence is an example - breakpoint can be set
> anywhere
>
> For the instructions between LR and SC, use the rules for a constrained
> LR/SC sequence: at most 16 instructions between lr and sc, all base
> integer instructions other than loads, stores, JALR, FENCE, SYSTEM and
> backward jumps or branches, or their compressed forms. Scan forward
> from the probed instruction. Reaching an sc through permitted
> instructions only means the probe sits inside a sequence; any other
> instruction, an lr, the end of the window or the end of the readable
> text means it does not. Only a sequence that follows these rules is
> guaranteed to make progress, so a probe inside any other one is
> already on unsupported ground. Scanning forward rather than tracking
> state from the start of the function also keeps an lr that has no sc,
> such as the one in __cmpwait() before wrs.nto, from affecting probes
> later in the same function.
Yes, I agree with the approach for LR-SC pair, but it needs to be
cross-tested before getting in. Could you provide the easy test cases?

>
> kprobes scan the kernel text up to the end of the enclosing symbol.
> uprobes have only the probed instruction copied, so they read the
> text that follows it from the task, which the caller's mmap_lock
> allows.
>
> Fixes: c22b0bcb1dd0 ("riscv: Add kprobes supported")
> Fixes: 74784081aac8 ("riscv: Add uprobes supported")
One patch for one Fixes tag, is that okay?

> Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
> ---
>  arch/riscv/include/asm/insn.h          | 28 +++++++++++
>  arch/riscv/kernel/probes/decode-insn.c | 91 ++++++++++++++++++++++++++++=
++++++
>  arch/riscv/kernel/probes/decode-insn.h |  7 +++
>  arch/riscv/kernel/probes/kprobes.c     | 27 +++++++---
>  arch/riscv/kernel/probes/uprobes.c     | 31 ++++++++++++
>  5 files changed, 176 insertions(+), 8 deletions(-)
>
> diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.=
h
> index c3005573e8c9..f5de81753bec 100644
> --- a/arch/riscv/include/asm/insn.h
> +++ b/arch/riscv/include/asm/insn.h
> @@ -10,11 +10,16 @@
>
>  #define RV_INSN_FUNCT3_MASK    GENMASK(14, 12)
>  #define RV_INSN_FUNCT3_OPOFF   12
> +#define RV_INSN_FUNCT5_MASK    GENMASK(31, 27)
> +#define RV_INSN_FUNCT5_OPOFF   27
> +#define RV_INSN_FUNCT7_MASK    GENMASK(31, 25)
> +#define RV_INSN_FUNCT7_OPOFF   25
>  #define RV_INSN_OPCODE_MASK    GENMASK(6, 0)
>  #define RV_INSN_OPCODE_OPOFF   0
>  #define RV_INSN_FUNCT12_OPOFF  20
>
>  #define RV_ENCODE_FUNCT3(f_)   (RVG_FUNCT3_##f_ << RV_INSN_FUNCT3_OPOFF)
> +#define RV_ENCODE_FUNCT5(f_)   (RVG_FUNCT5_##f_ << RV_INSN_FUNCT5_OPOFF)
>  #define RV_ENCODE_FUNCT12(f_)  (RVG_FUNCT12_##f_ << RV_INSN_FUNCT12_OPOF=
F)
>
>  /* The bit field of immediate value in I-type instruction */
> @@ -136,7 +141,13 @@
>
>  /* parts of opcode for RVG*/
>  #define RVG_OPCODE_FENCE       0x0f
> +#define RVG_OPCODE_OP_IMM      0x13
>  #define RVG_OPCODE_AUIPC       0x17
> +#define RVG_OPCODE_OP_IMM_32   0x1b
> +#define RVG_OPCODE_AMO         0x2f
> +#define RVG_OPCODE_OP          0x33
> +#define RVG_OPCODE_LUI         0x37
> +#define RVG_OPCODE_OP_32       0x3b
>  #define RVG_OPCODE_BRANCH      0x63
>  #define RVG_OPCODE_JALR                0x67
>  #define RVG_OPCODE_JAL         0x6f
> @@ -188,6 +199,17 @@
>  #define RVG_FUNCT12_EBREAK     0x1
>  #define RVG_FUNCT12_SRET       0x102
>
> +/* parts of funct5 code for A extension */
> +#define RVG_FUNCT5_LR          0x02
> +#define RVG_FUNCT5_SC          0x03
> +
> +/*
> + * The AMO funct3 field holds the access width: 010 for .w, 011 for .d.
> + * Matching bits 14:13 alone accepts both and nothing else.
> + */
> +#define RVG_AMO_WIDTH_MASK     GENMASK(14, 13)
> +#define RVG_AMO_WIDTH_WD       BIT(13)
> +
>  #define RVG_MATCH_AUIPC                (RVG_OPCODE_AUIPC)
>  #define RVG_MATCH_JALR         (RV_ENCODE_FUNCT3(JALR) | RVG_OPCODE_JALR=
)
>  #define RVG_MATCH_JAL          (RVG_OPCODE_JAL)
> @@ -200,6 +222,8 @@
>  #define RVG_MATCH_BGEU         (RV_ENCODE_FUNCT3(BGEU) | RVG_OPCODE_BRAN=
CH)
>  #define RVG_MATCH_EBREAK       (RV_ENCODE_FUNCT12(EBREAK) | RVG_OPCODE_S=
YSTEM)
>  #define RVG_MATCH_SRET         (RV_ENCODE_FUNCT12(SRET) | RVG_OPCODE_SYS=
TEM)
> +#define RVG_MATCH_LR           (RV_ENCODE_FUNCT5(LR) | RVG_AMO_WIDTH_WD =
| RVG_OPCODE_AMO)
> +#define RVG_MATCH_SC           (RV_ENCODE_FUNCT5(SC) | RVG_AMO_WIDTH_WD =
| RVG_OPCODE_AMO)
>  #define RVC_MATCH_C_BEQZ       (RVC_ENCODE_FUNCT3(C_BEQZ) | RVC_OPCODE_C=
1)
>  #define RVC_MATCH_C_BNEZ       (RVC_ENCODE_FUNCT3(C_BNEZ) | RVC_OPCODE_C=
1)
>  #define RVC_MATCH_C_J          (RVC_ENCODE_FUNCT3(C_J) | RVC_OPCODE_C1)
> @@ -227,6 +251,8 @@
>  #define RVC_MASK_C_EBREAK      0xffff
>  #define RVG_MASK_EBREAK                0xffffffff
>  #define RVG_MASK_SRET          0xffffffff
> +#define RVG_MASK_LR            (RV_INSN_FUNCT5_MASK | RVG_AMO_WIDTH_MASK=
 | RV_INSN_OPCODE_MASK)
> +#define RVG_MASK_SC            (RV_INSN_FUNCT5_MASK | RVG_AMO_WIDTH_MASK=
 | RV_INSN_OPCODE_MASK)
>
>  #define __INSN_LENGTH_MASK     _UL(0x3)
>  #define __INSN_LENGTH_GE_32    _UL(0x3)
> @@ -262,6 +288,8 @@ __RISCV_INSN_FUNCS(c_ebreak, RVC_MASK_C_EBREAK, RVC_M=
ATCH_C_EBREAK)
>  __RISCV_INSN_FUNCS(ebreak, RVG_MASK_EBREAK, RVG_MATCH_EBREAK)
>  __RISCV_INSN_FUNCS(sret, RVG_MASK_SRET, RVG_MATCH_SRET)
>  __RISCV_INSN_FUNCS(fence, RVG_MASK_FENCE, RVG_MATCH_FENCE);
> +__RISCV_INSN_FUNCS(lr, RVG_MASK_LR, RVG_MATCH_LR)
> +__RISCV_INSN_FUNCS(sc, RVG_MASK_SC, RVG_MATCH_SC)
>
>  /* special case to catch _any_ system instruction */
>  static __always_inline bool riscv_insn_is_system(u32 code)
> diff --git a/arch/riscv/kernel/probes/decode-insn.c b/arch/riscv/kernel/p=
robes/decode-insn.c
> index 433d9035b888..78a6f2ac6808 100644
> --- a/arch/riscv/kernel/probes/decode-insn.c
> +++ b/arch/riscv/kernel/probes/decode-insn.c
> @@ -4,11 +4,102 @@
>  #include <linux/kprobes.h>
>  #include <linux/module.h>
>  #include <linux/kallsyms.h>
> +#include <linux/bug.h>
>  #include <asm/sections.h>
>
>  #include "decode-insn.h"
>  #include "simulate-insn.h"
>
> +/*
> + * Can insn sit between the lr and the sc of a constrained LR/SC sequenc=
e?
> + * The ISA allows base integer instructions there, except loads, stores,
> + * JALR, FENCE, SYSTEM, backward jumps and taken backward branches, plus
> + * their compressed forms. Backward branches are treated as not allowed:
> + * the retry branch follows the sc, so one inside the body is not a
> + * constrained sequence.
> + */
> +static bool __kprobes riscv_insn_is_lrsc_body(u32 insn)
> +{
> +       u32 funct3;
> +
> +       if (GET_INSN_LENGTH(insn) =3D=3D 2) {
> +               switch (insn & RVC_INSN_OPCODE_MASK) {
> +               case RVC_OPCODE_C0:
> +                       /* c.addi4spn; the rest of the quadrant is loads =
and stores */
> +                       return (insn & RVC_INSN_FUNCT3_MASK) =3D=3D 0;
> +               case RVC_OPCODE_C1:
> +                       /* Arithmetic, c.j, c.jal and branches, bit 12 is=
 the offset sign */
> +                       if (riscv_insn_is_c_j(insn) || riscv_insn_is_c_ja=
l(insn) ||
> +                           riscv_insn_is_c_beqz(insn) || riscv_insn_is_c=
_bnez(insn))
> +                               return !(insn & BIT(12));
> +                       return true;
> +               case RVC_OPCODE_C2:
> +                       funct3 =3D (insn & RVC_INSN_FUNCT3_MASK) >> RVC_I=
NSN_FUNCT3_OPOFF;
> +                       if (funct3 =3D=3D 0)        /* c.slli */
> +                               return true;
> +                       if (funct3 =3D=3D 4)        /* c.mv, c.add, but n=
ot c.jr, c.jalr, c.ebreak */
> +                               return !riscv_insn_is_c_jr(insn) &&
> +                                      !riscv_insn_is_c_jalr(insn) &&
> +                                      !riscv_insn_is_c_ebreak(insn);
> +                       return false;   /* stack loads and stores */
> +               }
> +               return false;
> +       }
> +
> +       switch (insn & RV_INSN_OPCODE_MASK) {
> +       case RVG_OPCODE_OP_IMM:
> +       case RVG_OPCODE_OP_IMM_32:
> +       case RVG_OPCODE_LUI:
> +       case RVG_OPCODE_AUIPC:
> +               return true;
> +       case RVG_OPCODE_OP:
> +       case RVG_OPCODE_OP_32:
> +               /* funct7 0 or 0x20 is base I; anything else is M, B or a=
nother extension */
> +               return !((insn & RV_INSN_FUNCT7_MASK) & ~(0x20U << RV_INS=
N_FUNCT7_OPOFF));
> +       case RVG_OPCODE_BRANCH:
> +       case RVG_OPCODE_JAL:
> +               /* forward only, bit 31 is the offset sign */
> +               return !(insn & BIT(31));
> +       }
> +       return false;
> +}
> +
> +/*
> + * Does the instruction at the start of buf lie inside a constrained LR/=
SC
> + * sequence? Such a sequence holds at most RISCV_LRSC_MAX_BODY instructi=
ons
> + * between the lr and the sc, all from the set above. Walk forward from =
the
> + * probed instruction: reaching an sc through permitted instructions onl=
y
> + * means the probe sits in the body; anything else, including an lr that
> + * opens a new sequence, means it does not. The walk stops at the end of
> + * buf, so a short buffer only makes the answer more permissive.
> + */
> +bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len)
> +{
> +       u32 insn;
> +
> +       /* 2 instructions for LR and SC itself */
> +       for (size_t n =3D 0, off =3D 0; n < RISCV_LRSC_MAX_BODY + 2 && of=
f + 2 <=3D len;
> +                       n++, off +=3D GET_INSN_LENGTH(insn)) {
> +               insn =3D buf[off / 2];
> +               if (GET_INSN_LENGTH(insn) =3D=3D 4) {
> +                       if (off + 4 > len)
> +                               return false;
> +                       insn |=3D (u32)buf[off / 2 + 1] << 16;
> +               }
> +               if (n =3D=3D 0) {
> +                       if (riscv_insn_is_lr(insn))
> +                               continue; /* 1-st instruction lr is OK */
> +                       else
> +                               n++; /* if it's not lr, scan one instruct=
ion less */
> +               }
> +               if (riscv_insn_is_sc(insn))
> +                       return true;
> +               if (!riscv_insn_is_lrsc_body(insn))
> +                       return false;
> +       }
> +       return false;
> +}
> +
>  /* Return:
>   *   INSN_REJECTED     If instruction is one not allowed to kprobe,
>   *   INSN_GOOD_NO_SLOT If instruction is supported but doesn't use its s=
lot.
> diff --git a/arch/riscv/kernel/probes/decode-insn.h b/arch/riscv/kernel/p=
robes/decode-insn.h
> index 42269a7d676d..0ea952cc7595 100644
> --- a/arch/riscv/kernel/probes/decode-insn.h
> +++ b/arch/riscv/kernel/probes/decode-insn.h
> @@ -15,4 +15,11 @@ enum probe_insn {
>  enum probe_insn __kprobes
>  riscv_probe_decode_insn(probe_opcode_t *addr, struct arch_probe_insn *as=
i);
>
> +/* A constrained LR/SC sequence has at most this many instructions betwe=
en lr and sc */
> +#define RISCV_LRSC_MAX_BODY    16
> +/* Bytes from the probed instruction (can be lr) through the farthest po=
ssible sc */
> +#define RISCV_LRSC_SCAN_BYTES  ((RISCV_LRSC_MAX_BODY + 2) * 4)
> +
> +bool __kprobes riscv_probe_in_lrsc_body(const u16 *buf, size_t len);
> +
>  #endif /* _RISCV_KERNEL_KPROBES_DECODE_INSN_H */
> diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probe=
s/kprobes.c
> index 63ee5066def5..9b26052a0c4d 100644
> --- a/arch/riscv/kernel/probes/kprobes.c
> +++ b/arch/riscv/kernel/probes/kprobes.c
> @@ -49,35 +49,46 @@ static void __kprobes arch_simulate_insn(struct kprob=
e *p, struct pt_regs *regs)
>         post_kprobe_handler(p, kcb, regs);
>  }
>
> -static bool __kprobes arch_check_kprobe(unsigned long addr)
> +/*
> + * Walk the instructions from the enclosing symbol up to addr to check t=
hat
> + * addr is an instruction boundary. Then reject a probe inside an LR/SC
> + * sequence: the breakpoint trap drops the reservation, so the SC would =
fail
> + * and the loop would hit the probe again on every retry. The sequence i=
s
> + * recognised by a forward scan with the constrained-sequence rules, as =
for
> + * uprobes, so an lr that is not followed by an sc (as in __cmpwait()) d=
oes
> + * not taint the rest of the function.
> + */
> +static int __kprobes arch_check_kprobe(unsigned long addr)
>  {
> -       unsigned long tmp, offset;
> +       unsigned long tmp, size, offset;
>
>         /* start iterating at the closest preceding symbol */
> -       if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
> -               return false;
> +       if (!kallsyms_lookup_size_offset(addr, &size, &offset))
> +               return -EILSEQ;
>
>         tmp =3D addr - offset;
>
>         while (tmp <=3D addr) {
>                 if (tmp =3D=3D addr)
> -                       return true;
> +                       return riscv_probe_in_lrsc_body((u16 *)addr, size=
 - offset) ? -EINVAL : 0;
>
>                 tmp +=3D GET_INSN_LENGTH(*(u16 *)tmp);
>         }
>
> -       return false;
> +       return -EILSEQ;
>  }
>
>  int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  {
>         u16 *insn =3D (u16 *)p->addr;
> +       int ret;
>
>         if ((unsigned long)insn & 0x1)
>                 return -EILSEQ;
>
> -       if (!arch_check_kprobe((unsigned long)p->addr))
> -               return -EILSEQ;
> +       ret =3D arch_check_kprobe((unsigned long)p->addr);
> +       if (ret)
> +               return ret;
>
>         /* copy instruction */
>         p->opcode =3D (kprobe_opcode_t)(*insn++);
> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/probe=
s/uprobes.c
> index eb177d0ce8ab..d97a10262166 100644
> --- a/arch/riscv/kernel/probes/uprobes.c
> +++ b/arch/riscv/kernel/probes/uprobes.c
> @@ -28,6 +28,34 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *reg=
s)
>         return instruction_pointer(regs);
>  }
>
> +/*
> + * Is the instruction at addr inside a constrained LR/SC sequence? Only =
the
> + * probed instruction was copied, so read the text that follows it from =
the
> + * task. The caller holds mmap_lock, as uprobe_write_opcode() requires t=
oo.
> + * Text that cannot be read ends the scan early, which accepts the probe=
.
> + */
> +static bool uprobe_in_lrsc_body(struct mm_struct *mm, unsigned long addr=
)
> +{
> +       u16 buf[RISCV_LRSC_SCAN_BYTES / sizeof(u16)];
> +       struct vm_area_struct *vma;
> +       struct page *page;
> +       size_t got =3D 0;
> +       int len;
> +
> +       while (got < sizeof(buf)) {
> +               len =3D min_t(size_t, sizeof(buf) - got,
> +                           PAGE_SIZE - offset_in_page(addr + got));
> +               page =3D get_user_page_vma_remote(mm, addr + got, FOLL_FO=
RCE, &vma);
> +               if (IS_ERR(page))
> +                       break;
> +               uprobe_copy_from_page(page, addr + got, (void *)buf + got=
, len);
> +               put_page(page);
> +               got +=3D len;
> +       }
> +
> +       return riscv_probe_in_lrsc_body(buf, got);
> +}
> +
>  int arch_uprobe_analyze_insn(struct arch_uprobe *auprobe, struct mm_stru=
ct *mm,
>                              unsigned long addr)
>  {
> @@ -53,6 +81,9 @@ int arch_uprobe_analyze_insn(struct arch_uprobe *auprob=
e, struct mm_struct *mm,
>                 return -EINVAL;
>         }
>
> +       if (uprobe_in_lrsc_body(mm, addr))
> +               return -EINVAL;
> +
>         return 0;
>  }
>
>
> --
> 2.43.0
>


--=20
Best Regards
 Guo Ren
