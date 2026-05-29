Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C151A6828;
	Fri, 29 May 2026 23:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780098701; cv=none; b=imUGYfiIzJR7j9aLl7tu3phgI+1xOqd66jXCfkG1ACssSczSZoIvZ1Oy/SBHQK4wtNArxD44q55UIlmdHTYUZL+NF4C1ZDKEeds+uRDz4qHn9t9+kv4zUP99BN+S+F3pYWaQ3BVFl1Xk+oHInuK44tu2rOMXFt/w9bbqqSXBDyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780098701; c=relaxed/simple;
	bh=nN5UjqGVeXR76zsZ0UAFX1NArFJF90EKwyyX3qaA/Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aw4QsEy2nnxJjxx6jqnxYLBbabWzvG8gKFIb0ZHhkrGiQ2rCVTxmSrtx9tRC2iDRyzhkiTZvGHYlYLUJhZdqLs0DjveUE6JMkTGNrHfVBOAmi+mNKcnROgMeGM/P5oHQdWp/H5PfKOp2fyscqQ1zH4URcH5Qkl2/DqgfStsoOS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2C65740314;
	Fri, 29 May 2026 23:51:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 22DE11C;
	Fri, 29 May 2026 23:51:36 +0000 (UTC)
Date: Fri, 29 May 2026 19:51:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Eva Kurchatova <eva.kurchatova@virtuozzo.com>, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, jpoimboe@kernel.org,
 samitolvanen@google.com
Subject: Re: [PATCH] tracing: fix CFI violation in probestub helper
Message-ID: <20260529195134.37d4f5cc@fedora>
In-Reply-To: <20260529200826.GO3493090@noisy.programming.kicks-ass.net>
References: <20260524154301.21119-1-eva.kurchatova@virtuozzo.com>
	<20260528164902.1bb985f3@gandalf.local.home>
	<20260529200826.GO3493090@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f56hfxcn7ipn3smed64gt1tuxd4jp78a
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 22DE11C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+jUsw3A9dnyTbe3HhHKhjXaxFDu8SxqXQ=
X-HE-Tag: 1780098696-497061
X-HE-Meta: U2FsdGVkX1+in6OnRFltKWXV/4Onbzv5e1RppnUiwiEu8J67C25TL9/Y0FcM9YyTcWgnYfYVXP8T2YvT9iMRjwjep1tg1W3JClxYuK+v8+2hNm6f82WQwbSSIqsZ4njWaFsnoybi8uVvrKhXZO3BYECZbrXDoMHO/vle9wylAnEmkSWuikxuhjEG8KB7Lcjibwg47R0AjGTTtc4pj2vkSK22JV8HnLyPCMXFvJ5gDyRyBBCRHDjfx3k6NbD2yH5IdBopNp7/kSE6ceF6RUr6eIpH0CsBVGoo8aYngdNHQQEyCw8H7eumUzi1i669intWcoGigV+/DFniZZXIILllfmuzIiNxjlenTldOOxFmJ5Whgub1AOpcg5J2xw/87yrTWIMoAvBn4/YLyqq4l4GVPIhHEPvwoSR/A/6skBONYakzi0XaYoWR24B0WytF2tZG

On Fri, 29 May 2026 22:08:26 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, May 28, 2026 at 04:49:02PM -0400, Steven Rostedt wrote:
> > On Sun, 24 May 2026 18:43:01 +0300
> > Eva Kurchatova <eva.kurchatova@virtuozzo.com> wrote:
> >   
> > > When multiple callbacks are registered on the same tracepoint, probestub
> > > will be indirectly called via traceiter helper.
> > > 
> > > Pointer to probestub callback resides in __tracepoints section, which is
> > > excluded from ENDBR checks in objtool. Pointers to regfunc/unregfunc
> > > callbacks reside in extended structure however, which is not affected.
> > > 
> > > Registering multiple callbacks will result in a #CP exception due to
> > > missed ENDBR in __probestub helper on a CFI-enabled machine.
> > > 
> > > Fix this by adding CFI_NOSEAL annotation to probestub declaration.
> > > 
> > > Fixes: d5173f753750 ("objtool: Exclude __tracepoints data from ENDBR checks")
> > > Signed-off-by: Eva Kurchatova <eva.kurchatova@virtuozzo.com>  

> 
> The only place the function address lives is in that __tracepoint
> section. Since that is explicitly excluded by objtool, it figures there
> are no actual references to __probestub and the function goes on the
> seal list and the kernel explicitly scribbles the ENDBR on boot.
> 
> Then, if it ever gets used on an IBT enabled host, *boom*.

That makes much more sense.

> 
> I agree it would've perhaps been clearer if there was part of a splat in
> the changelog, but the issue is real afaict.
> 
> Also, I do think this:
> 
> > > @@ -356,6 +357,7 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> > >  	void __probestub_##_name(void *__data, proto)			\
> > >  	{								\
> > >  	}								\
> > > +	CFI_NOSEAL(__probestub_##_name);				\
> > >  	DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);
> > >  
> > >  #define DEFINE_TRACE_FN(_name, _reg, _unreg, _proto, _args)		\  
> 
> could do with a comment, explaining why it wants the NOSEAL.

Yes.

Thus, the above change log is totally incorrect and should be updated to:

   tprobes uses a stub function of the tracepoint to allow fprobes to
   attach to the tracepoint call site and have access to its arguments.
   The stub function is called __probestub_##_name() and is only
   referenced as a pointer in the tracepoint structure so that the
   tprobe can have access to it.

   The issue is that the probstub function is only referenced in the
   __tracepoint section and objtool thinks nothing calls it. Since it
   explicitly excludes the __tracepoint section, objtool thinks there
   are no callers so it puts the probstub function into the seal list
   and then the kernel scrubs its ENDBR on boot.

   This becomes an issue if someone were to use a tprobe which will
   register the probestub as a callback to the tracepoint so that a
   fprobe may attach to it and get access to the arguments. Without the
   ENDBR it will make the kernel go BOOM!


Then have a comment in the patch with:

 void __probestub_##_name(void *__data, proto)			\
 {								\
 }								\
+/*								\
+ * The probestub is only used for tprobes and not referenced	\
+ * anywhere else. This causes objtool to think it's not called	\
+ * at all and will add it to the seal list which will remove	\
+ * the ENDBR causing issues if a tprobe is ever used.		\
+ */								\
+CFI_NOSEAL(__probestub_##_name);				\
 DEFINE_STATIC_CALL(tp_func_##_name, __traceiter_##_name);


-- Steve
