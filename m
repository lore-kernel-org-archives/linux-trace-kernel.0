Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB13AFCE3;
	Tue, 19 May 2026 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779203582; cv=none; b=VoDXPQaRr57uKLC6X8QGCWKKugAhgJilVe2zz86gXixLJfwAr3nvQ+Spf4ubnNW9pZVTUjraDntEbBLqHNbqbBnazQNA9DPOoXCTpC7K5hQL7HkBT/1HtXj6QrwO8jQBJgDSwO2JlMWMTfYkyvQvuhihXw/V/b3z9aTbKWJfv+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779203582; c=relaxed/simple;
	bh=3EdPDTW1UVKusuIIZzXgkz7+DCGIHKUsdGgzdNl9Y3w=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LDudIds6I42S/KZh2eMBwKFaXccL8+Vf2qR4xIX9uxx1wBcQCI/XrRKtAD/XvnwUZbsvnCXVI0vKwuynjAdPOXPi0O0NfWiljuMdViNS1MlajDb0eMlq1RoMs0JPQPtbjKG+GYpikhtXQilkD9gqNs9VeeEUBkTJuHcBnAU5eTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0xrZ1Qj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0xrZ1Qj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EA08C2BCB3;
	Tue, 19 May 2026 15:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779203582;
	bh=3EdPDTW1UVKusuIIZzXgkz7+DCGIHKUsdGgzdNl9Y3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i0xrZ1Qj+n04bESzyOEUAq4nK3kqsDN2J15akW87z/Z4U1T5/f9I9mJcu6K16ORnT
	 A87HNafth3gEJjKRYzLldvPgU2K3obJ/KbgbLRAvitmdJ1u7oJQ7tv62Qb3G8IwtV/
	 r+ptpgYZifNXW8kF2wwVxpj+Zzr2LvF7Wcf7DLxn9JWEzVUkytHW97pl5VlGhy+Cqc
	 QaSkOVQRPTjzw7bBa8oOR9ftcKPCfjmiX30QHTtlKed+EUjwbpsU+j6324bffnEAR4
	 kLl2hrNRQtKc8afpYt7fnSHUtxORzpJtCWnyb+VB/07DVyKXov76NPdrGY/dacAPKN
	 gE1wGDefV7dbg==
Date: Wed, 20 May 2026 00:12:59 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: lihongtao <lihongtao@kylinos.cn>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Fix buf leaks in apply_xbc
Message-Id: <20260520001259.0cde0c415601b269b3fc8838@kernel.org>
In-Reply-To: <20260519031255.139036-1-lihongtao@kylinos.cn>
References: <20260519031255.139036-1-lihongtao@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 11:12:55 +0800
lihongtao <lihongtao@kylinos.cn> wrote:

> If data calloc failed, free the buf before return.
> 

OK, this should be a real bug.

> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> Signed-off-by: lihongtao <lihongtao@kylinos.cn>

BTW, according to the DCO, can you use your real name here(Lihong Tao?)

https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-developer-s-certificate-of-origin

Thanks,

> ---
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
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
