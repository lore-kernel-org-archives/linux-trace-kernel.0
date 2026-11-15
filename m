Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794705206;
	b=KFX2FAJaOn+eJAa0YQORGb2ybDmGrA8lOuX+IbbXh/XDhbHah+MboPuEg5R1E35o81RJ
	 CgrTw6zUvSj4Hb9Q+mKrQdhhvpPJQIIUOiONGksPsDSzviirSACfbzU+18dZBYpGPHJmT
	 MopeuKNjVcsmOmqtH44OTKR/bOfE4fyB/qEegJadk7m+kbZd//zY+HYFnX494RIkkeLr1
	 yTRie/vGqK0MYtFjivZ6SZ/MOA90GmnVo14vVSMBbYf20cjCUV/an5jXq3krYNYAGDd6i
	 tdoZlJZ1aFuRxEqHUn7jqY4Vyly7RdmSTS+EUGQJlTpQxEPSSyoieWmWlPu628FiUYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794705206;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=UI8zlSuuYeyEvkH8m4fC9E/a2u7b1gVYjwuT2B3/r64=;
	b=WDoc2CQz+naa6U+LGOhr/a8tQgnZMai2atcNTNkDdxtk6w17FAC+ibEgQmDjZlS0omnL
	 BGEv2EyfoXXKXUtsCTCLTHNbUdMp3+f0pTql7Rqb9cGNNvONUm6MHQkPd5lJjKwp26xZx
	 Ha2UIDF6hck2mtVX9jHGEMrOwR4eu7yezL6OCI1pZ5tnLsC5cTzXQ6PQI/Rxo8XTyJ2wA
	 f/mjBGsSkCZBIZJXkJCQz+QwLi4Q1LcKjyLCqckAJXrFIizV0bajhdIt/HA+Um0fZLzxF
	 B5IVE8Mbyt5NoFIXynej1/OOJBfGz4ay099kWNnyT9h55l26h+dEDK33p9zreqBBNyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YIQzOx+M;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E74606A323
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Nov 2026 01:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0E74606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YIQzOx+M
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso8437665e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 17:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794705204; x=1795310004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UI8zlSuuYeyEvkH8m4fC9E/a2u7b1gVYjwuT2B3/r64=;
        b=YIQzOx+MIxCX4mKKAFU3lDwY+E24s3BfRzh/ORQGZc1CCDUOWLKBcO9B+3VT6Iifcj
         UC28HJODq+pH0aOUz92zTzX++eOlFota38d5EAXT3I6tNCFHX0Nqp1mDsv8mH29CFdzc
         IlJqE0zq7uZj5+m56/aW/miD1rPvWOkTCCKP1KmiHOKjn0ppuOocfQIisMvRyMxpoTyC
         F03x/su2MCJtUrvlUtYacR2qBR2eNhI3+ISuaq+9vQLazFDkVM1yAqSYrc5g4bvtNYI0
         7KdTcAuyTP2QmiE4ymj2IsPhX6gwKCZHvkqKbDnRCH7BIExw+QkigBxqvXtquTLwzmbo
         JZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794705204; x=1795310004;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UI8zlSuuYeyEvkH8m4fC9E/a2u7b1gVYjwuT2B3/r64=;
        b=e0VxpC4XscQsQjwOLlMypsVjtFDVV9jZTo/dJvEmBfNEkyJLokH0rtqys1n8mxO+Qw
         qw0emVvLRdRa8FKobdTWw+/YG+bVxIe8TyxS5WkmxOhu2gIjO7dPp5AT4kTOvkgOap62
         v8cHud1KmsIb5coCN8b/AK0xZ7GyefFItXacRvzvywSLvVFZZB4Gz3hzzRkIUvRzrBjr
         3uSz3At/VhFozLVHyLm2peYFB1DjAwSHaVxtfrDU4dNJZ7R1jjUM0clXO4Pu2ATXhNYV
         LCvc7GafnNKUDNuvw/OCXsK1L7QmnANDFSTb0GYgOx1zo6+dWq3lhDaCATewXw02t5Zr
         F0EQ==
