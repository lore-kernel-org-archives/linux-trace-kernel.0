Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EF623D7FF;
	Fri,  6 Mar 2026 08:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772786772; cv=none; b=fWcpV4ReVp28KFcqyndyNWV/ExCxeFArj8h4rjUrRHUiyPDGFdK1QUqdqQHB7O3TCkEG8S5PfLrK3cnQLlKuUfpRC/CtfeM1121y0gk1gXIFMn9/Pgv+y3sfx12Kzej8rPxcStjmvkTfXWh7Vl7XLqEuHmsMtKMdZW7Y5LfN6v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772786772; c=relaxed/simple;
	bh=odh/H8l/Fnf4zTvRg3h+qhF6+SQEVZQV3RRIRa8N7DU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CoJvDQNBfy/pU2GmI79lnTBzDZOGTqcZ4opRdXyemHy0lGLkpXbf67wcwzTDs8NIbeeellu4/wk2wVh5LuIm1HjE9jnYQbi8C4c02hH+lVoQQSSG87Z+qIJ30N2qUJMJBBcePIMV9ZXnj61Uw3accZxBjoyjAw9ThwcrCGiQtoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5CZqiTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5CZqiTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757BAC4CEF7;
	Fri,  6 Mar 2026 08:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772786772;
	bh=odh/H8l/Fnf4zTvRg3h+qhF6+SQEVZQV3RRIRa8N7DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f5CZqiTvrGG4Rqejd+J98R6PqK1VY64c8j8AhUBgvqhnhK+BAttP3UcZpKLeQ+uwe
	 6qgBfyX80zDzS/NN9Q9nf21Kujv3gy7z/D4JTZoTv6IiFJQ8E+Q7KM2+BEddViC0eV
	 AAAVpeqGbp5pzUz1Bcq4lJyZjMjcDOMVDX/COqmzr06XQPGSM32SkNrob49b4zXI9B
	 Qnxmd6ykde/uTZHb0WqR3AP2oiu4e48/PuQ9nbtvCPHRe+Vzq6wv6E15pmI2dl2/ym
	 3Yk72ot4kcXonNzs/3H4kyMPpMtcUoIBWUQxzomkRrZcvaXECN1r3F2BFx6t1JtkWp
	 SmhUGsjfCpRUA==
Date: Fri, 6 Mar 2026 17:46:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] ring-buffer: Handle RB_MISSED_* flags on commit
 field correctly
Message-Id: <20260306174609.d387b67d04e05328ea262fba@kernel.org>
In-Reply-To: <20260305130348.3266e4c9@gandalf.local.home>
References: <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
	<177211312362.419230.15156461178245984273.stgit@mhiramat.tok.corp.google.com>
	<20260305130348.3266e4c9@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Mar 2026 13:03:48 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Feb 2026 22:38:43 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the MSBs of rb_data_page::commit are used for storing
> > RB_MISSED_EVENTS and RB_MISSED_STORED, we need to mask out those bits
> > when it is used for finding the size of data pages.
> > 
> > Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
> > Fixes: 5b7be9c709e1 ("ring-buffer: Add test to validate the time stamp deltas")
> > Cc: stable@vger.kernel.org
> 
> This is unneeded for the current way things work.
> 
> The missed events flags are added when a page is read, so the commits in
> the write buffer should never have those flags set. If they did, the ring
> buffer code itself would break.

Hmm, but commit ca296d32ece3 ("tracing: ring_buffer: Rewind persistent 
ring buffer on reboot") may change it. Maybe we should treat it while
unwinding it?

> 
> But as patch 3 is adding a flag, you should likely merge this and patch 3
> together, as the only way that flag would get set is if the validator set
> it on a previous boot. And then this would be needed for subsequent boots
> that did not reset the buffer.

It is OK to combine these 2 patches. But my question is that when the flag
must be checked and when it must be ignored. Since the flags are encoded
to commit, if that is used for limiting or indexing inside the page,
we must mask the flag or check the max size to avoid accessing outside of
the subpage.

> 
> Hmm, I don't think we even need to do that! Because if it is set, it would
> simply warn again that a page is invalid, and I think we *want* that! As it
> would preserve that pages were invalid and not be cleared with a simple
> reboot.

OK, then I don't mark it, but just invalidate the subpage.

Thanks,

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
