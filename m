Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86CCA59;
	Mon,  9 Mar 2026 02:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022747; cv=none; b=ozhQXuuUMCsOTguTpp/hCnU6eUBxdEi2j+1dFmsF4Is9UyXbbJpOezFKJ3UVgQfouLwqlO6Gg1DIgCBFrA6rv0aW3X2rKEvlDikl46grOITpBRO+cDpWX1AP7+FUdfktA1Rz/N0yXTtj6X+YWLb8qVjrVyvHZZtkG4KMHQDFgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022747; c=relaxed/simple;
	bh=JH9xVyqeJwsOvcWB8TpvQScl2dtERznHSOADe3PG56k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dXNDTF9GmF0y6tHqkhq+cRogJkcRFS98qIGCmGonURyypcEeMP4Jru4UaxUkRs4lz7R9/o2FJ1shpoazWpqvNaIv7J0cxe259yAmKUTSePJqC8bOAi/USK/nAinXCzEq6Luzqp0FzKtFuew91g+ntfacy9WO13OKlUlmxuTSGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 83B0A13B870;
	Mon,  9 Mar 2026 02:19:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id C3DDD2003D;
	Mon,  9 Mar 2026 02:19:02 +0000 (UTC)
Date: Sun, 8 Mar 2026 22:19:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260308221901.545e7b8b@robin>
In-Reply-To: <20260309085317.6679cf91151767eff7130cc4@kernel.org>
References: <177289358078.248514.14947007976699929481.stgit@devnote2>
	<177289359843.248514.164858607457269337.stgit@devnote2>
	<20260307102711.50932648@robin>
	<20260309085317.6679cf91151767eff7130cc4@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: c3rrp1gocho7r7y6xpqck5ag3xo58utk
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: C3DDD2003D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX182cuaSJ54s19FP5m7PuIhHMOzjh1eN6HY=
X-HE-Tag: 1773022742-167473
X-HE-Meta: U2FsdGVkX1+GSpVT0bW6XFKyWEvQNtAPJdyApLMZLoI7crcsDXedzrjtkPBv0giEK6Dh8ccFLWWRFugvJUmaS1gVD2FpKBSphMNUQdTkkNKTqGijYiFTCVs4ttX/V5ersLXvIiergEHWzqd17rvOCWSiTffWEzSIGgVVWmc4FezV6HqB+Ic3Ty4gF1IleHQiZiZ54iotKGfjXXV5ItjrAlo8M7oM3smYUrXxpOPak1w6PP8nFnykK30V/roy5YZw5tnnP7b3DpaHkzrY9CFMMJDh8zIF211fAz+qdAuNkLX03kaSmnyrxHtEGqBrHjxblYK+2Cz91bwfKgmoCkITU9YNp8yQ08II

On Mon, 9 Mar 2026 08:53:17 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > @@ -1827,11 +1833,6 @@ static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> > >  			return false;
> > >  		}
> > >  
> > > -		if ((unsigned)local_read(&subbuf->commit) > subbuf_size) {
> > > -			pr_info("Ring buffer boot meta [%d] buffer invalid commit\n", cpu);
> > > -			return false;
> > > -		}  
> > 
> > This should still be checked, although it doesn't need to fail the loop
> > but instead continue to the next buffer.  
> 
> We already have another check of the data in the loop in
> rb_meta_validate_events() so data corruption should be
> handled there.

Hmm, OK.

> 
> > 
> > Also, I mentioned that if the commit == RB_MISSED_EVENTS, then we know
> > the sub buffer was corrupted and should be skipped.  
> 
> Yes, if RB_MISSED_EVENTS bit is set, the commit field is out of range.
> That is checked in rb_validate_buffer().
> 
> > 
> > And honestly, the commit should never be greater than the subbuf_size,
> > even if corrupted. As we are only worried about corruption due to cache
> > not writing out. That should not corrupt the commit size (now we can
> > ignore the flags and use page size instead).  
> 
> Hmm, but if the kernel crash and reboot when it sets RB_MISSED_EVENTS,
> we will see the bit is set and commit size is different. 

The RB_MISSED_EVENTS is only set on the reader page.

If the kernel crashes no boot up while reading the validated buffer,
then that's a bit more than what this is supposed to handle.

> 
> Note, I think the reader_page RB_MISSED_EVENTS flag is not cleared after
> read. commit ca296d32ece3 ("tracing: ring_buffer: Rewind persistent
> ring buffer on reboot") drops clearing commit field for unwinding the
> buffer.

But that should be fine, as it's only read only. Once tracing is
started, it should be reset.

-- Steve
