Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8D032E6AC;
	Mon, 24 Nov 2025 20:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764015188; cv=none; b=b+3sHmtvndKAF9MYpj9jHN4RXRAl2v7M+0KpmKxdHyqBU2SjmsQJJ55i/2AWMHUxHFbioK5W1PVXlBQqArLC66g9KuqFFAyOD3rfttWaRgiPYqBiGwVhE+7nE7PSqjMLY1WUL/FL71waEuL1XQwiLTYEBOsSbvfv/fKEw9suBGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764015188; c=relaxed/simple;
	bh=xHo61vJ5nQFQu6c1UrCVWvtoTvY5cpP9WHdMCkOHtFM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=myZB4RSMZzJiFGZIjdWbJy7o8s6vwMTabSjgoGyiiwewMhslHj/8KzFRbUAjoEk8n0gwRgsZPmqnzlnBPFXVj+erMsUpHy4LXi/S+VZi4XDDQmmQFbg7JgH9FcYFFQccLqM3arCTu7b7Q42kO1zwr3JQtBpkO75clW3mjVXB2sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 1F4C01A054B;
	Mon, 24 Nov 2025 20:13:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 28BA060010;
	Mon, 24 Nov 2025 20:13:00 +0000 (UTC)
Date: Mon, 24 Nov 2025 15:13:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Lukas Bulwahn <lbulwahn@redhat.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org, Lukas
 Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] MAINTAINERS: add tracepoint core-api doc files to
 TRACING
Message-ID: <20251124151341.3e99a015@gandalf.local.home>
In-Reply-To: <20251105182505.6efad861@gandalf.local.home>
References: <20251105092428.153378-1-lukas.bulwahn@redhat.com>
	<20251106080616.a46ca1c46b4034ce9757e5c9@kernel.org>
	<20251105182505.6efad861@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 28BA060010
X-Stat-Signature: fwd54mib44p5qkqhxidqpzespecd35di
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/nYpvfZztApzwGmtUyPFLO23D+xnGWi+g=
X-HE-Tag: 1764015180-465532
X-HE-Meta: U2FsdGVkX1+5WfzA9dGIycsRNZM3kZT8igEct0JOXX2f8a2x0Z3FI/WdifZQ36G911oBpd4SKYAKb44vhCrMuPYznQbNOB/vRGp+GUD58GtMmkIZzPeFjrEG5mLubkwmprxgL9lxiPVsGS4SkvhCD+GmQYzRuaVgppk4rW6gc/Mrp4UPP9iXBZEj1Hht5SFCb5O1XvfGZCrZi6661Ld8gm+u7uBsEnD3zjnxP+NpRkdI5j2Kk2/R68LzKvZa63tm5RDvcw7xSJwmC5wKq3+ZPeflgP0GP+qwfMYimlWx+Fj3jCPjaYYQDo8ASI70S5ILnN8IfxJQCFbsvL28PaSCKNsQLRLf3ayLyypWCz8YGJuqy594S19keeeDn40anlkvDH8Tkj2RqElaEfdQNLnatg==

On Wed, 5 Nov 2025 18:25:05 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > Yeah, that should be maintained by us.
> > 
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>  
> 
> Agreed:
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

BTW, should I be taking this through my tree?

-- Steve
