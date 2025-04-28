Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B727A108;
	Mon, 28 Apr 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857438; cv=none; b=u18cFdjF9AFw7ulM9Q8PqijX6XCxHlvj7A9e1rYG5Dxb9fr4cj/y1tElIBF60WOoHiSnaJyCvtOJx4UlzIEPMxnwpmESfCjsOB+bk35m8U7bZ86IwsmvUeYcfQDDuJTFSs19dEGYRb5IJQjlpJVMsXjoOthYGIc2lhX/q+Cnb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857438; c=relaxed/simple;
	bh=xDf5umZkFPSJgMJ7wl3HM6HVboLDn8yih9xn6sjKnYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mN8yhNwWJTD5DXG7RTaORDDPmQKGKbc2CxN0cSWXwqG/NuI9fhXf2uC4WGVjAaU05ldJmVjgTuHfO780OAMRGtEFBNBrRnmhHmbB5RPcpx7gonsFWsuV4zeJ/N+2wuit0vXOsAbKbb3OGMnhezgCKDTGqfd8SX4DuCqecNXQFJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW4UjjZy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW4UjjZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E5FC4CEE4;
	Mon, 28 Apr 2025 16:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745857437;
	bh=xDf5umZkFPSJgMJ7wl3HM6HVboLDn8yih9xn6sjKnYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fW4UjjZy/lkiKX0ONaVWzbry9V57fcUyY+mKqc2hBAe69TX4r/tkOvfCF8lAdzozf
	 sEKKXM3EEaSZ8/dUrLnA89mfL75+QjIU0/Dfi0Et9heXti0mZPiYhL5Ux9bt1kGCzw
	 swWEP6XNrngX2+TsuKdasep7CaJRjbqYwtKbdL3Hu/OpTHKFXRUwU/yQJZ5yW0E0ze
	 pCtwHIP7YqfrJ3cl+qbkSh5xP8z6E1Ka9P3fRdz+RKiCVow8m3hEB5IkIUuUDxkRaf
	 Sp8JplhYxQZmH3Sq3SIXkT45Nt+/+HaXR2ueOEooAzjaNTHzT7PNT2zTDW798CN0JW
	 QMLQcv/C7+eiw==
Date: Mon, 28 Apr 2025 09:23:55 -0700
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
Subject: Re: [PATCH 5/6] x86/vdso: Use CFI macros in
 __vdso_sgx_enter_enclave()
Message-ID: <amh7fzsjx4p5nowy3b3j6blkty5ojqf7jawtlslexwzdbxrhc3@zersgacmcnai>
References: <20250425023750.669174660@goodmis.org>
 <20250425024023.000117829@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250425024023.000117829@goodmis.org>

On Thu, Apr 24, 2025 at 10:37:55PM -0400, Steven Rostedt wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Use the CFI macros instead of the raw .cfi_* directives to be consistent
> with the rest of the VDSO asm.  It's also easier on the eyes.
> 
> No functional changes.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  arch/x86/entry/vdso/vsgx.S | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
> index c0342238c976..8d7b8eb45c50 100644
> --- a/arch/x86/entry/vdso/vsgx.S
> +++ b/arch/x86/entry/vdso/vsgx.S
> @@ -24,13 +24,14 @@
>  .section .text, "ax"
>  
>  SYM_FUNC_START(__vdso_sgx_enter_enclave)
> +	SYM_F_ALIGN

I'm not sure why I had this SYM_F_ALIGN here, but it doesn't belong here
and can be removed.

-- 
Josh
