Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E0E3BCD3F
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 15:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787411094; cv=none; b=V1vImiGkQjSg+Cfp5F0G088y5k8sAsq1C2hcAcrxd14JxrprwJVRtS47/+YoW0lxlcedJjaP9zt9+/FjdxvbWKAhyWBRDauNm4rMHhqiE8JRlFNuWTkoIIhbGdtJzwF7lQpyGlJT3wmNSmwKiDJ6cCt7+mvO1THUTeGfWRv2Z0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787411094; c=relaxed/simple;
	bh=4gSzoUBNkTbMnW2K7t/gknyS64mQ29BZebNS1TnBGRM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SKm7er5r3KweXZTvh3Ufq0I3RBxXyqGQ0+V2K5d0CnLDbMaubeEYMB+M2stH1xGwbz1jxNll4SO9clLS5myo3H+TeT39cO5jafODosPKNPzjL3Lxi/A/1bbSWVkebzB9DAeU1mx0cKvgDK9XOvzEm0Isevn6KL009vKBzh5GA/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=REJvq85Z; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="REJvq85Z"
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 96CE1A25F9;
	Sat, 22 Aug 2026 15:04:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id C842A2002D;
	Sat, 22 Aug 2026 15:04:37 +0000 (UTC)
Date: Sat, 22 Aug 2026 11:04:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Vincent Donnefort"
 <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260822110424.346fa3c8@fedora>
In-Reply-To: <20260817140812.2C7D41F00A3A@smtp.kernel.org>
References: <20260817134750.3909384-1-vdonnefort@google.com>
	<20260817134750.3909384-2-vdonnefort@google.com>
	<20260817140812.2C7D41F00A3A@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: C842A2002D
X-Stat-Signature: csot9rfgip36j3dbfjipqur1nawcdwmw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/puzTS47SMMoyQA487ctOXmD3EuwsLQVg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=amuDGBPzxC6ExbZ0Fz/ZTEnaJsX4fm3NP4n2KyOgkSM=; b=REJvq85ZrSSU+rvRpF1Q0Gk3aUQoo5gQSELNi0FpojZVoV03bWCTskZ6EaAIsI5eQ2SuTfh6m9SKCi/fMV5zB1iXla0KKwqjZvRQXadLGup/6MDC9wQzCYdJzwwDM20iuj8M7rw3ixhYURSq74OqFR7Sr4rKYfiu2zpX3dsa0LE=
X-HE-Tag: 1787411077-779464
X-HE-Meta: U2FsdGVkX18WBIWtfLlSfYmrEK++xmk4S7hN+Tkg3YJv1rMM3TUCPABsI+yk0noTClJi/xX7fOZRuHNrOA58wzGP78NleJWIeTXh8eRkrGPtKRI/E13ncCElXIESAZwNidKBAdRaHuo3Vwv7OKrpJdFCV+2jzBnZ24ugGcIO5vuHWNopjt6rj4fcTu8alR1lzrxjpzewhcT104uF+jpnWNOBMsKXG64GVOoGb2P9cqewa+1ikwhJmn6qTtCrTRqKz/BY1q1ucUJt163SumEapbKsUJpK8FjAqfs7h6t2/FgKGh0PGtCAZuZJtOdlESHmJaz7HkA3jP2Faq1U/ioubUE28E7oPahs

On Mon, 17 Aug 2026 14:08:11 +0000
sashiko-bot@kernel.org wrote:

> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 395238b2b715c..737922b236d46 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c  
> [ ... ]
> > @@ -7128,7 +7116,9 @@ ssize_t tracing_buffers_read(struct file *filp, char __user *ubuf,
> >  				    iter->cpu_file, 0);
> >  	trace_access_unlock(iter->cpu_file);
> >  
> > -	if (ret < 0) {
> > +	if (ret == -EAGAIN) {
> > +		goto again;
> > +	} else if (ret < 0) {  
> 
> [Severity: High]
> If ring_buffer_read_page() returns -EAGAIN because the subbuffer order was
> updated but cpu_buffer->reader_page->order hasn't been updated yet, this
> branches back to the again label.
> 
> Since the loop does not yield the CPU or call cond_resched(), could this cause
> a hard lockup if the reader and the resize thread are on the same CPU?

Hmm, this looks legit. We should at least have a way to break out if it
loops too many times.

> 
> >  		if (trace_empty(iter) && !iter->closed) {
> >  			if (update_last_data_if_empty(iter->tr))
> >  				return 0;  
> [ ... ]

> > -		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
> > -		if (IS_ERR(ref->page)) {
> > -			ret = PTR_ERR(ref->page);
> > -			ref->page = NULL;
> > +
> > +new_read_page:
> > +		ret = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file, &ref->rpage);
> > +		if (ret) {
> >  			kfree(ref);
> >  			break;
> >  		}
> >  		ref->cpu = iter->cpu_file;
> >  
> > -		r = ring_buffer_read_page(ref->buffer, ref->page,
> > -					  len, iter->cpu_file, 1);
> > +		page_size = ring_buffer_read_page_size(ref->rpage);
> > +
> > +		r = -EINVAL;
> > +		if (IS_ALIGNED(*ppos, page_size) && len >= page_size) {
> > +			r = ring_buffer_read_page(ref->buffer, ref->rpage, len, iter->cpu_file, 1);
> > +			if (r == -EAGAIN)
> > +				goto new_read_page;  
> 
> [Severity: High]
> Similar to the read path above, this catches -EAGAIN and loops back to
> new_read_page.
> 
> Because goto new_read_page executes continuously without releasing
> trace_access_lock() or yielding the CPU, can this permanently deadlock the
> system during a resize by preventing the resize thread from acquiring the
> necessary locks?

This also looks legit.

-- Steve

> 
> > +		} else if (!i) {
> > +			/*
> > +			 * If the first iteration fails this is an invalid userspace input.
> > +			 * Otherwise, this is because the subbuf order has been modified. Do not
> > +			 * report an error and finish the read.
> > +			 */
> > +			ret = -EINVAL;
> > +		}  
> 

