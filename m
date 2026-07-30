Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667A31C2AA;
	Thu, 30 Jul 2026 00:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785369795; cv=none; b=kZ4mye9ly/5PWbKM5bjyyXcg6vF/QLZ41sDUgwDvnLGkMEswjB5bksRVnFvK+gl20bK97auzZi2PMCLPN1VmdfkzHXVVT3n6/v/BH+xSFfUZBmrwLGaShBMZ9cVrbN8eQhNa4V4MyVebOfEkRXz4U1kRJGbJkBkRH7q/E4VuClA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785369795; c=relaxed/simple;
	bh=A8Oucm4HJCT1VFbtub/ajcbP4AfSKFCrDYz2fmJm4Eg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mbkfQEoT3XMPb95Vxd+a4Xn8BTwDfsCxEx84EVZ0BN2YaM942woqzOh0zPzfmj9Bzi88KVASZPQveOhF9g7OcSi94z0tbniqyCSukMsMBRBrY3C/xYAncPHdLE13RQp8otRYlClTA+K1SCAjvKuu/SzvmSh1rHutBGDIl+y3qXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5nFSGTa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5nFSGTa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B0A1F000E9;
	Thu, 30 Jul 2026 00:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785369794;
	bh=TZXWw/54kDIDx73XnHw22X7yeZR5LWN5LDGxddSIeDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i5nFSGTa54IX2AUca+NVsi84ye/eHv0R/PXeVpCmikWEvqGvVEgNq01rWwCctSwKK
	 mcSGvF3NJ2w4pKWWSewA8xqOsYR1ecGWQe+m9DBZu7LmSPKbIh1aJ98HRt7Qyvm0aV
	 oQk7YKhzp9qUhN5VQCcWwqtj/TSSi/pWOQCDTEYW3ZB1zG2vznlvzhwlgz66DRjFYR
	 +0oD2xTAN95YjfGa/2w0oug19eFahFBxbosPh8KDHTheLHoiAWJ+TvHESMEY8wz9Tk
	 brs3/patuZKp+2R16Bh8C86IZ9tQkrrWOxXOO+CNlRDXVDU4uXSwY1nS7XgB2UVAxH
	 A1t9WCsd6A78A==
Date: Thu, 30 Jul 2026 09:03:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <steven@rostedt.org>
Cc: Hongyan Xia <hongyan.xia@transsion.com>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Dennis Zhou <dennis@kernel.org>,
 Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, Oleg Nesterov
 <oleg@redhat.com>, Naveen N Rao <naveen@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Jiazi Li <jiazi.li@transsion.com>,
 Pu Hu <hupu@transsion.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "llvm@lists.linux.dev"
 <llvm@lists.linux.dev>
Subject: Re: [RFC PATCH 9/9] arm64/debug: Mark debug exception helpers
 __always_inline
Message-Id: <20260730090307.24d3e4b1041f30d87d390e1c@kernel.org>
In-Reply-To: <20260729140846.3c18f437@gandalf.local.home>
References: <cover.1785153469.git.hongyan.xia@transsion.com>
	<eb38b41ae1b3216ec69fb45555ef5df57efd7b8d.1785153469.git.hongyan.xia@transsion.com>
	<20260729140846.3c18f437@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 14:08:46 -0400
Steven Rostedt <steven@rostedt.org> wrote:

> 
> Masami,
> 
> 
> On Mon, 27 Jul 2026 12:25:48 +0000
> Hongyan Xia <hongyan.xia@transsion.com> wrote:
> 
> > From: Hongyan Xia <hongyan.xia@transsion.com>
> > 
> > Static inline should be enough to actually inline functions for most
> > compilers, but my Clang-19 somehow thinks it's better to outline them.
> > These tiny helpers then live in normal .text sections instead of
> > .noinstr sections, violating noinstr.
> > 
> > Mark them __always_inline so the compiler can never outline them.
> > 
> > Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> > ---
> >  arch/arm64/include/asm/esr.h       | 2 +-
> >  arch/arm64/include/asm/percpu.h    | 2 +-
> >  arch/arm64/include/asm/preempt.h   | 4 ++--
> >  arch/arm64/include/asm/ptrace.h    | 4 ++--
> >  arch/arm64/kernel/debug-monitors.c | 2 +-
> >  include/linux/kprobes.h            | 8 ++++----
> 
> Are you OK with this patch? If so, can you ack it?

Yeah, this patch looks good to me. Anyway these are expected to be
inlined.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

For other patches, Sashiko noted some comments, I need to check it.

Thank you,

> 
> -- Steve
> 
> >  6 files changed, 11 insertions(+), 11 deletions(-)
> > 
> 
> [..]
> 
> > diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
> > index 8c4f3bb24429..5880445ed0f0 100644
> > --- a/include/linux/kprobes.h
> > +++ b/include/linux/kprobes.h
> > @@ -384,17 +384,17 @@ static inline void kprobe_ftrace_kill(void) {}
> >  struct kprobe *get_kprobe(void *addr);
> >  
> >  /* kprobe_running() will just return the current_kprobe on this CPU */
> > -static inline struct kprobe *kprobe_running(void)
> > +static __always_inline struct kprobe *kprobe_running(void)
> >  {
> >  	return __this_cpu_read(current_kprobe);
> >  }
> >  
> > -static inline void reset_current_kprobe(void)
> > +static __always_inline void reset_current_kprobe(void)
> >  {
> >  	__this_cpu_write(current_kprobe, NULL);
> >  }
> >  
> > -static inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
> > +static __always_inline struct kprobe_ctlblk *get_kprobe_ctlblk(void)
> >  {
> >  	return this_cpu_ptr(&kprobe_ctlblk);
> >  }
> > @@ -449,7 +449,7 @@ static inline struct kprobe *get_kprobe(void *addr)
> >  {
> >  	return NULL;
> >  }
> > -static inline struct kprobe *kprobe_running(void)
> > +static __always_inline struct kprobe *kprobe_running(void)
> >  {
> >  	return NULL;
> >  }
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
