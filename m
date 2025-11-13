Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9AD43557F4;
	Thu, 13 Nov 2025 16:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050476; cv=none; b=DAqxpGklNPEk+OMGnKJ/q/Qw2zlaP10B9WQQ8v+aSCRS+9IVopAUcVkB2rI7uOA+3ewqTHYCUVSn2uk2KS3cZHV5bCeP+0XaGocPvMc0bhExFC7sQl9oBzj/RMqJT7TEkgeJJ9oog4g3QcgOZxoH1ia1GPA7FKFpbjw3EzQUmK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050476; c=relaxed/simple;
	bh=nCinza8nXx9Hmdirv7+F7P9s5xaniUgTMseT8oVoFrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEgrUbEwESpyMmNSV343USrtO3Uv1P8NqVGSO+f3cznKf5IG8KVvMceCn5d4v8RGtmm3dAIxwvPw11jVyFECA7+zNeSlxREQZED3iT2pyM2+U0Gea+CAei7pGT2Mx7E444yPmq8lrwZ37AKVT0sQ3xGzhOyjQjY5kRF77U6fTqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id AC3755C2C8;
	Thu, 13 Nov 2025 16:14:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 7590F2002B;
	Thu, 13 Nov 2025 16:14:24 +0000 (UTC)
Date: Thu, 13 Nov 2025 11:14:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com, Yongliang Gao
 <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113111439.0f65c135@gandalf.local.home>
In-Reply-To: <20251113160739.DUvh9i_o@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
	<20251113073420.yko6jYcI@linutronix.de>
	<CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
	<20251113141515.iZSIDK0T@linutronix.de>
	<20251113100524.5c5f6bdc@gandalf.local.home>
	<20251113151729.4Zky6d-t@linutronix.de>
	<20251113102445.3e70c1ec@gandalf.local.home>
	<20251113153508.9mYBNQlL@linutronix.de>
	<20251113105106.4270f6ac@gandalf.local.home>
	<20251113160739.DUvh9i_o@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gyds8z71y513t87c115dmt3uai8zutis
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7590F2002B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+0jg/VqpirRkY1Ose5yAU41JKcYZ9rCNM=
X-HE-Tag: 1763050464-866752
X-HE-Meta: U2FsdGVkX18cQi7g5vupGwmRZpL7/m9u9MdsYl3xRiAR3aliWAcYn7dAnBAgEXV+/9mTfWRzDZhz80bj7La32WdOT6VWJaTuGACow0YZ4RBxfh//8BZ2NPnIjm6dZfMjanUQHcvadrJXx4lk0PUUZcj1E5+ltePXEcdZ+DfOHspuRxIbWToaj44sEPk32EH5lo2+4aRbD7el/TiYGR49L32lz+QHFSWDrF5a8QyNNfJH5v1EbzINANZ6JUhz4+FWjVuL9dqG9KkGhZMQ6VaFTs3dP905PnflOtHkrbjzpT0SL0Yo58szLi5mmE/iKP+n

On Thu, 13 Nov 2025 17:07:39 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2025-11-13 10:51:06 [-0500], Steven Rostedt wrote:
> > Yes, because they are only tested in sched_switch and fork and exit tracepoints.
> > 
> > Although, this was written when tracepoint callbacks were always called
> > under preempt disable. Perhaps we need to change that call to:
> > 
> > 	tracepoint_synchronize_unregister()
> > 
> > Or add a preempt_disable() around the callers.  
> 
> Please don't. Please do a regular rcu_read_lock() ;)
> I tried to get rid of the preempt_disable() around tracepoints so that
> the attached BPF callbacks are not invoked with disabled preemption. I
> haven't followed up here in a while but I think Paul's SRCU work goes
> in the right direction.

I meant just reading the pid lists, which are usually called from
tracepoints that are in preempt_disabled locations.

Anyway, I can add rcu_read_lock() around the callers of it.

> 
> > I'm very nervous about using RCU here. It will add a lot more corner cases
> > that needs to be accounted for. The complexity doesn't appear to be worth
> > it. I'd rather just keep the raw spin locks than to convert it to RCU.
> > 
> > The seqcount makes sense to me. It's simple and keeps the same paradigm as
> > what we have. What's wrong with using it?  
> 
> I'm fine with it once you explained under what conditions retry can
> happen.  Thank you.

Thanks,

-- Steve
