Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6F348B385
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779122358; cv=none; b=bOa19N00AOQ5vur+mNKMgQVrmwK2PurOIHZn14lAvWGnRSp2U+t3n/hevu1xvodZNo/lxAegakly8KDiQhFbhTplju+6ppmABnU8ZZ7xKyIY1+PKszNubFwUX/Ed0j0TIqw3CI+mGIrpghG2Q9Vqp8me9J2i8W0arPb21e09QIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779122358; c=relaxed/simple;
	bh=wtfm5s0cYEM0IzmHheJlIyC/xbWNf/mBPw/DEtmUof4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDMs55qRyTpC4ru02B31cbDjPTzaL5SmBsv4eF062BP87Ff7+1NxOurIKWLWTqqeSne7Q+/+z2YK3XDPvBnHcKOpPhyrJXMt/4Qp5vJKoQCFWd5m4lOPjbyJiEbUU53ZOdEnKHhfnSGSFC7BSgwcSD1jUB2SyrogtCwacSBnEJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzEDG8dW; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzEDG8dW"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-448528f4e69so1650829f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779122354; x=1779727154; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDAuz36Ay6h7YMO6HB48q6LTLUi8+4QkMA1nwKPRRj8=;
        b=nzEDG8dWo5EnoyGy02jekBuEQUFH/RkPb+7ygZ1KRVmL2uJ2VrKZo5xuXrL/j0sIrW
         R1YDvEWZ9NV5k++Ab8ooHGbna4CYKU918lVp/ELhCFZIdfEqbM8yuJluiDsq4nDgnCl7
         5EC/9HlU5O1Xsj+f4aim95PrJv5V355DSJ0LaeKjscjl29F2Mc7wN0xaKcLM8cpHwv22
         qDFFLDlEjHIf3XOGLEboE/tda4lrx2vrQOVWkRbsxFFP23muTKnTx0MOdbI10mpjH+Md
         w4hAsEohSeCH1w64u9+gRTImADGYJrrsw1qizN5t/+OTKamxtrWOgLSe/F8zk2gfrVkb
         Y2eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779122354; x=1779727154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDAuz36Ay6h7YMO6HB48q6LTLUi8+4QkMA1nwKPRRj8=;
        b=har7U/X3MQ/M7OVW3JOv1GSpEbNu3LASAdlVtbxb1Admq5mnLKJ6dvOMLtwsd+ay8N
         DUpnXx8qV2yvQdNKwTpuc+RMRXgEff0VXmX20NcfxEw1wpLknMOUoiu6CgDOx0gpTAml
         is9KJOyFBEqDX9iUo8I8M0hv9vgRJNxy7SiVpIij59Tv8bH5fhMh5GBgapFI4Fx6smqY
         nYpTUjFAikqqQ+zoGSxdOXCCvM3v2rJFuuSg6sH+etoG+DSvOJ57SbjbzKR7CvDFQZK+
         pM6HmVRdM/rZWHfLXa64d+lj/wsiNUjddNy6slRjwJfKC+oyZYsQc798qPkIDYUNdLba
         ihtw==
X-Forwarded-Encrypted: i=1; AFNElJ/9sogilQepaMhOS2RZmzJ/KZOiwBfVcb5TIrldk/9QWfryoPiGYxv24ObIIOcWYzb2SiQ6m+6XjdzYNol/RsDWqT4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1y8WCZJLzt4dy3fCNN23mT8PtZrMno72g1e4nbHuysWZlspL
	fO1xo7WOB4en/x7DmDvaeYkf8oDt7uE3KzzgKSpCzr5p2itHroocI5CO
X-Gm-Gg: Acq92OFVGj0t6/i7ryMBWK1ATN5GrrjkCHepg4XYmQvPyTq9qb/lt/98n888QXjVroF
	q0yeGvCHbkq3u64yez+favUtOySYbcgFv1jTiQBLoSx6GtLc+BYOZbiVK5Yc6Ks71RlKvTp/X17
	XaxKcX7pLwjkSVArVKaMVPxhxt+Odj9XjMozDxfrtTo8G942EtXB0G5RQpGsh/DoW7Y8vFpyl2z
	Gs2LrO2gSDCAo76MT4z1jf8o5yUv2qsTiITCAJgr5wW3UZcnTzPUpIEirMAffGnVuEuvCfKTxEu
	UHWzArm7EdIg+126zDhf/6GxeZdcB9dcTJqJVAycS950hqMFCLZj0/ZEFcn8lb+f3sZ3WJdTAnq
	Sr2iMwayFUugv5YGpGXHTPBzgQFRZgtdIMBFmb17BsXyCK/7bUUlgcf66vGzs1qtcCI/y6U6lvT
	10C4F+o5MM7iGjAhcGVgLXSw==
