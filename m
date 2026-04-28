Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D4B1F7916;
	Tue, 28 Apr 2026 19:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777406099; cv=none; b=UoJtZz+DesnMn31eMW+nrZmkK81SWoqWmV2uUFsadyUnR3wdLD9Uos+BP0rPnUT+75UFxzBANPegMdjal4Do8Hwwu8U6FGpXn6DGGAjTsNJbq0ljSsfk57l6EA5Ut/9bMe4o9DyOOkaHF/6t7Avbpk7nTtHv4Z/r7XpJXtnkpAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777406099; c=relaxed/simple;
	bh=yQdhugZtdilFCH7oKpjwX063ZwGY5J/CX9CRXPXswmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oru7OPzGTFc4ihKLPfV5H/JwzjwRvM2NoMURy5uAuOx1JXJ2PpQtentiqH2CLxMCj8UMHl9h94FNbYA/ncY6ESfJk3nsyLEo5qf1aClIoRI/QgJW4aZJ07+7V+VTV2v7DCjN2c1FJf+4sX6cGH4g6JVA8g2lgFM9Zljfn7zerDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 65FF68B4EF;
	Tue, 28 Apr 2026 19:54:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 6158820016;
	Tue, 28 Apr 2026 19:54:53 +0000 (UTC)
Date: Tue, 28 Apr 2026 15:55:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 3/8] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260428155508.4f47279e@gandalf.local.home>
In-Reply-To: <177701354681.2223789.14633430761021638378.stgit@mhiramat.tok.corp.google.com>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
	<177701354681.2223789.14633430761021638378.stgit@mhiramat.tok.corp.google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: m9mastd5se131aaz4xejahg9oauwro5m
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 6158820016
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18m48WcMR0YIPxC0AO+Xbj94B0nP/3Lxys=
X-HE-Tag: 1777406093-875647
X-HE-Meta: U2FsdGVkX1/lgOk4DwxGNl45o43+EDq39Zqwt0Ndd1cEsKemzPRyqUO+pIk9qv0n/P7XUAi3kvadBvvbT7bucgbRICT5LD6cao+Y3OQizFwbJFlAqaqjen30sMCEstI2dYmZ1S4zjl+YiVSQX+mk6zFx/HgCdQLWr0/snJP7Ra1xo8CUYkax2gDa2WZWA0BAOZqLARQiVGzSWChXkBUhgMTw8FhenhSsELu4HgFsuAPgjhiWrV9D7TdrvQ3nmbfGqBXm9NjD+2XDPmGhUSkP8HRp0Hexbv/c9ImW8r1i6vnMdaGZbm87WEyKsOUHwv/O3Chh39tngpNDVIUxqTr+OHD8ZGc2xgX+

On Fri, 24 Apr 2026 15:52:27 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> @@ -5648,11 +5668,12 @@ __rb_get_reader_page(struct ring_buffer_per_cpu *cpu_buffer)
>   again:
>  	/*
>  	 * This should normally only loop twice. But because the
> -	 * start of the reader inserts an empty page, it causes
> -	 * a case where we will loop three times. There should be no
> -	 * reason to loop four times (that I know of).
> +	 * start of the reader inserts an empty page, it causes a
> +	 * case where we will loop three times. There should be no
> +	 * reason to loop four times unless the ring buffer is a
> +	 * recovered persistent ring buffer.

Can you explain more to why this is allowed for persistent ring buffer?

Note, I do not like any loops that can go into an infinite loop and lock up
the machine. If something goes wrong with a persistent ring buffer, then
this could possibly go into an infinite loop.

I want to understand why this is allowed, and possibly add a check that
prevents this from never ending.

-- Steve


>  	 */
> -	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3)) {
> +	if (RB_WARN_ON(cpu_buffer, ++nr_loops > 3 && !cpu_buffer->ring_meta)) {
>  		reader = NULL;
>  		goto out;
>  	}
