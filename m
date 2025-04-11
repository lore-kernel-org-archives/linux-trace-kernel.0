Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E63D2367CB
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377350; cv=none; b=DJDBOaY1ZE+sX3EqOoYNYwPoo6aD6quLM3+6lGuTYxsUSeuakR9N+hzT7pSnriPpVGB98wo4rI8KzfcQw99NjK1IkySGd+JlNgG5t5Sd1xj9jAh7G5kQ81aaxUWe4bw4Z2ihgD9vaLmAVTyxHVcMcILIDrUzVacn4qYn/eHLhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377350; c=relaxed/simple;
	bh=CQbisDDlqIuUL9kLnmsm4eBXkI4TlVKGpOx54RbTORs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMWYQHrMASxSPFsx1o0xLowZDLj0k5N04y4Oau/kIYOKc0Vi27ihkmRQ7wSkxBy/0rfrWYgbW5XnbG2EkZd9YpDoZfMaHLRks37JN0filNrxeTmbuKU+PPGdel7fZrnZmbMBO+Ze7AMfpjxdIocv5e9i42tc40tEwocgc8ysGbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=mxiYWBEu; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="mxiYWBEu"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5498d2a8b89so2061674e87.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 06:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1744377345; x=1744982145; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0wN+ZoR9FraBx8eyzdPTJ1cLQd/mVtKq5MlDuPX3cQQ=;
        b=mxiYWBEuR2sLPj8SDTpNZ833PYiYNLWxAIh7aG5oC3tcrDcdXAET1k1oIBGX63iMEW
         YvAPUShT43lvxONGo1kKnVPyLAgnXJQRLzH5KdJ93Np2kclVvVteQHH/Y6CYSSwJcvQ4
         aZQXFrOUhkDgTBtMV9OwbMR5HTShe0R7lDTjJ+zmaS4Oop6rtnqIPpiSBa6AqLBITBEj
         HXlhRBCLOLdgl5P4Mj2+NgK92NW7EWpbzdZ/0A/9C7OyRPTRL7L9J7XnrnNr2+CbPNnj
         W4n9jsynp1k9vKIZQVrpYY1PHF9CuFvkFasZWooJutXrwvEGf2j+FhYvqxmBa4EsRkxD
         z1uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744377345; x=1744982145;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wN+ZoR9FraBx8eyzdPTJ1cLQd/mVtKq5MlDuPX3cQQ=;
        b=nee3NnhHc3blZVGhNRVvj98DlsjPp6Jc2Y1/IOaUskaEGOR4/jMeXHmiDEMytFvVUp
         GT9jF5Q5ZChpdfNMUrjwH1t+VKOWJ5SzVqiGQOFjiPECX6oGwytKe1LQjjfEyHte/eGk
         Zqy90BcUOUxW491y2jYgonWVWKhMe3sXQH6gePRC9JSpbwJhHHYhNvGc+i97MTxmVC8z
         aZ/7pj3hFAxnCCFZpYgCg5Q8v02bemr5za2MbgiLL9vpg272Ib7fn5NKQJiZS+cn2JB9
         bw3sX7zKCm4Fg7RuK2JrL3SshnLK2Awr5Hbx5ZVSa0yaunrvZhSRBxFyyywc3FBeOWwf
         7hbw==
X-Forwarded-Encrypted: i=1; AJvYcCU5zwvnDZuAFFd1y2jvNgjmv8zAZZNNjHU7DOfOLBiKUUlGDSeCWecqFXDK04ok8cUewr0YuTORcMaIBtwsCyWYLTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2e8V6K1q9+3+yRWNtVhMTz1URjvMnwj05GPiICF4rYS9jIVw3
	pymFA2hnBTdIyr2zFz2zy1v0LXGa4OUbZs1woNoiQbZRlbDpNip0itAFCLGy12s=
