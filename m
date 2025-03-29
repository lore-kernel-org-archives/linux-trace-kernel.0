Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD131C460A;
	Sat, 29 Mar 2025 13:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743255345; cv=none; b=syteqel0PkQOrZNM04Zq8DXjfuhB7nRI+AdVJD4J5kZKlv5LjOf7EEI5Uim+NDHjjAlZ6jQWv8VhpfbCHEQ1sDRIqOC5hBGXbnCgnwWo7oC4ZxjjK3KBkPtMjTiCmXhxcC422E1vIT7EetL9kFzXSnhBBNIlLxjml2UuoSAPSlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743255345; c=relaxed/simple;
	bh=+S2YwW0R/VrGE2BqFDOgebu3LwcT+mV5mrkXCsYwago=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X6UY7DNgKYWSHGct0JuHuJQA5ewFFbek6zJ6UDqLcFqdwpNOVfRIT65tEOh94oSJqm6rDDKde3QDHVO8rypQuEzo44eCH7cJHhRy2NdovlKlgj+kCzxS0vF+VLHaKowT3Au2HbC7VrtEnc5zmuFX3yxCTY2God1xtLBQR9WsfR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJLddEmK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJLddEmK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D657EC4CEE2;
	Sat, 29 Mar 2025 13:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743255344;
	bh=+S2YwW0R/VrGE2BqFDOgebu3LwcT+mV5mrkXCsYwago=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CJLddEmKG8zXkTIk0DEOQgMbeMx0vWC1Wnzz4yGYOpEjN93TQtXbPld+66obQh5MA
	 MKr2D83hydkIuz8PsVgkguzJ3a71P7u2EfN4HDEmfbFhjdCMAJVLS79aYl2JZOxHMq
	 XICWMUl8I8jtaarcbGhTEec/njOkeWVqCrRhWYGmn1RVR3L3ISXvTCVV6Cz+XxgWM3
	 UuwbO1wZ2mj2cqn0znKcBdl6o+N+LBYqtv9BUiTAkCgNXE3BgJfHA+WErsgnMff5Pa
	 1VL9x+sS1YPlM38i7Y2VZNAeu1lwcMeglXLCXABITLsHaJ7jfvDtiMGdYsbnLb4p1X
	 W3NaaY98yuLdQ==
Date: Sat, 29 Mar 2025 22:35:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] tracing: tprobe-events: Support multiple tprobes on
 the same tracepoint
Message-Id: <20250329223535.e121322ab3191368ad5ee799@kernel.org>
In-Reply-To: <20250326070809.9f92d18741c6342a68179c5a@kernel.org>
References: <174212767109.348872.18231451508464729427.stgit@devnote2>
	<174212769289.348872.12945848497242748827.stgit@devnote2>
	<20250325130628.3a9e234c@gandalf.local.home>
	<20250326070809.9f92d18741c6342a68179c5a@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Mar 2025 07:08:09 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > +	/* tpoint can be NULL, but we don't care here. */
> > > +
> > > +	/* Search existing tracepoint_user */
> > > +	for_each_trace_fprobe(tf, dpos) {
> > > +		if (!trace_fprobe_is_tracepoint(tf))
> > > +			continue;
> > > +		if (!strcmp(tf->symbol, name)) {
> > 
> > If the try_module_get() failed, can this every be true?
> 
> Ah, that becomes true in the next patch. In this patch, it should
> not be true.

No, I was wrong. Even if the try_module_get() failed, tracepoint_user
is allocated anyway (with tpoint = NULL). Thus this can be true.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
