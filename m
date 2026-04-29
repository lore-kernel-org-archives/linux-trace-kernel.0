Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788C03783AC;
	Wed, 29 Apr 2026 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476026; cv=none; b=lzfNfYoj37AVdZql6RX7XyW0KmGoQk+zq3weFd+9Mchc2mSGv9ScKM7aG2hWRLbJCEtox+dv7I6DpdNcwsWKKFM2F/b9xz0CrqjXJgdfZX+/OUTIfeTO0wj/fXRxNQ2mCwxwbcOwnyOtAoXvy8F8jyNPdY1Cz5Q1hxlKVBBnPTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476026; c=relaxed/simple;
	bh=iRtJTYnWWpEWI9sc96kjWYUWN9eoqli1GDs2kMFzcbc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eDB1esrG6Bs+GcRuxmcf6qe/Fv0h8BDG/Q2o/iUhJphjiu788ms+XLsC68oUTKb2RFhjyB6sI7n9xduk7I5yKkMNJiD3j6ivkmcvHWFNiahVraLJnIpA9RenuviGo5+2BjFoDTGhbAvdfqTOrzDkYtlmZIkrLS0epdDg5nyxSoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgAD3s71; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgAD3s71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E936EC19425;
	Wed, 29 Apr 2026 15:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777476026;
	bh=iRtJTYnWWpEWI9sc96kjWYUWN9eoqli1GDs2kMFzcbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rgAD3s71Iddnt7NVEUWoeX/uhntmqnmf4ij+Qu3t33coW2DmX02hlUzxvH6DyJv10
	 EzYK42UFDXvu2e7D3zctYWpNYESrwLhCu8taPjw0ME6bZRwWr+shtPqYms2PvOqCQd
	 HeNbWUyxoSQVbuvUSZl7uK0zRAAC0dNJzcijN75qkBhMVY9SIUOWZOVCe31lbc4oSe
	 bNBj8eTuWwsyw7JHPxCwzZyRkMeHVmkSjcwtNEHMuL53hhha2Mlgaw1WliJs9C/k1H
	 iohsJ2NUQFLoKRhMRJu5MEYSa0PWfScpwYNiY6N70DfzdrHEMKQDhUnuZTa4dDJdN1
	 io0+WuMwNWKIA==
Date: Thu, 30 Apr 2026 00:20:23 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 4/8] ring-buffer: Skip invalid sub-buffers when
 rewinding persistent ring buffer
Message-Id: <20260430002023.b19608c27a746284e8f73b80@kernel.org>
In-Reply-To: <20260428162146.78e52988@gandalf.local.home>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
	<177701355481.2223789.8929563537404268817.stgit@mhiramat.tok.corp.google.com>
	<20260428162146.78e52988@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 16:21:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Apr 2026 15:52:35 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -1892,9 +1895,19 @@ static int rb_validate_buffer(struct buffer_data_page *dpage, int cpu,
> >  	 * subbuf_size is considered invalid.
> >  	 */
> >  	tail = local_read(&dpage->commit) & ~RB_MISSED_MASK;
> > -	if (tail > meta->subbuf_size - BUF_PAGE_HDR_SIZE)
> > -		return -1;
> > -	return rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
> > +	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
> > +		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
> > +
> 
> This code seriously needs comments.

OK, I'll add it, or let code explain clearer?

	if (tail <= meta->subbuf_size - BUF_PAGE_HDR_SIZE)
		ret = rb_read_data_buffer(dpage, tail, cpu, &ts, &delta);
	else
		ret = -1;

Thanks,

> 
> -- Steve
> 
> > +	if (ret < 0 || (prev_ts && prev_ts > ts) || (next_ts && ts > next_ts)) {
> > +		local_set(&bpage->entries, 0);
> > +		local_set(&bpage->page->commit, 0);
> > +		bpage->page->time_stamp = prev_ts ? prev_ts : next_ts;
> > +		ret = -1;
> > +	} else {
> > +		local_set(&bpage->entries, ret);
> > +	}
> > +
> > +	return ret;
> >  }
> >  


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