X-Gm-Gg: ASbGncs2HspWnKfV0gAyCQ8lhzKh1ZIRPjL1Sr5rbAzdUPUdp4OTozcsRRl4YY5lRE1
	zOTin99rMXIfBmSE+yr4YQo2LM/TwX2/ODww6s3RXhilOl3cAXBmDJkS4G/yuYZvLRRVLrMF2ti
	nxLQpXBfHo+mu/iEVDTNBP4r6pnUpsUF3EGO44ydJhKKpwPa2zBKmCGOGaX7uBiXU8wfghuBghu
	uMY3bX+4xZOdru+eBpXIBQlOViAR5zmc2Xr55bE8cdJg+21Kn2rSJip//g6o8PTm4wEuAZlbJX+
	DggUAHu2+Jnwe8KGitCeEsXDPCC97IK92LqUljKVYc4cG2DbUCwsdw4qHmPZEPiToUUSM7qD2Ie
	Ko0JSQ2E/q+nYka18o288BVLEsFWwCSqJjA==
X-Google-Smtp-Source: AGHT+IE3083X574tqADw7NbJaCpkPbYkvntHjSXglZdCRT9a6tqLqs/ZFy4+2uPxGFh0eP/9eUbkmg==
X-Received: by 2002:a05:6512:10c8:b0:549:91c6:96a8 with SMTP id 2adb3069b0e04-54d4528e891mr854002e87.7.1744377344426;
        Fri, 11 Apr 2025 06:15:44 -0700 (PDT)
