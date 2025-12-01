Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED2123A58B;
	Mon,  1 Dec 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764621033; cv=none; b=Az75FlastZvZBYwU7kQ/yioXWeANjIGBRhbYDiNMqriMbkJLFnClnqJkkHPHoA2gW+uEMWPlFzaLHuhDQ0CE9gy2SMiW+VXCbXv1U5/cd+ZOp8bA0gvi/9zOccVLQCRGQvjpK8HklAz5Gu+00lgnSxNQZzYIlh2OavECRf9nLlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764621033; c=relaxed/simple;
	bh=3dCnTNuicHLtfAnv7VfSWZ6UoU7x8E8Phwpo2c4stq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DKv1RtAOnZjrwPAqBlkQtEEDuZKoEF03NKO430fR+tPYcMwCHOA5iSR0+TSePEXuJxmw72S/LxyGDzI/FW6azpoz/76HSO/S2yGu2WioP4JcbFNcSqe4PtBiKpPrvxbuwuqRc8OIKLtnxveF/xypov/HWilsjfwJPqHzQqoOaw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuPDKOC+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuPDKOC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4770AC4CEF1;
	Mon,  1 Dec 2025 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764621032;
	bh=3dCnTNuicHLtfAnv7VfSWZ6UoU7x8E8Phwpo2c4stq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EuPDKOC+4xQe6r8BtyGlBGashWohtdTYInIa57pVrtfo06XYC3LNkhqzaJbIukCyf
	 FseyNwX7noLdmGXs9YKBvT+ARMRnH7OwQU02OxSdZmJ0NWwAXUSMXb7EoSrFETYYpY
	 UhXh/4UxxsFkAb9AIKGfjyuSszOcxRRmzNh+79P28i7rdn23jeK2OFMtbcD5V7Wqml
	 Y79kFsi43ErWw/ojwO9mI1j1oIX6FmO/CfaGrXZ5ON3ZGxn+rqcKtioblu02Fc5vrM
	 Pp4FaWdywIrWiqhg74Fb5DnM/S4uY9or2sMzEf5vdlULuwTIZ7H0jKU75/6/7HY4Oh
	 CS/Jc0uQ+E8bw==
Date: Mon, 1 Dec 2025 21:30:25 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 2/3] unwind_user/fp: Use dummies instead of ifdef
Message-ID: <aS364Z_XJA2LHA9y@gmail.com>
References: <20251201125416.1239568-1-jremus@linux.ibm.com>
 <20251201125416.1239568-3-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201125416.1239568-3-jremus@linux.ibm.com>


* Jens Remus <jremus@linux.ibm.com> wrote:

> -#ifndef ARCH_INIT_USER_FP_FRAME
> - #define ARCH_INIT_USER_FP_FRAME
> +#ifndef CONFIG_HAVE_UNWIND_USER_FP
> +
> +#define ARCH_INIT_USER_FP_FRAME(ws)
> +
> +#endif /* !CONFIG_HAVE_UNWIND_USER_FP */

Just a nit, there's no need for the closing /* !.. */ 
comment for such a short CPP block - just like it's 
done in the next couple of lines:

> +#ifndef ARCH_INIT_USER_FP_ENTRY_FRAME
> +#define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)
> +#endif

Thanks,

	Ingo
