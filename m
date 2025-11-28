Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DB01F9F47;
	Fri, 28 Nov 2025 10:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764324705; cv=none; b=HKEvJcP760r+QRflzsPq1kdWwBatg12BNGo7Fhkd3W4+jTCDMizSQznGl35VwPZ/IfArDnkgBwgYttJYtM0xNgdKKPLI3glh3rHdBlG4v7DkGo70COplV47L8Y0QIqmkS0BfN3za7iivKAzZkDIzMAo8fJROeraGDsEumNGv5UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764324705; c=relaxed/simple;
	bh=6WI2CxYYMpRpfu9DioP9Fw2VmxH17gtemr21Lmin3ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=filgrkjbOK9d13ozlEzvv12ROcpUA++GICTLm9XYtGwHHA2SWGbzBQ0ekUtWontEw7Hj/GNbOa1qFOr+NFWA7AHybATt5auAz3RSJoeCZsy+myicW1Is0VbHIr8ST9djRvvjCVXHKO1IVhI40MZzuWpfTvN8mH00lIyQV9dbm2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KT7xwThG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KT7xwThG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7JmcTbLyT5izeVGuP2Mp4uRx5abZaxO/JVtsoWNxe48=; b=KT7xwThGksFlsfzkAx7qk/CflY
	LXjtr5rP3e9XmuDCO2VGLNTKkB4W7JfKw+PHzGNR9QyPYluYlLHVhsmyZ5unZqtD7rlWBw3/Frg8B
	JHHoSyWthPUiTTABFCllMettgHtEAz5ubqHj6YsKOKhQMmHastJamuyy8w3pwHPvBTrb9bb63BLpQ
	/aoUQnJL3opOUpmu5QCrgZU4STX/DPgeD5oEXk8mKpkcRcHphvl+mJJt9bgv2JTofYS3hoag1RjPt
	QuhwVGXZsf9Z6X6F9XpTKMh/hoScFjz/q68X7c4s+aiX4E/6KCGpZ+W86Wp+tmCc9+/sDgu+F02pp
	yRZltHtg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOua6-0000000BhJS-2ccN;
	Fri, 28 Nov 2025 09:15:58 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0AB62300230; Fri, 28 Nov 2025 11:11:20 +0100 (CET)
Date: Fri, 28 Nov 2025 11:11:19 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Steven Rostedt <rostedt@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH 2/3] unwind_user/fp: Use dummies instead of ifdef
Message-ID: <20251128101119.GI3245006@noisy.programming.kicks-ass.net>
References: <20251125164349.2592874-1-jremus@linux.ibm.com>
 <20251125164349.2592874-3-jremus@linux.ibm.com>
 <20dda91c-46e4-466d-9ebb-7e12fc6f5d28@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20dda91c-46e4-466d-9ebb-7e12fc6f5d28@linux.ibm.com>

On Thu, Nov 27, 2025 at 05:51:47PM +0100, Jens Remus wrote:
> On 11/25/2025 5:43 PM, Jens Remus wrote:
> > This simplifies the code.   unwind_user_next_fp() does not need to
> > return -EINVAL if config option HAVE_UNWIND_USER_FP is disabled, as
> > unwind_user_start() will then not select this unwind method and
> > unwind_user_next() will therefore not call it.
> > 
> > Note that enabling the config option HAVE_UNWIND_USER_FP without
> > defining ARCH_INIT_USER_FP_FRAME, ARCH_INIT_USER_FP_ENTRY_FRAME, and
> > unwind_user_at_function_start() will result in a compile error, which
> > is helpful when implementing support for unwind user fp in an
> > architecture.
> > 
> > Signed-off-by: Jens Remus <jremus@linux.ibm.com>
> 
> > diff --git a/include/linux/unwind_user.h b/include/linux/unwind_user.h
> 
> > @@ -5,9 +5,17 @@
> >  #include <linux/unwind_user_types.h>
> >  #include <asm/unwind_user.h>
> >  
> > -#ifndef ARCH_INIT_USER_FP_FRAME
> > - #define ARCH_INIT_USER_FP_FRAME
> > -#endif
> > +#ifndef CONFIG_HAVE_UNWIND_USER_FP
> > +
> > +#define ARCH_INIT_USER_FP_FRAME
> > +#define ARCH_INIT_USER_FP_ENTRY_FRAME
> 
> Will fix this as follows in the next version:
> 
> #define ARCH_INIT_USER_FP_FRAME(ws)
> #define ARCH_INIT_USER_FP_ENTRY_FRAME(ws)
> 
> > +
> > +static inline bool unwind_user_at_function_start(struct pt_regs *regs)
> > +{
> > +	return false;
> > +}
> 
> Would it be better to provide a generic dummy implementation (see below)
> or should each arch implement that if it cannot tell whether the topmost
> frame is at function start? If so, would it move from linux/unwind_user.h
> to asm-generic/unwind_user.h?  Either way it would need to be outside of
> the !CONFIG_HAVE_UNWIND_USER_FP guard.

I suppose a common fallback would be fine.
