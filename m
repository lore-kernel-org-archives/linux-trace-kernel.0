Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE62F6591;
	Fri, 20 Feb 2026 19:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771617544; cv=none; b=DVCehD6pTGHl8v7Jx/TFCS78wG7IQ7PALCHB72h8TarqH99tEtnwW3yN+CV9paCRABLIH6ElQmpX6rZEWOkJnVT1G3DSdmQjihCn4Tp+7Gdtp6KagaE9+u2Ho7Txn2nMewYFQZFmIYVp/nGBuEhGJLZjMIpjpdwUIYNvKUc4DOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771617544; c=relaxed/simple;
	bh=fMtd0a8b4tLrWXBhqUMbqzFfimnbYBvZaW75LAdNHes=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YFcqHjf2uu/m1QcXSmMisrYgcL4OxcTV45bb4xwpozmIQshp2QuGGHe9hGXFPeXN8mssCrhRKVzkqvUh0pjB7t7A4KEpJjmiwyQSpvJVoL134WhIBlvmEvBU2ngUaccy/WPDK1xjOPPrH/mMYcKDkkrSH2A+EGBN0PV8jNFb1bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id B580657CFA;
	Fri, 20 Feb 2026 19:58:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 1EFB420025;
	Fri, 20 Feb 2026 19:58:54 +0000 (UTC)
Date: Fri, 20 Feb 2026 14:59:02 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] ring-buffer: Record invalid buffer event
Message-ID: <20260220145902.33704c96@gandalf.local.home>
In-Reply-To: <177140968338.1537493.3298484599734677165.stgit@mhiramat.tok.corp.google.com>
References: <177140965047.1537493.15501794841217306382.stgit@mhiramat.tok.corp.google.com>
	<177140968338.1537493.3298484599734677165.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 1EFB420025
X-Stat-Signature: mao55ir7d17pj1116o3ayf5kw8kgjirq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Wbk2UkMYmiijEcGeilxv+mcnwKB2vGmw=
X-HE-Tag: 1771617534-268642
X-HE-Meta: U2FsdGVkX1+mUSsd0AZC4+Ch24gR8a7L+rp3O7x8spQ0QHlvrbXbNCfMgjgMKtjln1pO0HFZUXROkSq2nhSQvNkOIahgmu5DwIyypabfCZDmbHmv6Cm0EBwWNlRWVzqSze1D2ZvX0ng3Xu/RSEVzZOQcxJFZw3Ai6MHFHc50P+KEFI5rCn9VfVnGZW1wRjxyfOZiP7GKX/uW/qW6a5M4eeW07oA//2Q3qFR4eMWKWdddEvRkQdohG4/Bi8r6xqvq0A0qnl1kdaGBLhHqV24nZ+zdekTsp8mcxEbTNMCKAjDdAxNy7/wXBwb7eFIgphFmoa+kqKeWu0RGfvfpgJi1BYy9K1LE5/1n

On Wed, 18 Feb 2026 19:14:43 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Record an invalid buffer event on the invalidated sub buffer
> so that user can notice how much data is skipped.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

As I showed in patch 3, just mark it as having missed events. We could add
a pr_warn() that says the buffer was corrupted, but we don't need a
"invalid" event.

-- Steve
