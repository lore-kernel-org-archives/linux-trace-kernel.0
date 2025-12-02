Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516841C71;
	Tue,  2 Dec 2025 01:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764640245; cv=none; b=UTehAhXwf1xMJaAPk5bu9Dy+3nvoxytJNqrWCpWtOPY7wHfnVERuZKSf4kP4gCmSQZglKvCw3SQgO9p+Kym68q9x860qrvtmSwoUTYwJTKzECXhCEUTpPReIT8VdqXiKFjDp86fc2ELvuDi8+HM9+OaqrAdIo3oMeg7gMTOHB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764640245; c=relaxed/simple;
	bh=qcwYCq08cNL03h++s8AsBpFLxNX5kS+FrqBl7PVoG18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwaSqsqxbL/hQDXK1GQzR24zmmS2t4CuLrLpYwIxMDPNbDFYbCq8Us6RL0/5H5eA3Dl8XbSNPy0INOm8Hyg+JHqk8ZBWUlqImF442ndpYuYMYGKKmMcFyLFZk0p7V/QI8iyEaVLYsf5VJCB2AFkCHn65uge/6XuMwfB6ZEzISxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id F411F1A0485;
	Tue,  2 Dec 2025 01:50:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 2ABBD1B;
	Tue,  2 Dec 2025 01:50:34 +0000 (UTC)
Date: Mon, 1 Dec 2025 20:51:32 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Nam Cao <namcao@linutronix.de>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
Message-ID: <20251201205132.520eb490@gandalf.local.home>
In-Reply-To: <20251201203816.5e777f12@gandalf.local.home>
References: <cover.1763370183.git.namcao@linutronix.de>
	<dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
	<20251125145736.48c3ed9d@gandalf.local.home>
	<e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
	<20251126095106.7eadaba6@gandalf.local.home>
	<2e46a7dc417119bb7e331ff14253b0ff678d697e.camel@redhat.com>
	<20251201102447.53f33be5@gandalf.local.home>
	<8f98932a8fa9c3e63c9a5cb7ba764e9db968bada.camel@redhat.com>
	<20251201203816.5e777f12@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2ABBD1B
X-Stat-Signature: qoyka331onjdjn3ky7wgmbafauim5w64
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19wDQKiQUUdpLjfW4CmjnGESvpU4+zG0Z8=
X-HE-Tag: 1764640234-878713
X-HE-Meta: U2FsdGVkX18LzNSn2J3ZCJCF/UT42HeyAztK3bT6+3ujmWS7ZpmUMtB9REkcrTB9zimWSYN5L1I2GPXctSnjdAZDwsA2MP8Ya8FFGpCSuodiqyUjBVOTJrd3Y2hTDLrAScg6pjjry6Mj/hNYV5ZmIR0ag0RC2xGMDPFUwOByoQxgcKaD2Qd935rZOixO7O9reoWLqUatTuHi+n21jM80AEddLTMYW04mY85HkloygexPQ+ySA+7Fw7oQLNLBRs1Q1l/SVJzazZ297Tm+P/WpfT62QonIlhGhKy6OioOFm6u0ahu4JyAHWTEzNZdagSOHMtDYyPnWGuU4+wM+HEAZ6xAWQJhWj4YEfNettQO0PZ6u1UIJWKvOnNeX8AaN6cvg+Ha1ovkDaWC7TL/oISQFxpxL1DejQKsuKpsGLJSZdwY=

On Mon, 1 Dec 2025 20:38:16 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 01 Dec 2025 16:28:21 +0100
> Gabriele Monaco <gmonaco@redhat.com> wrote:
> 
> > I'm stupid, I sent it [1] but the script somehow didn't add you in the To: field
> > and I didn't notice..
> > 
> > I'd say since the merge window is open, this change can wait.
> > 
> > Sorry for that.
> > 
> > Gabriele
> > 
> > [1] - https://lore.kernel.org/lkml/20251126152253.464350-1-gmonaco@redhat.com  
> 
> I can still pull it and run it through my tests tonight and push it later this week.
> 
> It's just clean up code. Linus doesn't get too upset if simple cleanup code
> gets added just before the merge window. It's new features that he doesn't
> like added late in the game.

After pulling it, I take it back ;-)

It's best to always use your latest branch that you did your last pull on
during a release cycle.

I see you based these changes on v6.18-rc7, but your previous pull was
based on v6.18-rc5. If I were to pull this in, it gets a bit spaghetti like
in the merges.

  v6.18-rc5 -> pull1
  merge <- v6.18-rc7 <- pull2

Where now we have changes between rc5 and rc7.  Was there a reason you
based on top of rc7 and not use your last pull?

It's fine sending urgent patches this way, as these tags are in Linus's
tree and it's just new changes being added. But for a subsytem tree, it's
best not to pull in Linus's tree unless there's a good reason to do that.

What I can do is simply pull the patches on top of your last patch
directly, and keep the history clean for my pull request to Linus.

-- Steve

