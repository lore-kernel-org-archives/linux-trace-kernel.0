Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C86279DA3;
	Wed,  3 Sep 2025 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756895493; cv=none; b=Q0mnxpY57zTxdTuQ235DMcU5hP6FmU/xUBztK0pN6awHctPpUzu0AjQe5r6gq9mb9/oMlLatgxXPsd5oseG8JgoF6PN8qT4N9vl9iitt2TF5A6bkgkqAHwzf+bHhX/heW/tbIyYki1YsOaQy86y8ZG8kW6B0t9CLWKbe/iJLrkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756895493; c=relaxed/simple;
	bh=0B3nLZs7Ua+KW7LjOWjwB9lGSpTmwpy/EG15w0U8e3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxZANJ3/LuEAxj+PYidWTJSz2iHAVp1HmZLbWHeaiMFq5C85zXH1saD8QkzntbeTVtabc5tyOnKuQeNSAZ6auGG4RsGOaICpNghgqXM/2cv8UNlva7GU25OOlI2gdkgcDYrM1w0OSPmkeuejKKVn41toGEcpep9yGDneece6Afg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tth4tRFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tth4tRFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D1FC4CEF0;
	Wed,  3 Sep 2025 10:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756895492;
	bh=0B3nLZs7Ua+KW7LjOWjwB9lGSpTmwpy/EG15w0U8e3k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=tth4tRFfCHGy1dEHvnj7kXw9/jgOF5MohFf9B/2S2wtsL04C9HC718pXarghT+Biq
	 kkb+H8NBzX/qFdL13wvDJNMBrTnhCVz5EWxNya5ZfjEw5Afu9GJmbs1L7IeN9zcfW1
	 /QbguRnl7W406SHwohDd36HLhPULUixtapOWVhQJBo765HlKVCXOJrcHCFxojVnJlk
	 SKgqTTbortv8ZB6Z3v3H0rW24cdQkLr82dguvemFUtrdj5CfpB6JoOLPgF6ISM/R0G
	 G4w6cnckYytQ8bHMpB0EdXM0RLGA+mbiJSTBECybJLaCJrTm/qJa5mTT2QfzaXY1B7
	 Avq7nT/yC8m9Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D85D4CE0FFB; Wed,  3 Sep 2025 03:31:31 -0700 (PDT)
Date: Wed, 3 Sep 2025 03:31:31 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2025.08.13a] [tracing]  364ac25d46:
 WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault
Message-ID: <d1ee722b-eb90-4b7e-9c2f-2db7d3b33ce9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <202508211038.c93e8603-lkp@intel.com>
 <68044ea3-32c1-4d72-9bd3-fe2031669d79@paulmck-laptop>
 <aLebLoM2OQD+KPxQ@xsang-OptiPlex-9020>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLebLoM2OQD+KPxQ@xsang-OptiPlex-9020>

On Wed, Sep 03, 2025 at 09:34:38AM +0800, Oliver Sang wrote:
> hi, Paul,
> 
> On Fri, Aug 29, 2025 at 08:07:41AM -0700, Paul E. McKenney wrote:
> > On Thu, Aug 21, 2025 at 01:26:45PM +0800, kernel test robot wrote:
> > > 
> > > hi, Paul,
> > > 
> > > we also noticed there is similar commit in newer branch
> > >   dev.2025.08.14a
> > >   dev.2025.08.19a
> > > but we didn't finish any bisect for them so far.
> > > 
> > > if the issue is already known and fixed in newer version, please just ignore
> > > this report. sorry if any inconvenience.
> > > 
> > > below full report FYI.
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed "WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault" on:
> > > 
> > > commit: 364ac25d46eea504eb90229d2a1f92e18c1a1eae ("tracing: Guard __DECLARE_TRACE() use of __DO_TRACE_CALL() with SRCU-fast")
> > > https://git.kernel.org/cgit/linux/kernel/git/paulmck/linux-rcu.git dev.2025.08.13a
> > > 
> > > in testcase: boot
> > > 
> > > config: i386-randconfig-004-20250819
> > > compiler: clang-20
> > > test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 4G
> > > 
> > > (please refer to attached dmesg/kmsg for entire log/backtrace)
> > 
> > Thank you for your testing efforts, and apologies for being slow!
> > 
> > Could you please try the diagnostic patch at the end of this email?
> > 
> > 							Thanx, Paul
> 
> by applying the patch, the issue gone. but since you said this is a 'diagnostic
> patch', not sure if it's a real fix. anyway:
> 
> Tested-by: kernel test robot <oliver.sang@intel.com>

Thank you very much!  This tells me that something on the code path from
the tracepoint to the BPF program needs to have preemption disabled.
I will leave the diagnostic patch in my tree, and will be looking into
what the real fix should be.

							Thanx, Paul

> [...]
> 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <oliver.sang@intel.com>
> > > | Closes: https://lore.kernel.org/oe-lkp/202508211038.c93e8603-lkp@intel.com
> 
> [...]
> 
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20250821/202508211038.c93e8603-lkp@intel.com
> > > -- 
> > > 0-DAY CI Kernel Test Service
> > > https://github.com/intel/lkp-tests/wiki
> > 
> > 
> > commit 2d6142ce44dca77fb173bb96850634b169277214
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Aug 28 12:56:42 2025 -0700
> > 
> >     EXP tracing: Diagnostic for __DECLARE_TRACE() use of SRCU-fast
> >     
> >     This patch is intended to test the theory that preemption needs to be
> >     disabled in some portion of the tracing infrastructure extending from
> >     the __DECLARE_TRACE() macro to the target BPF program.
> >     
> >     Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> > index a22c1ab88560b8..c422e4c5ed51ed 100644
> > --- a/include/linux/tracepoint.h
> > +++ b/include/linux/tracepoint.h
> > @@ -273,7 +273,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> >  	static inline void __do_trace_##name(proto)			\
> >  	{								\
> >  		if (cond) {						\
> > -			guard(srcu_fast_notrace)(&tracepoint_srcu);	\
> > +			guard(preempt_notrace)();			\
> >  			__DO_TRACE_CALL(name, TP_ARGS(args));		\
> >  		}							\
> >  	}								\
