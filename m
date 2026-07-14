Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85FA47DF90;
	Tue, 14 Jul 2026 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784045515; cv=none; b=tdLCSLLDY3uCdqtuakl3qNxrErwyNeIulLKDpQnBkdsbxedahucCq9wW9YPuV2+NNyszJ+aFIr7x/8QWyEcKU35h0oiPB7qXNHxjWphaODsrPx6YJojq8GV6QKWtSic2MXfEF98Jm/fglCr5XU1I53VnqX6Le+TdfrTDmOQAztY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784045515; c=relaxed/simple;
	bh=ZgkCnmDFbzXv3VQralO4WFT5tgQxRh+5/euC+KLF664=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvSQreP0A2430h3+d6d41SWbeg+jE3bzoZSVnz1zuQgUThRUJtFDrTpdSlCX+oxn5qnAgLomcLYuZ9PEiagy7xktbBp4oGxpqKByp/6QPIW3axRgf4aSOQnB7YOGiSd3owo7FdXdUCt9nnZ8e2iNebA2QGhV9sD95ayWGW8x7nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id DA304C0405;
	Tue, 14 Jul 2026 16:11:45 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id BAC8120011;
	Tue, 14 Jul 2026 16:11:42 +0000 (UTC)
Date: Tue, 14 Jul 2026 12:11:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>, Vincent
 Guittot	 <vincent.guittot@linaro.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall	
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider	
 <vschneid@redhat.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v3 4/5] sched: Add task enqueue/dequeue trace points
Message-ID: <20260714121145.1e73c05e@gandalf.local.home>
In-Reply-To: <61d904e5dc673d398c20bc4359e0f9b16ef4fde4.camel@redhat.com>
References: <cover.1754900299.git.namcao@linutronix.de>
	<918fe0f29a94e49db05c4f63a8a210dda9b90925.1754900299.git.namcao@linutronix.de>
	<61d904e5dc673d398c20bc4359e0f9b16ef4fde4.camel@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: cymut3jt3wkhodd9xkpy9zgymjsefmma
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: BAC8120011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/QfbV98iHxc54oaReqUEYdiNvZksvCebA=
X-HE-Tag: 1784045502-69967
X-HE-Meta: U2FsdGVkX1+gM2+3z0OHafZM+IF37iUglsM6n2rmVm7sGmPj6GPMWosE66vDOEgY4+C+ALJB/xvpUSSzdzg41SBbAzsjrJMeuVbYnm8rsJRhHzXBbr6GlGTiFTiOqfk7dWcVwHmQbqqaiDxT04bgKz9gDKuKNXPdigHGD0gqTYHoJo3hdX/fyRv1dzbaJXcRa28xAKiYd+ESp5LEUfO4TmkO/MARc6aMI8Zr4TfERjIknul3LHUUMs+WgejlnMyo8q6LAJ0sEqLixzVvifTrW0jsurNtE8k3LdPcaFRlBhHclYNAn8FSbbjbwV7+pkMs/CDGOootfWZEjVPNBoUpzB05uAwUSs1ujn/U4NQiN9u5T9J7JbO1NA==

On Wed, 13 Aug 2025 08:50:39 +0200
Gabriele Monaco <gmonaco@redhat.com> wrote:

> On Mon, 2025-08-11 at 10:40 +0200, Nam Cao wrote:
> > Add trace points into enqueue_task() and dequeue_task(). They are
> > useful to implement RV monitor which validates RT scheduling.
> > 
> > Signed-off-by: Nam Cao <namcao@linutronix.de>
> > ---  
> 
> Peter, Ingo, this patch adds new tracepoints in the scheduler do agree
> with the change, can we get an Ack?

Are we still waiting on an Ack for this?

I see it in the archive of Patchwork:

  https://patchwork.kernel.org/project/linux-trace-kernel/list/?series=989907&state=%2A&archive=both

-- Steve
