Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1539FCCC;
	Tue,  1 Sep 2026 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788291299; cv=none; b=J08908gyXMcvqS8reJpsXvaDfboGVqTLAIHT4imDXsac6TKpKnisfhR+H+dGNXxOvvbIHrGxGm39OABccjy5LyxC/DAHHGqDY1T3CN3O5uvoMx+YnJJ3oWletSAn2KD/NhiOuDqmOwvLUkibm9EHmyoOM65B7GsU5/CsIjAZf6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788291299; c=relaxed/simple;
	bh=QAf0GlGjO+drU64tznY2XHbRaK0JD3BTTwclzdpdpJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HrCAhPJGyOxx5FtmQizFu11YWcQcPOWDxOU4J2XZN1tY9KAHh/SyQyn4jXanoLEdt4Fi/LSBcaostHlSjlpxYdxtDlvZUX1l9pTWumfDcepI3WnaJYK0/oHwymT6dW9vAgSwF7Mkl0FcmBR7zfmSAWSXH0qIb6O0zn1E9hn3XJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=vaXEbfqb; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="vaXEbfqb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Pc5tgHIncMdwoX60lN+HQ2I/H4CUjfUuWcqA+FwveKw=; b=vaXEbfqb+UYBIKdKCkzOxy6UBh
	aU/SInLPX71p4qILClopOYPE6dszyIZwKD5znWw4PxeqGX+U42XZWKfm79iCVaAaqWCIEqrNZJvU8
	nVQjQ2apcibYuRsKDfflncrFU4RM/377T2kZRNSUuYxA1HYZg/v53Bveu3ZVqFpRa24BSUEgylrq+
	zFxZiC1FvzZle9XD3dnwD0kV+jWvmrhRrrraD0XtiBt22mRt7wr6WlBdIiLI7yvJrYlncp9Y6w9/b
	VUFXg1Uwu34SpAhBp9Js26cVuQbdORHb/04ZnVa8N3GuwVaLDbmqGLcNgdSYGb4Rkf2bUXllgK7pf
	FNGAJo4Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x1UFq-002WwB-0d;
	Tue, 01 Sep 2026 19:34:46 +0000
Date: Tue, 1 Sep 2026 12:34:41 -0700
From: Breno Leitao <leitao@debian.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2] ftrace: Take trace_array reference before accessing
 its ftrace_ops
Message-ID: <apcorAs7MwGiq1AC@gmail.com>
References: <20260828223901.29e26edb@robin>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828223901.29e26edb@robin>
X-Debian-User: leitao

On Fri, Aug 28, 2026 at 10:39:01PM -0400, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The trace instance files set_ftrace_filter and set_ftrace_notrace was
> updated to work with specific trace instances (trace_arrays). The issue is
> that when these files are opened, there is a small race window where it
> will use the ftrace_ops from the inode->private pointer to get a reference
> to the trace_array and then take its reference. The problem is that the
> ftrace_ops itself could be freed. If the rmdir on the instance happens at
> the same time the set_ftrace_filter file is opened, the rmdir could have
> also freed the ftrace_ops and referencing it will cause a use-after-free
> bug and crash the kernel.
> 
> Instead, pass in the trace_array as the file private data (NULL for the
> top level instance), and then pass both the trace_array and the ftrace_ops
> to the ftrace_regex_open() function. If the trace_array is NULL, then it
> just uses the ftrace_ops without the need to take its reference (like
> normal). If the ftrace_ops is NULL, that is only the case for the top
> level instance and the global_ops can be used.
> 
> This allows the trace_array to have its reference incremented before
> touching the ftrace_ops that could also be freed when the instance is.
> 
> Cc: stable@vger.kernel.org
> Fixes: 591dffdade9f0 ("ftrace: Allow for function tracing instance to filter functions")
> Reported-by: Breno Leitao <leitao@debian.org>
> Closes: https://lore.kernel.org/all/apGORjltZgAiAYHT@gmail.com/
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Tested-by: Breno Leitao <leitao@debian.org>

Thanks Steven for the quick fix,
--breno