X-Forwarded-Encrypted: i=1; AL+hErFsLjv5aaCBEgERBbvS60JjdwkU0uTNbNFhpcx+GZaeNyqrmdQY1BnkOK1qPawhTr2UIEzCu9XSA5e8uacooi5FtKA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HPhwcC1sgj/tR2OItknpIB7+xaND/E1EIT8E5UQE38o4/QtcX
	8yyPLFryHKjHda/7FuxWRYNGbzEPxbPJtvX59Ve81WgZ9YAFyA54wJjN
X-Gm-Gg: AYBFou0qeDFnOWdOFMV5sh1OV/caYtUWZ0U0Mrk3ZE9tI5AIS0oGL2LNG0io4gHZyao
	vKjybmCYAjfjSmwvaJRYKhB4zG80Hn5S7vsZcLTlHpYD6fX89orDxEUtCdErgByZH+AmUFKxgYW
	damCL65GD8Jgp1iXFe1cB4PK871j0Gfq8ywRJ3QHaZlsrs9xM+adGFvQNxLKNO9JhoHh+9tLIL5
	Hh3MRORjKI6D/ZxEoOvUbkS7Vdm9ukAhz89n2FLSSuGkvJSySHoIsFv38V2UBRSJQDQ4cgaLEtC
	rtL8/u0sokvhE61odgARxnbKD++XIy3l9YbE7Kkk55Hi/DkN4zVrArTUprmjUftFDz9d3We6PX/
	bByIvhcK2mxYS0LlA77RLKfWHnbGSjhC6ahzDGGj/SFntbj9bwHeKGi/1bXtfliZwQbzhWjfFXb
	JyIsOG9mVzAFeiwh59kADJGeK+Vgi6nWK8WdXvGJLbsBz4dl1Pf+bgyOdfqlhdMC+3BqCUj/RKC
	Ylfkci4OLbhyIwTZlMFCj1fVnWpE2k0siQM9puoui8uRoXzprLNsa+ZIzcN0Q1iRnLKm7pw5Gu0
	0NdtqcLW3Hp3yXU4hbpVjD0mrA3q9T2yULZnnicjZmEEJMCVWLdaZYvXxGR2CJDGNCukIyB6ogB
	hkz0rUdM=
X-Received: by 2002:a05:600c:a10a:b0:4a2:10f9:37ce with SMTP id 5b1f17b1804b1-4bb55a4f1d8mr101009845e9.15.1794705204022;
        Sat, 14 Nov 2026 17:13:24 -0800 (PST)
Received: from localhost (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5faf05f8sm85013725e9.10.2026.11.14.17.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 17:13:23 -0800 (PST)
Date: Sun, 15 Nov 2026 01:13:22 +0000
From: Stafford Horne <shorne@gmail.com>
To: Sahil <sahilcdq0@gmail.com>
Cc: jonas@southpole.se, stefan.kristiansson@saunalahti.fi,
	naveen@kernel.org, davem@davemloft.net, mhiramat@kernel.org,
	pjw@kernel.org, wangruikang@iscas.ac.cn, namcao@linutronix.de,
	kees@kernel.org, linux-openrisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] openrisc: Add utilities and clean up simulation
 of instructions
Message-ID: <avkHMp3Qa_C01Nd8@antec>
References: <20260930202744.50489-1-sahilcdq0@gmail.com>
 <20261026201240.107462-2-sahilcdq0@gmail.com>
 <au7I8FNoMcsoh54X@antec>
 <52c3ae66-4165-4fc3-a440-fcb76931382a@gmail.com>
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
In-Reply-To: <52c3ae66-4165-4fc3-a440-fcb76931382a@gmail.com>

