Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F3361DAB;
	Wed, 29 Apr 2026 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777480760; cv=none; b=gSLYrHJpWM6M8epSNm7Sf0Psz9/mIEIffxDHKrdJOfK/xkv9uVtAnC53smikZfnsAVMazVHrRdMRtpsutCSCID2oqZMjNGpmgUlgrwVA+DpRS2UxfjHJBA24x1BiTWPFYnvqIA1Bez+lhAPM80RZ51M5lNI2ensEaEVs4Zll4uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777480760; c=relaxed/simple;
	bh=LuooT5/c9U9R6Wxb5os317o2rYPmO+PrUlkceOzZqFg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnRl/N7TWwX/+YhOXZqiSeoWxmYBOXfWUs/hFdWE7qUlXCUzAcLnowaFooQZ6YftUCpYRlLJz//lQk3wgXwIoQyZ45YhARvtU8BgyUaOw2ZJjo54fBlgODxqefMiNeVKq2ky5xdaqslFAfslh2AxaGaOX01J9MaXmhdGHPUD0qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4C6988B340;
	Wed, 29 Apr 2026 16:39:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 4AA7520033;
	Wed, 29 Apr 2026 16:39:09 +0000 (UTC)
Date: Wed, 29 Apr 2026 12:39:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 4/8] ring-buffer: Skip invalid sub-buffers when
 rewinding persistent ring buffer
Message-ID: <20260429123926.204893bc@gandalf.local.home>
In-Reply-To: <20260430002023.b19608c27a746284e8f73b80@kernel.org>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
	<177701355481.2223789.8929563537404268817.stgit@mhiramat.tok.corp.google.com>
	<20260428162146.78e52988@gandalf.local.home>
	<20260430002023.b19608c27a746284e8f73b80@kernel.org>
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
X-Rspamd-Queue-Id: 4AA7520033
X-Stat-Signature: iu88zayeg6ne7c8wjgbd3qfdoysmewpm
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18HVNhk5oli4waG8dH1zzmr57zUTbTPRqY=
X-HE-Tag: 1777480749-847527
X-HE-Meta: U2FsdGVkX18e8tf31RS8/ePPO45W5EQbETJbQmuhbtYRO3flXKvGNpFTlfQOxozfw2x0F8o5SZ24KpKDIRsJyDQsgLPPNmM+OMMhUFH/KHPV3R1bOpN1quUmn/WHRsLwVts66aZCHuiaQ4f3/xoG+XQZ54brVKYrmM4Z5N/T7zvsfOE28zjVzFeZ7wWIgImrgmK/7EagSALJ443zlzSUb7E95RnsoNNOdmUpqOOip9zZBmrB0R460zlnCPbxlvAJTPeragkYS3GwWZtIn8sEVhO/sgGChC/+d+yuNw8trgPH8xyIfn4qpZu+KBF7mSFc1VRcSqeVH9SCwhLV+4OlaQj0BhrIdX4EzDwqPunOXvxrJMqrJPM1ZrOLQdudPP1iwc7WBWn6C5IuO0ExIDxWWA==

On Thu, 30 Apr 2026 00:20:23 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Tue, 28 Apr 2026 16:21:46 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Fri, 24 Apr 2026 15:52:35 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> >   
> > > @@ -1892,9 +1895,19 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
> > >  	 * subbuf_size is considered invalid.
> > >  	 */
> > >  	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
> > > -	if (tail > meta->subbuf_size - BUF_PAGE_HDR_SIZE)
> > > -		return -1;
> > > -	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
> > > +	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
> > > +		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
> > > +  
> > 
> > This code seriously needs comments.  
> 
> OK, I'll add it, or let code explain clearer?
> 
> 	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
> 		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
> 	else
> 		ret = -1;

That's better...

> 
> Thanks,
> 

The below should have some explanation too. I can figure it out, but it
wasted more brain cycles than I would have liked ;-)

-- Steve


> >   
> > > +	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
> > > +		local_set(&bpage->entries, 0);
> > > +		local_set(&bpage->page->commit, 0);
> > > +		bpage->page->time_stamp = prev_ts ? prev_ts : next_ts;
> > > +		ret = -1;
> > > +	} else {
> > > +		local_set(&bpage->entries, ret);
> > > +	}
> > > +
> > > +	return ret;
> > >  }
> > >    
> 
> 

