Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6706883B;
	Fri,  1 Dec 2023 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j9ftvqxc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A89C3C433C7;
	Fri,  1 Dec 2023 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701409893;
	bh=u4fezI674MfIiRcaNlHhXBBvjWBXFe/Vu9dKNlCWKL8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j9ftvqxc9QdhdMf9LvQAOFNLl5/DfDGD+5eO1gkcTof4dlFfhaa/DxzCv/MlYci2K
	 nVKKlUNYr/rvetf5rUY7HUvCQGKpO3AnsFXhajtth5JZ4z12/acd/VY0f8acKdgHiD
	 6FtrGZZneu8RZrC7lz9q/61uZv6kRVQ/SlX9Bs1p11qCa3h5SQ8oM8d9Txch0ST9a/
	 Z0NMn0ggsiueRagWdsunV+KemTtgT63qU80cn26YguBY/2HicuBnGAqH/Nn+YeuRI3
	 g0kTrHFXrxSRhhzLl7NOlqB54QtPToPdTZ74TkajfvJ5fMY0x4JwHOmyD4GP1e5h5u
	 pM05lgAImQnaA==
Date: Fri, 1 Dec 2023 14:51:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] tracing/uprobe: Replace strlcpy() with strscpy()
Message-Id: <20231201145129.30fcaf1b762a9b496ac44a2f@kernel.org>
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

Thanks for reporting! Let me pick this.

Thanks!

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