On Fri, Nov 13, 2026 at 10:41:56PM +0530, Sahil wrote:
> Hi Stafford,
> 
> On 11/7/26 12:15 PM, Stafford Horne wrote:
> > Hi Sahil,
> > 
> > Thanks for your patches, sorry its taken me time to get around to them, my year
> > since summer has been quite hectic.
> 
> No worries. I completely understand :)
> 
> > I will do the review in chunks so give me some time.
> 
> Thank you for the review.
> 
> > On Tue, Oct 27, 2026 at 01:42:37AM +0530, Sahil Siddiq wrote:
> > > Introduce new instruction-related utilities and macros for OpenRISC.
> > > This is in preparation for patches that add tracing support such as
> > > KProbes and Kretprobes.
> > > 
> > > Currently, PC is first updated and then saved in the link register
> > > (r9) when simulating l.jal and l.jalr. This can result in a corrupted
> > > page table (bad page map in process). Fix this by saving PC in r9
> > > before updating it.
> > > 
> > > Move branch simulation to its own function, simulate_branch(), so it
> > > can be reused. It's already being used by do_illegal_instruction().
> > > It'll also be used by KProbes in the following commit.
> > > 
> > > Introduce simulate_pc() to simulate l.adrp. KProbes will require this
> > > instruction to be simulated as well. simulate_branch() and simulate_pc()
> > > need to be handled differently since branch instructions change the
> > > value of PC while l.adrp depends on PC but doesn't change its value.
> > > 
> > > Use a static key to check if delay slots are disabled. Delay slots are
> > > a part of the CPU's configuration and won't change at runtime. Since
> > > they are often enabled in an OpenRISC CPU, using a static key will
> > > reduce the overhead of checking this flag in the default case while
> > > processing KProbes inserted at branch instructions and simulating them.
> > > 
> > > Link: https://raw.githubusercontent.com/openrisc/doc/master/openrisc-arch-1.4-rev0.pdf
> > > Signed-off-by: Sahil Siddiq <sahilcdq0@gmail.com>
> > > ---
> > > Changes v2 -> v3:
> > > - arch/openrisc/kernel/insn.c:
> > >    - (simulate_pc):
> > >      Handle case when rd=0
> > >      Add function to KProbe blacklist
> > >    - (simulate_branch): Likewise
> > > - arch/openrisc/kernel/setup.c:
> > >    - (setup_arch): Set static key before calling paging_init()
> > > - arch/openrisc/kernel/traps.c:
> > >    - (do_trap): Move handling of Kprobes in commit #2
> > > 
> > > Changes v1 -> v2:
> > > - arch/openrisc/include/asm/cpuinfo.h: Introduce "delay_slot" static key
> > > - arch/openrisc/include/asm/insn-def.h:
> > >     - Use macros instead of union
> > >     - Use better names for macros
> > >     - Use genmask() for masks
> > > - arch/openrisc/kernel/insn.c:
> > >     - Use macros instead of magic values
> > >     - (simulate_pc): Update PC
> > >     - (simulate_branch): Handle rb=r9 in l.jalr simulation
> > > - arch/openrisc/kernel/setup.c: Use "delay slot" static key
> > > - arch/openrisc/kernel/traps.c: Use macros instead of magic values
> > > 
> > >   arch/openrisc/include/asm/cpuinfo.h  |  3 +
> > >   arch/openrisc/include/asm/insn-def.h | 58 ++++++++++++++++--
> > >   arch/openrisc/include/asm/spr_defs.h |  1 +
> > >   arch/openrisc/kernel/Makefile        |  2 +-
> > >   arch/openrisc/kernel/insn.c          | 88 ++++++++++++++++++++++++++++
> > >   arch/openrisc/kernel/setup.c         |  4 ++
> > >   arch/openrisc/kernel/traps.c         | 53 +++--------------
> > >   7 files changed, 159 insertions(+), 50 deletions(-)
> > >   create mode 100644 arch/openrisc/kernel/insn.c
> > > 
> > > [...]
> > > diff --git a/arch/openrisc/kernel/insn.c b/arch/openrisc/kernel/insn.c
> > > new file mode 100644
> > > index 000000000000..619d8080d822
> > > --- /dev/null
> > > +++ b/arch/openrisc/kernel/insn.c
> > > @@ -0,0 +1,88 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * OpenRISC instruction utils
> > > + *
> > > + * Linux architectural port borrowing liberally from similar works of
> > > + * others.  All original copyrights apply as per the original source
> > > + * declaration.
> > > + *
> > > + * OpenRISC implementation:
> > > + * Copyright (C) 2026 Sahil Siddiq <sahilcdq0@gmail.com>
> > > + */
> > > +
> > > +#include <linux/kprobes.h>
> > > +#include <linux/ptrace.h>
> > > +#include <asm/insn-def.h>
> > > +#include <asm/cpuinfo.h>
> > > +
> > > +DEFINE_STATIC_KEY_TRUE(delay_slot);
> > > +
> > > +void simulate_pc(struct pt_regs *regs, unsigned long pc_insn)
> > 
> > Since this simulates l.adrp, maybe the name makes more sense to be called
> > simulate_adrp?
> 
> Sure, I'll rename it.
> 
> > > +{
> > > +	int page_offset;
> > > +	unsigned int rd, op;
> > > +
> > > +	page_offset = sign_extend32(
> > > +		(pc_insn & OPENRISC_ADRP_IMM_MASK) << OPENRISC_ADRP_IMM_SHIFT, 31);
> > > +	rd = (pc_insn & OPENRISC_ADRP_REG_MASK) >> OPENRISC_ADRP_REG_SHIFT;
> > > +	op = get_6_bit_opcode(pc_insn);
> > > +
> > > +	switch (op) {
> > > +	case OPENRISC_OPCODE_ADRP:
> > > +		if (rd != 0)
> > > +			regs->gpr[rd] = page_offset + (regs->pc & OPENRISC_ADRP_OFFSET_MASK);
> > > +		regs->pc += OPENRISC_INSN_SIZE;
> > > +		return;
> > > +	default:
> > > +		break;
> > > +	}
> > > +}
> > > +NOKPROBE_SYMBOL(simulate_pc)
> > > +
> > > +void simulate_branch(struct pt_regs *regs, unsigned long jmp_insn)
> > > +{
> > > +	int displacement;
> > > +	unsigned int rb, op, link_offset, temp;
> > > +
> > > +	displacement = sign_extend32(
> > > +		((jmp_insn) & OPENRISC_JUMP_IMM_MASK) << OPENRISC_JUMP_IMM_SHIFT, 27);
> > > +	rb = (jmp_insn & OPENRISC_JUMP_REG_MASK) >> OPENRISC_JUMP_REG_SHIFT;
> > > +	op = get_6_bit_opcode(jmp_insn);
> > > +	link_offset = OPENRISC_INSN_SIZE;
> > > +
> > > +	if (static_branch_likely(&delay_slot))
> > > +		link_offset <<= 1;
> > 
> > Why do shift left here instead of += OPENRISC_INSN_SIZE? Since logically we are
> > adding one more insn for the delay slot, not doubling.
> 
> Since link_offset is initialized to OPENRISC_INSN_SIZE, shifting it to the left by 1 would
> update link_offset to 2 * OPENRISC_INSN_SIZE. This is a little more obscure than explicitly
> setting it to 2 * OPENRISC_INSN_SIZE. Initially, I thought the left shift operator might be
> less expensive than multiplying.
> 
> I was going through mor1kx's design and noticed there's also a pipelined implementation for
> the multiplier [1]. But it looks like the implementation for shifting is simpler and can be done
> in one cycle. Please let me know if my understanding is incorrect here.

That's correct, but my suggestion was to use += OPENRISC_INSN_SIZE instead of
2 *.

> > However, It may be more efficient to avoid using the alu and write as:
> > 
> >         if (static_branch_likely(&delay_slot))
> >                 link_offset = 2 * OPENRISC_INSN_SIZE;
> >         else
> >                 link_offset = OPENRISC_INSN_SIZE;
> > 
> > what do you think?
> 
> I am not sure if I have understood the alu part. WIll it be more efficient because 2 * OPENRISC_INSN_SIZE
> will be optimized by the compiler to simply be a single number? So no alu operation will be required,
> just one store operation?

Yup, since 2 * OPENRISC_INSN_SIZE is a constant expression the compiler
will replace it with 8.  Then the above code would be just one store operation,
something like:

    if (static_branch_likely(&delay_slot))
	    link_offset = 8;
    else
	    link_offset = 4;


> 
> > > +	switch (op) {
> > > +	case OPENRISC_OPCODE_J: /* l.j */
> > 
> > I think these comments (/* l.j */) are no longer needed sinc you have
> > the named macros.
> 
> Got it, I'll remove the comments.

[snip]

Thanks,
 -Stafford