Received: from h-2001-9b1-c3c7-e600-116c-cc53-dd4f-4ae1.na.bahnhof.se ([2001:9b1:c3c7:e600:116c:cc53:dd4f:4ae1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54d3d238d43sm428622e87.78.2025.04.11.06.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 06:15:43 -0700 (PDT)
Message-ID: <de8870a8cd2609b6f7db70a92e4a34e13c6e3e8d.camel@rivosinc.com>
Subject: Re: [PATCH v4 05/12] riscv: ftrace: prepare ftrace for atomic code
 patching
From: Robbin Ehn <rehn@rivosinc.com>
To: Andy Chiu <andybnac@gmail.com>, linux-riscv@lists.infradead.org, 
	alexghiti@rivosinc.com, palmer@dabbelt.com
Cc: Andy Chiu <andy.chiu@sifive.com>, =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
 <bjorn@rivosinc.com>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, 
 Alexandre Ghiti <alex@ghiti.fr>, puranjay12@gmail.com,
 paul.walmsley@sifive.com,  greentime.hu@sifive.com, nick.hu@sifive.com,
 nylon.chen@sifive.com,  eric.lin@sifive.com, vicent.chen@sifive.com,
 zong.li@sifive.com,  yongxuan.wang@sifive.com, samuel.holland@sifive.com,
 olivia.chu@sifive.com,  c2232430@gmail.com
Date: Fri, 11 Apr 2025 15:15:42 +0200
In-Reply-To: <20250407180838.42877-5-andybnac@gmail.com>
References: <20250407180838.42877-1-andybnac@gmail.com>
	 <20250407180838.42877-5-andybnac@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi, thanks,

On Tue, 2025-04-08 at 02:08 +0800, Andy Chiu wrote:
> From: Andy Chiu <andy.chiu@sifive.com>
>=20
> We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
> instruction fetch can break down to 4 byte at a time, it is impossible
> to update two instructions without a race. In order to mitigate it, we
> initialize the patchable entry to AUIPC + NOP4. Then, the run-time code
> patching can change NOP4 to JALR to eable/disable ftrcae from a
> function. This limits the reach of each ftrace entry to +-2KB displacing
> from ftrace_caller.
>=20
> Starting from the trampoline, we add a level of indirection for it to
> reach ftrace caller target. Now, it loads the target address from a
> memory location, then perform the jump. This enable the kernel to update
> the target atomically.
>=20
> The new don't-stop-the-world text patching on change only one RISC-V
> instruction:
>=20
> =C2=A0 |=C2=A0 -8: &ftrace_ops of the associated tracer function.
> =C2=A0 | <ftrace enable>:
> =C2=A0 |=C2=A0=C2=A0 0: auipc=C2=A0 t0, hi(ftrace_caller)
> =C2=A0 |=C2=A0=C2=A0 4: jalr=C2=A0=C2=A0 t0, lo(ftrace_caller)
> =C2=A0 |
> =C2=A0 |=C2=A0 -8: &ftrace_nop_ops
> =C2=A0 | <ftrace disable>:
> =C2=A0 |=C2=A0=C2=A0 0: auipc=C2=A0 t0, hi(ftrace_caller)
> =C2=A0 |=C2=A0=C2=A0 4: nop
>=20
> This means that f+0x0 is fixed, and should not be claimed by ftrace,
> e.g. kprobe should be able to put a probe in f+0x0. Thus, we adjust the
> offset and MCOUNT_INSN_SIZE accordingly.
>=20
> Co-developed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
> Changelog v4:
> =C2=A0- Include Bj=C3=B6rn's fix for kprobe
> =C2=A0- Refactor code for better reading (Robbin, Bj=C3=B6rn)
> =C2=A0- Remove make_call_ra and friedns (Bj=C3=B6rn)
> =C2=A0- Update comments to match reality (Bj=C3=B6rn)
> =C2=A0- Drop code defined by !WITH_ARG
> =C2=A0- Add a synchronization point when updating ftrace_call_dest (Bj=C3=
=B6rn)
> ---
> =C2=A0arch/riscv/include/asm/ftrace.h |=C2=A0 49 ++++++------
> =C2=A0arch/riscv/kernel/ftrace.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 130 ++++=
++++++++++++----------------
> =C2=A0arch/riscv/kernel/mcount-dyn.S=C2=A0 |=C2=A0=C2=A0 9 +--
> =C2=A03 files changed, 92 insertions(+), 96 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftr=
ace.h
> index d8b2138bd9c6..6a5c0a7fb826 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -20,10 +20,9 @@ extern void *return_address(unsigned int level);
> =C2=A0#define ftrace_return_address(n) return_address(n)
> =C2=A0
> =C2=A0void _mcount(void);
> -static inline unsigned long ftrace_call_adjust(unsigned long addr)
> -{
> -	return addr;
> -}
> +unsigned long ftrace_call_adjust(unsigned long addr);
> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip);
> +#define ftrace_get_symaddr(fentry_ip) arch_ftrace_get_symaddr(fentry_ip)
> =C2=A0
> =C2=A0/*
> =C2=A0 * Let's do like x86/arm64 and ignore the compat syscalls.
> @@ -57,12 +56,21 @@ struct dyn_arch_ftrace {
> =C2=A0 * 2) jalr: setting low-12 offset to ra, jump to ra, and set ra to
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return add=
ress (original pc + 4)
> =C2=A0 *
> + * The first 2 instructions for each tracable function is compiled to 2 =
nop
> + * instructions. Then, the kernel initializes the first instruction to a=
uipc
> at
> + * boot time (<ftrace disable>). The second instruction is patched to ja=
lr to
> + * start the trace.
> + *
> + *<Image>:
> + * 0: nop
> + * 4: nop
> + *
> =C2=A0 *<ftrace enable>:
> - * 0: auipc=C2=A0 t0/ra, 0x?
> - * 4: jalr=C2=A0=C2=A0 t0/ra, ?(t0/ra)
> + * 0: auipc=C2=A0 t0, 0x?
> + * 4: jalr=C2=A0=C2=A0 t0, ?(t0)
> =C2=A0 *
> =C2=A0 *<ftrace disable>:
> - * 0: nop
> + * 0: auipc=C2=A0 t0, 0x?
> =C2=A0 * 4: nop
> =C2=A0 *
> =C2=A0 * Dynamic ftrace generates probes to call sites, so we must deal w=
ith
> @@ -75,10 +83,9 @@ struct dyn_arch_ftrace {
> =C2=A0#define AUIPC_OFFSET_MASK	(0xfffff000)
> =C2=A0#define AUIPC_PAD		(0x00001000)
> =C2=A0#define JALR_SHIFT		20
> -#define JALR_RA			(0x000080e7)
> -#define AUIPC_RA		(0x00000097)
> =C2=A0#define JALR_T0			(0x000282e7)
> =C2=A0#define AUIPC_T0		(0x00000297)
> +#define JALR_RANGE		(JALR_SIGN_MASK - 1)
> =C2=A0
> =C2=A0#define to_jalr_t0(offset)						\
> =C2=A0	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
> @@ -96,26 +103,14 @@ do
> {									\
> =C2=A0	call[1] =3D to_jalr_t0(offset);					\
> =C2=A0} while (0)
> =C2=A0
> -#define to_jalr_ra(offset)						\
> -	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_RA)
> -
> -#define to_auipc_ra(offset)						\
> -	((offset & JALR_SIGN_MASK) ?					\
> -	(((offset & AUIPC_OFFSET_MASK) + AUIPC_PAD) | AUIPC_RA) :	\
> -	((offset & AUIPC_OFFSET_MASK) | AUIPC_RA))
> -
> -#define make_call_ra(caller, callee, call)				\
> -do {									\
> -	unsigned int offset =3D						\
> -		(unsigned long) (callee) - (unsigned long) (caller);	\
> -	call[0] =3D to_auipc_ra(offset);					\
> -	call[1] =3D to_jalr_ra(offset);					\
> -} while (0)
> -
> =C2=A0/*
> - * Let auipc+jalr be the basic *mcount unit*, so we make it 8 bytes here=
.
> + * Only the jalr insn in the auipc+jalr is patched, so we make it 4
> + * bytes here.
> =C2=A0 */
> -#define MCOUNT_INSN_SIZE 8
> +#define MCOUNT_INSN_SIZE	4
> +#define MCOUNT_AUIPC_SIZE	4
> +#define MCOUNT_JALR_SIZE	4
> +#define MCOUNT_NOP4_SIZE	4
> =C2=A0
> =C2=A0#ifndef __ASSEMBLY__
> =C2=A0struct dyn_ftrace;
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 1fd10555c580..cf78eef073a0 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -8,10 +8,21 @@
> =C2=A0#include <linux/ftrace.h>
> =C2=A0#include <linux/uaccess.h>
> =C2=A0#include <linux/memory.h>
> +#include <linux/irqflags.h>
> =C2=A0#include <linux/stop_machine.h>
> =C2=A0#include <asm/cacheflush.h>
> =C2=A0#include <asm/text-patching.h>
> =C2=A0
> +unsigned long ftrace_call_adjust(unsigned long addr)
> +{
> +	return addr + MCOUNT_AUIPC_SIZE;
> +}
> +
> +unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
> +{
> +	return fentry_ip - MCOUNT_AUIPC_SIZE;
> +}
> +
> =C2=A0#ifdef CONFIG_DYNAMIC_FTRACE
> =C2=A0void ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
> =C2=A0{
> @@ -32,51 +43,32 @@ void ftrace_arch_code_modify_post_process(void)
> __releases(&text_mutex)
> =C2=A0	mutex_unlock(&text_mutex);
> =C2=A0}
> =C2=A0
> -static int ftrace_check_current_call(unsigned long hook_pos,
> -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int *expected)
> +static int __ftrace_modify_call(unsigned long source, unsigned long targ=
et,
> bool validate)
> =C2=A0{
> +	unsigned int call[2], offset;

There is a mix of unsigned int and u32.
It doesn't seem to serve any purpose?

> =C2=A0	unsigned int replaced[2];
> -	unsigned int nops[2] =3D {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
> =C2=A0
> -	/* we expect nops at the hook position */
> -	if (!expected)
> -		expected =3D nops;
> +	offset =3D target - source;
> +	call[1] =3D to_jalr_t0(offset);
> =C2=A0
> -	/*
> -	 * Read the text we want to modify;
> -	 * return must be -EFAULT on read error
> -	 */
> -	if (copy_from_kernel_nofault(replaced, (void *)hook_pos,
> -			MCOUNT_INSN_SIZE))
> -		return -EFAULT;
> -
> -	/*
> -	 * Make sure it is what we expect it to be;
> -	 * return must be -EINVAL on failed comparison
> -	 */
> -	if (memcmp(expected, replaced, sizeof(replaced))) {
> -		pr_err("%p: expected (%08x %08x) but got (%08x %08x)\n",
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *)hook_pos, expected[0], ex=
pected[1],
> replaced[0],
> -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 replaced[1]);
> -		return -EINVAL;
> +	if (validate) {
> +		call[0] =3D to_auipc_t0(offset);
> +		/*
> +		 * Read the text we want to modify;
> +		 * return must be -EFAULT on read error
> +		 */
> +		if (copy_from_kernel_nofault(replaced, (void *)source, 2 *
> MCOUNT_INSN_SIZE))
> +			return -EFAULT;
> +
> +		if (replaced[0] !=3D call[0]) {
> +			pr_err("%p: expected (%08x) but got (%08x)\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (void *)source, call[0], replace=
d[0]);
> +			return -EINVAL;
> +		}
> =C2=A0	}
> =C2=A0
> -	return 0;
> -}
> -
> -static int __ftrace_modify_call(unsigned long hook_pos, unsigned long ta=
rget,
> -				bool enable, bool ra)
> -{
> -	unsigned int call[2];
> -	unsigned int nops[2] =3D {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
> -
> -	if (ra)
> -		make_call_ra(hook_pos, target, call);
> -	else
> -		make_call_t0(hook_pos, target, call);
> -
> -	/* Replace the auipc-jalr pair at once. Return -EPERM on write error.
> */
> -	if (patch_insn_write((void *)hook_pos, enable ? call : nops,
> MCOUNT_INSN_SIZE))
> +	/* Replace the jalr at once. Return -EPERM on write error. */
> +	if (patch_insn_write((void *)(source + MCOUNT_AUIPC_SIZE), call + 1,
> MCOUNT_JALR_SIZE))
> =C2=A0		return -EPERM;
> =C2=A0
> =C2=A0	return 0;
> @@ -84,22 +76,21 @@ static int __ftrace_modify_call(unsigned long hook_po=
s,
> unsigned long target,
> =C2=A0
> =C2=A0int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> =C2=A0{
> -	unsigned int call[2];
> +	unsigned long distance, orig_addr, pc =3D rec->ip - MCOUNT_AUIPC_SIZE;
> =C2=A0
> -	make_call_t0(rec->ip, addr, call);
> -
> -	if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
> -		return -EPERM;
> +	orig_addr =3D (unsigned long)&ftrace_caller;
> +	distance =3D addr > orig_addr ? addr - orig_addr : orig_addr - addr;
> +	if (distance > JALR_RANGE)
> +		return -EINVAL;
> =C2=A0
> -	return 0;
> +	return __ftrace_modify_call(pc, addr, false);
> =C2=A0}
> =C2=A0
> -int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> -		=C2=A0=C2=A0=C2=A0 unsigned long addr)
> +int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned=
 long
> addr)
> =C2=A0{
> -	unsigned int nops[2] =3D {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
> +	u32 nop4 =3D RISCV_INSN_NOP4;
> =C2=A0
> -	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
> +	if (patch_insn_write((void *)rec->ip, &nop4, MCOUNT_NOP4_SIZE))
> =C2=A0		return -EPERM;
> =C2=A0
> =C2=A0	return 0;
> @@ -114,21 +105,38 @@ int ftrace_make_nop(struct module *mod, struct
> dyn_ftrace *rec,
> =C2=A0 */
> =C2=A0int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
> =C2=A0{
> -	int out;
> +	unsigned long pc =3D rec->ip - MCOUNT_AUIPC_SIZE;
> +	unsigned int nops[2], offset;
> +	int ret;
> +
> +	offset =3D (unsigned long) &ftrace_caller - pc;
> +	nops[0] =3D to_auipc_t0(offset);
> +	nops[1] =3D RISCV_INSN_NOP4;
> =C2=A0
> =C2=A0	mutex_lock(&text_mutex);
> -	out =3D ftrace_make_nop(mod, rec, MCOUNT_ADDR);
> +	ret =3D patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
> =C2=A0	mutex_unlock(&text_mutex);
> =C2=A0
> -	return out;
> +	return ret;
> =C2=A0}
> =C2=A0
> +ftrace_func_t ftrace_call_dest =3D ftrace_stub;
> =C2=A0int ftrace_update_ftrace_func(ftrace_func_t func)
> =C2=A0{
> -	int ret =3D __ftrace_modify_call((unsigned long)&ftrace_call,
> -				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (unsigned long)func, true, true=
);
> -
> -	return ret;
> +	WRITE_ONCE(ftrace_call_dest, func);
> +	/*
> +	 * The data fence ensure that the update to ftrace_call_dest happens
> +	 * before the write to function_trace_op later in the generic ftrace.
> +	 * If the sequence is not enforced, then an old ftrace_call_dest may
> +	 * race loading a new function_trace_op set in ftrace_modify_all_code
> +	 *
> +	 * If we are in stop_machine, then we don't need to call remote fence
> +	 * as there is no concurrent read-side of ftrace_call_dest.
> +	 */
> +	smp_wmb();
> +	if (!irqs_disabled())
> +		smp_call_function(ftrace_sync_ipi, NULL, 1);
> +	return 0;

Here we allow the read of cpu_online_mask being reordered with the store to
ftrace_call_dest.

Can't this happen then?

Hart X                 | Hart new
load cpu_online_mask   |
                       | store cpu_online_mask
                       | tlb shootdown/icache flush
store ftrace_call_dest |
ftrace_sync_ipi        | // not hit
                       | sees old value ?

Thanks, Robbin

> =C2=A0}
> =C2=A0
> =C2=A0struct ftrace_modify_param {
> @@ -172,17 +180,11 @@ void arch_ftrace_update_code(int command)
> =C2=A0int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_ad=
dr,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long addr)
> =C2=A0{
> +	unsigned long caller =3D rec->ip - MCOUNT_AUIPC_SIZE;
> =C2=A0	unsigned int call[2];
> -	unsigned long caller =3D rec->ip;
> -	int ret;
> =C2=A0
> =C2=A0	make_call_t0(caller, old_addr, call);
> -	ret =3D ftrace_check_current_call(caller, call);
> -
> -	if (ret)
> -		return ret;
> -
> -	return __ftrace_modify_call(caller, addr, true, false);
> +	return __ftrace_modify_call(caller, addr, true);
> =C2=A0}
> =C2=A0#endif
> =C2=A0
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dy=
n.S
> index 3f06b40bb6c8..8aa554d56096 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -13,7 +13,6 @@
> =C2=A0
> =C2=A0	.text
> =C2=A0
> -#define FENTRY_RA_OFFSET	8
> =C2=A0#define ABI_SIZE_ON_STACK	80
> =C2=A0#define ABI_A0			0
> =C2=A0#define ABI_A1			8
> @@ -62,8 +61,7 @@
> =C2=A0* After the stack is established,
> =C2=A0*
> =C2=A0* 0(sp) stores the PC of the traced function which can be accessed
> -* by &(fregs)->epc in tracing function. Note that the real
> -* function entry address should be computed with -FENTRY_RA_OFFSET.
> +* by &(fregs)->epc in tracing function.
> =C2=A0*
> =C2=A0* 8(sp) stores the function return address (i.e. parent IP) that
> =C2=A0* can be accessed by &(fregs)->ra in tracing function.
> @@ -140,7 +138,7 @@
> =C2=A0	.endm
> =C2=A0
> =C2=A0	.macro PREPARE_ARGS
> -	addi	a0, t0, -FENTRY_RA_OFFSET
> +	addi	a0, t0, -MCOUNT_JALR_SIZE	// ip (callsite's jalr insn)
> =C2=A0	la	a1, function_trace_op
> =C2=A0	REG_L	a2, 0(a1)
> =C2=A0	mv	a1, ra
> @@ -153,7 +151,8 @@ SYM_FUNC_START(ftrace_caller)
> =C2=A0	PREPARE_ARGS
> =C2=A0
> =C2=A0SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
> -	call	ftrace_stub
> +	REG_L	ra, ftrace_call_dest
> +	jalr	ra, 0(ra)
> =C2=A0
> =C2=A0	RESTORE_ABI_REGS
> =C2=A0	bnez	t1, .Ldirect

