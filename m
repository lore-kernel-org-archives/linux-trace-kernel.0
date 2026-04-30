Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A76D3DA7EC;
	Thu, 30 Apr 2026 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557070; cv=none; b=TFNUYtCTM2Q3Xd1SY5czpDuImK0SMfYvDx9rSuuZ+54XpqNE35xg8vRVOWxwfPZqJ9ypa+UcKXoBiaqeShsxzl4AKjuLEo04avZtYKnYx+J+ZoGGd+inrXdWJVyg9AzFTiWqkpaJ+sRyUDHUa7N03O03i1M77Znh3CgSmgIPSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557070; c=relaxed/simple;
	bh=OpN8Prpv10sIl7Ff1Arb4PHgP/pH1AVwauT7gFnLaHg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VPAHFeZuEpFicunfz8t3PY5unQrpZ43CzRrp654D85LlLczCpvE3xWbapo4SHCn+iHxA4srOpqZUx+BhdlaIQ3KZnQMq6gOgN6SHA03jXGE6yQrcEkLxCgG42K7h/GkIwDCcMmbc65ljM+RY9gGv+KEn7JMU03b6O38Ew5WXFWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A8601D1D56;
	Thu, 30 Apr 2026 13:35:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 26EF080063;
	Thu, 30 Apr 2026 13:35:40 +0000 (UTC)
Date: Thu, 30 Apr 2026 09:35:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Carlier <devnexen@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] tracepoint: add lockdep rcu_is_watching() check to
 trace_call__##name()
Message-ID: <20260430093554.756072d7@gandalf.local.home>
In-Reply-To: <20260430053511.8767-1-devnexen@gmail.com>
References: <20260430053511.8767-1-devnexen@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: q9id8qp1feyd7s73u3om9jb4o33mmbsz
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 26EF080063
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+p916Swy4me/4Nm8CXLG+r6fUu2JGnwpo=
X-HE-Tag: 1777556140-186274
X-HE-Meta: U2FsdGVkX1/0BNUubA0nktOv6cQOPBQdFNgh4Gq2B9KIcnlVocyDdeZe7QLtJ22gTy8F+YJXCUIRlP8jkgStQ6eskkxvHWFoxcPb4CXKQ6XXNyGnIZLWSk0MX93bmXfGZgdH6shauWXRvC7wPQSTSWIypATzujX9mBUgxpIERdkeBN6BOG6n6/C/fpwnfIYHFOEV6TlLwIF25KPEq4HqYa/5BBjO84hY0OVr8m99eotbGSw/hPmP2Z7FUDnHg/xcH4amzJ/DmnkysFcw2szf/A9Axx9I+MTosuZTjg5L6rhN5GmcFKNrEmDFs1GLl6T+a2fyNT2WJKt3Jj0RhLwkz+2y9odWor/C

On Thu, 30 Apr 2026 06:35:10 +0100
David Carlier <devnexen@gmail.com> wrote:

> Without it, sites converted from trace_foo(args) to trace_call__foo(args)
> lose the WARN_ONCE(!rcu_is_watching()) coverage under CONFIG_LOCKDEP when
> the tracepoint is enabled - the case that commit c2679254b9c9 ("tracing:
> Make tracepoint lockdep check actually test something") added the warning
> for.
> 
> Mirror the same block in both trace_call__##name() bodies, gated by
> (cond) in __DECLARE_TRACE to match its trace_##name() and ungated in
> __DECLARE_TRACE_SYSCALL.

If it gets called without rcu watching, the rcu dereference in
__DO_TRACE_CALL() will trigger.

No need to add the warning here. The reason the trace_foo() had it, was to
trigger when the tracepoint WASN'T enabled.

Now, perhaps where the warning should go, is in the trace_foo_enabled()
code.

-- Steve
