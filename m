Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E492D595A;
	Tue, 18 Nov 2025 13:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763473984; cv=none; b=hKvsTgR5SjiaxO4NwXv/ZyW18yd1ccAN3fP5fM+YNaiTKdNFXpn8PhT8E4NSIrqoXhwkHW0sR5AcZE3Ipa4bc5QBZThX+ztBelum4Y/eBJbjRBT54A0wEFfQUsWKPuf0kB342eFUzgDVg/O3bs8mVRMCG1ZZqnUst+vZjE+NJNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763473984; c=relaxed/simple;
	bh=ogLbbCW+wzR8Ke7FfdDpbk3pauCtGOWvIdtmorVKo6E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cZW/X9EuAYn6B+cCzWhO4N6p9KLR667XxWRiOiZLV2b9G15WJPyKLLpC7QGc/ekM7VYk7vkuvW+hG7SOOKgwHgAQvDmszUcpxKmkKofDN1zmDOaTCtA30qcbpSUa8yYGqdafACYQT6cMHLHV8Tf/tg6FRSS6CQvRUsQl8ndButE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 677C758895;
	Tue, 18 Nov 2025 13:53:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 8A6D220027;
	Tue, 18 Nov 2025 13:52:57 +0000 (UTC)
Date: Tue, 18 Nov 2025 08:53:24 -0500
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
Message-ID: <20251118085324.32816807@gandalf.local.home>
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
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 8A6D220027
X-Stat-Signature: gar98u9ihc7n1jwfx6m66ef3an5k3o7i
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+YLNCnnRaXdo31052x8nmaVW2RmTc6lDY=
X-HE-Tag: 1763473977-111348
X-HE-Meta: U2FsdGVkX1/OIx5NgS9H5bIEDHpB33q9BkdZ9ru2HN/dvkJOdROz7Q7c3X3DvZAN4Inri62x3WlQHUnHirV51hcHYkSnVV68DRPCKjbLXIpsknlfbC1sEpb5Kh33uNrj8kEg90qJp40BGdrHFIqX0UvQJKd0dtX6+w7mGtTmmaml9rz/RCQbJkB52J4sqf+dUtvRsjExG9l2M8pI+ZkSECO1sDLzDpwBwrXZ8BIMLBGtrQtEJSxV3qXOFutC+rTwFwsqrZ9JKnpbxWCTABdyux0oD2Rc64zf2UBRi3OXeW8CT9QMLSsXqJGNi3+7L04q/v9T0LasRtPertAJG66Cl4wjDRJyJNDo

On Tue, 18 Nov 2025 17:11:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > echo "perf:my_counter=pmu/config=M,config1=N" >> /sys/kernel/tracing/trigger  
> > 
> > Still need a way to add an identifier list. Currently, if the size of
> > the type identifier is one byte, then it can only support up to 256 events.  
> 
> Yes, so if user adds more than that, it will return -ENOSPC.

The issue is that the ids are defined by what is possible, not by what the
user enables.

-- Steve
