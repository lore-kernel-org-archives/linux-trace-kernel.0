Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7884579C2;
	Tue, 11 Jun 2024 06:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086323; cv=none; b=fNU3Zsl7UCPSKIZWXTIW5LOeHtjKk6bP0ueG48mIFp5LxrWLozonxVwdhvotZevf5eGCgNFmwHs8w63MwpEhsUQM/06YhhQKc/1mO2V/8l11VId/6gjQcYqH2LjKAMH0Uwdsb9zpu+6zDhhJWdf4grU0QlyF9ShnyqayElquVBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086323; c=relaxed/simple;
	bh=FnX0yoxR6ZaCdJZqR446yzRj3FXdbNWw744N+h5an/A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Xc+egQK14IlO3dsTYH2rOepw1KLxB8kotTYuA9ZKUzZgEBnHEW8uvESeYt25Yn5n0ekRk8mif3jNg2FIoxF8olAoVie6bmt4KhzQrxg3IMwX/TJeoKYVV0l12PItoJ2I17Hg3Dcua+PxhpLvJi7bfqpCsyLpkOq/bjPzvf1/kJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0QzyBgY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0QzyBgY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6788BC2BD10;
	Tue, 11 Jun 2024 06:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718086322;
	bh=FnX0yoxR6ZaCdJZqR446yzRj3FXdbNWw744N+h5an/A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0QzyBgY9wKE2btdFa/+xBFG3+ltYad4sCqm9Jge3jI3JlxHyP8QnzBuLCbvjhyAN
	 hsjuBQfSQAzUB3CputC3M+WIz17tUusYN5Kl38dMzAPzoJ1QTNB7sB40BEyAkfAVrE
	 cGKZMjgmQWpGwaNla42q8H/nK6NstaYSd33/b9x5EkwT27tk4+JfzpjKUgnXYBRY7u
	 wsHGkbmDSRmUoF81FUOA2PXmnBts4z/hwGIofZlrCXNoNm9zSftnXhvR+HtmXHq87L
	 RSr9GvnDsk7EWMIOd2a7lsGr6JDMIkUJceDWEXDl8noz2nI3ZijgYq9nYXprzAoVyw
	 Jaegczi5PABxA==
Date: Tue, 11 Jun 2024 15:11:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/3] tracing/kprobe: Remove unneeded WARN_ON_ONCE() in
 selftests
Message-Id: <20240611151159.fefefc259661e7a41afb39ed@kernel.org>
In-Reply-To: <20240610201813.319d6500@gandalf.local.home>
References: <171805478534.52471.6269290579314514778.stgit@devnote2>
	<171805480405.52471.13982671291270977479.stgit@devnote2>
	<20240610201813.319d6500@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 20:18:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Jun 2024 06:26:44 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the kprobe-events selftest shows OK or NG with the reason, the
