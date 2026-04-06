Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7BF271471;
	Mon,  6 Apr 2026 01:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775438672; cv=none; b=Du4MD4RsrhsG4FkXvwK2C4E0/GQIoxlxDt4cTd6Qd+OqXi3PgvOB3vYyfT2DlHN/wz5RRb/2qrEfH++MEOpJha/H4RhWT1QkfYSg9foOq4XbhKMD/+/MGNsiNBMjJ2UaFCH/enwvnGM6/WOtpW7FOx/mOjE+AW36hc4t+xjC82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775438672; c=relaxed/simple;
	bh=3OLtjJgIDVy+KgojIqVI39DhSFmcAF4YjZxEAmoB/Bs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dd/XGj/cj/2v84dPBRl5+WCiw569CEW0sSqZXCBZe+w6sat1mjmysDf9NE10MNlcq6EUWBYwAwOunMudWo/T78wnhmrF7U5nN3x9QI3ekrbDljItrvPvcClWMvufHq7ZlKjxbGjoMo+MJeb1WPiXRM7odktBG2EY3t6jNHZ+HLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhxtI1uq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhxtI1uq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D628AC116C6;
	Mon,  6 Apr 2026 01:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775438672;
	bh=3OLtjJgIDVy+KgojIqVI39DhSFmcAF4YjZxEAmoB/Bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XhxtI1uq463lg6zjC3zk1xU5UaSFExSoo91mjN/7qbhoy3PDwY06ysw+bxny9zsMo
	 dgWn7Qld95Kcx4ur6/EzWxkmi3tio00nGF2uN2j4iIyHrN1XoeW6XEraqzOsg0u8DN
	 /ZHkSC/z66/FXlrx/Sa4621RxUA5ZutJSjJhby1P8DEW39phjMoXUWKv9GymU7ZDh0
	 DPBxV47ZDrEwrq7gg56gqi4YrJvd/QZjVdrvcuhsuTFZfpX21em6xRKQms5GflOtoX
	 oBm8f+q2MkP211Ub8gTYYsNxe6kuux9cXqnycnqC6ySAcW7xraV+9S1nmtC+E+n//1
	 Pt1ahGtQNnTSA==
Date: Mon, 6 Apr 2026 10:24:28 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/probe: reject empty immediate strings
Message-Id: <20260406102428.90c395d2038da4c76162e750@kernel.org>
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

I would like to suggest the subject as

"tracing/probe: Reject non-closed empty immediate strings"


On Thu,  2 Apr 2026 00:03:15 +0800
Pengpeng Hou <pengpeng@iscas.ac.cn> wrote:

> parse_probe_arg() accepts quoted immediate strings and passes the body
> after the opening quote to __parse_imm_string(). That helper currently
> computes strlen(str) and immediately dereferences str[len - 1], which
> underflows when the body is empty.
                                   ^ and not closed with double-quotation.

> 
> Reject empty immediate strings before checking for the closing quote.
        ^ non-closed.

Thank you,

> 
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
