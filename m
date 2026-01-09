Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F61A285;
	Fri,  9 Jan 2026 19:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767986853; cv=none; b=KY+DTrL+V873JaWmGAlPSc9rvJ7bSo+L75vK6i2Rwf/82oH5OEM2s80z3/0NyNdHRRFpE/0kXgFCE05G9h3jWQqEu5ZIz3l/1CVlHJcg1DFbcPsy2KHvkkwitU1mX7cis7/yf8Vu2//2bXf8KJotoS9GFmWHomLU0PgyHFPrScU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767986853; c=relaxed/simple;
	bh=OenCN6HjgGMHYIHj9sPx0OSi6qw6Ed/g+qzaqsxFHhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjmDCNNh+rmraxVp2h1/46sJAeYr2IRjm5agfDxaEbE/RhCR12uxNEWK6J+Rix3CDxS1lU+FBqBHQucr3bNargQptB1AsFJ2n+bCiaboy7yKUHeM2Vl3QiGLjH3dc82GwOeAVVjSBp5Vx+Uj0zP+wm7TS2z4lhpiU5XcoDvw4U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id DAA2A5B75A;
	Fri,  9 Jan 2026 19:27:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 7CA8E6000A;
	Fri,  9 Jan 2026 19:27:27 +0000 (UTC)
Date: Fri, 9 Jan 2026 14:27:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Tejun
 Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Frederic
 Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Michal Hocko <mhocko@suse.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH v2] tracing: Replace use of system_wq with system_dfl_wq
Message-ID: <20260109142758.145f57f8@gandalf.local.home>
In-Reply-To: <20251230094236.358ae2d8@gandalf.local.home>
References: <20251230142820.173712-1-marco.crivellari@suse.com>
	<20251230094236.358ae2d8@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 8koh9yizza1xkeju5qigiw3qzry8ekkk
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7CA8E6000A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19T+HqThgZMoB4pM+VO2FIrrY1DmOyDiUY=
X-HE-Tag: 1767986847-43518
X-HE-Meta: U2FsdGVkX19RjaI9IZoJWGFiLDTLSqnoEntCrd4KusakDxv11uo4+qWv9rjdXWbUPYgNH8kE2qLTuqsXgqiWdDl5qDgMR/s1BrMOD/FxIdQKzF3Sn0zcGW3B9yPaZiZfI62DF1/F1x7iScvh0jkFBqDHSdjq0B0UXi77Dh/41Ew3VXV4Oho1SiUL56/bwZchrzXzZv0UoDRPLk4hLYpVtVe5F97avU9MOdYDaymgs0NlMgYWl0O8qqGF4N3rGYNWVF6t51WQtOXUa3av60/6qi22JOadchZmHNVOu692//jg8X6EIM9QwD95gj1t6O4ZF8OZQtn15R7885L8JAwYothcyisdvUbdOQMTj03NF0bT7UItgUeLDNjmEoRQQ04Ra90nn2UvIFnqIzbzNrb2x/d4aUlXcUClt3Jcp5QZ95DvsTiPQeYbeP9tRb3iXfiR1JkhIVDuQGZBRrJwTK9SOA==

On Tue, 30 Dec 2025 09:42:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > Suggested-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> > ---
> > Changes in v2:
> > - use system_dfl_wq instead of system_percpu_wq because this workload has no
> >   benefits being per-cpu.  
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

I guess I'll take this through my tree, as I'm pulling in patches now to
base off of -rc5.

-- Steve
