Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7E52F659C;
	Mon, 24 Nov 2025 21:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020910; cv=none; b=Ki5AEjsTcyj/yHJOCoRZdECeIeEQbFtud6u1/66HYRw4qoefJg4AWoxniR0Cv1n2y0r1Dq0mLPVlZuCwTPh+FjOzTLusUFlCmOCG9T+YZOk8jM8op4jtedB8Fz8kcNfQz94QNC7/bPBqFHMB5irK+JfvBfjtsI+/I6TMpEfkUzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020910; c=relaxed/simple;
	bh=Z/sD2dNaWC4UKQT+U55zKbzRudVZCZXaR7o3Os92w/0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaHgKC4jVogcBZUcrF9jBJkf3VfVh0+n/MnIPFdcXpUwLymRi8SBQQbqnLKEgLmOluOU4PK6Y6evNJjfK1K2JLeFrCSAFRCTCoBDmLMEbFv4Sv7rtPMdP+xjRpcbKmlPHohqFwiSPaIxpgb0QSV6BlGnnTIizucsGyoo5EJgVHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 826D4594FE;
	Mon, 24 Nov 2025 21:48:25 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id A5BCA60009;
	Mon, 24 Nov 2025 21:48:23 +0000 (UTC)
Date: Mon, 24 Nov 2025 16:49:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Donglin Peng <pengdonglin@xiaomi.com>, Sven Schnelle <svens@linux.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v7] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
Message-ID: <20251124164905.55cd25bb@gandalf.local.home>
In-Reply-To: <20251124164701.1216a073@gandalf.local.home>
References: <20251114025522.2115359-1-dolinux.peng@gmail.com>
	<20251124164701.1216a073@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 958tpufmrypbg8mrrs331t6qngec75sk
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: A5BCA60009
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19HGYXEFB7t0QNJ5BZrS0GQP1zkXpf8roQ=
X-HE-Tag: 1764020903-516963
X-HE-Meta: U2FsdGVkX1/w++v4GJ1/9SqyxPLdNy9tJboniJG8rlkuFMQpc+voOoQVtRQ/2GyGSOZSWHYsE4O/fM3o/mCS85GJK7yXg+CMzKPGugzXr6UZIfTjoMPrTwZtBZJJCRbuUJ0f6lPHNAQYwp7QuF+fZPUVWutBIR4cUbSmw3/N7BlLqj5BuJvSNRfd62zkg+y0yMor2sh6/w5sgMm8x6bAvKK1jf0/D+dAjgrZ+Jjr7EzMBD765rQMQQqudxA70bGRZS4OUWoZn3+OGuT3Ggr2JEnmAhA1OnTBUIQMCTS0VVZ4B/JD672J2hWtkvm8lvvoE/Z8FQnTaZn8LdToxtxes4h6ly/DuGkOcmDZP+BiI0YimjCENasjHjYIgDmv5RBMC9moBJGzz7kvpGYExorcoKR2dgbZ3Tj+WBkWAOqLrF8=

On Mon, 24 Nov 2025 16:47:01 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 14 Nov 2025 10:55:22 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
> 
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -95,14 +95,14 @@ FTRACE_ENTRY_PACKED(fgraph_retaddr_entry, fgraph_retaddr_ent_entry,
> >  	TRACE_GRAPH_RETADDR_ENT,
> >  
> >  	F_STRUCT(
> > -		__field_struct(	struct fgraph_retaddr_ent,	graph_ent	)
> > +		__field_struct(	struct ftrace_graph_ent,	graph_ent	)
> >  		__field_packed(	unsigned long,	graph_ent,	func		)
> >  		__field_packed(	unsigned int,	graph_ent,	depth		)
> > -		__field_packed(	unsigned long,	graph_ent,	retaddr		)  
> 
> You can't delete the retaddr without breaking user space.
> 
> Please keep that here.
> 

Also, please rebase on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git  trace/for-next


Thanks!

-- Steve
