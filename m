Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410EA935;
	Tue, 19 Nov 2024 01:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731979554; cv=none; b=ZGN2K09s9eWYW2XgQ8sjYMFWWdXMmOtggruXU1Wz2aFK0qQ/c47LXN/cbWfGMp/IXPF/TVV+lVPKdHdIkg7IUx/OzdbMwFHrpdJX/a3YqzxqiIWR86OODcg68XsNENPy6PXO0GcXDr0PTP4dAtJP/iA6Rfjku3p4muB9wwW/Mx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731979554; c=relaxed/simple;
	bh=5c/t0aEODqgRGmWnuxsXvGXvo/bdmacX6X2qh8qZJIA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iRPnvhAOK36EdxCCV0uDLgiZ2EQnazB/LAFf9VAjiKSjpAVO0l0HnmFnm2KAmaPq6oOVSeuJILvH2UJUHqJCERPVVGvQbfXaH4efxQ1IDjrtHblD2P/yoddWMRNtsEIvLzzByRMvnUbdy+zzW9X0PVP2lGbhdJQlEAK2b2brWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ok7J7i2e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ok7J7i2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC420C4CECC;
	Tue, 19 Nov 2024 01:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731979553;
	bh=5c/t0aEODqgRGmWnuxsXvGXvo/bdmacX6X2qh8qZJIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ok7J7i2e3cT96gQO/CeWjk+Oo50l+6frcNjytO1nRDo4GdmfdIcBA2ftwbtp7yeLH
	 56lGR4K9tvwsfLCUVp8wrepk/2uMy4dATRReZ/II4Q6SzNWW/9NxERxBqHA0TPzS2i
	 0iyHqJhurI6IhPtg5pyaXU74tH28iiV55bdcSSWMEE9d0/LyL3YjYc4OzfsH5DKauw
	 +51qAAx6YJEnAV0R56jt82mpx3RgmYHQ+ASWJizl5QLZbOee7xrdmrJFtieZ2u337u
	 aIFKZjb0NxH0Su4zaAoUSzRqrqb8W+d+6rcg02E1kibUY8OXFnRClEtxepn7deWv8L
	 2BQF2cNJU//4g==
Date: Tue, 19 Nov 2024 10:25:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Luo Yifan <luoyifan@cmss.chinamobile.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 trivial@kernel.org
Subject: Re: [PATCH] tools/bootconfig: Fix the wrong format specifier
Message-Id: <20241119102549.5da4d2c1cdbb7514014cd273@kernel.org>
In-Reply-To: <20241105011048.201629-1-luoyifan@cmss.chinamobile.com>
References: <20241105011048.201629-1-luoyifan@cmss.chinamobile.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Luo,

On Tue,  5 Nov 2024 09:10:48 +0800
Luo Yifan <luoyifan@cmss.chinamobile.com> wrote:

> Use '%u' instead of '%d' for unsigned int.

Good catch, thanks for the fix!
Let me pick.

> 
> Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
> ---
>  tools/bootconfig/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 156b62a16..8a48cc253 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -226,7 +226,7 @@ static int load_xbc_from_initrd(int fd, char **buf)
>  	/* Wrong Checksum */
>  	rcsum = xbc_calc_checksum(*buf, size);
>  	if (csum != rcsum) {
> -		pr_err("checksum error: %d != %d\n", csum, rcsum);
> +		pr_err("checksum error: %u != %u\n", csum, rcsum);
>  		return -EINVAL;
>  	}
>  
> @@ -395,7 +395,7 @@ static int apply_xbc(const char *path, const char *xbc_path)
>  	xbc_get_info(&ret, NULL);
>  	printf("\tNumber of nodes: %d\n", ret);
>  	printf("\tSize: %u bytes\n", (unsigned int)size);
> -	printf("\tChecksum: %d\n", (unsigned int)csum);
> +	printf("\tChecksum: %u\n", (unsigned int)csum);
>  
>  	/* TODO: Check the options by schema */
>  	xbc_exit();
> -- 
> 2.27.0
> 
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
