Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848D2F50;
	Tue, 22 Jul 2025 00:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753145354; cv=none; b=TDN/rL13cVtigDqIexZbW1PrLeqqUaB9HxTsRszImj8JJ/KShC+sv/BBw4PRp8Xtyf71ZFv6DAfmgrxQS1nzYLnMu5DGvNntHa0zV80UqOpQRCRN0nhg3wjyTu9r4YjApYsUw/ZQVwIEPZVqVGeZSClo3e6B0jONOMbqhN96H+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753145354; c=relaxed/simple;
	bh=KVI9k7s/L4Ayeqhq7kJYG7hPHnV7SbdabPHTTfX+jr8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNOr2CGLc9AF3bFen0N1r72txnHYtmn/qVgyogGiIK/+8M7hs8BujVwKUi7Rv26mBqJGRUizRB4VJhYNGXpBZuEyPiEPFkaCiyYjKW9Oyyckf1WWESnodCxu+GE26QK/QEtpJ31m8HiPlL3BclTE7vLGJuAHcHNstlrVbsGL/OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 6DD3C80220;
	Tue, 22 Jul 2025 00:49:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 880462000D;
	Tue, 22 Jul 2025 00:49:01 +0000 (UTC)
Date: Mon, 21 Jul 2025 20:49:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gabriele Monaco <gmonaco@redhat.com>,
 john.ogness@linutronix.de
Subject: Re: [PATCH] tracing: Remove pointless memory barriers
Message-ID: <20250721204932.306da76c@gandalf.local.home>
In-Reply-To: <20250626160459.soHxOROG@linutronix.de>
References: <20250626151940.1756398-1-namcao@linutronix.de>
	<20250626113520.315db641@gandalf.local.home>
	<20250626160459.soHxOROG@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6n9ez7isuyrhxjostx31dwy4reqs3m16
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 880462000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Y0Rjjwhtck8BgjauIYgM8gaipfMNLK88=
X-HE-Tag: 1753145341-930020
X-HE-Meta: U2FsdGVkX19QYcHnL34WLPTvZXgaVWQno+rmFQQzkd7ot3CDZMVSpZXlBzuFS6XetEN13QEJBOkDhhtC8DHeyVrZEYwDHQqANz1/pKsryPLTX2QbHr2vv8dq+Di+nS1kEZVeVGA7UPtKGic6Harcx7ME1wZYbjl1rkf7F2AzhveqjSo3iBDtaAhZ1qB4n14wGLgLHjh7TMw0hOo225+Iv57bzYz5Dx+495LQyktAM4+JWlAFH6i3pS355uhQdIYEs8eRbSlcrXMOjPayJV/XF3ICrCXwp6CLIvBvzq/K8nJSYjlSTGUY00IZE3RTbbnD

On Thu, 26 Jun 2025 18:04:59 +0200
Nam Cao <namcao@linutronix.de> wrote:

> > The above three interact with each other. Without the barriers, the
> > tr->buffer_disabled = 0, can be set on one CPU, and the other CPU can think
> > the buffer is still enabled and do work that will end up doing nothing. Or
> > it can be set to 1, and the other CPU still sees it disabled and will not
> > do work when it can.  
> 
> (I'm not that experienced with memory barrier, so I may be writing nonsense
> here)

So I did some git archeology and realized that the buffer_disabled is just
a cache to make irqsoff tracing faster. The commit even said it's not going
to be accurate.

OK, I'll just take this patch.

Thanks,

-- Steve
