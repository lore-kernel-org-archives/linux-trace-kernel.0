Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89783749C
	for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Oct 2023 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="laarTbT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AFBC433C8;
	Sun, 15 Oct 2023 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697384844;
	bh=eOVWZcQW/22SSN6LdG+8MdF6GFeozANXU+Xp290Y5Bc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=laarTbT7Ar5NeNnpuBFNp3kjWxPiqtc6OFJGOgns6fU/+qyWtxv8McGMTYyqhprmj
	 9QTeDNkPOIsyr0TI86d5+JUZfFW9754ySMrDkRcxOemc9/BBNhZAFrBmpNQJ+hZITj
	 C/aHW1oKwkd7yuRupIl3MxgPhWM3dH/6mZJpbIh7AdLhvaVE5zPtA83ksfGAwfdw7a
	 UHu/F+bAgx/q2Sx5J21iou+7LefehQrD9tH2sOSjXMCWHMiXlvTsPMPGBEA2cQx7m/
	 5QQ4Ut/AhnaY6mnEIH+wt67fqEnfgabDnztLB6BbAPFDhvEdJxbKJO+lq3HP3zhcdY
	 mjvezkedVdCtw==
Date: Mon, 16 Oct 2023 00:47:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Guo Ren <guoren@linux.alibaba.com>, Steven Rostedt
 <rostedt@goodmis.org>, linux-riscv@lists.infradead.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: ftrace: Fix to pass correct ftrace_regs to
 ftrace_func_t functions
Message-Id: <20231016004719.64c6a762f90826632b2eeaa1@kernel.org>
In-Reply-To: <20231015231523.901bee54f885a7bb72e1f021@kernel.org>
References: <169625103396.278295.15281009481727023114.stgit@devnote2>
	<20231015231523.901bee54f885a7bb72e1f021@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

Sorry please ignore this. I found that the arch/riscv doesn't support
HAVE_DYNAMIC_FTRACE_WITH_ARGS. Thus this might add a new feature support.
Let me update it.

Thank you,

On Sun, 15 Oct 2023 23:15:23 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Hi,
> 
> Gentry ping.
> 
> I think this should be an important fix because if a fprobe handler without
> FTRACE_OPS_FL_SAVE_REGS tries to access any register via ftrace_regs, that
> will get a wrong value.
> 
> Thank you,
> 
> On Mon,  2 Oct 2023 21:50:34 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since ftrace_func_t requires to pass 'struct ftrace_regs *' as the 4th
> > argument even if FTRACE_OPS_FL_SAVE_REGS is not set, ftrace_caller must
> > pass 'struct ftrace_regs *', which is a partial pt_regs, on the stack
> > to the ftrace_func_t functions, so that the ftrace_func_t functions can
> > access some partial registers.
> > 
> > Fix to allocate 'struct ftrace_regs' (which has the same size of 'struct
> > pt_regs') on the stack and save partial (argument) registers on it
> > instead of reduced size custom data structure.
> > 
> > Fixes: afc76b8b8011 ("riscv: Using PATCHABLE_FUNCTION_ENTRY instead of MCOUNT")
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  arch/riscv/kernel/mcount-dyn.S |   65 +++++++++++++++++-----------------------
> >  1 file changed, 28 insertions(+), 37 deletions(-)
> > 
> > diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> > index 669b8697aa38..84963680eff4 100644
> > --- a/arch/riscv/kernel/mcount-dyn.S
> > +++ b/arch/riscv/kernel/mcount-dyn.S
> > @@ -14,46 +14,37 @@
> >  	.text
> >  
> >  #define FENTRY_RA_OFFSET	8
> > -#define ABI_SIZE_ON_STACK	80
> > -#define ABI_A0			0
> > -#define ABI_A1			8
> > -#define ABI_A2			16
> > -#define ABI_A3			24
> > -#define ABI_A4			32
> > -#define ABI_A5			40
> > -#define ABI_A6			48
> > -#define ABI_A7			56
> > -#define ABI_T0			64
> > -#define ABI_RA			72
> >  
> >  	.macro SAVE_ABI
> > -	addi	sp, sp, -ABI_SIZE_ON_STACK
> > -
> > -	REG_S	a0, ABI_A0(sp)
> > -	REG_S	a1, ABI_A1(sp)
> > -	REG_S	a2, ABI_A2(sp)
> > -	REG_S	a3, ABI_A3(sp)
> > -	REG_S	a4, ABI_A4(sp)
> > -	REG_S	a5, ABI_A5(sp)
> > -	REG_S	a6, ABI_A6(sp)
> > -	REG_S	a7, ABI_A7(sp)
> > -	REG_S	t0, ABI_T0(sp)
> > -	REG_S	ra, ABI_RA(sp)
> > +	addi	sp, sp, -PT_SIZE_ON_STACK
> > +
> > +	/* Save t0 as epc for ftrace_regs_get_instruction_pointer() */
> > +	REG_S	t0, PT_EPC(sp)
> > +	REG_S	a0, PT_A0(sp)
> > +	REG_S	a1, PT_A1(sp)
> > +	REG_S	a2, PT_A2(sp)
> > +	REG_S	a3, PT_A3(sp)
> > +	REG_S	a4, PT_A4(sp)
> > +	REG_S	a5, PT_A5(sp)
> > +	REG_S	a6, PT_A6(sp)
> > +	REG_S	a7, PT_A7(sp)
> > +	REG_S	t0, PT_T0(sp)
> > +	REG_S	ra, PT_RA(sp)
> >  	.endm
> >  
> >  	.macro RESTORE_ABI
> > -	REG_L	a0, ABI_A0(sp)
> > -	REG_L	a1, ABI_A1(sp)
> > -	REG_L	a2, ABI_A2(sp)
> > -	REG_L	a3, ABI_A3(sp)
> > -	REG_L	a4, ABI_A4(sp)
> > -	REG_L	a5, ABI_A5(sp)
> > -	REG_L	a6, ABI_A6(sp)
> > -	REG_L	a7, ABI_A7(sp)
> > -	REG_L	t0, ABI_T0(sp)
> > -	REG_L	ra, ABI_RA(sp)
> > -
> > -	addi	sp, sp, ABI_SIZE_ON_STACK
> > +	REG_L	a0, PT_A0(sp)
> > +	REG_L	a1, PT_A1(sp)
> > +	REG_L	a2, PT_A2(sp)
> > +	REG_L	a3, PT_A3(sp)
> > +	REG_L	a4, PT_A4(sp)
> > +	REG_L	a5, PT_A5(sp)
> > +	REG_L	a6, PT_A6(sp)
> > +	REG_L	a7, PT_A7(sp)
> > +	REG_L	t0, PT_T0(sp)
> > +	REG_L	ra, PT_RA(sp)
> > +
> > +	addi	sp, sp, PT_SIZE_ON_STACK
> >  	.endm
> >  
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > @@ -96,8 +87,8 @@ ftrace_call:
> >  	call	ftrace_stub
> >  
> >  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > -	addi	a0, sp, ABI_RA
> > -	REG_L	a1, ABI_T0(sp)
> > +	addi	a0, sp, PT_RA
> > +	REG_L	a1, PT_T0(sp)
> >  	addi	a1, a1, -FENTRY_RA_OFFSET
> >  #ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> >  	mv	a2, s0
> > 
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
