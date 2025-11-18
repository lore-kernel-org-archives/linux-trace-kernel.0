Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924103376B8;
	Tue, 18 Nov 2025 13:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763474234; cv=none; b=QMkWv9ZKFJS0g2GhEMlJJBlWM5ZnjV30YRj/VNEScSsVTThUXHmOMXIDgTtEMO5viO2IE/IH8x7lTw7FVDh8/Maezc2iqaaGf9hQk3PFyxvEk8J9UQRurbxLDLb4k3pwkmPnl4uSy/t1muCC+yJYpJ2miV901/a2kBpRX7jLMZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763474234; c=relaxed/simple;
	bh=C0vpxMUpcMm1Jtr1s/Hwfu0NydpQe3jkyLTCqmymRAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkvV71IaTy1+INA1DqjtiWHeV8mCu1BGslv4D7fJBmnpz1gVvyjbZdgZkczhLT6x7yejdVZ25PcPQg5X58HWs0G6OovdTexpD53UreajEFups1cFErk0N3V8im0Lv1bxpSKJ5Qy8bctom6jiBuwiX7H8ZuPtlL0DnrkRXHIb6Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 6F3FA14053C;
	Tue, 18 Nov 2025 13:57:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 989E82000D;
	Tue, 18 Nov 2025 13:57:06 +0000 (UTC)
Date: Tue, 18 Nov 2025 08:57:33 -0500
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
Message-ID: <20251118085733.2a9ce5b0@gandalf.local.home>
In-Reply-To: <20251118085324.32816807@gandalf.local.home>
References: <20251118002950.680329246@kernel.org>
	<20251118120821.0c47ef684b53d5d9a2d6dc83@kernel.org>
	<20251117224227.782f6eab@batman.local.home>
	<20251118171147.72d4f1e26407f8d54720e0f2@kernel.org>
	<20251118085324.32816807@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7sfjujzhwn93opepwbtjftxyr844ueff
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 989E82000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18wmqGD2xByqUytnGOmmm5fZa8Y4nNbztI=
X-HE-Tag: 1763474226-370225
X-HE-Meta: U2FsdGVkX1/2PM3H1K5tv4igudRZVMWL1DnIX/s1lnigA6Ew6EbKafz6jObHdx7uYyuaSh8FeDAC4anWT7F56Fn4M1FgX8AOOntgDOM9Oph14TGUh4ERd+Dc533LENAHcKh4j4elt4DFGC/wh9QbINyCBAdoaV0v/uF1vGyjhpeV2Ys21kxkcolaYNaOB+kZifL7KLVU5PxK+Ez7/bh1rYn2qdWOIwc0SSlJ/c1U4MNYXRXERNb8puSvTORi4wP7yPHH6i9Wy36oDOLwISDMUQzZvwgYl4WAFkZeDS5eQjBhwQhZI+kKz8vhKYWdA/akC36b19Yk22dxquT7oaXdAFrODagYQEgQm5JTVNsiy5lTvje3n95fguzLdTQ4pfjG

On Tue, 18 Nov 2025 08:53:24 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Yes, so if user adds more than that, it will return -ENOSPC.  
> 
> The issue is that the ids are defined by what is possible, not by what the
> user enables.

Now we could take 4 more bits from the mask and bring the raw value down to
just 52 bits. 2^51 at 4GHz is still 6 days. Which is plenty more than required.

This will make the id 12 bits, or 4096 different defined events.

-- Steve
