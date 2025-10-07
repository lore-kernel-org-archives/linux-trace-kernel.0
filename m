Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7262DDDD2
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759806764; cv=none; b=srE5Pw3+ruadkpWZE8FH63t3wHMPdbPhONHIiWpBhIp7e/ALRowmk8nZHlgR6wQ8GmIzvZmAaUUzZgIz4AwRu9wTGuHfwzswHYf17Z7yptyupV43KcAoOCU++TcQwwAM7hokh4AVvERoOHzpz0hQI6q8cIaDWAqS+pZMFkdlp9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759806764; c=relaxed/simple;
	bh=JqLQ9GdGACLiotBrHerO2CE3M2BFiKN6dTWGtZDXT7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNZ4OcBM2PtPgiMu8vcMDsRv87670akU/uHJuJJUhAEmhqkf2R9hLeqdxBA2eAfiBDeoq8MXe+ZIU5SXtZ5/Aty1czOGECDI8ox7ooOaHZrFuPhAKAMNJZg1NzVYwNKxw7pQITJxuUJ5157VnlNmD8Tf9nePIrEhouuQ04oCmAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=awcmM1HL; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="awcmM1HL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759806759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SOOyWl5/zCiHJcE5VliB1ZHnaBHVoLSMy7X8ybhVYo0=;
	b=awcmM1HLg037zcr9XZM9dbzpijUINxme/NaPHHC860h/hIP64D7wUyKLG51zY1PohwEPIX
	CoJ+Z8+Ue3PPLjdMxOum4KzGmQuZP43LcSjPs5rhQn8Gkg6FER3K0tcbZrGwep1uWu/xvO
	M+LL8On1npCd6jKxF5OkP5i8RkZjzQk=
From: Menglong Dong <menglong.dong@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Menglong Dong <menglong8.dong@gmail.com>,
 Thorsten Blum <thorsten.blum@linux.dev>,
 Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject:
 Re: [for-next PATCH v2] tracing: wprobe: Fix to use IS_ERR_PCPU() for per-cpu
 pointer
Date: Tue, 07 Oct 2025 11:12:18 +0800
Message-ID: <6198553.lOV4Wx5bFT@7950hx>
In-Reply-To: <175979899246.1800846.1725245135731182727.stgit@devnote2>
References: <175979899246.1800846.1725245135731182727.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
X-Migadu-Flow: FLOW_OUT

On 2025/10/7 09:03, Masami Hiramatsu (Google) wrote:
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since wprobe uses IS_ERR() for per-cpu pointer, it failed to build.
> 
> /tmp/next/build/kernel/trace/trace_wprobe.c: In function '__register_trace_wprobe':
> /tmp/next/build/kernel/trace/trace_wprobe.c:176:20: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
>   176 |         if (IS_ERR((void * __force)tw->bp_event)) {
>       |                    ^
> /tmp/next/build/kernel/trace/trace_wprobe.c:177:35: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
>   177 |                 int ret = PTR_ERR((void * __force)tw->bp_event);
>       |                                   ^
> 
> Use IS_ERR_PCPU() instead.
> 
> Reported-by: Mark Brown <broonie@kernel.org>
> Closes: https://lore.kernel.org/all/aN6fTmAjD7-SJsw2@sirena.org.uk/
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  - Confirmed that `make allmodconfig && make` passed on x86_64 and arm64.
>  Changes in v2:
>  - Remove unneeded casting.
>  - Use PTR_ERR_PCPU() too.
> ---
>  kernel/trace/trace_wprobe.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index 4b00a8e917c1..98605b207f43 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c
> @@ -173,8 +173,8 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
>  	attr.bp_type = tw->type;
>  
>  	tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
> -	if (IS_ERR((void * __force)tw->bp_event)) {
> -		int ret = PTR_ERR((void * __force)tw->bp_event);
> +	if (IS_ERR_PCPU(tw->bp_event)) {
> +		int ret = PTR_ERR_PCPU(tw->bp_event);

This version LGTM.

Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>

>  
>  		tw->bp_event = NULL;
>  		return ret;
> 
> 
> 




