Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E70B19066D;
	Mon, 28 Apr 2025 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857022; cv=none; b=cuEUNt1s3h20pmL4HM1qKMfQbRbkVG7dlgDop/T0opbmegXp7xux5BhXtezHHyUb4ahz1DqcYb7gnvB25dFmHN1IKnFNp98UbYQ1j4BqlXh8EV5Z1CaUNst3uiB1lnKoFXdZ/MKOGzEgecQjl+0qc49aKSuf/KPesXX8luOse38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857022; c=relaxed/simple;
	bh=TASeDazyN7eXm09e3SBOcYITDNYVQynsbbWL4B8Xze8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ma/a+cdS/weBiCsUe9tXZpFx2KkX1HWJ+TOFBNuttNl5wKjuwA0eK+liC9EDcMa2j2A1adQbWffxOiC04VB8WrQ3YnLlxSijHPa1wMP0EIDN/9ZLZKoNqLZ0v1H4BAMDe7TjMFsmldZGMHQIEWRADuG9Ei3jila7JpgovHQ4Dng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bERNZOQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bERNZOQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A30C4CEEC;
	Mon, 28 Apr 2025 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745857021;
	bh=TASeDazyN7eXm09e3SBOcYITDNYVQynsbbWL4B8Xze8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bERNZOQQrexttEzrgZWshYjafBJgHQAsisgO24FpIDVb+uhCEMDrekM4VJ9BTqlA7
	 cwjqLwwncVhECH51Xzc77fswAKk0r2/n01kicuYCLiWprYYgWDbbBmrGH6IcpysNLi
	 a+2QXvaLvKObqdEe1DNFn5mwCn2jfpvfwX5l1cGdGVPFAMYE47FINopdEHq2dmjyN/
	 9MuVEC+kBahoyCMt5sUQbD2Itumofu5jPWr6YMs0BK6vQGCfrePgV16LaeViHtpBJp
	 tudv4ZXTl6t04HcUOl52XejylY7a4meOQfH4ieJTMTZD0pe+Df0YSsC+crkmXiecwp
	 stZ28WANOwddw==
Date: Mon, 28 Apr 2025 09:16:59 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Indu Bhagat <indu.bhagat@oracle.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Jens Remus <jremus@linux.ibm.com>, x86@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 5/6] x86/vdso: Use CFI macros in
 __vdso_sgx_enter_enclave()
Message-ID: <nl5qjjmdqgd6hrxefkhihjmzzdzt6lsjsil74pemlrywvsezkr@syb6jbpc2fav>
References: <20250425023750.669174660@goodmis.org>
 <20250425024023.000117829@goodmis.org>
 <2d81ea94-e46e-497c-bbfb-8db38203e57c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d81ea94-e46e-497c-bbfb-8db38203e57c@oracle.com>

On Fri, Apr 25, 2025 at 04:22:22PM -0700, Indu Bhagat wrote:
> On 4/24/25 7:37 PM, Steven Rostedt wrote:
> > From: Josh Poimboeuf <jpoimboe@kernel.org>
> > 
> > Use the CFI macros instead of the raw .cfi_* directives to be consistent
> > with the rest of the VDSO asm.  It's also easier on the eyes.
> > 
> > No functional changes.
> > 
> 
> Although unrelated to the current intent of the patch, a question:
> 
>   Why does the stub after .Linvoke_userspace_handler in vsgs.S not have CFI
> directives ?

Yeah, looks like that stack alignment code needs some CFI.

-- 
Josh
