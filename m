Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA393B14BC;
	Fri, 16 Oct 2026 10:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792145643; cv=none; b=Vj8WXV8/eyYJZusWH/H/T+2+um9SvxhTN/cqGZg9RH9ko/FsaeejFt0HDSlMrb6s5WfywZxhLzpxcHsucDQNS1yx5TlbpJVdfeRUVYL+GTepYW/Q8d7Ngr4kc86B5SRLYk4jBUstX2QmN5/xHiHEJh6HpD7Lx1H6wfRT1f82qzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792145643; c=relaxed/simple;
	bh=HcFHvmgxmWGzg24WeGboYzy5XPVHK8biuJzL/4ePzm0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=awAvQI/D2T6rhHqnoT03HEloSW2JQKoSPWkrkXtpJEeAuo2q3/8R9R2rnTORe1frs/yzoCh9KLbmVelVozk9rnC3P6Ia/zObP/rIXWsuVcoRMuiNEGv0CKxF0tTI/WCODvVCHqGCMO/4waBsVjR1z6YzAk9S0XZ1W7Vfz6pb0+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPIhoC9f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QK4XbgSf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPIhoC9f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QK4XbgSf"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792145640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KvR7oQutL7jrEfWP/R+GUbT2UYY00800fNri/81jLPU=;
	b=FPIhoC9f0f1LKG/er39KVSu3yahFfZdPBlbmS9+1ehXmWapObPU416wKuzRi+iHzH3arg9
	HNz5Ys/TusyBKAGCllDKSei2QkhaddF8FAmswoZDUJrsPx+X/OvScRAJ1Im3xvY3lPKRW7
	dhRfxdUx7NSx8T7MOts3jNBQO8zSGAhxqPm5J7e6KUUH+QJ/bRgPs+YAoP1hgBNh57sXoH
	6d/ihnaA5j+nWfdaHNO3sOE6iXkBo+qgztWC1rG/PXh3Bato/GNVw03Nw+kjtGpCORj3D1
	N9x1l9Y1G+nvlKWTpGPiFfnHxUCaoBUR4wBqQKwBMaE+O8vq9GGEhmJXSqmRBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792145640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KvR7oQutL7jrEfWP/R+GUbT2UYY00800fNri/81jLPU=;
	b=QK4XbgSfnoSubrvKF6JfO+oY1KD696knkPtcae5qxtQ3E47EwqyE0unPnbWiI4FDCDh/oM
	Nmr71tfyPbGQSDDA==
To: Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Naveen N Rao <naveen@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Xiaofeng
 Yuan <yuanxiaofeng@eswincomputing.com>
Subject: Re: [PATCH v6 1/2] riscv: kprobes: reject probes inside LR/SC
 sequences
In-Reply-To: <20261016081706.1085-2-yuanxiaofeng@eswincomputing.com>
References: <20261016081706.1085-1-yuanxiaofeng@eswincomputing.com>
 <20261016081706.1085-2-yuanxiaofeng@eswincomputing.com>
Date: Fri, 16 Oct 2026 12:13:58 +0200
Message-ID: <87se263qc9.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Xiaofeng Yuan <yuanxiaofeng@eswincomputing.com> writes:
> +static __always_inline bool riscv_insn_is_lr(u32 code)
> +{
> +	u32 funct5 = (code >> 27) & 0x1f;
> +	u32 funct3 = (code >> 12) & 0x7;
> +
> +	return (code & RV_INSN_OPCODE_MASK) == RVG_OPCODE_AMO &&
> +	       funct5 == RVG_AMO_FUNCT5_LR &&
> +	       (funct3 == RVG_FUNCT3_AMO_W || funct3 == RVG_FUNCT3_AMO_D) &&
> +	       !(code & GENMASK(24, 20));
> +}
> +
> +static __always_inline bool riscv_insn_is_sc(u32 code)
> +{
> +	u32 funct5 = (code >> 27) & 0x1f;
> +	u32 funct3 = (code >> 12) & 0x7;
> +
> +	return (code & RV_INSN_OPCODE_MASK) == RVG_OPCODE_AMO &&
> +	       funct5 == RVG_AMO_FUNCT5_SC &&
> +	       (funct3 == RVG_FUNCT3_AMO_W || funct3 == RVG_FUNCT3_AMO_D);
> +}

There are already RV_EXTRACT_FUNCT3() and RV_EXTRACT_RS2_REG(), we
should use them to avoid code duplications.

And I think we should also have RV_EXTRACT_FUNCT5() to stay consistent.

> +static int __kprobes arch_check_kprobe(unsigned long addr)
>  {
> -	unsigned long tmp, offset;
> +	unsigned long pc, offset;
> +	int outstanding_lr = -1;
>  
> -	/* start iterating at the closest preceding symbol */
>  	if (!kallsyms_lookup_size_offset(addr, NULL, &offset))
> -		return false;
> +		return -EILSEQ;
>  
> -	tmp = addr - offset;
> +	/* pc starts at the closest preceding symbol, a known instruction boundary */
> +	pc = addr - offset;
>  
> -	while (tmp <= addr) {
> -		if (tmp == addr)
> -			return true;
> +	while (pc < addr) {
> +		u32 insn = get_unaligned((u32 *)pc);
> +		unsigned int len = GET_INSN_LENGTH(insn);
>  
> -		tmp += GET_INSN_LENGTH(*(u16 *)tmp);
> +		if (riscv_insn_is_lr(insn))
> +			outstanding_lr = 0;
> +		else if (riscv_insn_is_sc(insn))
> +			outstanding_lr = -1;
> +		else if (outstanding_lr >= 0 && ++outstanding_lr > MAX_LRSC_GAP)
> +			outstanding_lr = -1;
> +
> +		pc += len;
>  	}

The spec says "The loop comprises only an LR/SC sequence and code to
retry the sequence in the case of failure, and must comprise at most 16
instructions placed sequentially in memory". The 16 instructions limit
includes LR. So I think this implementation is off by one:

    lr     (outstanding_lr=0)
    inst1  (outstanding_lr=1)
    inst2  (outstanding_lr=2)
    ...
    inst16 (outstanding_lr=16)
    inst17 (outstanding_lr=-1)

As it is considering instruction from LR to inst16 to be a loop, so it
allows 17 instructions.

Nam
