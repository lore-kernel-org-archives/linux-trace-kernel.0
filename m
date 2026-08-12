Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF383B42F9;
	Wed, 12 Aug 2026 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786578113; cv=none; b=nMflhBqOM5hMPHLaVzkmpRtW8PvJnfq15oImtNuzsMjaH94tcrzZd+KJr6ZyeBkB+65SO9ujiSlPubZh+XkOp4iBRq0+YPQEqifA5apoBV87Ty1lnZHthkPIjjLyivRIpDclngQ7bmU44tcy1Y9jiNE8k56Fwf+hdqlmrREQ4Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786578113; c=relaxed/simple;
	bh=P9osnGMEfu7Fq4kBhKTpwhE9lWWMOn8Pjcq9zAFW8o8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Yc8wmLslwq1MMrm0FRGHnzFh8Ws/hiEWfZ1M0wi1EKn23ZwNED9U5zR9ZbuSoW1fXj6ZxliW1/oFJZt8+JkPrqmAbdJmX/UbRbWDaymD+0fzxtzzl3H3rgjL7iR3/SOazY92+L5OlCB7CqqKkm304jyy7/QleDyjZzM/AWFVqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpJjVeD4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpJjVeD4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 946E21F000E9;
	Wed, 12 Aug 2026 23:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786578112;
	bh=3F6egPcCnZXgUG4ALUc+aW58huXaS8Em/m3p3tdpGX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=JpJjVeD4DTM++gXTxWTf7XexVEJg7irzUKWqfbo4azn7ljimXucu3eTvAjEz9xsoH
	 JOr/RCL03CNNyuzqxun+YuzW08cVnlhkMkcNgMrjpXngAj4tDkhokQh+zGTywZfadt
	 dOE0OMmrRx7PPzIBycTlsIUWP3tFj/giVcvqh9Ga/RGvzyutfxcdpkekhCPvzTuTRV
	 WtCvgBj70MLPb9rECaxkX8G0KAvvByIogAR1nSBow4ZuwStxp9GrIFQ+Zrqk1MNLNo
	 VrA8MmTJqLfewhL5hLWXHAyALtxAdbLK1ARZIWNF2s//rlTT2G613e/SErZQ1D1w3K
	 +cS2XS542fK2Q==
Date: Thu, 13 Aug 2026 08:41:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, Vincent Donnefort
 <vdonnefort@google.com>, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/9] ring-buffer: Fix subbuf resize race with ring
 buffer readers
Message-Id: <20260813084148.2cd802c4a8ef6ff8ba151bbf@kernel.org>
In-Reply-To: <20260812132457.69d467ce@gandalf.local.home>
References: <20260812153311.2328812-1-vdonnefort@google.com>
	<20260812153311.2328812-4-vdonnefort@google.com>
	<20260812155312.ADF031F000E9@smtp.kernel.org>
	<anyi-W-fZHqCPRZd@google.com>
	<20260812132457.69d467ce@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 13:24:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> Hi Roman,
> 
> On Wed, 12 Aug 2026 17:44:41 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > > [Severity: High]
> > > This is a pre-existing issue, but can this 32-bit integer capacity calculation
> > > truncate large trace buffers?
> > > 
> > > For buffers larger than 4GB, the multiplication of old_capacity and
> > > buffer->buffers[cpu]->nr_pages can exceed 32 bits. Because nr_pages is a
> > > 32-bit signed integer, the result is truncated, and the buffer is shrunk to a
> > > tiny fraction of its intended size during a resize operation.  
> > 
> > This is fixed in a later patch.
> > 
> > >   
> > > > +		nr_pages = DIV_ROUND_UP(nr_pages, rb_subbuf_capacity(buffer));
> > > >  
> > > >  		/* we need a minimum of two pages */
> > > >  		if (nr_pages < 2)  
> > > [ ... ]  
> > > > @@ -7896,7 +7941,7 @@ int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu)
> > > >  			 * missed events, then record it there.
> > > >  			 */
> > > >  			commit = rb_page_size(reader);
> > > > -			if (buffer->subbuf_size - commit >= sizeof(missed_events)) {
> > > > +			if (rb_subbuf_capacity(buffer) - commit >= sizeof(missed_events)) {  
> > > 
> > > [Severity: High]
> > > This is a pre-existing issue, but does this create a time-of-check to
> > > time-of-use race leading to an out-of-bounds kernel memory write and
> > > VMAP flush?  
> > 
> > This is fixed in a later patch.
> > 
> 
> Is it possible to have Sashiko pull together all the patches so that it
> doesn't report bugs that are fixed later in the series? I mean, sending a
> patch series to fix a bunch of issues shouldn't trigger Sashiko telling you
> about the issues in the early patches where the fix is in that same patch
> series later on.

Agreed. Since we have to backport the fixes to stable kernels, the fixes
must be the first in the series (even if it looks like ad-hoc). We can
clean it up or enhance it later.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
