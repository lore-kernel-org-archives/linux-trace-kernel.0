Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B26036D;
	Tue, 11 Jun 2024 00:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718064431; cv=none; b=ERHCCMyiU91O8j2wFPJpsrd9LHsAp3wVgCeFUpSeoWsVaddgm7rjHNGdXyuurWC4zK8woHVmmZvRbqp4q/uVnrazzai5Miyn6ADtiZujJVbMzRuDEguqr2ZXStLAm5HR06MNiDOOsf7RNOQEzMNDlsqgAtbDx/mfr/fBWZNTnbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718064431; c=relaxed/simple;
	bh=atyHicKZdMAHj/WLHQbktI55MDWwQjhtggNyC1vQN78=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G7mfrPNoF0VQATAgFBhGYpGGZelGui1JJRbJDz98vIFa2/j3jXmwNH7fsH9uLDdeuxG8F56XbAadqU9Wso94DzF6ECCLdDfoiImv81aYvq+JtCDrPgke+vi+acVYES4s05bQv/N1cfHJN96cY/cYwZqD4GdFEr5D0LDtnrGNSUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvXTE/yI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvXTE/yI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18069C32786;
	Tue, 11 Jun 2024 00:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718064431;
	bh=atyHicKZdMAHj/WLHQbktI55MDWwQjhtggNyC1vQN78=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YvXTE/yI0cihdrzYnjsyqEu8vwUkGEzrvKpbBSw0ioa5sdr+SmjOG4HbeXweMmtem
	 Du/1njQq3MdgB5O6/h0HGKhYWfaThbSIDXdbwNMZ/YGaX7CiYO1gUHhBqFSOiMQL3t
	 idx6eVTugDbRampqLr2gPhk9i2UmiUChik8JbAOYpTiDo5AYrAsP0eSfDwPBpg1g5h
	 Dhx/KQI1aEN7POBePyICphL4fyG/XVdhuUgn2GwuT4etcDVGUs8wuFmlMt+pP+hhC/
	 uiYV0JDFQ3vmbldma8buDJSisRmJoCF9zY7/fUsqhdkH/5yV9N4psxF5F+7xsAolKv
	 DjKwTkTEdialg==
Date: Tue, 11 Jun 2024 09:07:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH 2/3] tracing/kprobe: Remove unneeded WARN_ON_ONCE() in
 selftests
Message-Id: <20240611090707.58b663bf1d8659b3b76fc136@kernel.org>
In-Reply-To: <20240610174052.0fd280f2@gandalf.local.home>
References: <171805478534.52471.6269290579314514778.stgit@devnote2>
	<171805480405.52471.13982671291270977479.stgit@devnote2>
	<20240610174052.0fd280f2@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 17:40:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 11 Jun 2024 06:26:44 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the kprobe-events selftest shows OK or NG with the reason, the
> > WARN_ON_ONCE()s for each place are redundant. Let's remove it.
> 
> Note, the ktests we run to validate commits, fail when it detects a WARN()
> triggered.
> 
> If this fails in any configuration, ktest will not detect it failed.

Hmm, I think there are 2 options,
 - remove pr_warn() instead. (WARN_ON_ONCE + pr_warn is redundant)
 - Or, remove WARN_ON_ONCE() from each place, but add WARN_ON_ONCE() when
   `warn` is not zero.

Thank you,

> 
> -- Steve
> 
> 
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/trace_kprobe.c |   26 +++++++++++++-------------
> >  1 file changed, 13 insertions(+), 13 deletions(-)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
