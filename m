Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C792F175A8D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669928; cv=none; b=lOqjafv+scpvomFuNQdKEr50Kzjybgk0l5UPaOlHbYtwQni2j08K9Yb43vu5UfWQ8qV57wL6jT8x9EDHLslbxMGTUI5WW/UE7lM2P8BrO6B0gW3wYA3wppFq1yaRcqp3mzz9U0/+Z2INp0WcxKz/q6pUfE+sM3cSjM5+62Q+bRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669928; c=relaxed/simple;
	bh=suhtIJ0aa2cDAqihFKYl+Rw8Px8kaKib3qwkiA1R5wM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqDyxjc3j6F0NWV/zPHMM3KxtjbOWk17YykSeoDd15K30EG/xR9jfVcfdl9euRWObKyU/dOhUyu6xBhP4Ai7gkRlRH8+ZwUTY5wNTBEK7E5HgqRgp/eE8oD/Bjw+Dw4pKOn+YKyenwLXiXCqzfHmCixhCxdTwuOEb+awrPlTm1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=f6CGX+Yo; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="f6CGX+Yo"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B1DBA1A017B;
	Fri, 14 Aug 2026 01:12:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 19CD132;
	Fri, 14 Aug 2026 01:12:04 +0000 (UTC)
Date: Thu, 13 Aug 2026 21:12:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Vincent Donnefort"
 <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/10] ring-buffer: Fix subbuf resize race with ring
 buffer readers
Message-ID: <20260813211220.3d48b0dd@gandalf.local.home>
In-Reply-To: <20260813135142.C27031F000E9@smtp.kernel.org>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-5-vdonnefort@google.com>
	<20260813135142.C27031F000E9@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 19CD132
X-Stat-Signature: 71g1zky86jt4orzdifa5phh7a7i7obs9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/oYukaqEj00g3bb18W4mk4ShbSfCIjBZY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=V6W0qWnOoNIl8aEPk8qUXyBHTsHuSV4rhHciRx1Beug=; b=f6CGX+Youhwj1edG2xBkuBQxiAPC07hHQuF77WDA+0dgnkGcq7JAJByE3RKCT92XCqdo+At1iw5xVNg0TLPoVAr2tDrdZQCo8Xek2Vb7TOzwNdSGTaM7ETSYhr2LYoDAdx1wXqd94fLkxbLrqLZP3hEs6CX/iTWIxxD25nkH/ok=
X-HE-Tag: 1786669924-85786
X-HE-Meta: U2FsdGVkX19dJMn2e9Q6tbFuRhYKzosndpJj1V57C8JCrnhN3e4Muhn6K/royXXdjobEUi5KesFo9New76YnQ0YNhU7NNcADEZcIjR8vgU32OOp9Yll3oZdmmx72QUg3GIhty8R7NkAVhqeoogYsiMPlUOTRMNwdorZ91VEARoCUE/R5Dv8HZjZp6VlnBSK/+d5XQS7HJj/qgtqsOrN/jIrBH4QXFyaA5lB78xFaxHR1/RTAsNWPltKfbEyFOE/GF9PT6Fs1RgkAifBcInakk3VRQ5mWc90AtY4Jr4RU9YX6AUq8Ol1CQz4GgN0x4+EHA8Gcp1xG4Ciq06mXeqcjxueztVJfS54h

On Thu, 13 Aug 2026 13:51:42 +0000
sashiko-bot@kernel.org wrote:

> > +	/*
> > +	 * Only KDB is using GFP_ATOMIC, for the others, lock the buffer to
> > +	 * prevent concurrent resizing.
> > +	 */
> > +	if (gfpflags_allow_blocking(flags))
> > +		mutex_lock(&buffer->mutex);
> >  
> >  	atomic_inc(&cpu_buffer->resize_disabled);
> >  
> > +	if (gfpflags_allow_blocking(flags))
> > +		mutex_unlock(&buffer->mutex);
> > +
> > +	/* Holds the entire event: data and meta data. */
> > +	iter->event_size = rb_page_capacity(READ_ONCE(cpu_buffer->reader_page));  
> 
> [Severity: High]
> Can this cause a use-after-free when called with GFP_ATOMIC?
> 
> If this is called with GFP_ATOMIC, it skips taking buffer->mutex and
> increments resize_disabled without synchronization. If a concurrent
> ring_buffer_subbuf_order_set() evaluated resize_disabled to 0 just before
> this increment, it can proceed to replace and free the reader_page.
> 
> The lockless dereference of bpage->order inside rb_page_capacity() on the
> freed reader_page would then access freed memory. Prior to this patch, it
> read the scalar buffer->subbuf_size which was safe from this use-after-free.

The only caller of this with GFP_ATOMIC is kgdb doing a ftrace dump. It's
in debugging mode and nothing else should be reading the trace buffer while
the system is being debugged by kgdb. If they do, then great, they can keep
the pieces.

-- Steve
