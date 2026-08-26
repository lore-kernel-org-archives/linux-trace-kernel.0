Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC593F8ECC
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787755016; cv=none; b=rumOZBehdGQqiB/3iigMpI4ZCBkkKIOdo+JiGrST9lnBNfWgEMj4htsqafQxqJDmVcUW9lEMgt+xBQTg5y/zfI0Nx8u9TL9xYcr5hX4AE1nluFRexHxnfvRo02mNrbmoNx+1AXa5+rO6AiQ/iYLoj2ly1P4mwILiC7ALd7qARR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787755016; c=relaxed/simple;
	bh=BFlIYPg5r9toqxM+0alEDZcm7K7Zh4h1iVhW9V086cE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i1etXtbL5M1YnKcoTekvJT0NNoG0fUatlywfJQNHk09O0BD0iFvOKNNeLopQELkER9Cc/27bWM1CVvIjfj1Jmyn6nEx2eisApdbAzTkht3CaVGbQrqtShC3p9eXU5nLU3qOP3XO70RfFE1nfRvkR8nEWdC04a0+WuWGyV4dhyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=w//Ijzbo; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="w//Ijzbo"
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 9AC6E1C00D0;
	Wed, 26 Aug 2026 14:36:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id E0DBC60010;
	Wed, 26 Aug 2026 14:36:51 +0000 (UTC)
Date: Wed, 26 Aug 2026 10:37:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Vincent Donnefort"
 <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260826103736.2b55b464@gandalf.local.home>
In-Reply-To: <20260826095947.4FF8B1F000E9@smtp.kernel.org>
References: <20260826094528.3738023-1-vdonnefort@google.com>
	<20260826094528.3738023-2-vdonnefort@google.com>
	<20260826095947.4FF8B1F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8shnaieq386df1g9kcsq9qbk9mrg6gwi
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: E0DBC60010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX196Vtf+CFc8/XxF79fZUi6wVh/MPRUJRgg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=HKqjgjDUb/PaWHKag6Zf2P3OkqH5QHAY6Oe+S+NvXC4=; b=w//IjzboT5nUTRYTY/mCJlrRhOsr7Dmjoht5bq4feXRLOrbuWd9nVXabsXAAc7iONu6y21JTuxZw1BMF7V1pGkVI5TDgfU2qpCTYNyp8Fnaw7VxhV9Yv2iZkEEGw8E+UHaLgjPqc1lc0daT542BLfrO01ieC9uck0Y6imlcEXn0=
X-HE-Tag: 1787755011-646789
X-HE-Meta: U2FsdGVkX18tLrerqf/wT5Qsue6qphBciHUjJ9l11sDr63tsPMNuM5Sy4MZCXUpKksrua6b4TPXfGw74e7B9OYEw9sR2UfRLYtOsEJI4Fwof8pF7w2CXwUcGWSQgCbVAVg2hLCAB7mfcMgVQND9VgLY/25qT1sL0v/2GfV5FCghK6tBBiWtg+mgqyTzKNiHz9Juy84Pa4h07xtGB/y4PuxGqnWZ/TdAau0/7VEb+URJ7laZ2f/gNbFsePYGqHZz4YrOh4HSUJBCkNEOX/UcsmnUB4mqLX5hgJ7qqOjCfwdUu8WG52CAb4tj+dm+8vhdcW+67T52vgQKoazGh4aT082k1h6Sw+SEQ

On Wed, 26 Aug 2026 09:59:46 +0000
sashiko-bot@kernel.org wrote:

> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c  
> [ ... ]
> > @@ -7183,7 +7218,8 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
> >  	 */
> >  	if (read || (len < (size - read)) ||
> >  	    cpu_buffer->reader_page == cpu_buffer->commit_page ||
> > -	    rb_is_static(cpu_buffer)) {
> > +	    rb_is_static(cpu_buffer) ||
> > +	    data_page->order != reader->order) {
> >  		struct buffer_data_page *rpage = cpu_buffer->reader_page->page;
> >  		unsigned int rpos = read;
> >  		unsigned int pos = 0;  
> 
> [Severity: High]
> Does this new condition break splice reads when the buffer order changes?
> 
> When tracing_buffers_splice_read() allocates a read page with the new order
> and calls ring_buffer_read_page() with full=1, it will now enter this manual
> copy block because the subbuffer orders no longer match.
> 
> However, just a few lines down inside this block in ring_buffer_read_page(),
> there is the following check:
> 
>         if (full &&
>             (!read || (len < (size - read)) ||
>              cpu_buffer->reader_page == cpu_buffer->commit_page))
>                 return -1;
> 
> Since the reader page typically hasn't been partially read yet (read == 0),
> and full == 1 from splice, this check evaluates to true and immediately
> returns -1 instead of copying the data.
> 
> Because tracing_buffers_splice_read() loops and ultimately returns -EAGAIN
> on failure, will this cause an infinite loop of -EAGAIN for userspace tools
> trying to read across buffer resizes?
> 


This is a legitimate concern. But with an easy solution. Perhaps just add:

	if (full &&
	    (!read || (len < (size - read)) ||
-	     cpu_buffer->reader_page == cpu_buffer->commit_page))
+	     cpu_buffer->reader_page == cpu_buffer->commit_page) &&
+	    data_page->order == buffer->subbuf_order)
		return -1;

If the user is changing the buffer size at the same time as reading raw
pages, they get what they deserve! I just don't want to let the kernel go
into an infinite loop.

-- Steve

