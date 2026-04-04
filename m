Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D58625;
	Sat,  4 Apr 2026 00:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262847; cv=none; b=EiZw3YrQYyS00NoDwACq7gg2zUia2XFpYf2HzdF3AB9dIDCPUtwu85qdMtdNHFLRStBMf4S994gPzdJ73m0zsbvwuAXWS3IInnE0qjD4s+srxnOpQMTgTyLZShI8b9JbzV4bpcqXKQJ/v2yIaX9/EXbHynQZJIDzmpuPhjdoOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262847; c=relaxed/simple;
	bh=fVNdL/o9S9xt6Sf7j57v4F3QUns88VfVuhlnc17JuSU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Vjeb5QQwBwdba2nVFkD4EssYP8UNg7YROqrUgQHe2gz/KQnYL52znqYgYkvHHjA1AYFKvDTRgaTxzkJmU3wzGcoTTbsGHIBWR90+P51B//8VB7matNveR2lOXmfBRTcdYq1ulc7JAYjBK++hjK3rCJBe8m0GRLon22bNkRZXBiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a+77hpP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a+77hpP5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F2AC19421;
	Sat,  4 Apr 2026 00:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775262847;
	bh=fVNdL/o9S9xt6Sf7j57v4F3QUns88VfVuhlnc17JuSU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a+77hpP5fHMsbsuQ5ERuZACAG3i3TLjmWAvSbRnfJ8ZJouEv4FZtTQRGF079UhkAe
	 sY+X+jvJsGGj3LS0MuFTfE13CXPAJpa/WOUE6ZAC3Ed96bAi8I/gWxw4lOSufCsBzp
	 lQTD0R5p8IEYNk4lxizWZclzgfxLyFAR88UMpTMqWjW9gxVjAliOd4QhxkvxjDC46h
	 1TXuJHsbPXz2cCkLsc7BMWI2JsuztWFzDutt8KmMvx6xdU2qZYPyl95ZKqZDBY0b7X
	 174dYT6udFyNmfmUgiBz9CKVuGBidur51w7rHY9rLI3VxqXBr8Q2Ehuf46rxAM0FlM
	 k7mSlQHSuJEag==
Date: Sat, 4 Apr 2026 09:33:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/probe: reject empty immediate strings
Message-Id: <20260404093359.e3bc3f7ededeba6a73858e5d@kernel.org>
In-Reply-To: <20260401160315.88518-1-pengpeng@iscas.ac.cn>
References: <20260330062920.40766-1-pengpeng@iscas.ac.cn>
	<20260401160315.88518-1-pengpeng@iscas.ac.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 00:03:15 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> parse_probe_arg() accepts quoted immediate strings and passes the body
> after the opening quote to __parse_imm_string(). That helper currently
> computes strlen(str) and immediately dereferences str[len - 1], which
> underflows when the body is empty.
> 
> Reject empty immediate strings before checking for the closing quote.
> 

Oops, good catch!

Let me pick it.

Thank you!

> Fixes: a42e3c4de964 ("tracing/probe: Add immediate string parameter support")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
> Changes since v1:
> - resend as a standalone patch instead of part of an accidental
>   cross-subsystem 1/4 series
> 
>  kernel/trace/trace_probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index e0a5dc86c07e..e1c73065dae5 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1068,7 +1068,7 @@ static int __parse_imm_string(char *str, char **pbuf, int offs)
>  {
>  	size_t len = strlen(str);
>  
> -	if (str[len - 1] != '"') {
> +	if (!len || str[len - 1] != '"') {
>  		trace_probe_log_err(offs + len, IMMSTR_NO_CLOSE);
>  		return -EINVAL;
>  	}
> -- 
> 2.50.1 (Apple Git-155)
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
