Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979623;
	b=nxLz6W1M8o0cM4dNZcIDHJvg7qFxnzYt6n8vz1XMMEXt3osfEh08LGIBZVt/m0nfOt6c
	 N8NUcxgUzjkoRHIenOE1rsctdzIiXiw+q94oXX6N+Lq+617AvwO2M8jNNjwJezhnawWbD
	 KkLCBfvCIRbEMxHufNZXBWlLSOLJys3N7QETzI3EGuLl3HMVIj++hhMJVxtIUlcdLAzno
	 fNhVppbEOe73HavZHoROg1Jaz/zsceEzneABHvLp6EQat4lVrvf9TCraJ/co9VkewBgp1
	 3J7M4eIQlI2Pms/uPOwTcYw+1rcRqaVec81/EnHSMP6OXEm4TLprNt6iRWrCPLwDnPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979623;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=n0TA3FzCIGpnxlwr6L+aCV/S8fQL4bPUb1PUN1c74K0=;
	b=CtVvXmWqxpxfjXbHq8eGmYCfVq0RLX8+zqLZ7g3Q95RsrDPmurVTdVt4q9cCW0zxPcsf
	 VD1E1c8tCQunZsDFEbMEApJoasNR9D8m5DF4IauaLd2dX5S1t4F2VeqnGBYRN9GRvHc3X
	 xLeogZL/rNMlsJuyU8hpp6EV/jxHcSRLq+NFQ/dvqzRuFGLQpjorcy3Cd7QAqpOs3j8h2
	 cFdP04WF0MyuycXjLV0ygrN6tmTYEWno57fgHQEk4D66vEAz+hyOMMRoGidKd7UbtfC8k
	 Myaxp1VpwvbXUlSsg0ZqPOen2qdLNumrxt+4Y36IGz4Qc4yptzw1d137RMmy3+UclDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTFkJb0E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45979606A31B;
	Mon, 26 Oct 2026 01:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTFkJb0E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60301F01825;
	Mon, 26 Oct 2026 01:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792979622;
	bh=n0TA3FzCIGpnxlwr6L+aCV/S8fQL4bPUb1PUN1c74K0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iTFkJb0EdDmwPa2Ge0eGs87BpHYCrLXuXJpgbueCOHU8mLWftT72ptm4wWphRcke2
	 ahRAtG43pmGVI9XHJ7OoJFLCJekPLit6X8euC/RDZxZRO+2dIdz0RvPkQORgKpX2Y9
	 iQsSRsxSseO4qYM6/wnb7LPEQl0k1Bd4KEtEKOiQ1Dx1hSxg8GfiepiQ8AzVcy4taP
	 wxs/Uwsxh6xQCyeXR98FsQii7cOLtVb30BA7XmL6xaRV+TDpkMcBolO227SgeVZ+i0
	 0+b8dczquB3QMddVaMqYiqsXp00ORUxnTqb3ZJS7SjcAMSs+WSNovubRw+BHCFDGBu
	 dVYdaEIDmIzQw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Free tracer resources on instance creation failure
Date: Mon, 26 Oct 2026 10:53:40 +0900
Message-ID: <undine-1792979620229535425-240da28948f7e6f5@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261025165250.65363-1-pocj8ur4in@gmail.com>
References: <20261025165250.65363-1-pocj8ur4in@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi,

On Mon, 26 Oct 2026 01:52:50 +0900, Baek Kyu, Kim <pocj8ur4in@gmail.com> wrote:
> Creating a tracefs instance can allocate private tracer nodes, copied
> flags and option arrays before trace_array_create_dir() returns. If a
> later allocation fails, trace_array_create_systems() jumps to
> out_free_tr and frees the trace_array without releasing those private
> allocations. The failed instance is never registered, so normal removal
> cannot reclaim them.
> 
> Free the tracer nodes and option arrays when trace_array_create_dir()
> fails, then continue through the existing trace_array cleanup. Earlier
> failures still use out_free_tr because the tracer list is not yet
> initialized there.
> 
> Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>

Please add the appropriate Fixes tag before the Signed-off-by:

Fixes: 428add559b69 ("tracing: Have tracer option be instance specific")

Commit 428add559b69 introduced per-instance private tracer nodes (tr->tracers),
flags, and option arrays, and called __update_tracer() from
trace_array_create_dir(). When trace_array_create_dir() fails, these allocated
resources were leaked because out_free_tr did not release them.

> ---
> Tested under ARM64 QEMU/KVM through tracefs instance mkdir with
> failslab targeting tracer flags, a later tracer node and option-array
> growth. The baseline retained one or four private allocations after
> the failed mkdir; the patched kernel retained none. Normal instance
> option read/write and removal also passed.
> 
>  kernel/trace/trace.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
[...]
> @@ -8761,6 +8761,11 @@ trace_array_create_systems(const char *name, const char *systems,
>  	return tr;
>  
> + out_free_tracers:
> +	free_tracers(tr);
> +	for (int i = 0; i < tr->nr_topts; i++)
> +		kfree(tr->topts[i].topts);
> +	kfree(tr->topts);

Two minor nits:

- Please declare `int i;` at the beginning of trace_array_create_systems()
  rather than inlining it inside `for (int i = 0; ...)`, matching the
  prevailing style in trace.c (e.g. in __remove_instance()).

- The cleanup loop freeing tr->topts[i].topts and tr->topts exactly mirrors
  the logic in __remove_instance(). Consider refactoring this into a small
  helper function, e.g. `free_tracer_options(struct trace_array *tr)`,
  shared by both trace_array_create_systems() and __remove_instance().

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
