Received: from eggs.gnu.org (eggs.gnu.org [209.51.188.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2434A2C0F81;
	Thu,  7 May 2026 21:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.51.188.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778188212; cv=none; b=bQ2XUlwVl/HLG0cluEPLDwzXoguFhTmBd77JkqzuEmAP8sXNYafOIM9Vplb2Gd0KGftjvY11P8uSfzIZZQqO6HX15LrVeu31Zg5YZvygmnFyu6fxEzqLaKdW4bY4/1k2Ke09SD82sBB+5gre6Ym0fF+FCQTOzNUnj7Z7igd5J5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778188212; c=relaxed/simple;
	bh=4vYYgErW+nIaCE0SbyZfOCvBLqy8tYt2or1Xez1qDb0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=XPyEqGviwBUqt2sDNJW3im1SBxkauql6kB4ECX3A0LELHVjT0WKZgKEOzykF+7KhpLTDkFHMWMkDn/VEZydoUaqXzbrtl5gMC8uKChyZZZ8+BwHvL5KBy4moJ9e/U7fHpcRejprf/rRuZzd12biS70j0hCMHbq4g1V3d4KFipis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org; spf=pass smtp.mailfrom=gnu.org; dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b=Y7sVmGfN; arc=none smtp.client-ip=209.51.188.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gnu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnu.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnu.org header.i=@gnu.org header.b="Y7sVmGfN"
Received: from fencepost.gnu.org ([2001:470:142:3::e])
	by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.90_1)
	(envelope-from <jemarch@gnu.org>)
	id 1wL5yp-0006c3-30; Thu, 07 May 2026 17:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
	s=fencepost-gnu-org; h=MIME-Version:Date:In-Reply-To:Subject:To:From:
	references; bh=He8ZW3Yxt2pIU0lx/KlHBxrxzoDf/nrfBLSQAW3PhBY=; b=Y7sVmGfNApHedg
	mm/Gp7n9ylo+Z1prHPlj5grQZQTC0hX+704KhpkJE5u/ZRwgl199uXl5wFEUadbwa5j5cCSQeZoNf
	6lcK9jS+2HmtL+i+yGgRqyGThbI5saESW6y4EjxJ4duBguBGy1u3twNhjR7KvorUXe8SlfCiboC4l
	2R6NUthCwcVhRxuXw/o1OOaZxi2lRT4ailXlXPmU9euhDbEgGteYf2ut5WcYeuvWVPi7z1Q1/u77q
	uYE0G7MiuV4nvCSbHd/54rn6geCaOnWPzxqPPiX99YUqpcWmeAXGr0t2/mhW7tpPx66IDy/+gM/lc
	47jBXq7ZOCr/qURhV6QA==;
From: "Jose E. Marchesi" <jemarch@gnu.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, jremus@linux.ibm.com,
 jpoimboe@kernel.org, peterz@infradead.org,
 mingo@kernel.org, jolsa@kernel.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, andrii@kernel.org,
 indu.bhagat@oracle.com,
 beaub@linux.microsoft.com, torvalds@linux-foundation.org,
 akpm@linux-foundation.org,
 fweimer@redhat.com, kees@kernel.org, codonell@redhat.com, sam@gentoo.org,
 dylanbhatch@google.com, bp@alien8.de, dave.hansen@linux.intel.com,
 david@redhat.com, hpa@zytor.com, Liam.Howlett@oracle.com,
 lorenzo.stoakes@oracle.com, mhocko@suse.com, rppt@kernel.org,
 surenb@google.com, vbabka@suse.cz, hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
In-Reply-To: <20260429114355.6c712e6a@gandalf.local.home> (message from
 Steven Rostedt on Wed, 29 Apr 2026 11:43:55 -0400)
Date: Thu, 07 May 2026 14:37:36 +0200
Message-ID: <87zf2bl7jj.fsf@gnu.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


> +/**
> + * sys_stacktrace_setup - register an address for user space stacktrace walking.
> + * @op: Type of operation to perform
> + * @addr_start: The virtual address of the stacktrace information
> + * @addr_length: The length of the stacktrace information
> + * @text_start: The virtual address of the text that @addr_start represents
> + * @text_length: The length of teh text
> + *
> + * This system call is used by dynamic library utilities to inform the kernel
> + * of meta data that it loaded that can be used by the kernel to know how
> + * to stack walk the given text locations.
> + *
> + * Currently only sframes are supported, but in the future, this may be used
> + * to tell the kernel about JIT code which will most likely have a different
> + * format.
> + *
> + * The type command may be extended and parameters may be used for other
> + * purposes.
> + *
> + * Return: 0 if successful, otherwise a negative error.
> + */
> +SYSCALL_DEFINE5(stacktrace_setup, int, op, unsigned long, addr_start,
> +		unsigned long, addr_length, unsigned long, text_start,
> +		unsigned long, text_length)
> +{
> +	switch (op) {
> +	case STACKTRACE_REGISTER_SFRAME:
> +		return sframe_add_section(addr_start, addr_start + addr_length,
> +					  text_start, text_start+text_length);
> +	case STACKTRACE_UNREGISTER_SFRAME:
> +		return sframe_remove_section(addr_start);
> +	}
> +	return -EINVAL;
> +}

FWIW passing start and end of both the tracing data and the text segment
it covers seems reasonable to me.  This covers the case in which the
same tracing data describes several text segments, which can happen with
SFrame and other similar formats.

> diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
> index 7a42b32b6577..54a99cffeec4 100644
> --- a/scripts/syscall.tbl
> +++ b/scripts/syscall.tbl
> @@ -412,3 +412,4 @@
>  469	common	file_setattr			sys_file_setattr
>  470	common	listns				sys_listns
>  471	common	rseq_slice_yield		sys_rseq_slice_yield
> +472	common	stacktrace_setup		sys_stacktrace_setup
