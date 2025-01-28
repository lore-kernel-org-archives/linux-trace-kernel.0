Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBB1684AE;
	Tue, 28 Jan 2025 17:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738085394; cv=none; b=L1atDF1UsyKPOAPdq3ibkD7gayAFQxhYkL46ZuBh1RPo01xvythbO/KNpEUiA6TCqWQew0SdET83fZjfNONarmtWDvlmss9qiBt70+lPMqzgh2niqy/YyVcc5SCk9WHbtDaR//sFB9sGSOK68Iz97v7xCZctpDbSmRqyLW3xVC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738085394; c=relaxed/simple;
	bh=DOU+9MlLC3uVBrFcq107Fc2agt863+p/C4A0YylxAE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IX0ycsxTZ3xweCJ3YfbHYudv32kgkaQEaFCCTxbq221PZ07JHbkwozMLihO3IUOPkOOPBoyuPiXhl+kaR5K2nuQFgWoDmGrvN1OXpYXWd/khZZwhJ3WZv+zqaekKlueoVBuCH9YWQfTEjJmp1igGkP8HxQKGMWQEVr7BgQ5x7yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5A6C4CEE2;
	Tue, 28 Jan 2025 17:29:52 +0000 (UTC)
Date: Tue, 28 Jan 2025 12:30:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Message-ID: <20250128123012.4f425227@gandalf.local.home>
In-Reply-To: <c3842632-cb15-469f-a6e8-8e9ccb3fff56@efficios.com>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
	<20250128112733.37d7c771@gandalf.local.home>
	<c3842632-cb15-469f-a6e8-8e9ccb3fff56@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 11:46:25 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> I'm trying to wrap my head around what you are trying to achieve here.
> 
> So AFAIU you are aiming to store the relative offset from kernel _text
> and module base text address into the traced events rather than the
> actual address.
> 
> Based on Masami's cover letter, this appears to be  done to make sure
> users can get to this base+offset information even if they cannot read
> kallsyms.
> 
> Why make the tracing fast path more complex for a simple matter of
> accessing this base address information ?
> 
> All you need to have to convert from kernel address to base + offset is:
> 
> - The kernel _text base address,
> - Each loaded module text base address,
> - Unloaded modules events to prune this information.
> 
> What is wrong with simply exporting this base address information in the
> trace buffers rather than rely on kallsyms, and deal with the conversion
> to module name / base+offset at post-processing ?

Hmm, we could probably get away with that too. I think we were focused on
kallsyms, where we wanted a way to not have to distinguish between current
boot info and previous boot info. But when we started pulling in the module
info, it may be possible to do a post processing.

I have said in the past that I wanted module information in the persistent
memory. By doing that this may not be needed. I'll look into it.

-- Steve
