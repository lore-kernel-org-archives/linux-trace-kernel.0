Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28171537A7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 17:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742405087; cv=none; b=IsArOsGvvQtoycTUey6ZjNTQQdUc3YdeHTCmc4O10CyhOxrbidpkZ//h5nikDviMf7r+AOqcC3RnLA9vMDu59L7xqniwXCDe7EJed/1b+LKNLTkaKjEW2Uf+9R5v9Lmtde0GUZDMMYLbmwrjmONCj7jIduBAfmPF5gGa9MI1fDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742405087; c=relaxed/simple;
	bh=gic5TJGgxxzRKjumPuv3tUCOhcLyMwuvkayfwcKIDGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYZs1OJO6XuWJPYCUP/JChDhlOMcW3FJPXgWwNzKrz+pCQ9XekHBDvg6AjeW4JwXGs5sY1yhNwtVhgMO7pDC2lf99csGQNNqMtKnpfUKB3bUkcYPOtxdOmMq1zYwj9IC+I3e5//Ix91CBgQ62N580Lr0CQ5n3zCcmtfokoMuDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=u6WmUBDe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="u6WmUBDe"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224019ad9edso31681605ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Mar 2025 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1742405085; x=1743009885; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ovtjsc/ngsMtbRru+3v3f/ts46HtxiqzAUDsNuQW/M=;
        b=u6WmUBDe70oiYQsofHKtFLi3UVsV41tiYrqOKAlelc3ksn/v9SPPn75e90pPLOvK+B
         ouJhKJ8AyWtRUAoGhJ8+HVeErEiWmYCYX1IpEtFov3GL7gdYgK7KPkRasr5twcCUtEwi
         O/bRTzmceUmxQFvyqK0xXMu2cxoER8hvipPLBLnPAp6r1KmvIkxvE9Xyh/R7D6gZq7G6
         6U+8WHOHbG8uqfjDss3BEMsfA/lpHwxaP3L+HWsePBf5p58fkYyiKOjbFmnLTHm9dPIU
         oT4VrT3gBCS78T7x8d26Mo5VlLnqXXFl5Zf4mPZwiWQxvhf3Rwi5P5Fh+YWHNyLzLSUy
         OYUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742405085; x=1743009885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ovtjsc/ngsMtbRru+3v3f/ts46HtxiqzAUDsNuQW/M=;
        b=LrqHkzXRhxfuWoQycJDRFVPnnQPxNO+VsNFiHVVqI9Kk9A/iclmcJZps1OJRZ/toU4
         l/ZXoW/KgDPb646dWX2UNrNMGMTimm3K0s5MREigiwk4xAwVHbqwb/TYr4pNDDsCtlCH
         VF+96VizrNKJaFwUC7YNXYnwe8JKVPg+wzV1evMZi6xdidTPo7ISsTygPA/4wRJigDYf
         EsJw/38GJf5TzOqnX47Md4h8OjuD00NVErbFU/YNFirDXL4tHkgz+DQSa07yiCJwM6Y6
         uOSPPLh0kk3C1Hac6LfHg9hwAbV3DQak+y+6DDFJaa1dNMZ05p0aT8DHVgTN2fUzSJHt
         bqsA==
X-Forwarded-Encrypted: i=1; AJvYcCU9ge74AtVpMG0ti+G1pgbZKPOh3PlmWyQlgQy1ushH61XkZvnUIai2pbHp065/Qg2wL7ZkizkjzDCSYQNnnS83Q0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX3G9zn2nhFlWTRyMIeU1RmzfXfkMT4qnpmToFnQsA5O3zxMCS
	R8xxK9IZwPiq0fohgFrm+m4ojViLDOsnPVYi9Do/qN9xZvbVkCi/bNR9EiYG19Q=
X-Gm-Gg: ASbGncuwdkfMGcbMq/hl2uAvwUhApanoKccWosD/Eq/OQAoCOcoyjkrmUwTZoS22MPi
	T3G8yIMeb3EbDiQclbPHDtIErFwKcEIeb402MBtgRJ9rxf9ajNPdZkPuxcH/0XWHUGqFwkydp6V
	2/uV1E0xg6u+5Ije21QFVYjjJlR5px5A4lJeg0RCLDsYP+aRgc4qYgwE+5exOIODCvHnZmFCnge
	qnxh1uCnstOmlQ3Xp5/7g57Y9xy+ZmZb0G7WWsYmEZSMep+7Bo9dT0vL+qXGKhhPXHeS1hu41f/
	RxqGUErTOM5q0yPw+tvPnitUdjEu+jPc2OFPrdsc
X-Google-Smtp-Source: AGHT+IGGukMmGzrRkcCLcnDVIfPfEcGzaPbBFEMioj9IaaorGdbf4I/BJxhdPW8WI0glghzqTFGz+Q==
X-Received: by 2002:a17:903:41ce:b0:224:1ec0:8a1a with SMTP id d9443c01a7336-22649caaa83mr46300995ad.51.1742405085227;
        Wed, 19 Mar 2025 10:24:45 -0700 (PDT)
