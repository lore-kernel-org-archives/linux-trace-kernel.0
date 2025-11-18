Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6685393DF9;
	Tue, 18 Nov 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763483491; cv=none; b=OnC2jZb1cJ7IWs3xJbjVtL1cPE+pywrFk6ZT1WNRM3ArRVQ3o1XnFKxl6Dn6A92sC2f1noDhMdTkKrF/SdGiOy4/BHfKZtW4yCXSt3eFpr4v1yzKKI5DC78+TkhprOQxt5NO7lJbFgzAaiHyKXHp5I13eGK81Om//TkOH0FDnLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763483491; c=relaxed/simple;
	bh=VArFyFTH61MvKpaBYcbRqfd+AnuJxKQoVoXbVZht0Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VX1EB28PfqHZRZ5dn365C48/cTTIarPPxU3eQ+SR5rTWhvUDlBUsE3tJhuyzbv0oDAgexhTt5+83CMmkR9bH0iNWLBA5MW7qjWZdqxUkJDV2g3ulZC1TJU6cenPlqOS397ZkjkOmvkkpoB00Wh/CNi+Ea/Kbj/mDxfOOq650J7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2E336C05B7;
	Tue, 18 Nov 2025 16:31:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 4607D20010;
	Tue, 18 Nov 2025 16:31:18 +0000 (UTC)
Date: Tue, 18 Nov 2025 11:31:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>, Namhyung
 Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Douglas Raillard <douglas.raillard@arm.com>
Subject: Re: [POC][RFC][PATCH 0/3] tracing: Add perf events to trace buffer
Message-ID: <20251118113145.34ca624e@gandalf.local.home>
In-Reply-To: <20251118171147.72d4f1e26407f8d54720e0f2@kernel.org>
References: <20251118002950.680329246@kernel.org>
	<20251118120821.0c47ef684b53d5d9a2d6dc83@kernel.org>
	<20251117224227.782f6eab@batman.local.home>
	<20251118171147.72d4f1e26407f8d54720e0f2@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 33r34o9ga67zpi4atz8tyyw4inybks9o
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4607D20010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ubVP0JUDr8P0B+81F+7mtbZ+gLMgBMfc=
X-HE-Tag: 1763483478-10747
X-HE-Meta: U2FsdGVkX1/QMKKj+Lpp6mxKba4uENFQTSc1b+DUsD3XeWYsE4ieKPLQBdgSfwb8QHSkwbixY5sJ8K7hwigM/8UbQQv69cQ8Nhl2Qa2pIp8T3hDJ09gee5+7uzy2cIkHvIcjpVlU3mFSzfFWaPqIUKcmsfqtdyDNJuV3SMaY2BhTU0PrHS2s3siHBEEanvQxsZlpRpbHZOHvrXe4X1PnTgaezqp9+0ToCNe9x6fw80tc6VQFKURpGW0VG+IwQO4NsqN15N7jmBfzZuW6RbQXLcE+mcLsGDv+zVGTzC/jZGzGDx45LQ3kX1tFiF233JyFzM7x3xx853plNXOtSOB7mZElhzB9aFuu

On Tue, 18 Nov 2025 17:11:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > If we need to set those counters for tracers and events separately,
> > > we can add `events/trigger` and `tracer-trigger` files.  
> > 
> > As I mentioned, the trigger for events should be in the events directory.  
> 
> Agreed.
> 
> > 
> > We could add a ftrace_trigger that can affect both function and
> > function graph tracer.  
> 

Actually, I should add "trigger" files in the ftrace events:

  events/ftrace/function/trigger
  events/ftrace/funcgraph_entry/tigger
  events/ftrace/funcgraph_exit/tigger


Hmm,

-- Steve

