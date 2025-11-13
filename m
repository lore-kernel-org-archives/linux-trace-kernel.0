Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04AD62FCC04;
	Thu, 13 Nov 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763048110; cv=none; b=NsVOBYGnkE0IGPfYAGFcoHseaG1Bn7q2qzf0n8L9qgc38ElSqsDTpk6dNtum8zx3h7UyznvPcVHkVcUKDCMSM1NsT9Qq/3R4uRzRDNP5GKiJVdbiAOn6K818gROCtNRj1fWiI4cLPbv/p6zZG/OX+06m9WlMadSjEWkNkU2muJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763048110; c=relaxed/simple;
	bh=sGsUrBxKaUcMUEDWs3RWnDG9pcyCi3/cWvE3uyosF8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSHIYASjNrpFNwYVfxNOjmHeRjf3FU01+dSaU9s49s4VpUg5zq0xs+7jhP6pWPtGiA9OtJlk/4AdIoz5xIaxraEpZQM7YnDjTkx3Vvd+09fifgYoVz/7alQas9aZAReJePmH9n+OiTv3QEZyn1epwEWq4fv2iVyM/56YNS6du/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 7203112E880;
	Thu, 13 Nov 2025 15:34:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 3496642;
	Thu, 13 Nov 2025 15:34:57 +0000 (UTC)
Date: Thu, 13 Nov 2025 10:35:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Yongliang Gao <leonylgao@gmail.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, frankjpliu@tencent.com, Yongliang Gao
 <leonylgao@tencent.com>, Huang Cun <cunhuang@tencent.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
Message-ID: <20251113103512.18e7bb03@gandalf.local.home>
In-Reply-To: <20251113073420.yko6jYcI@linutronix.de>
References: <20251113000252.1058144-1-leonylgao@gmail.com>
	<20251113073420.yko6jYcI@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3496642
X-Stat-Signature: wp6ewwb7ig78q5mk1hftxuoh7afw3mxr
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+RRL0pBoBitY5GJUxNSksZFm0Ijjh4dTc=
X-HE-Tag: 1763048097-196843
X-HE-Meta: U2FsdGVkX18eSdJGVsNqxmespPieagfFW34r1f3N+aZ8swXRuH8jdnT5UhL4CMPd/vNPlPL6YVv5kBXvPAhsZsSQa2bqmzgyV/bFmG0+7+aaONXEJl3UdBZgyIt9LbiupluNf6VpC2S65Hgj6PhdCPLGSp4K4PctDRvnOnGp0S8GzhBSRlL9l7hUcQXhe+l97EIX578g8mEoYv/qNtiudPLHCZ2Gm8CqwQe99nYEBVC2dInp2jFRgaIebUx4FNdiW9aKUh+Kz+/sw9T6Eig5s2Nehkf3L+VcbYZaYkQMccWVG7dFzE+HiOFBUikxvKgd

On Thu, 13 Nov 2025 08:34:20 +0100
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > +	do {
> > +		seq = read_seqcount_begin(&pid_list->seqcount);
> > +		ret = false;
> > +		upper_chunk = pid_list->upper[upper1];
> > +		if (upper_chunk) {
> > +			lower_chunk = upper_chunk->data[upper2];
> > +			if (lower_chunk)
> > +				ret = test_bit(lower, lower_chunk->data);
> > +		}
> > +	} while (read_seqcount_retry(&pid_list->seqcount, seq));  
> 
> How is this better? Any numbers?
> If the write side is busy and the lock is handed over from one CPU to
> another then it is possible that the reader spins here and does several
> loops, right?

I think the chances of that is very slim. The writes are at fork and exit
and manually writing to one of the set_*_pid files.

The readers are at every sched_switch. Currently we just use
raw_spin_locks. But that forces a serialization of every sched_switch!
Which on big machines could cause a huge latency.

This approach allows multiple sched_switches to happen at the same time.


> And in this case, how accurate would it be? I mean the result could
> change right after the sequence here is completed because the write side
> got active again. How bad would it be if there would be no locking and
> RCU ensures that the chunks (and data) don't disappear while looking at
> it?

As I mentioned the use case for this, it is very accurate. That's because
the writers are updating the pid bits for themselves. If you are checking
for pid 123, that means task 123 is about to run. If bit 123 is being added
or removed, it would only be done by task 123 or its parent.

The exception to this rule is if a user manually adds or removes a pid from
the set_*_pid file. But that has other races that we don't really care
about. It's known that the update made there may take some milliseconds to
update.

-- Steve
