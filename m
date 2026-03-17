Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD831125A0;
	Tue, 17 Mar 2026 07:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732713; cv=none; b=XStZjub3hh1nqbTK5fmzu8+GNJpWdTTfRHR7gcYls7FqfLqwXrXfov93TnrLlaHfjMdL1e59XoT7cfGiVW5MJ6Q2VZGwnfWI65iaz3I4BMON/qXgNaBvWXHwNMW23a4omyHPQV9cJqDRqXaR5v478GK9UV2zrvb8SoExlDfBe8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732713; c=relaxed/simple;
	bh=m85Qfcrl3/AIXzzQmNeXmljEB4IflAd2YilbTcr4Vzo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=DMsAOgldCwwJXDURf4zXcmCZJo0Pu6zclBFPbLTAcyQ2ND6mxQE+2Vf3CTbAatyNf86vuU28LTZJW43rdApHwjJ7z3rsDtDu3Y5ZOg2GTAxXU7oPYlLCgOwZs3DIXpmSuaJZ9ohHEg+hxxSdMEdeK9sS6k2L2ljQ8pbUDcEPvhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrYM9Gta; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrYM9Gta"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B59F5C4CEF7;
	Tue, 17 Mar 2026 07:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773732713;
	bh=m85Qfcrl3/AIXzzQmNeXmljEB4IflAd2YilbTcr4Vzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SrYM9GtayvkR1tytnZLzzaTRnUQvitzk82TKDlf5E4bi3k1jkYGgMv3YilQDQzN8C
	 FE78rCFlXkeO7KIWkAGN/TN0EZhFXiXy/lSwe46CXkFPTJ96dBWwI6ffvXynb3StRZ
	 1lnnzOTQS71ZkgvJLlV63xciCBvrc5q8UqeJh9929HOHi3o7ZLNCmnZFZB5VlnXoUF
	 35+0ov7a6e0Uvmhm2J6gL4+uutb1er566FhTWgJtPd6VlTxxd2Q725kb4UUvQqk3PG
	 tUSJ+JDWNCnXRhXy0IF6I/e/jovrIHPWyw5oNpmR7XJnvBVVnCB3gKZXQU5dGZnwyY
	 vZ4BSpm8aCVJQ==
Date: Tue, 17 Mar 2026 16:31:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 11/17] tools/bootconfig: fix fd leak in
 load_xbc_file() on fstat failure
Message-Id: <20260317163151.264b0617484d202daba85f0f@kernel.org>
In-Reply-To: <20260315122015.55965-12-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
	<20260315122015.55965-12-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 12:20:09 +0000
Josh Law <objecting@objecting.org> wrote:

> If fstat() fails after open() succeeds, load_xbc_file() returns
> -errno without closing the file descriptor.  Add the missing close()
> call on the error path.
> 
> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  tools/bootconfig/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 55d59ed507d5..8078fee0b75b 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -162,8 +162,10 @@ static int load_xbc_file(const char *path, char **buf)
>  	if (fd < 0)
>  		return -errno;
>  	ret = fstat(fd, &stat);
> -	if (ret < 0)
> +	if (ret < 0) {
> +		close(fd);
>  		return -errno;

Sashiko.dev[1] found that close() will overwrite errno. So please make it

	ret = -errno;
	close(fd);
	return ret;

[1] https://sashiko.dev/#/patchset/20260315122015.55965-1-objecting%40objecting.org

Thanks,

> +	}
>  
>  	ret = load_xbc_fd(fd, buf, stat.st_size);
>  
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