Received: from ghost ([2601:647:6700:64d0:4763:97aa:9309:154a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6888562sm117615825ad.2.2025.03.19.10.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 10:24:44 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:24:42 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	Pasha Bouzarjomehri <pasha@rivosinc.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/2] riscv: Move nop definition to insn-def.h
Message-ID: <Z9r92tCdsjoJTQ88@ghost>
References: <20250318-runtime_const_riscv-v9-0-ddd3534d3e8e@rivosinc.com>
 <20250318-runtime_const_riscv-v9-1-ddd3534d3e8e@rivosinc.com>
 <20250319-3bf29b05bf02bfdaa32b261c@orel>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319-3bf29b05bf02bfdaa32b261c@orel>

On Wed, Mar 19, 2025 at 04:27:39PM +0100, Andrew Jones wrote:
> On Tue, Mar 18, 2025 at 05:38:45PM -0700, Charlie Jenkins wrote:
> > We have duplicated the definition of the nop instruction in ftrace.h and
> > in jump_label.c. Move this definition into the generic file insn-def.h
> > so that they can share the definition with each other and with future
> > files.
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/ftrace.h   | 1 -
> >  arch/riscv/include/asm/insn-def.h | 2 ++
> >  arch/riscv/kernel/ftrace.c        | 6 +++---
> >  arch/riscv/kernel/jump_label.c    | 4 ++--
> >  4 files changed, 7 insertions(+), 6 deletions(-)
> > 
> > diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> > index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..b7f361a50f6445d02a0d88eef5547ee27c1fb52e 100644
> > --- a/arch/riscv/include/asm/ftrace.h
> > +++ b/arch/riscv/include/asm/ftrace.h
> > @@ -79,7 +79,6 @@ struct dyn_arch_ftrace {
> >  #define AUIPC_RA		(0x00000097)
> >  #define JALR_T0			(0x000282e7)
> >  #define AUIPC_T0		(0x00000297)
> > -#define NOP4			(0x00000013)
> >  
> >  #define to_jalr_t0(offset)						\
> >  	(((offset & JALR_OFFSET_MASK) << JALR_SHIFT) | JALR_T0)
> > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > index 9a913010cdd93cdfdd93f467e7880e20cce0dd2b..0a1fc5134f29da190554c59f8cee3b5374c9aa2d 100644
> > --- a/arch/riscv/include/asm/insn-def.h
> > +++ b/arch/riscv/include/asm/insn-def.h
> > @@ -200,4 +200,6 @@
> >  #define ZAWRS_WRS_NTO	".4byte 0x00d00073"
> >  #define ZAWRS_WRS_STO	".4byte 0x01d00073"
> >  
> > +#define RISCV_INSN_NOP4	0x00000013U
> 
> This should be _AC(0x00000013, U), but since this is the first of its kind
> (all other defines are of the form ".4byte ..." -- either explicitly, like
> the ones above, or through the INSN_* macros), then it feels like it
> either doesn't belong here at all or that we should provide it and a
> ".4byte ..." version.

Sure, I don't have a strong opinion about this. I was debating adding
the .4byte version also but decided against it because it isn't being
used yet, I will add it.

- Charlie

> 
> Thanks,
> drew
> 
> > +
> >  #endif /* __ASM_INSN_DEF_H */
> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > index 3524db5e4fa014a4594465f849d898a030bfb7b8..674dcdfae7a149c339f1e791adb450535f22991b 100644
> > --- a/arch/riscv/kernel/ftrace.c
> > +++ b/arch/riscv/kernel/ftrace.c
> > @@ -36,7 +36,7 @@ static int ftrace_check_current_call(unsigned long hook_pos,
> >  				     unsigned int *expected)
> >  {
> >  	unsigned int replaced[2];
> > -	unsigned int nops[2] = {NOP4, NOP4};
> > +	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
> >  
> >  	/* we expect nops at the hook position */
> >  	if (!expected)
> > @@ -68,7 +68,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
> >  				bool enable, bool ra)
> >  {
> >  	unsigned int call[2];
> > -	unsigned int nops[2] = {NOP4, NOP4};
> > +	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
> >  
> >  	if (ra)
> >  		make_call_ra(hook_pos, target, call);
> > @@ -97,7 +97,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> >  int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
> >  		    unsigned long addr)
> >  {
> > -	unsigned int nops[2] = {NOP4, NOP4};
> > +	unsigned int nops[2] = {RISCV_INSN_NOP4, RISCV_INSN_NOP4};
> >  
> >  	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
> >  		return -EPERM;
> > diff --git a/arch/riscv/kernel/jump_label.c b/arch/riscv/kernel/jump_label.c
> > index 654ed159c830b3d5e34ac58bf367107066eb73a1..b4c1a6a3fbd28533552036194f27ed206bea305d 100644
> > --- a/arch/riscv/kernel/jump_label.c
> > +++ b/arch/riscv/kernel/jump_label.c
> > @@ -11,8 +11,8 @@
> >  #include <asm/bug.h>
> >  #include <asm/cacheflush.h>
> >  #include <asm/text-patching.h>
> > +#include <asm/insn-def.h>
> >  
> > -#define RISCV_INSN_NOP 0x00000013U
> >  #define RISCV_INSN_JAL 0x0000006fU
> >  
> >  bool arch_jump_label_transform_queue(struct jump_entry *entry,
> > @@ -33,7 +33,7 @@ bool arch_jump_label_transform_queue(struct jump_entry *entry,
> >  			(((u32)offset & GENMASK(10,  1)) << (21 -  1)) |
> >  			(((u32)offset & GENMASK(20, 20)) << (31 - 20));
> >  	} else {
> > -		insn = RISCV_INSN_NOP;
> > +		insn = RISCV_INSN_NOP4;
> >  	}
> >  
> >  	if (early_boot_irqs_disabled) {
> > 
> > -- 
> > 2.43.0
> > 
> > 
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
