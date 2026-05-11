Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E772D7814;
	Mon, 11 May 2026 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516986; cv=none; b=puKxHJ+QViigJFSy8XgbU4oYvNt8WUTvS0cw1Sf98GyKR0RWfy5x/uoMNfMvnBbk5DbWeqYfWPR/wV2HWAYIKbqR2w5lhr2BmPYQEbard2eO7zRpj8teAgSucdSoOrWrb4p2dAgMQsmJrIPfNTCkTGkbJd1hC7MzcTmtBfRu41M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516986; c=relaxed/simple;
	bh=c63a4JxePfIgjpgQ4bMho60Nz7+hTPym2Qpet2uaDk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPedOj1dDqUIlh43U0r5ViudfzEIF/A700xLr4IWEPjmGvVJjhzht4jvB7TtxM6l0n004pSKOAgkfNQww7/QDWfBQ0YAj63F2XdSKWgoIjUE1SvZOGMLRiEPBv7Qwq8qV3McvRyXVbl1VshCyUeCmZpv0Nk7wFBpjKoV4skUbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYYpvVFO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XYYpvVFO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FB3C2BCC9;
	Mon, 11 May 2026 16:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778516986;
	bh=c63a4JxePfIgjpgQ4bMho60Nz7+hTPym2Qpet2uaDk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XYYpvVFOF00vdXabkI5V87vD7BFVLIXY+qFT2ClunVZKi+tPI0A/8qTXulLEY0DeY
	 qqTTvho0mSwUsjNJmWHHt6a2oIXHQ7gWau/W3GBodDGBrrCrwwzAPgzTyOBbTojYam
	 3hwFGn6hN8g4UvabpRwzolIBi/k5DjAoTHC7foRroFwNEwScLAA5gcYiPmxbzWkpxt
	 /1s8jwlVN1Mx7zwpG0PeyVk/MLDHjSg871CdLooSg27sJ0LsUt1lbuWmc6ZBL+lzxT
	 jSdhQSMc7FFsWMF//ZopDDSrTnhyoosExOzX5FNBFlEwfKrA+3pdTz1xoZPoXHnDhb
	 NwMTBxpC7XaXQ==
Date: Mon, 11 May 2026 12:29:43 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v19 0/7] ring-buffer: Making persistent ring buffers
 robust
Message-ID: <20260511122943.41e204bc@gandalf.local.home>
In-Reply-To: <20260507131416.35bc304d89f974ae3b33d20b@kernel.org>
References: <177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com>
	<20260502152304.560a5954@robin>
	<20260502181619.7f5003dc@robin>
	<20260507131416.35bc304d89f974ae3b33d20b@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 May 2026 13:14:16 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > I'll test this some more, and make a proper patch.  
> 
> Ah, indeed. Thanks for fixing!
> 
> BTW, shouldn't we unify common logic of those functions?

Hmm, there's not much common between the two. One is a consuming read and
the other is a non-consuming read that needs to test for a bunch of race
conditions.

If you see something that can be shared, I'm all for it.

-- Steve
