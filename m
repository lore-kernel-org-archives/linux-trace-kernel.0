Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4393D399013;
	Thu, 12 Mar 2026 15:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773329064; cv=none; b=EO5Wk2LTP7tONdPBzm3A98umGtDad2QbLjg8Qxml2OY5/cbY148BgkHF2eR4l6XJhgghcVNA24SVnUQhYcsRrm4/8A+AAfXHTe+oDlI8iFzO/dHBACo8gkyEoglMM9SKg1gREyMa1/jSY5FM1NNIT+gvk863gohk5avbA2BNJFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773329064; c=relaxed/simple;
	bh=cN0KMaLzaUcJbNNpmje9MQ0FALTu2rXzl0SOp/23i1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/P3q3rlD7Zna1NAvktT6M4VOg6e7gPEDsFkPFW/uLF5ssQHzsdl5Off++bthWUUmHv1df9bUc2u/dlCwLRQLN6OEUXIdsXdv+I2xLMZrwfSqsKIinZjMV/QORbmBTQnru81xuUaW5c0SeEt+sCZyqqtcMexQ5dogyT93qw9xMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVdn0v0z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVdn0v0z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67CCC4CEF7;
	Thu, 12 Mar 2026 15:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773329064;
	bh=cN0KMaLzaUcJbNNpmje9MQ0FALTu2rXzl0SOp/23i1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EVdn0v0z/kVnpPSRvBwBMLT/TyFi4iWnnCtXnS03ygImp276Okr6QIgFmbyh8YUuQ
	 fRl5p6xDUo6dkMDRtf6BVK8HlilV2NbnI5mhT2UPI+dZ1pC8aLr3uZKVgsk4AhQMX4
	 4pt3j/SbVUZkEr1rRXYBOB3MLB02fjh3RjtB1UtM0/bTcKLiyFzo2gZYPsvIvkuiFw
	 jgCKZC4iBR3IhmflZQsPnAc1T/mtScrETJcX496IP7reRdtDUEhAZVcuQroEHZ6MzP
	 fIIg4CN+V43IJcflWBCtidXBNE0bzCZi4utXQMgBG/O0vM35eDTGpPKmKn2a1qukeH
	 PEWbRcdz+grdQ==
Date: Thu, 12 Mar 2026 09:24:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] io_uring: Use trace_invoke_##name() at guarded
 tracepoint call sites
Message-ID: <abLapcC7YGYDyJ3L@kbusch-mbp>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
 <20260312150523.2054552-4-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312150523.2054552-4-vineeth@bitbyteword.org>

On Thu, Mar 12, 2026 at 11:04:58AM -0400, Vineeth Pillai (Google) wrote:
>  	if (trace_io_uring_complete_enabled())
> -		trace_io_uring_complete(req->ctx, req, cqe);
> +		trace_invoke_io_uring_complete(req->ctx, req, cqe);

Curious, this one doesn't follow that pattern of "if (enabed && cond)"
that this cover letter said it was addressing, so why doesn't this call
just drop the 'if' check and go straight to trace_io_uring_complete()? I
followed this usage to commit a0730c738309a06, which says that the
compiler was generating code to move args before checking if the trace
was enabled. That commit was a while ago though, and suggests to remove
the check if that problem is solved. Is it still a problem?
