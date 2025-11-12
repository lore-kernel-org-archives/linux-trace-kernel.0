Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4408833D6EE;
	Wed, 12 Nov 2025 15:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962125; cv=none; b=FOCP4BZ5lweqNtr4CYKIB1PrCaClgjLuP+V/Kyf+w8ly789qdXJJ8YOZ+A5B0Pw/KxF0dQuBA4OIHivvP2/7LGObKkVqvj5cjTBd1mIbskOjv7G72s4cshVEO6N5XTTs0REyDjmsoQHt62StItM56kirC+if2Y/Je1E1u+oLaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962125; c=relaxed/simple;
	bh=3gkC8Ve81YewfEXHoyC7FppINRYMWESv+WWvKHpsTc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GI+IenHTn2G/gjkvhZjCQgiNRt/ZykNJg/OAhVG66xBr4ljlXCMuAmecK0UTxZ6sjMTAFJWmetvidTvZ9UY769iWxozP+3EqXGkH7sTg9R/NRss43auMrhu1o/DKLFIfUTXT/DumtdXBQi3t3/TZ6yqyWmOZpzTGWBGzRy25RRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 64F28598A0;
	Wed, 12 Nov 2025 15:42:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 3030820014;
	Wed, 12 Nov 2025 15:41:58 +0000 (UTC)
Date: Wed, 12 Nov 2025 10:42:11 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Yongliang Gao <leonylgao@gmail.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Yongliang Gao <leonylgao@tencent.com>,
 Huang Cun <cunhuang@tencent.com>, frankjpliu@tencent.com
Subject: Re: [PATCH] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251112104211.353de586@gandalf.local.home>
In-Reply-To: <CAJxhyqDCFRT_fPWHb67x-PUu+Om91UrbrQEifcF7m+dkZ35dqA@mail.gmail.com>
References: <20251015114952.4014352-1-leonylgao@gmail.com>
	<20251110183854.48b33b50@gandalf.local.home>
	<20251111081314.j8CFfAD6@linutronix.de>
	<20251111102739.2a0a64cf@gandalf.local.home>
	<CAJxhyqDCFRT_fPWHb67x-PUu+Om91UrbrQEifcF7m+dkZ35dqA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: f5hodjosu7kzs6izjjatumcmjqz5f6r9
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 3030820014
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX181HVt/Jt8xNZPVnRShk00n5xvMLvUt8L4=
X-HE-Tag: 1762962118-722198
X-HE-Meta: U2FsdGVkX18an0i7HOroGuJoECsASm+vl42v8JskrQGG4nqeTyt/Ejqax/Uo1nidWrZ37B0KbKZxCRMHhwBCyg6KOfc7cNVGZNKlVgg0/EOk1Ly/q02GL5kic0wcz8DNAKIGLxlMrnOhCwmbZmYGcfbrWDt9fks2omNSf7sUABUqi2BbD284lEOozpJcNArgp6pq4r7kNrkyVfK2erZ2+OljNU9+PCsvpt8rWJNyVT3ZAJMAexyVRu36u+kHkXmKPYPDXlx4/PsCPaCwchEq+3wfLKB4Op8ihBqk7apBJnAKXOWB0w4v4K/PpGd54gF60Sm9M/J0cRhwyGyeSIi7IKZVk3bIfOddUDdl+x+HxnMaf54QJueqzQ==

On Wed, 12 Nov 2025 13:27:10 +0800
Yongliang Gao <leonylgao@gmail.com> wrote:

> Thank you for your detailed response and the proposed RCU-like approach.
> 
> I've looked into using a regular seqlock instead of the current
> implementation, but as you pointed out, the write side is indeed a
> critical path. More importantly, I found that even with seqlock, the
> write_seqlock() function internally uses spin_lock() which on
> PREEMPT_RT gets converted to an mutex. This would cause the same
> issues we're trying to avoid - potential sleep in atomic contexts.

I believe there is a raw_read_seqcount() functionality that is safe for
PREEMPT_RT. Have you looked into using that?

-- Steve
