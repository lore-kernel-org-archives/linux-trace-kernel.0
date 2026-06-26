Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90E53DB336;
	Fri, 26 Jun 2026 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782488746; cv=none; b=NZCZr5RBuIx5ap8pwv67ZYF3chmXMc8cQITNoKMYlLJDO10YFHino6Ye4FPlRM4QtyM4an/Q3pusEdYXlKp2Rk5cQF+rnjV9FvNxqHwyrVeKxpSx0UAozVnvVZjz8KNZ0p3mP64s5EfX8l3Usaai6/PJP7o2VAotttmP3I+O2VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782488746; c=relaxed/simple;
	bh=qZKptdCJSkMTTyABot2IPcwQP8mWC4AcZQJO2SalZCY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=B4ABxozuw88AOHwpHEeWi0Aiuosu7KXLj6ohXKzwt9CQuG9jYWe4HTNsNyQC8nz3MFd1azl58PAOquQn9nftSocUy00WHNDpWDcP4BoPa7OAvv0XEkxLbGabe39JFm1l4kR+6mBoqZRruolLGTkLQO+0xlYdqZHKINxYPA2EaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VC7qYdhV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VC7qYdhV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7691F000E9;
	Fri, 26 Jun 2026 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782488741;
	bh=5nNXMDWDKH1yXvqBFyPzRpjFWZl62kKodd/S4IBn1Ns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VC7qYdhVzne83s+YIAuvUw/NmYE9soPzXB4P2iVw55hOY+jO4CyYTCyeVepIx8l9H
	 Cvlk7Npk3OTX96bITvLGN8G3ug/rt2eYlsx4m1vpUS9GbFhbCqUrUTlx0dSUMKg246
	 oLWm32k2CKgtCJvZDsR1mQ1VQubzZmVz4bvZARQzRJMLpfQK5bhe5b0gt7xYaBesVa
	 9q6DAaKqi1KnwYjnPJYyVYRJ/Kk0SgTABl6lSMavU3nEnZsbeBgsCyjJ4MIRkyDx2v
	 /jaWzYkWrDvuDy9vf+Ia2izcQLSaRqR4d9uZyFI07ErfKG6MCbZE3NlYMLwprHQdvq
	 cgBt5DwvcteRQ==
Date: Sat, 27 Jun 2026 00:45:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Martin Kaiser <martin@kaiser.cx>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-Id: <20260627004538.4cc8b34a4a20ee14f9a38c28@kernel.org>
In-Reply-To: <20260626064223.60ffeeaa@fedora>
References: <20260615145500.2662456-1-martin@kaiser.cx>
	<20260616110910.e6420488b6a798d49951cde9@kernel.org>
	<ajJbkeK0zXb8MtcS@akranes.kaiser.cx>
	<20260618105227.c58c85e9cb19bce673d9a79b@kernel.org>
	<ajasLMUt_AMM3ztH@akranes.kaiser.cx>
	<20260622125815.7416792c020bd3d81c01e51b@kernel.org>
	<20260626055440.76c28d25@fedora>
	<aj5SdK9gUIVoPmmE@akranes.kaiser.cx>
	<20260626064223.60ffeeaa@fedora>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 26 Jun 2026 06:42:23 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 26 Jun 2026 12:20:36 +0200
> Martin Kaiser <martin@kaiser.cx> wrote:
> 
> > > That is, to have +u0() say "this is going to be dereferencing user space".  
> > 
> > > I'll add Martin's patch and see if it makes the above work.  
> > 
> > I've just tried your command with my patch. It works for me, filenames are
> > logged correctly.
> 
> Yep, this definitely looks like a fix. We have;
> 
> 	addr = rec + field->offset;
> 
> Where addr points to the location of the field on the ring buffer, thus
> your change to make it:
> 
> 	val = *(unsigned long *)addr;
> 
> Reads the full "long size" of the event on the ring buffer, instead of
> reading just one byte. It is "val" that gets dereferenced later by the
> probe logic (the "+0u()"), which has all the protections we need.
> 
> I'll queue this up.

I've already queued this on my probes/core branch.
(which will be probes/fixes)

Thanks,

> 
> Thanks!
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
