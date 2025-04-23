Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7C2F41;
	Wed, 23 Apr 2025 00:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369081; cv=none; b=f+3KcZSnotCEH2ZBjL0+zaoTyuCsOR2yzRqpm8BQa+9drAP5rdYZ3nj7e0KhPdEOwjxdRfVtBPentayZg3hKyuKpsVPe+s+BNadYqodub+Bdq8fIJJ+0VLKRDw7nI2jC6lVTqVYILUFtlJQ7lVf//49+YxeEg0suUEsjRG9rlKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369081; c=relaxed/simple;
	bh=JTXqV8oT0II9JNsm9+6s5usVsSgR1/1bwJyriQGXLUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DRmCrJIlYbxy4pS3jc+UBlUnHTs1JH10nv4MckSnhYPwH4Zfy46h7vP8P/Tna+tw9mOGbNmt9shP/MAaD3jTM8xgRa/mnJy9/H/Gp0B7+l2YHLzN0Af1sZUYvzgGNa8iJiEQuL4LKIn3/QxZeG5++7Ltj9SIrqCEIUzBkKgfTDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOyrJ+eV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOyrJ+eV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33E6C4CEE9;
	Wed, 23 Apr 2025 00:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745369081;
	bh=JTXqV8oT0II9JNsm9+6s5usVsSgR1/1bwJyriQGXLUc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EOyrJ+eVx1eJuduXiqYSxmuGTnqkBIidIVFwTm1UsCZRh4fAdsJ7pBpqKzh5SP/Bt
	 n9QK7AU1N2jp2AgAp4ngsoVfWbEvqNyzRuHvnqWLd9xp76BaUA41WxAAgmRTW0bXLj
	 /CCMespB2AYirddwhSqcJZNdQaIzwLr8GqdoE9kDgMRtHKjuitRkYW+zGthiO3kApZ
	 Qn0QzSEdoJWdu6LSx6adh6NxG1Qjlwgr7jxGVeAmfY3sD86DxemZH+dfJ1yv3eJNnV
	 aci/dF7WFw8/9HHyWGDy+p+kZKK5nhvHiG9/C3qk3FLJrJKx3v+t+vAzrncdc8BtMv
	 Ea/cC/mN7L/0A==
Date: Tue, 22 Apr 2025 17:44:37 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Remus <jremus@linux.ibm.com>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v5 3/6] x86/asm: Fix VDSO DWARF generation with kernel
 IBT enabled
Message-ID: <nqm6xphzy5hptxvmeajrwaklxneivdwd6rcs5lvtrglecbnkwv@rpmclrmxzwwh>
References: <20250422183439.895236512@goodmis.org>
 <20250422183722.404841398@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250422183722.404841398@goodmis.org>

On Tue, Apr 22, 2025 at 02:34:42PM -0400, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> The DWARF .cfi_startproc annotation needs to be at the very beginning of
> a function.  But with kernel IBT that doesn't happen as ENDBR is
> sneakily embedded in SYM_FUNC_START.  As a result the DWARF unwinding
> info is wrong at the beginning of all the VDSO functions.
> 
> Fix it by adding CFI_STARTPROC and CFI_ENDPROC to SYM_FUNC_START_* and
> SYM_FUNC_END respectively.  Note this only affects VDSO, as the CFI_*
> macros are empty for the kernel proper.
> 
> Fixes: c4691712b546 ("x86/linkage: Add ENDBR to SYM_FUNC_START*()")
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> [ Fixed rebased issues. May need extra review ]
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v4: https://lore.kernel.org/all/5c7992c111adee94e242fbca2b3e64ab8e96e595.1737511963.git.jpoimboe@kernel.org/
> 
> - Rebased to latest kernel which had changes to the ENDBR caused by:
>   582077c94052 ("x86/cfi: Clean up linkage")

The code looks good, though that bug was already fixed up by
582077c94052 ("x86/cfi: Clean up linkage").  So this is really just a
cleanup now.  The "Fixes" tag can be removed, with the commit log
something like: 

Add CFI_STARTPROC and CFI_ENDPROC annotations to the SYM_FUNC_* macros
so the VDSO asm functions don't need to add them manually.  Note this
only affects VDSO, the CFI_* macros are empty for the kernel proper.

-- 
Josh
