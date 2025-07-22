Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196C110F2;
	Tue, 22 Jul 2025 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753223900; cv=none; b=aBn6PYjW2U2W+i7tn0MaW+dymc046bw2IRxbbUg123VcXPeOMWj1/u4ie+SWT/Msw7VLZpeEwL8GzCsO0H9RdwvhbaZsLM6ZFZ+/UkdzjJqwCd+z6P3CWrOs1O0Ztj2fc9I/SnBD3U9vILeKqI+dtOuglqabRWEx94DSpKyPOLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753223900; c=relaxed/simple;
	bh=O4lTGhJPt0Y+JJtY/1ypIqNNSxQvZLpaqQoEtc6MRhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SD40syBP4MHQaZtJ55oiwGhwdlNhpLvw6AfGYbXR2EaFrsD32xOuuh/luLRoVTJfCuphVTJ0QXGxkoUaLYo187gjkHhqOWzgXhL5FyRiDz4Kf6fYaEXV5hp8vmHdWQOcK6Tgto0SbyZ2avMqYhguIlGQn3C2vPAccfzCZAIGT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id DC58C59353;
	Tue, 22 Jul 2025 22:38:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 34AF46000C;
	Tue, 22 Jul 2025 22:38:14 +0000 (UTC)
Date: Tue, 22 Jul 2025 18:38:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] tracing: probe: Allocate
 traceprobe_parse_context from heap
Message-ID: <20250722183813.74dd1386@gandalf.local.home>
In-Reply-To: <175322170601.44400.16839124706616607558.stgit@devnote2>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
	<175322170601.44400.16839124706616607558.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ahe595rfxbyrusj76d6eqfdxag4nf7cn
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 34AF46000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+YE4SSP3kdxcYZkd1J/kCI3qbFgQxVdxQ=
X-HE-Tag: 1753223894-968788
X-HE-Meta: U2FsdGVkX1/+IKfaPGRmCn402R3POCQxNFAgY7fI0DncJyo/8AXG3pNvxqIudi2XcUD/k4Pct5/agBODstVyfou682GQDb5w4eaHXGYYq4/LQB7H3ajdsqTfz7mbKdkzrKlk0D6KN8i17rKqoCMg1cZQg6D6u/kVYDVlQsNzCQbjPFr9tIV61yyfmp1Efn61kTif/lnJll1N8l3v/BOh08YJyXnDRMlnC2GtYL1yqH9ha7en0gFg/CRyMAbuv0g08c3h/NQ51mv3OZrfns2+ePVhBS7SVCaFEzNRdI1lwAhKB0l18q2NyTOmDP18QOBSfaa5HCbOCwkDGY5Jw8eMPxu0/Qfr9lOOzs5ofvOlFFnZOuh5Wk6JzRZV5IabUm4IROMBTU/otKzZoQfWKWWrBCM007GRid5xmVzSm34fHOk=

On Wed, 23 Jul 2025 07:01:46 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Instead of allocating traceprobe_parse_context on stack, allocate it
> dynamically from heap (slab).
> 
> This change is likely intended to prevent potential stack overflow
> issues, which can be a concern in the kernel environment where stack
> space is limited.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202506240416.nZIhDXoO-lkp@intel.com/
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
