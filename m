Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795134136;
	b=cMZMQR5OSLJuU0w79ecAf4idwBUfSN06kf4A5n8K6yEh1/eLmf22QK4dMEoRcz/LS6fl
	 lMmTR9k/PbEttZoPzJfyec7yXqxegc2paMWOetleP71qQ79FASDKYHPr3Clw/RAQM/WO6
	 U1v6YR6ZuXIn3Sh6aAoQRaeUzWkwfAOjdkjNtAJFfV5sy19D0E4+2i5ZGcZ0v15hx+YxW
	 M9/Winz8a/TqvVsth7WsJGcSiuVa0r1yKzQ34teobQXe6/kGQ68QBgNy8iGiZ+k08d9dn
	 F86GnJffePxAUpGdrV6G/UXd82vP0bmxHbeHQFNIS3/hcIQBMgMG4nblLIkSVThXQLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795134136;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=w5atY0hQFmzBHV9Bia209Pu+yefuWzUOfHps6zaalJc=;
	b=SlkNw0TpiJzy2eYw2IYIxNldbf2doZAVRhLAe6dSyyzLlcJDJxQ4qO1eHToJlbNeXJQp
	 1T9FK+8FbdC3TpMEKyXvgR1OMBI5kmlxQfweD+DGs2ZpC02pEKplo352gT4AWF1mukbma
	 1kmwUHp/4HJtndnrv+B40DGYyLD4OHmaWEs/Ae6SFWz8iXfmDnYegIprcHbPQJG+G9gk7
	 N+p+57TMgInK0W7P7+q3uviSb6Kj1ICvv8CAouXRUE371qVaRKA3uLWC4dk032iuqdpFO
	 xgAoUJAsLGv8qecaJKio1EHNBaiaDYoV7EAa03vi/jPqhMgYtvwtM9m0d96y9jiGHqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N2/v4XTU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427FF606A320;
	Fri, 20 Nov 2026 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N2/v4XTU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76FC21F000C4;
	Fri, 20 Nov 2026 00:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795134135;
	bh=w5atY0hQFmzBHV9Bia209Pu+yefuWzUOfHps6zaalJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N2/v4XTUI53sN0egghPRVvePSjLZkQNn1a+Bbl3byqgilSEx/lZO2bfPiuAoCV/8d
	 3x2/uUsgsBqAXd/2VWGPD22z4A1Zv1wwlTWfajWJ52fpTtonI9rQ6+yk4jExoyZ4hw
	 wYBw4DqesBoY0OLOpNoRJLcrJ9zCkXN9MEvBujShhaVMUbVYHXtWIZ/1pxes6vbyxw
	 hR/EsEvu/FunlnD7O6M07UHxsEjQdywjqemoCuTalc2mqH0wfD6yOdkNhTpO6JTE+i
	 OzwoRX4iX3vlufvYWF6TNajIKQUZZpX4IE5hSqM3CjByVl+BfayroRxcEUTqZkjt7l
	 rQNaZkxaj6hJA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Yifan Feng <evanfengff@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ftrace: Reject "!!" in front of a set_ftrace_filter command
Date: Fri, 20 Nov 2026 09:22:12 +0900
Message-ID: <undine-1795134132889316378-ce5fb576430c5edd@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261119191205.32892-1-evanfengff@gmail.com>
References: <20261119191205.32892-1-evanfengff@gmail.com>
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

On Thu, 19 Nov 2026 11:12:05 -0800, Yifan Feng <evanfengff@gmail.com> wrote:
> A command written to set_ftrace_filter with two '!' in front of the
> function glob triggers the WARN_ON() in
> unregister_ftrace_function_probe_func():
> 
>   # echo '!!vfs_read:traceoff' >> set_ftrace_filter
>   WARNING: kernel/trace/ftrace.c:5675 at unregister_ftrace_function_probe_func+0x662/0x870
> 
> The command callbacks strip the first '!' and pass the rest as the glob
> of the probe to remove. filter_parse_regex() then reports the second
> '!' as a negated glob, which function probes do not support.
> 
> Return -EINVAL for such input in ftrace_process_regex(), before a
> command callback is called.
> 
> Fixes: 23b4ff3aa479 ("ftrace: add traceon traceoff commands to enable/disable the buffers")
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Yifan Feng <evanfengff@gmail.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
> v3: add the comment above the check that Steven Rostedt asked for. No code change.
> v2: https://lore.kernel.org/linux-trace-kernel/20261119030900.37343-1-evanfengff@gmail.com
> QEMU with the v2 code, all 7 probe commands: one WARNING each before, none after.
> Found and written with the help of an AI coding assistant.
> 
>  kernel/trace/ftrace.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c7d74b33d36d..4e4337243797 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -5846,6 +5846,13 @@ static int ftrace_process_regex(struct ftrace_iterator *iter,
>  
>  	/* command found */
>  
> +	/*
> +	 * A double "!!" confuses the parser. This isn't a boolean operation,
> +	 * simply reject it.
> +	 */
> +	if (func[0] == '!' && func[1] == '!')
> +		return -EINVAL;
> +
>  	command = strsep(&next, ":");
>  
>  	guard(mutex)(&ftrace_cmd_mutex);
> 
> base-commit: 4405c18c95d2d0f99f6c581ef0ee8591a1aa6ccd
> -- 
> 2.39.3 (Apple Git-146)
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
