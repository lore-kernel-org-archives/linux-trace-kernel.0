Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C2FD2E6;
	Fri,  1 Dec 2023 06:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Je1LOd7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA9D6C433C8;
	Fri,  1 Dec 2023 06:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701412050;
	bh=xwy7BCCRY25CuNdlNIR9LwJI9+brUDxnwlzmTmnS0iA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Je1LOd7ZCPaGuQlDPrkVlPlLLd1YvK2ugR4B0YEHCeLusKv6vNtUU0wmHD4yKpm81
	 ac623VzTcwDJ1u4r4hxxw9Ax3LYX1TgtnN5BJubUUIshLMLfnZ09enpykRfzsHhGZR
	 u7Pto96X05N0DRW2WFu1G/A2hZB5fukUjb6S+UrmohONmOg98q6iKCaotRtaIiqLDr
	 heAotKjZTFVYHQ9u+1BP0v5j460EEi6f3qpAzi9Jqr8jLkQS8n9htn6mzIBssRtgc7
	 0GSbv+7c8UZ3WZ4+ctuVGw0mdAP+AmTiR3WQu9Nt+4oHd7TmJTB3O76s5zWSgRVJ03
	 pDGIx0uuoxJKA==
Date: Fri, 1 Dec 2023 15:27:26 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing/uprobe: Replace strlcpy() with strscpy()
Message-Id: <20231201152726.91421003ccd64eb5e369043c@kernel.org>
In-Reply-To: <20231130205607.work.463-kees@kernel.org>
References: <20231130205607.work.463-kees@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 12:56:08 -0800
Kees Cook <keescook@chromium.org> wrote:

> strlcpy() reads the entire source buffer first. This read may exceed
> the destination size limit. This is both inefficient and can lead
> to linear read overflows if a source string is not NUL-terminated[1].
> Additionally, it returns the size of the source string, not the
> resulting size of the destination string. In an effort to remove strlcpy()
> completely[2], replace strlcpy() here with strscpy().
> 
> The negative return value is already handled by this code so no new
> handling is needed here.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy [1]
> Link: https://github.com/KSPP/linux/issues/89 [2]
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Hi Kees,

As same as sample's change, should I ask you to pick this to your tree?
Since it is a kind of a part of series patch. I'm OK for it since this
does not change the code so much.

In that case, please feel free to add my Ack.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,


> ---
>  kernel/trace/trace_uprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index 99c051de412a..a84b85d8aac1 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -151,7 +151,7 @@ fetch_store_string(unsigned long addr, void *dest, void *base)
>  		return -ENOMEM;
>  
>  	if (addr == FETCH_TOKEN_COMM)
> -		ret = strlcpy(dst, current->comm, maxlen);
> +		ret = strscpy(dst, current->comm, maxlen);
>  	else
>  		ret = strncpy_from_user(dst, src, maxlen);
>  	if (ret >= 0) {
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
