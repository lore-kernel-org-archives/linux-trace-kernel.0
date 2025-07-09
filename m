Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B231156F4A;
	Wed,  9 Jul 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752024342; cv=none; b=AquFjjCrC0rtT2C2/6ez6vDbbeYIcYGqGlkZ/6FvME600mPBrMFkEKvGAQjRBxAGTTDXya9/M9KVGNz/gaKgtCMYKnZGZtx3MR0EXiobJwZGMGnsQS5T23bjNL3mfXXFAs9xyZFlx93O3M3kmzYJZvjgEIEC/Inesugfd3sWrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752024342; c=relaxed/simple;
	bh=2Z8M3fuvW0c/WKbK64IvGMnu8ouiQ9cebfL9R75RAqg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bs8hMvXbQYAGXfGBBDN8BeO+hnn3A3/WO2A5vswJKNfPi868jtHhvA+sMeALXnB8TpM9NSZ1SREiq/eblVBmLu2bQz0VvkRXHnK6++XgpbY+OxH/zOT1Z6svssoqHQO8O1MbHot+dq/+zeHYU9/XS/mSwfbD481S3x/S0sTavIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 40DEFB80B0;
	Wed,  9 Jul 2025 01:25:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 7585F20027;
	Wed,  9 Jul 2025 01:25:37 +0000 (UTC)
Date: Tue, 8 Jul 2025 21:25:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
Message-ID: <20250708212539.054a7d5b@batman.local.home>
In-Reply-To: <20250709100626.fc0611eb6801b7a8dad9164f@kernel.org>
References: <20250620085618.4489-1-gpaoloni@redhat.com>
	<20250701195939.3e297e20@gandalf.local.home>
	<20250709100626.fc0611eb6801b7a8dad9164f@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bkgwwze611hifgufiwa7qmn7cp1fgpz8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 7585F20027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ae/VyGYlQB95KTi3CT+28S0FRE4hYcFA=
X-HE-Tag: 1752024337-164833
X-HE-Meta: U2FsdGVkX1+Qxr3aDoEpA5apu9tHKDTHOnfv+8OGyWisUkPFE4jgAqdlck+GWVntEng32w0+19/uw+g1LJ07qHqFdsyntoKrdDu1UHuPcaHnLSdfxcvk/vSDTlGu83eMpeo8ovFHznaNFgBAvHSAOM8i0OZG42lw9k7QaOhywJmtHuMTdh/kn+b9btostioceLWqiNNGJV57gpM1rygXXjtLATR4IYjvkc3Ls7d7OTUkYR3OPQ80SWmXYXAMgNGpnL9gIr9Pjdao9nx8OQWNmWZREniZLSw1/4ZLvtb1JSdR9BRwaeL/Hwj3HN40vczQ8WN/4trpiifMBzyuLfCSH6U4eKpM1zHXMP1s2sodA5Lz7DFnnIWbTBMIaSqrgP+A+5PrBKdHj502XUTcFCJZ3g==

On Wed, 9 Jul 2025 10:06:26 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 1 Jul 2025 19:59:39 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > + * __ftrace_event_enable_disable - enable or disable a trace event
> > > + * @file: trace event file associated with the event.
> > > + * @enable: 0 or 1 respectively to disable/enable the event (any other value is
> > > + * invalid).  
> > 
> > Saying 0 or 1 should assume that those are the only values. Don't need the
> > content in the parenthesis.  
> 
> BTW, it should be "0 or !0"? (or we should make it boolean)
> This description means if it is "2", that is undefined.

Hmm, now here's an interesting point. So this is to define requirements
of a function based on what the function is doing. But does the
function have to have strict requirements?

If it can handle "0" or "!0" does that mean that's how it will be
defined? Or can it just state "0" or "1" and yes "2" is UB. That is,
it's not part of the requirements but if someone passes in 2, it could
act as a 1 as it's UB and implementation defined. Not a requirement.

-- Steve
