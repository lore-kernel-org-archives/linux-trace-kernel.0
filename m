Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46831EED8;
	Tue, 12 May 2026 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778547276; cv=none; b=VTHBHaMyA2s0qxi2kWixUtxnr3oYHP0hYR95Fnw6BJMhE6l1+jwJAJplUjRcID3fWfOfdfNg/vMB183fQCa+oj23Fjm/qhgTiVOP9keia6jREK+YUf+eb0WrswWgWEkvi38sfociXbMaQlBv4hGCESHxG5qqVUC8kFlZL2LZlG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778547276; c=relaxed/simple;
	bh=I0C9SVdPZIofrk/2NYSPziKCFfKB6wJ7FO+blU1dDpc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=N5Tg8BbIEmvKGkh5xWBtGv9EvPdJsr3gT0ThRbqEu+YmZAfdKkHLtFTM2EAURZt2k8T/esvFdLOCMa9GfeM5STJzY0UOW7Za9ocnWcpuc1SdG3WDpul6HeTHfCEin9T2nYn6qieFzCNkSBprRjvgYMv38oh80C8oBPT7KXlJE8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUlOH647; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUlOH647"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3219C2BCB0;
	Tue, 12 May 2026 00:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778547275;
	bh=I0C9SVdPZIofrk/2NYSPziKCFfKB6wJ7FO+blU1dDpc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YUlOH647EhHXBO61NbZyj0E9iEKS2dPZrXHF6gzN9iUTdnlBnHqa9a9JAJflPIxks
	 SA02DEnU2CDJjmE/cbgVGWFog2Ri0AUhfMnNb0kzAavEmIV+LK2LMZ9dzbIjS3Zeq8
	 CCcporAywCEhvshFmOSBBOUQRgtQuSrCqbti7Besn8GLQEVw68rWMhjCrIDy5WQTFK
	 ILkxLe1zTZbbUECFKwa8ODVTsecpbQKiwklqPNGCLw6cC4Z4y9ChfeH+Y6L0uZEM6b
	 cSawowI41AWCqKFsjDWlZraLHWBsdwy6X1xJjpKdv9PiiUOEec3NQFOUO31MfUlTLP
	 yT9QjCKn6yKsw==
Date: Tue, 12 May 2026 09:54:31 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v19 0/7] ring-buffer: Making persistent ring buffers
 robust
Message-Id: <20260512095431.a01161ece2acb7f48d7bd8c2@kernel.org>
In-Reply-To: <20260511122943.41e204bc@gandalf.local.home>
References: <177751968499.2136606.17388366710182662849.stgit@mhiramat.tok.corp.google.com>
	<20260502152304.560a5954@robin>
	<20260502181619.7f5003dc@robin>
	<20260507131416.35bc304d89f974ae3b33d20b@kernel.org>
	<20260511122943.41e204bc@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 12:29:43 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> On Thu, 7 May 2026 13:14:16 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
> > > I'll test this some more, and make a proper patch.  
> > 
> > Ah, indeed. Thanks for fixing!
> > 
> > BTW, shouldn't we unify common logic of those functions?
> 
> Hmm, there's not much common between the two. One is a consuming read and
> the other is a non-consuming read that needs to test for a bunch of race
> conditions.
> 
> If you see something that can be shared, I'm all for it.

Maybe we can introduce a common inline function to calculate
max_loop, or at least replacing "3" with a common macro.

Thank you,


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
