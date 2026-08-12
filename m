Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C868356A37;
	Wed, 12 Aug 2026 13:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786542658; cv=none; b=JNWTP1PHlZsC2UPqpW/dEsnMzjR+d9ZD67YbBhJAktVvwmCMEKxzHrJYROznWTvbACLlnwPi7KU7Sj0O0h88lr3kj5dKwcsjxsoHyzlti8S6QM40ODeWiPhJHIiRnQEm4A+G1Xc9g+0EbLg+YxSSk8uAAwHZkWvG7R+yjDOhnH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786542658; c=relaxed/simple;
	bh=M1qhVYA36Uv5lcNYDYO4xqqSGlN6e51AlM4xoxnJvew=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CG3ywCWQQRdJ30cG+Jay9GZZY8kLDJrmwA7SfGFoJ5fVxIYLShYOBjG/dml5Wzk9YK9/ad5aRRKconp8y0CqsVgy59ZFZXIheiGq4XfHNLltxrMKojTwnRiurCUtit1r6geC4pDz0bE+MYtgXMobdyCZyjJUf7z3qylbriB4lFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 8407EC015A;
	Wed, 12 Aug 2026 13:50:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id B855F17;
	Wed, 12 Aug 2026 13:50:52 +0000 (UTC)
Date: Wed, 12 Aug 2026 09:51:06 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5] tracing: Fix race between update_event_fields and,
 event_define_fields
Message-ID: <20260812095106.6b2e76df@gandalf.local.home>
In-Reply-To: <f7b0e5a6-c38d-634e-4353-6d1bb5dcd12e@allwinnertech.com>
References: <2e5730d2-c631-da41-3a3a-ae35bb4895f3@allwinnertech.com>
	<20260810104525.6a3a2e6c@gandalf.local.home>
	<3f27bacf-5f01-8cb5-a04c-824ca7b2c13f@allwinnertech.com>
	<20260811090045.2a3cbed9@gandalf.local.home>
	<f7b0e5a6-c38d-634e-4353-6d1bb5dcd12e@allwinnertech.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: B855F17
X-Stat-Signature: bosoajoosq4woka3a7p57cimmqaofztd
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/hUtLLlMXjwBzUEQZ6Vaj8jo7isCPh2W0=
X-HE-Tag: 1786542652-341870
X-HE-Meta: U2FsdGVkX1+SGOdG+5V8Hmxe8k4ZmINEZB75l6rLsLVj6UbBc6Tvh+iuH3URtgVv2vbAoo571Noa/k4QcPo39HI3mnq2QPvCiiV69hR7qtW3TpZJ9mqgMZei2rovhJaAwsnAbr5Hp0HMIMF7fUbYU6dw1PzUFoX0VTupzqJQ1yU8MBpnchQSOMNVR8HItZfnm9NWqubW3zSoy6MbHjBloqxYam8cUI4XpcDnuI8rAw2I9z27N6tNe4fF1sVHKdHBf90uObEP9AZvipia9rfIhDw9PuR8Hir1m9bbwqmtLuVB+EByMn+3Xmy3o776WFJJF5ugXt4Lpc8WXu02JTte+BIdy7HNqXpTWClZlQOTAS8oSAGZuhfgZTYJBn6jzkZ0

On Wed, 12 Aug 2026 10:14:24 +0800
Michael Wu <michael@allwinnertech.com> wrote:

> On 8/11/2026 9:00 PM, Steven Rostedt wrote:
> > This is still way too verbose. Is this AI written? If so, AI is *not* your friend.  

> This commit was written by me, not by AI. I apologize for wasting your time. Thank you for rewriting the change.

Heh, AI tends to be very verbose, which is why I was thinking it was AI.

> > Why are the priorities of the notifiers important here?  

> I probably wanted to describe the entire process, so I've gone on to say too much.

Yeah, adding more than what is needed distracts from the issue.

> > Less is more when it comes to describing a bug.  

> Got it.

Great. And thanks for the fix.

-- Steve
