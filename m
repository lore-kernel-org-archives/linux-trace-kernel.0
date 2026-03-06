Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1FA364936;
	Fri,  6 Mar 2026 14:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809184; cv=none; b=pJSd0LzPtawkYExuy3DPDKUkeOA4r1azXtaEZFHuhfjhB6s/01Th5NE4n/eCdVba9FSqy2Nrrm8ZfNn04FFvIvr2O4fVTXz4l6L4MmARIGPjEWBGClY49Z2kg/2NhaLOm1KhRwHdtyoi1MfMFQl2XTXtrr9Y9ThN0kBuKHV51Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809184; c=relaxed/simple;
	bh=XcB6rYuDR+ONszCxzHlLMBEXqz5B6dP7DS+uOKjsZkk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y19B+GVZHDQMJssqPzXCfCJV27OruD3DWANBPVAqcFE7G3KwUjaBlHkx64F8aDNg41MP+08ENge8NJ6AhcAWGOAToFQksW8ZLYxPKp6CCOds5I0hkBtl/xFCyf9+bm1lxbNXpMKsdRxb9Is++6bT3Uyn2yuUkOl6U85YdnMR498=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 49AD0BA18B;
	Fri,  6 Mar 2026 14:59:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 8E90020024;
	Fri,  6 Mar 2026 14:59:34 +0000 (UTC)
Date: Fri, 6 Mar 2026 09:59:35 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] ring-buffer: Handle RB_MISSED_* flags on commit
 field correctly
Message-ID: <20260306095935.5d155964@gandalf.local.home>
In-Reply-To: <20260306174609.d387b67d04e05328ea262fba@kernel.org>
References: <177211310553.419230.7846100548994399256.stgit@mhiramat.tok.corp.google.com>
	<177211312362.419230.15156461178245984273.stgit@mhiramat.tok.corp.google.com>
	<20260305130348.3266e4c9@gandalf.local.home>
	<20260306174609.d387b67d04e05328ea262fba@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: nm6165c83bogod4uojtsgjb4uset7n1s
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8E90020024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18gJ2roy9LWtd81D5tcX559Ex3xvMIfhSg=
X-HE-Tag: 1772809174-3994
X-HE-Meta: U2FsdGVkX18qti8jd/9766Z68AH4LLfjFNmlGAvJRrPg3zvCP9TvbNAWr4iCdG6gS7FfOUleassxMsUmuWJZkZzuX0b9LXFBL3Kk87iMm+JDUbQ84EF6/rbc/mnJ0rSDPEoDFDmGNs7WCjQJ2sCzWp32VnNtwWbMoGaoGudDB7PfR7o7vDcKJacoztclXpwuPqUbCN5kHJqBY/EIYpWoWRpCJNQxwAfzfmn5f97Jdy8t6uJTVzIxr/+//LfuZbG09Up85WO3x51yumAZRZ3AQDMwp7o/ObZmpRZNGUBNsxBQ4pMjt1RWoBllfB2NTu+ErGp1YPcUkJNJ1egjXUJx0KsSo4KWsHu7IYg+wm6NNT9iOjBbkoRphRVU2unfejuV16Pb+4ODLOFh7YNlHODPpA==

On Fri, 6 Mar 2026 17:46:09 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Thu, 5 Mar 2026 13:03:48 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Thu, 26 Feb 2026 22:38:43 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >   
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Since the MSBs of rb_data_page::commit are used for storing
> > > RB_MISSED_EVENTS and RB_MISSED_STORED, we need to mask out those bits
> > > when it is used for finding the size of data pages.
> > > 
> > > Fixes: 5f3b6e839f3c ("ring-buffer: Validate boot range memory events")
> > > Fixes: 5b7be9c709e1 ("ring-buffer: Add test to validate the time stamp deltas")
> > > Cc: stable@vger.kernel.org  
> > 
> > This is unneeded for the current way things work.
> > 
> > The missed events flags are added when a page is read, so the commits in
> > the write buffer should never have those flags set. If they did, the ring
> > buffer code itself would break.  
> 
> Hmm, but commit ca296d32ece3 ("tracing: ring_buffer: Rewind persistent 
> ring buffer on reboot") may change it. Maybe we should treat it while
> unwinding it?

Might change what?

> 
> > 
> > But as patch 3 is adding a flag, you should likely merge this and patch 3
> > together, as the only way that flag would get set is if the validator set
> > it on a previous boot. And then this would be needed for subsequent boots
> > that did not reset the buffer.  
> 
> It is OK to combine these 2 patches. But my question is that when the flag
> must be checked and when it must be ignored. Since the flags are encoded
> to commit, if that is used for limiting or indexing inside the page,
> we must mask the flag or check the max size to avoid accessing outside of
> the subpage.
> 
> > 
> > Hmm, I don't think we even need to do that! Because if it is set, it would
> > simply warn again that a page is invalid, and I think we *want* that! As it
> > would preserve that pages were invalid and not be cleared with a simple
> > reboot.  
> 
> OK, then I don't mark it, but just invalidate the subpage.

No, I mean you can mark it, but then just have the validator skip it.
Something like:

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 156ed19fb569..c98ab86cf384 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1950,6 +1951,10 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
 	rb_dec_page(&head_page);
 	for (i = 0; i < meta->nr_subbufs + 1; i++, rb_dec_page(&head_page)) {
 
+		/* Skip if this buffer was flagged as bad before */
+		if (local_read(&head_page->page->commit) ==  RB_MISSED_EVENTS)
+			continue;
+
 		/* Rewind until tail (writer) page. */
 		if (head_page == cpu_buffer->tail_page)
 			break;
