Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF2F39021D;
	Wed, 15 Apr 2026 06:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235156; cv=none; b=CO+4OEpDwx32ZOcLuich/CMJxmWMWT5yqfLmZS6E+HRTX8Wdq1mrX3CA3J3taKwlL5GTAvToUwToeVgYdBs4HJG671DGHShDXpd5qKKMtHXoV6vwlLgNz2HcAQI3bcV28Hcnk/UOmMP+PyyzZ7ceL01lmw7wIwjXJrx8VyT3nF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235156; c=relaxed/simple;
	bh=kd3t/0h0MZEPC1AEukuUFSkcMQSDxZRRrpw85dJuaeU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=K7Cu71EGAyEAdOP9Y3lVOBUM2LHLtBi1Lw9C1I5e0b/WPCrnqGBB+NKGAOjZ2XAuPLvp3+yvWsEj4y5BKGqoppRqZnT8xTPzap0vWpkZ54TL7oas3TpfVpdS9kAamDLGeuUhc5QDj1LLsr5VeqYpIGPQAidCH/SdV9qhCd9tMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nv6EqNmR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nv6EqNmR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F06B4C19424;
	Wed, 15 Apr 2026 06:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776235156;
	bh=kd3t/0h0MZEPC1AEukuUFSkcMQSDxZRRrpw85dJuaeU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nv6EqNmRQvuOBgLh6CmGaraznnyLPVvEie2P3G5ml6g2Xr0feIAB1c7Ohn1NaSxTM
	 jyR4wn49u1h3apjmul83sXihBbc/Dei7uf+d8j0tbNkxVTumr+KO8dhy1IC+kOSKmb
	 9WQ5UfOyvBM9Hgf8nHjyg2ynGS6xFkTNho3Fd9k8ZswQVDdHtMf5dYymQgz0b0BBy3
	 o5hE+WWw34pe1iUcD2MQl3hRAtsdb/jMNlGDaAY0GZWBY8TgUbEIDj8X7ud6JQOhVb
	 oBTKMD4WzjY0jqekDH16I2fjhGHgwpLPOH7s1C9FKKaogyUeYIQK3e/QNdqBd1x7Ct
	 wBLVr5yPLh0iw==
Date: Wed, 15 Apr 2026 15:39:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Stafford Horne <shorne@gmail.com>
Cc: Sahil Siddiq <sahilcdq0@gmail.com>, jonas@southpole.se,
 stefan.kristiansson@saunalahti.fi, naveen@kernel.org, davem@davemloft.net,
 mhiramat@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
 jbaron@akamai.com, rostedt@goodmis.org, ardb@kernel.org,
 chenmiao.ku@gmail.com, johannes@sipsolutions.net, nsc@kernel.org,
 masahiroy@kernel.org, tytso@mit.edu, linux-openrisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] openrisc: Add utilities and clean up simulation of
 instructions
Message-Id: <20260415153912.f26b46a37a078f491836bd76@kernel.org>
In-Reply-To: <ad51SeeF2Gv06mgQ@antec>
References: <20260407185650.79816-1-sahilcdq0@gmail.com>
	<20260407185650.79816-2-sahilcdq0@gmail.com>
	<ad51SeeF2Gv06mgQ@antec>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 14 Apr 2026 18:11:37 +0100
Stafford Horne <shorne@gmail.com> wrote:

> Hello Sahil,
> 
> Thanks for your patches.  I have a few questions. so this is not really a
> technical review at the moment just some main items.
> 
> On Wed, Apr 08, 2026 at 12:26:49AM +0530, Sahil Siddiq wrote:
> > Introduce new instruction-related utilities and macros for OpenRISC.
> > This is in preparation for patches that add tracing support such as
> > KProbes.
> > 
> > Simulate l.adrp. Fix bugs in simulation of l.jal and l.jalr. Earlier,
> 
> Why emulate l.adrp?  We don't really use this yet in any OpenRISC code.  This
> instruction is meant to be used to help -fpic code, see:
> 
>   https://openrisc.io/proposals/ladrp

Maybe because l.adrp depends on InsnAddr (instruction address), 
if kprobe runs copied instruction on its trampoline buffer, it
generates a wrong result. If it may not be used in the kernel,
arch_prepare_kprobe() can detect it and return an error.

[...]
> > +
> > +#define OPENRISC_INSN_SIZE  (sizeof(union openrisc_instruction))

This should be defined within an architecture header file.

> > +
> > +/* Helpers for working with l.trap */
> > +static inline unsigned long __emit_trap(unsigned int code)
> > +{
> > +	return (code & 0xffff) | OPCODE_TRAP;
> > +}
> > +
> > +static inline bool has_delay_slot(void)
> > +{
> > +	unsigned int cpucfgr = mfspr(SPR_CPUCFGR);
> > +
> > +	return !(cpucfgr & SPR_CPUCFGR_ND);
> > +}
> 
> This is for handling CPU's that do not have delay slots.  We didn't do this
> before, why are you doing it now?  Should we mention this in the git commit
> message?
> 
> Also, since this is a static configuration for the CPU should we use static keys
> for this?
> 
> > +
> > +void simulate_pc(struct pt_regs *regs, unsigned int jmp);
> > +void simulate_branch(struct pt_regs *regs, unsigned int jmp, bool has_delay_slot);

Also, do not use the same name for a function name and a local variable.
Please rename has_delay_slot() to machine_has_delay_slot() or rename
the has_delay_slot parameter to 'delay_slot'.

[...]
> > +#include <linux/ptrace.h>
> > +#include <asm/insn-def.h>
> > +
> > +void simulate_pc(struct pt_regs *regs, unsigned int jmp)
> > +{
> > +	int displacement;
> > +	unsigned int rd, op;
> > +
> > +	displacement = sign_extend32(((jmp) & 0x7ffff) << 13, 31);
> > +	rd = (jmp & 0x3ffffff) >> 21;

Please use GENMASK() macro instead of hex value.
(Moreover, define meaningful named macro instead of the magic number.)

> > +	op = jmp >> 26;
> > +
> > +	switch (op) {
> > +	case l_adrp:

l_adrp seems have 2 modes. Is this OK only supporting 32-bit?

32-bit Implementation:
rD[31:0] ← exts(Immediate[18:0] << 13) + (InstAddr & -8192)
64-bit Implementation:
rD[63:0] ← exts(Immediate[20:0] << 13) + (InstAddr & -8192)

> > +		regs->gpr[rd] = displacement + (regs->pc & (-8192));

Please use nicely named macro instead of -8192.

Thanks,



-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
