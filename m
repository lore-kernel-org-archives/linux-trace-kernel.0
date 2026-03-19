Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FFC279907;
	Thu, 19 Mar 2026 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773891374; cv=none; b=AuYXIEmJWJJ3BV1nrwMbOnpVImp+gfE9X5xuAYzmR9Um8LkG5Lut4KuDs7EYCY5wFaYHEsRQ6lIONw5fHssQ5fkeSHKL9ZaAXVJxcMP/8DxHfyVW6B9zIgbMJLDJwmg1tKozvCs3mNC3AneaD4vK9P+YdRVgcNC3ar5flHi1rOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773891374; c=relaxed/simple;
	bh=x3F3gu+SYziTD0Kq/Y+8M00QdWvbhDpc5WM3LQ1vpyo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=jxuce6lTDQVIbyVqcr6+ycqe39kkPGvjXHvI1VUzEUxzJClZOubJZJ3r7CjFDgSM77WEHWnsisn8gXZHOYkm129TWE7d0LwhyZ5D7zg5pl18WozaZPoGs+u5gIhke2SLIIoow4oqMfDbQk6iFOZGUVqmtoh0isKGROnf08ukhJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANet/0yj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANet/0yj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC93C19425;
	Thu, 19 Mar 2026 03:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773891374;
	bh=x3F3gu+SYziTD0Kq/Y+8M00QdWvbhDpc5WM3LQ1vpyo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ANet/0yjFhdhLMD896G/LEpk4nZoPw2M2JtB2yFq5PEVlK74E9qHAu+tOgdDAoEjX
	 /ia2jQzyonzj+jOx4yilSfAyzrIcCL0yBsYQxk0r8F3hNPdEmsRRBlDVRIJAgR+brc
	 9DAILUTNxIZCpCIlP9vTmfdrSkLnmEJBc8muw+i9/sh4hLwiJi8FYkNuRs7sVbG7Yz
	 ZroxntgLmhwuLNQORK6u3OjrvZkO/5E327/p5NensE6DLnepTfIOeoLZXzOj39qxG4
	 CzVJafFh/fi480SPk+jz62CVz2e7tjmYdiLlK8KBenrNUkCx/tJafS7seGYF4GczVB
	 82/boah9iR2Yw==
Date: Thu, 19 Mar 2026 12:36:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Ian Rogers <irogers@google.com>
Subject: Re: [PATCH v9 2/4] ring-buffer: Flush and stop persistent ring
 buffer on panic
Message-Id: <20260319123611.5ce2c457354b0b8cd886f9e6@kernel.org>
In-Reply-To: <831523cf-110c-419d-9b22-e54f93a3bdb5@efficios.com>
References: <177319273059.130641.10882692460536780093.stgit@mhiramat.tok.corp.google.com>
	<177319274904.130641.3303707869402603363.stgit@mhiramat.tok.corp.google.com>
	<20260318231959.717f07ec491a731941aee1d9@kernel.org>
	<c91f37bf-97e9-4752-99a9-3d534ce9d2f0@efficios.com>
	<20260319002918.5768a8ee053dd35373e215f2@kernel.org>
	<831523cf-110c-419d-9b22-e54f93a3bdb5@efficios.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 11:51:28 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2026-03-18 11:29, Masami Hiramatsu (Google) wrote:
> >>
> >> - AFAIU, you are not trying to evince cache lines after creation
> >>     of a new virtual mapping (which is the documented intent of
> >>     flush_cache_vmap).
> > 
> > Ah, OK. That's a good point!
> > (anyway I will replace it with do { } while (0) in the next version.)
> > 
> >>     
> >> - AFAIU flush_cache_vmap maps to no-code on arm64 (asm-generic), what am
> >>     I missing ? It makes sense to be a no-op because AFAIR arm64 does not
> >>     have to deal with virtually aliasing caches.
> > 
> > Yeah, so my patch also introduces arm64 specific implementation.
> 
> Just make sure to call this something else than "flush_cache_vmap",
> because you don't want to slow down vmap on arm64 which does not
> require to evince and certainly not write back cache lines after
> creation of a new virtual mapping.

OK, I will just leave it an empty do-while in asm-generic instead of
flush_cache_vmap(). If any architecture finds persistent ring buffer
needs to write back caches, it can add its own flush implementation.

BTW, do we need dmb(osh)? This runs dcache_clean_pop() after atomic
operation in ring_buffer_record_off().

	ring_buffer_record_off(buffer);
	arch_ring_buffer_flush_range(buffer->range_addr_start, buffer->range_addr_end);

Thank you,

> 
> Thanks,
> 
> Mathieu
> 
> -- 
> Mathieu Desnoyers
> EfficiOS Inc.
> https://www.efficios.com


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
