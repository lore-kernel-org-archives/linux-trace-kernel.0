Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF283655C1;
	Thu, 21 May 2026 02:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779331112; cv=none; b=hYUf0qsFwEqJnZoPWUWGU7sqtsrRHZmBYpwTO21r+GO++/UzvzIwObkA9We7bS8O4On44TT2E1LW0ulrtCeXy3wZik3zaJXXtP9xyL8FXMpKcwIDBrgS89IwY6WxYnpB9XoqHg+O/SlTqBY0Otx9NRRZSx779oN37bTlGjfDuoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779331112; c=relaxed/simple;
	bh=gXZvWGfHv6P2Jvvg2wKOz6+f3QcPz9QQTo9d9z7I+nM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QnCoA1aIxAePs/qJu+7nhiC+Q1+CJ0rEHPaymP6Q6vHNvrEyelZRBPESkkWawAaG9rMVZRim7ZJ8OgPaTxsFGFql6AeiXIY7ewDtb7mzTRvpU9b93cf1YwL06bvG6n4aMs7+NDfLZ3RF8WK/mNFIUcbSZond2wLpVUQe8wuDZ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k2dpL+vm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k2dpL+vm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76E91F000E9;
	Thu, 21 May 2026 02:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779331110;
	bh=tFq67Zdzx5So7eP4S6xI7PsicgpfIeVUYuzfkutkcZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=k2dpL+vmmsJevbkcBCOk+NuQIUm7ud0MvgYWoThgvL2v0gKk4NnJACH5JupbqnMif
	 XfPNrD9jXcKPLePKghzkRdOkj7Hv3RJp66mjSNnGCkvziuuE7ySCSrC2ZtcF4oiV3D
	 7GA4NWFIXTWj1mLhlo5PSCDbcFyAs9qS5epETcQZIKV17Dsj1CldDxS3Uo5YwJhjW5
	 kSvAc6zSGAomk5lKO/eWfFwi0JVOr85QHRqL9x/O6dUG4fZFMDSkiB1tKTdg5h0zlK
	 4JHcypcf2+CZSmJ3INwjK+GYNuUyIm3bTypSdlEavFhYO+7eXKhZZMMj0LvrJpaV43
	 94IPxCA13LEUA==
Date: Thu, 21 May 2026 11:38:27 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: lihongtao <lihongtao@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tools/bootconfig: Fix buf leaks in apply_xbc
Message-Id: <20260521113827.abef811ba8ab312d5bc85b65@kernel.org>
In-Reply-To: <20260520030126.147782-1-lihongtao@kylinos.cn>
References: <20260520030126.147782-1-lihongtao@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 11:01:26 +0800
lihongtao <lihongtao@kylinos.cn> wrote:

> From: Hongtao Lee <lihongtao@kylinos.cn>
> 
> If data calloc failed, free the buf before return.
> 

Thanks! Let me pick it.

> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> Signed-off-by: Hongtao Lee <lihongtao@kylinos.cn>
> ---
> V1 -> V2: Change Email Signed name
>  tools/bootconfig/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 643f707b8f1d..ddabde20585f 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -390,8 +390,10 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  
>  	/* Backup the bootconfig data */
>  	data = calloc(size + BOOTCONFIG_ALIGN + BOOTCONFIG_FOOTER_SIZE, 1);
> -	if (!data)
> +	if (!data) {
> +		free(buf);
>  		return -ENOMEM;
> +	}
>  	memcpy(data, buf, size);
>  
>  	/* Check the data format */
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