X-Received: by 2002:a5d:5885:0:b0:44e:902f:e341 with SMTP id ffacd0b85a97d-45e5c5bfbfcmr27408841f8f.20.1779122354393;
        Mon, 18 May 2026 09:39:14 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45d9ed30110sm42240417f8f.13.2026.05.18.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:39:13 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 May 2026 18:39:12 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] uprobes/x86: Move optimized uprobe from nop5 to nop10
Message-ID: <agtAsCSJbrgJdSAM@krava>
References: <20260514135342.22130-1-jolsa@kernel.org>
 <20260514135342.22130-2-jolsa@kernel.org>
 <20260518104306.GU3102624@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518104306.GU3102624@noisy.programming.kicks-ass.net>

On Mon, May 18, 2026 at 12:43:06PM +0200, Peter Zijlstra wrote:
> 
> You seem to have forgotten to Cc LKML and x86 :-(
> 
> On Thu, May 14, 2026 at 03:53:36PM +0200, Jiri Olsa wrote:
> 
> > @@ -1017,17 +1030,32 @@ static int int3_update(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  static int swbp_optimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  			 unsigned long vaddr, unsigned long tramp)
> >  {
> > -	u8 call[5];
> > +	u8 insn[OPT_INSN_SIZE], *call = &insn[LEA_INSN_SIZE];
> >  
> > -	__text_gen_insn(call, CALL_INSN_OPCODE, (const void *) vaddr,
> > +	/*
> > +	 * We have nop10 instruction (with first byte overwritten to int3),
> > +	 * changing it to:
> > +	 *   lea -0x80(%rsp), %rsp
> > +	 *   call tramp
> > +	 */
> > +	memcpy(insn, lea_rsp, LEA_INSN_SIZE);
> > +	__text_gen_insn(call, CALL_INSN_OPCODE,
> > +			(const void *) (vaddr + LEA_INSN_SIZE),
> >  			(const void *) tramp, CALL_INSN_SIZE);
> > -	return int3_update(auprobe, vma, vaddr, call, true /* optimize */);
> > +	return int3_update(auprobe, vma, vaddr, insn, OPT_INSN_SIZE, true /* optimize */);
> >  }
> >  
> >  static int swbp_unoptimize(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  			   unsigned long vaddr)
> >  {
> > -	return int3_update(auprobe, vma, vaddr, auprobe->insn, false /* optimize */);
> > +	/*
> > +	 * We have optimized nop10 (lea, call), changing it to 'jmp rel8' to
> > +	 * end of the 10-byte slot instead of restoring the original nop10,
> > +	 * because we could have thread already inside lea instruction.
> 
> Inaccurate, RIP could be on CALL, not inside LEA. Writing NOP10 would
> make it inside NOP10 though, and that would cause havoc IF you use the
> normal NOP10.
> 
> Thing is, the encoding of NOP{8,9,10} would actually allow you to
> preserve the CALL instruction :-)
> 
> That is, observe:
> 
>        PF1   PF2   ESC   NOPL  MOD   SIB   DISP32
> 
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> NOP10: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x78, 0x56, 0x34, 0x12 -- cs nopw 0x12345678(%rax,%rbp,8)
> 
> Specifically the CALL opcode sits in the SIB byte and decodes like:
> 
>   e8 := 11 101 000
> 
>   scale = 11  (2^3 = 8)
>   index = 101 BP
>   base  = 000 AX
> 
> And the displacement is just that, a displacement.
> 
> So you *could* in fact, write back _A_ NOP10, just not the standard
> NOP10.
> 
> > +	 */
> > +	u8 jmp[OPT_INSN_SIZE] = { JMP8_INSN_OPCODE, OPT_JMP8_OFFSET };
> > +
> > +	return int3_update(auprobe, vma, vaddr, jmp, JMP8_INSN_SIZE, false /* optimize */);
> >  }
> 
> Changelog wants significant update to explain this scheme.
> 
> So we have:
> 
>   NOP10 -+-> LEA -0x80(%rsp), %rsp, CALL foo -> JMP.d8 +8
>          |                                          |
>          `------------------------------------------'
> 
> And you want to belabour the point of how you ensure re-writing the CALL
> instruction isn't a problem (because I'm not convinced).
> 
> Note that the above results in:
> 
> initial:
> 0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> 
> optimize-int3:
> 1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- int3
> optimize-tail:
> 2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> optimize-finish:
> 3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x80(%rsp),%rsp; call 0x78563412
> 
> unoptimize-int3:
> 4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> unoptimize-tail:
> 5: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> unoptimize-finish:
> 6: 0xeb, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- jmp.d8 +8; call 0x78563412
> 
> optimize-int3:
> 7: 0xcc, 0x08, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> optimize-tail:
> 8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; call 0x12345678
> optimize-finish:
> 9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; call 0x12345678
> 
> Note that from step 7 to step 8, you re-write the CALL instruction
> without going through INT3. This means it is entirely possible for a
> concurrent execution to observe a composite instruction.
> 
> This is NOT sound!
> 
> However, I think it can be salvaged, if instead of only writing INT3 at
> +0, you also write INT3 at +5. The sequence then becomes:
> 
> initial:
> 0: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00 -- cs nopw 0x00000000(%rax,%rax,1)
> 
> optimize-int3:
> 1: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x00, 0x00, 0x00, 0x00 -- int3; int3
> optimize-tail(s):
> 2: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; int3
> optimize-finish-1:
> 3: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> optimize-finish-2:
> 3: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- lea -0x80(%rsp),%rsp; call 0x78563412
> 
> unoptimize-int3:
> 4: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> unoptimize-tail:
> 5: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- int3; call 0x78563412
> unoptimize-finish:
> 6: 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0xe8, 0x12, 0x34, 0x56, 0x78 -- cs nopw 0x78563412(%rax,%rbp,8); call 0x78563412
> 
> optimize-int3:
> 7: 0xcc, 0x2e, 0x0f, 0x1f, 0x84, 0xcc, 0x12, 0x34, 0x56, 0x78 -- int3; int3
> optimize-tail(s):
> 8: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xcc, 0x78, 0x56, 0x34, 0x12 -- int3; int3
> optimize-finish-1:
> 9: 0xcc, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- int3; call 0x12345678
> optimize-finish-2:
> 9: 0x48, 0x8d, 0x64, 0x24, 0x80, 0xe8, 0x78, 0x56, 0x34, 0x12 -- lea -0x80(%rsp),%rsp; call 0x12345678

sorry I missed this reply.. awesome, I'll check how to do this

> 
> > @@ -1095,14 +1125,25 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  		  unsigned long vaddr)
> >  {
> >  	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags)) {
> > -		int ret = is_optimized(vma->vm_mm, vaddr);
> > -		if (ret < 0)
> > +		uprobe_opcode_t insn[OPT_INSN_SIZE];
> > +		int ret;
> > +
> > +		ret = copy_from_vaddr(vma->vm_mm, vaddr, &insn, OPT_INSN_SIZE);
> > +		if (ret)
> >  			return ret;
> > -		if (ret) {
> > +		if (__is_optimized((uprobe_opcode_t *)&insn, vaddr)) {
> >  			ret = swbp_unoptimize(auprobe, vma, vaddr);
> >  			WARN_ON_ONCE(ret);
> >  			return ret;
> >  		}
> > +		/*
> > +		 * We can have re-attached probe on top of jmp8 instruction,
> > +		 * which did not get optimized. We need to restore the jmp8
> > +		 * instruction, instead of the original instruction (nop10).
> > +		 */
> > +		if (is_swbp_insn(&insn[0]) && insn[1] == OPT_JMP8_OFFSET)
> > +			return uprobe_write_opcode(auprobe, vma, vaddr, JMP8_INSN_OPCODE,
> > +						   false /* is_register */);
> 
> Coding style wants { } on any multi-line statement, even if its only one
> statement.

will fix

thanks,
jirka
