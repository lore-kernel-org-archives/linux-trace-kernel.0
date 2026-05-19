Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB57F3AFCEB;
	Tue, 19 May 2026 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203056; cv=none; b=sy7vlqjh7A+6D9W+Hgj/iMgmTkJT47WiwrvYiO3AtbUsIuOfosQDLOmZHtyl5zel16ugBMsQTqpUmSd58+ZO6fM8eO7hb67IvPOyV41DTFfD2kUEyxPhz9gbEI8wSXeiTaOqaylmGQUyNLao8R2lvQkoPiqQaRRofymhmUd1fbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203056; c=relaxed/simple;
	bh=sfG9cDgiPRC8EP3q94MWP/Vk8qWZgv3zawMTYi/OXtY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=YAT/5BHIOCKFXGHUuizcqUB1jn8keUodfdfg1uDE4Q49OAr299AbY89Yzfhh6ZHABr3VCGQCapKWnywtrWWo0/pCrv6IanHyhWMMCK/XlyNYXExtFf+EB5t7WrgvVPN1gJgnzbKp+WVGqWmFWdS8jXqRoFxKNdymx+a5zA3v824=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnmnE2Gk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnmnE2Gk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78114C2BCB3;
	Tue, 19 May 2026 15:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779203055;
	bh=sfG9cDgiPRC8EP3q94MWP/Vk8qWZgv3zawMTYi/OXtY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FnmnE2Gkv5jbzzqoo3f6gZzNLKN9obBNjwoFCut/YF2AUZkc9FkRW13LyDYgvITkl
	 GYx624bBSMcAXXiOzmRsbZar0cW8aGNgkWG2UsKjqz0L5mCCQUMZoI4EXlkN59VyPM
	 50GwFA6NIr0wW1j6UU544JvdIabsqpcBs9JuFqsN4FEg3nuRwB484+gl7RpdSw878Q
	 nZDBUvk4fJRCEBxK+amxyTAqv5y9y/liWaMKfRrKN/cmoiji/cqDKy8y4BiX/u8PFd
	 29IMf90ST++3c8uZEXuoyu0BWfaawjogy/LpXoJgDVfeFKoYTNiMoQCC24Edh9q9NV
	 Ipt4F5R6X5Q2w==
Date: Wed, 20 May 2026 00:04:12 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: lihongtao <lihongtao@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Fix null pointer when free buf
Message-Id: <20260520000412.907a3d930ff09e1c80c1177a@kernel.org>
In-Reply-To: <20260519031458.141050-1-lihongtao@kylinos.cn>
References: <20260519031458.141050-1-lihongtao@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 19 May 2026 11:14:58 +0800
lihongtao <lihongtao@kylinos.cn> wrote:

> In show_xbc() and delete_xbc(), if load_xbc_from_initrd failed,
> the buf may be NULL.

NACK, because free() can handle NULL correctly. See free(3)

   free()
       The free() function frees the memory space pointed to by ptr, which must have been
       returned by a previous call to malloc() or related functions.   Otherwise,  or  if
       ptr  has already been freed, undefined behavior occurs.  If ptr is NULL, no opera‐
       tion is performed.

Thanks,

> 
> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> Signed-off-by: lihongtao <lihongtao@kylinos.cn>
> ---
>  tools/bootconfig/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index ddabde20585f..417d07a46f92 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -328,7 +328,8 @@ static int show_xbc(const char *path, bool list)
>  		xbc_show_compact_tree();
>  	ret = 0;
>  out:
> -	free(buf);
> +	if (buf)
> +		free(buf);
>  
>  	return ret;
>  }
> @@ -360,7 +361,8 @@ static int delete_xbc(const char *path)
>  	} /* Ignore if there is no boot config in initrd */
>  
>  	close(fd);
> -	free(buf);
> +	if (buf)
> +		free(buf);
>  
>  	return ret;
>  }
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
