Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E721F30C3;
	Fri,  9 Jan 2026 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966724; cv=none; b=imXk5nNPlUhcV9iTC9cfq9x8r4lCE9yIdhZBCg251TXhOM8/96OouEHRama9n/XHCYuDtKsE9AsDbKg4JLOdwoU5t9GEzoedtQh1BU1TMSVM4LBNak/P5ScYiClnQqVu0TEYrqpDByF80RFaoURYpVNaT8xJWnlLMXcLbECHrgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966724; c=relaxed/simple;
	bh=JmQoDU+xB61L0vG2xAw8si4DDlJ4kpYKIP6hcBYkDHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcjOg70DGdkDEbYRtaQlJquUP5EKcBTk/t6IGuJNok0aQ9S3vlrVtUCxciQa/mAzBGZILeHwC2/Jpm0FU41CR63kNWHFWbLW9c4fnj/2rQ4TQmSvQ6i41jgH8y/CTfuCUQVBohyYYFwJDrN91KLw9zaOg1owkYXfPh00n/Lcs8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOuJ4cz9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOuJ4cz9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD79C4CEF1;
	Fri,  9 Jan 2026 13:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767966723;
	bh=JmQoDU+xB61L0vG2xAw8si4DDlJ4kpYKIP6hcBYkDHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VOuJ4cz9fYa82d1d6GkpK6UUxf3+Sy7pmJZyTUwXXj9por6Q9uHTFlfFKmyS136Qs
	 dr7vgDzlW8nrWJn4VqL+XT25/385bgjfUBtgZrYqS0S3Rb9QUZWvsh8d+FUTHijpAF
	 ORbnYjrpgGOg8kDPHmc20UzpM5wPx7TThRsrX2WmDfi/ck2qBDHH4TOORR3R40Ky9z
	 qjdvGE6Ig52LMlCi7t9XAErPJ4si42O35nxRtWKEB4vWVUN2hHVHZ6d/Md5IwvNjt4
	 bRilLQgGAETr9RumMECFEh/JW10F4c5deie6C/LQCdzU2Tpk665P66uwHEnPCm79C0
	 yxdQA1QmVoMUQ==
Date: Fri, 9 Jan 2026 19:20:55 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-trace-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, llvm@lists.linux.dev, Maryam Moghadas <maryammo@ca.ibm.com>
Subject: Re: [PATCH 1/3] powerpc64: make clang cross-build friendly
Message-ID: <aWEHPEJFYccmCVQK@blrnaveerao1>
References: <20251108210405.2375472-1-hbathini@linux.ibm.com>
 <20251108210405.2375472-2-hbathini@linux.ibm.com>
 <rtnn6dd6y3refo7myc4crzmrunbuyabr2ewlyk7oe4yx3f2rl2@wzoyvsucfeyf>
 <8141c6eb-f2b7-4a19-b637-af699bb8d5c4@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8141c6eb-f2b7-4a19-b637-af699bb8d5c4@linux.ibm.com>

On Mon, Dec 08, 2025 at 09:32:06PM +0530, Hari Bathini wrote:
> Thanks for the review, Naveen.
> 
> On 24/11/25 11:19 am, Naveen N Rao wrote:
> > On Sun, Nov 09, 2025 at 02:34:03AM +0530, Hari Bathini wrote:
> > > ARCH_USING_PATCHABLE_FUNCTION_ENTRY depends on toolchain support for
> > > -fpatchable-function-entry option. The current script that checks
> > > for this support only handles GCC. Rename the script and extend it
> > > to detect support for -fpatchable-function-entry with Clang as well,
> > > allowing clean cross-compilation with Clang toolchains.
> > > 
> > > Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> > > ---
> > >   arch/powerpc/Kconfig                                         | 5 +++--
> > >   ...-function-entry.sh => check-fpatchable-function-entry.sh} | 0
> > >   2 files changed, 3 insertions(+), 2 deletions(-)
> > >   rename arch/powerpc/tools/{gcc-check-fpatchable-function-entry.sh => check-fpatchable-function-entry.sh} (100%)
> > > 
> > > diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> > > index 325c1171894d..dfb62e211c92 100644
> > > --- a/arch/powerpc/Kconfig
> > > +++ b/arch/powerpc/Kconfig
> > > @@ -568,8 +568,9 @@ config ARCH_USING_PATCHABLE_FUNCTION_ENTRY
> > >   	depends on FUNCTION_TRACER && (PPC32 || PPC64_ELF_ABI_V2)
> > >   	depends on $(cc-option,-fpatchable-function-entry=2)
> > >   	def_bool y if PPC32
> > > -	def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh $(CC) -mlittle-endian) if PPC64 && CPU_LITTLE_ENDIAN
> > > -	def_bool $(success,$(srctree)/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh $(CC) -mbig-endian) if PPC64 && CPU_BIG_ENDIAN
> > > +	def_bool $(success,$(srctree)/arch/powerpc/tools/check-fpatchable-function-entry.sh $(CC) -mlittle-endian) if PPC64 && CPU_LITTLE_ENDIAN && CC_IS_GCC
> > > +	def_bool $(success,$(srctree)/arch/powerpc/tools/check-fpatchable-function-entry.sh $(CC) -target ppc64le -mlittle-endian) if PPC64 && CPU_LITTLE_ENDIAN && CC_IS_CLANG
> > 
> > Can you instead pass $(CLANG_FLAGS) to retain the same command across
> > gcc/clang?
> 
> Should work, I guess.
> But do I need to test for any additional clang flags that
> may interfere with what we are trying to check here?

From what I can tell, $(CLANG_FLAGS) includes a fairly static set of 
flags which will be included alongside other $CFLAGS. So, I don't think 
anything special should be needed there.

- Naveen

