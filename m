Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2503D348895;
	Mon,  9 Mar 2026 13:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773064396; cv=none; b=R5JqK0LSEi1clLLHyPKnxHoDAwEXGeJ0TckKyhPzsZ89ZynofbGuazFnjkf6naS8Pulmdpo8XJa7DdLW5VInc2QTBbVEWh/dgjIud+ZmVXpg4mQpPBCBjPmKBoRBIUkHX/KmMS96UDpWdsl6cj7aL75jn+Y8Ha+T29qfBrYlpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773064396; c=relaxed/simple;
	bh=LxBBGtV8QwyUaJcnWJDnZOYpss/VKsaoWn6L8j22FrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HWJsDsnkSiEd2aXd15GLaNz3PstpJM+fp5Gl2jYgyJ1iCPNU5eqJ6xs5ouvOZnn97kWW+/K6HsU6j2dUTflefmhu/O+8uOuwtRNEt05bfvvyHEurf1CG38ynw9nXZLcETFg6P2Y/rguP22WYLgjAiuDc8FRb+kWQefxu5a1zp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 2CE08136F48;
	Mon,  9 Mar 2026 13:53:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 7728260013;
	Mon,  9 Mar 2026 13:53:06 +0000 (UTC)
Date: Mon, 9 Mar 2026 09:53:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260309095313.340a15e0@gandalf.local.home>
In-Reply-To: <20260309223244.3be47d8abbb91b87680da2a3@kernel.org>
References: <177289358078.248514.14947007976699929481.stgit@devnote2>
	<177289359843.248514.164858607457269337.stgit@devnote2>
	<20260307102711.50932648@robin>
	<20260309085317.6679cf91151767eff7130cc4@kernel.org>
	<20260308221901.545e7b8b@robin>
	<20260309223244.3be47d8abbb91b87680da2a3@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: r91yfqhizz38m85pymgjkm9kp6e6ymik
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 7728260013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Du6XPTi/O2JY3IPcckwIvOAMdxhGJgog=
X-HE-Tag: 1773064386-466388
X-HE-Meta: U2FsdGVkX1+ipNSsfyB9boEBRvJyjsRF6T8OePJL30eu1/GSXdJqjG5VoJGOr/cnbYpjjsS6HDgOShRlcPbT8g9ySOoyT64LKkXN+KfRWAY49tPkz5+swWZDq6oef8Gcsf73+NyYu9Utam2tnN1tqTgGSWHwwpxv1heFOJ1stqlTHAVzZgexPF9rPgiMPzNn7dTwvZNOKQM3a6IoVDQv6Pc3ysdLM99aUTeodUCSs76D3AZHnlVWX49X/xPRPGisf7i1+BQdqLhHiHfHNHWWzuOlKP+1OZYtlVJfK8wk9aToXQz717e4i6SJBRv+ruloQHTIFH3gQ9ynms4+iegx/1G2PLeK6gri

On Mon, 9 Mar 2026 22:32:44 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > Hmm, but if the kernel crash and reboot when it sets RB_MISSED_EVENTS,
> > > we will see the bit is set and commit size is different.   
> > 
> > The RB_MISSED_EVENTS is only set on the reader page.  
> 
> When is it reset after read? I think I removed that with commit ca296d32ece3 ("tracing: ring_buffer: Rewind persistent ring buffer on reboot"). So the
> flags will be remains until the page is reused (as a writer page).

And that shouldn't be a problem.

> 
> > 
> > If the kernel crashes no boot up while reading the validated buffer,
> > then that's a bit more than what this is supposed to handle.  
> 
> But the above commit recovers the subbufs which has been read in the
> previous boot. This means commit field of those recovered subbufs
> can have those flags.

Yes, and since those flags are only set by the validator, if the validator
sees them set, it should skip processing the subbuffer. It knows it was
already flagged as corrupt.

> 
> >   
> > > 
> > > Note, I think the reader_page RB_MISSED_EVENTS flag is not cleared after
> > > read. commit ca296d32ece3 ("tracing: ring_buffer: Rewind persistent
> > > ring buffer on reboot") drops clearing commit field for unwinding the
> > > buffer.  
> > 
> > But that should be fine, as it's only read only. Once tracing is
> > started, it should be reset.  
> 
> IIUC, RB_MISSED_* flags are using 30 and 31 th bits and committed
> bytes counter is usually use 0-11 th bits. So other bits should be
> cleared. 
> 
> So, if "commit & RB_MISSED_MASK" is under the subbuf_size, this
> subbuf looks OK for checking its entries(timestamp data).
> e.g.

But it shouldn't be.  The only way the RB_MISSED flag gets set in the
writer portion is if on a previous boot the validator detected that the
subbuffer was corrupted. If they are set for any other reason, the
subbuffer should be considered corrupted anyway.

-- Steve
