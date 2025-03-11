Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402C725A339;
	Tue, 11 Mar 2025 12:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696627; cv=none; b=T9pVie0uNqjfSxDPNQ33Abd8Ld4tYnbM41BYseRGNKWpv1uHT7RkVr1bU8ne7JW7gBI1TzNED98svaUyluUqFSMzLDte1MkP5+8P8OePMAyT7s0NaJnTiQ3XRzOK08GlBHOpPq8e9SxCev6tWCX8YU9CSeMaDiVc98PYGbpW9vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696627; c=relaxed/simple;
	bh=Zsk1ZmRybGqn2PkkWNpha/pB8lPS6MEzdLmljcNcWpA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2y9mQPE3DioWdDeM7RJxLaQ2uLV5lEKEH2l6qBo7EjTCuoG48tHND9mxbSAEOggxq2xCLgC4s2C8QDYtxTdsNYJ8cNINdGevjfY1e1dsTU2R7J3Ioz1os9vd22AgQ3fdp6XqfZeRbXtlRVQsLYfg1VZSqaveNe/5oaDK9u2EgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E8FC4CEED;
	Tue, 11 Mar 2025 12:37:05 +0000 (UTC)
Date: Tue, 11 Mar 2025 08:37:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/synthetic: Replace deprecated strncpy() with
 strscpy()
Message-ID: <20250311083701.6947bd0d@batman.local.home>
In-Reply-To: <20250310200359.450172-1-thorsten.blum@linux.dev>
References: <20250310200359.450172-1-thorsten.blum@linux.dev>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Mar 2025 21:03:58 +0100
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index e3f7d09e5512..4b51f74897b4 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -207,8 +207,7 @@ static int synth_field_string_size(char *type)
>  	if (len == 0)
>  		return 0; /* variable-length string */
>  
> -	strncpy(buf, start, len);
> -	buf[len] = '\0';
> +	strscpy(buf, start, len + 1);
>  
>  	err = kstrtouint(buf, 0, &size);
>  	if (err)
> -

Looking at the code, it calculates the start and end by scanning the
string. I think it's better to just use memcpy() instead. It's not like
it's copying a random string passed in.

-- Steve