> > WARN_ON_ONCE()s for each place are redundant. Let's remove it.
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_kprobe.c |   26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> > 
> > diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> > index 16383247bdbf..4abed36544d0 100644
> > --- a/kernel/trace/trace_kprobe.c
> > +++ b/kernel/trace/trace_kprobe.c
> > @@ -2023,18 +2023,18 @@ static __init int kprobe_trace_self_tests_init(void)
> >  	pr_info("Testing kprobe tracing: ");
> >  
> >  	ret = create_or_delete_trace_kprobe("p:testprobe kprobe_trace_selftest_target $stack $stack0 +0($stack)");
> > -	if (WARN_ON_ONCE(ret)) {
> > +	if (ret) {
> >  		pr_warn("error on probing function entry.\n");
> 
> Actually, you can consolidate this to:
> 
> 	if (WARN_ONCE(ret, "error on probing function entry."))

Ahh, OK, let me update it.

> 
> >  		warn++;
> >  	} else {
> >  		/* Enable trace point */
> >  		tk = find_trace_kprobe("testprobe", KPROBE_EVENT_SYSTEM);
> > -		if (WARN_ON_ONCE(tk == NULL)) {
> > +		if (tk == NULL) {
> >  			pr_warn("error on getting new probe.\n");
> 
> And this to:
> 
> 		if (WARN_ONCE(tk == NULL, "error on getting new probe."))

Thank you!

> 
> end so on.
> 
> -- Steve
> 
> >  			warn++;
> >  		} else {
> >  			file = find_trace_probe_file(tk, top_trace_array());
> > -			if (WARN_ON_ONCE(file == NULL)) {
> > +			if (file == NULL) {
> >  				pr_warn("error on getting probe file.\n");
> >  				warn++;
> >  			} else
> > @@ -2044,18 +2044,18 @@ static __init int kprobe_trace_self_tests_init(void)
> >  	}
> >  
> >  	ret = create_or_delete_trace_kprobe("r:testprobe2 kprobe_trace_selftest_target $retval");
> > -	if (WARN_ON_ONCE(ret)) {
> > +	if (ret) {
> >  		pr_warn("error on probing function return.\n");
> >  		warn++;
> >  	} else {
> >  		/* Enable trace point */
> >  		tk = find_trace_kprobe("testprobe2", KPROBE_EVENT_SYSTEM);
> > -		if (WARN_ON_ONCE(tk == NULL)) {
> > +		if (tk == NULL) {
> >  			pr_warn("error on getting 2nd new probe.\n");
> >  			warn++;
> >  		} else {
> >  			file = find_trace_probe_file(tk, top_trace_array());
> > -			if (WARN_ON_ONCE(file == NULL)) {
> > +			if (file == NULL) {
> >  				pr_warn("error on getting probe file.\n");
> >  				warn++;
> >  			} else
> > @@ -2079,7 +2079,7 @@ static __init int kprobe_trace_self_tests_init(void)
> >  
> >  	/* Disable trace points before removing it */
> >  	tk = find_trace_kprobe("testprobe", KPROBE_EVENT_SYSTEM);
> > -	if (WARN_ON_ONCE(tk == NULL)) {
> > +	if (tk == NULL) {
> >  		pr_warn("error on getting test probe.\n");
> >  		warn++;
> >  	} else {
> > @@ -2089,7 +2089,7 @@ static __init int kprobe_trace_self_tests_init(void)
> >  		}
> >  
> >  		file = find_trace_probe_file(tk, top_trace_array());
> > -		if (WARN_ON_ONCE(file == NULL)) {
> > +		if (file == NULL) {
> >  			pr_warn("error on getting probe file.\n");
> >  			warn++;
> >  		} else
> > @@ -2098,7 +2098,7 @@ static __init int kprobe_trace_self_tests_init(void)
> >  	}
> >  
> >  	tk = find_trace_kprobe("testprobe2", KPROBE_EVENT_SYSTEM);
> > -	if (WARN_ON_ONCE(tk == NULL)) {
> > +	if (tk == NULL) {
> >  		pr_warn("error on getting 2nd test probe.\n");
> >  		warn++;
> >  	} else {
> > @@ -2108,7 +2108,7 @@ static __init int kprobe_trace_self_tests_init(void)
> >  		}
> >  
> >  		file = find_trace_probe_file(tk, top_trace_array());
> > -		if (WARN_ON_ONCE(file == NULL)) {
> > +		if (file == NULL) {
> >  			pr_warn("error on getting probe file.\n");
> >  			warn++;
> >  		} else
> > @@ -2117,20 +2117,20 @@ static __init int kprobe_trace_self_tests_init(void)
> >  	}
> >  
> >  	ret = create_or_delete_trace_kprobe("-:testprobe");
> > -	if (WARN_ON_ONCE(ret)) {
> > +	if (ret) {
> >  		pr_warn("error on deleting a probe.\n");
> >  		warn++;
> >  	}
> >  
> >  	ret = create_or_delete_trace_kprobe("-:testprobe2");
> > -	if (WARN_ON_ONCE(ret)) {
> > +	if (ret) {
> >  		pr_warn("error on deleting a probe.\n");
> >  		warn++;
> >  	}
> >  
> >  end:
> >  	ret = dyn_events_release_all(&trace_kprobe_ops);
> > -	if (WARN_ON_ONCE(ret)) {
> > +	if (ret) {
> >  		pr_warn("error on cleaning up probes.\n");
> >  		warn++;
> >  	}
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
