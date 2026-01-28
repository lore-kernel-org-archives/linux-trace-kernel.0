Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02A932AAC3;
	Wed, 28 Jan 2026 07:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769586862; cv=none; b=nVgqdRsI8o54LDOGAoIL6d/rGfDBnEc3oWYBI972KXMkR4AaOol31zBw72/mY8SZiSMpqPi1IeVwh+mlhn/Mv14UDNT/qNYoK7D8LShTFnmphKiZnpxBJLljOqtdc54iYcqufwpPT9bekcQLmPv9W00M7nL95A7lo12NvjLE/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769586862; c=relaxed/simple;
	bh=IujXjlFYPtO5Fcpcs/5bjnRjCLHtedyWn/hOHHE/Txk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JsX1qkwr95BV90U7d3VvjRZzniHSAzChoIlkkMcUUrSP/z3+njn7mLhT9D9krrGqp92G+OmUQ6Ep++CcLda4udIa63bTW4fkpXqtJD9lCF/RGjO8CXccXqxC+UlTz97K7QYhTyYzaOqhfPGpSGfog1bDcm3Ks3mK169rB13sOxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjC6NRR2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjC6NRR2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEDFC16AAE;
	Wed, 28 Jan 2026 07:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769586862;
	bh=IujXjlFYPtO5Fcpcs/5bjnRjCLHtedyWn/hOHHE/Txk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cjC6NRR2ozGiltsbUgWpDYXDjb2A8M2ginIN0k0HiqRrGi59X8zsEINCFaI/P0VUA
	 8MyqLxZ9Di2PBDDvTp3FNIS2e2eu4inyDQl0/Ja1LJW8NfSShov3x/zoNmucauGFJY
	 60M2XNrj8sWTd1pzlaljB1wGsTnx8O00Pns8ddh7wSBFQ0bzzVfclLQpEU6ug/PRQ9
	 NGXyc2KnK9kVTUHYZtOqP4I9evLrdBtdTAfORst3pxpxkJ2pDUN3WpjWfFMNSu8Jpj
	 3G9vO8fZ/A3COEqmXFSXt1FB4gs74jC09B5Xfs5cNu2TyWj+DZOCFcIXV5G/wSUWpw
	 7dT2qQN1peQuQ==
Date: Wed, 28 Jan 2026 16:54:20 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: trace_mmap.h: fix a kernel-doc warning
Message-Id: <20260128165420.acf6a36f36382c218e9933fd@kernel.org>
In-Reply-To: <20260128062522.403456-1-rdunlap@infradead.org>
References: <20260128062522.403456-1-rdunlap@infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 22:25:22 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> Add a description of struct reader to resolve a kernel-doc warning:
> 
> Warning: include/uapi/linux/trace_mmap.h:43 struct member 'reader' not described in 'trace_buffer_meta'
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: linux-trace-kernel@vger.kernel.org
> 
>  include/uapi/linux/trace_mmap.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- linux-next-20260126.orig/include/uapi/linux/trace_mmap.h
> +++ linux-next-20260126/include/uapi/linux/trace_mmap.h
> @@ -13,6 +13,7 @@
>   * @reader.lost_events:	Number of events lost at the time of the reader swap.
>   * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
>   * @reader.read:	Number of bytes read on the reader subbuf.
> + * @reader:		The reader composite info structure
>   * @flags:		Placeholder for now, 0 until new features are supported.
>   * @entries:		Number of entries in the ring-buffer.
>   * @overrun:		Number of entries lost in the ring-buffer.
Masami Hiramatsu (Google) <mhiramat@kernel.org>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
