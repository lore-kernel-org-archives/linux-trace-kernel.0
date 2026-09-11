Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716134CFDA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 14:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136959; cv=none; b=RCg491Mx4yDVDU2N/tXxKEtlPy+wfhlPNxs0SJBkXifmaoVmgxpNP+2Dde0hkZpiKDC7U2aLPyLllYWIKmsd1CGoKe6IT0Lkha8LoW1fqkvBnDzfyx7rIYdsGfi4kAUvYQjSIoGpjKt91Yn6p5R485WTG5oSbRjh5Yd0tkzG7sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136959; c=relaxed/simple;
	bh=69po7DbaADB2SY2EbTkF9uHs5ak2GL962m7ADhBkbiA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ql3Mb9QylUSbue7d+njqvwmZzX9xTYb7RPSj/xyQ4iCa3iylbDjAo1A+eRysMj1K8pvOhk5PO3uMug5M4KApTE+aYNLFogue+GRJGPvnmiLMTMpz+QHv/wWplL+LJHmiDKUXQakPkRpqq/4l1SMi980sNuiXsHkOgnDO4uomIEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nODU35TY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nODU35TY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2311F000FF;
	Fri, 11 Sep 2026 14:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136958;
	bh=iK+x+NVS0LavtFJPInEKq+RwHwyI9v6wqXKt8iVsImc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nODU35TYbRRP9p/H4pRYMTeRkW/17DlkeFU80m1ObQ2nlOa21u/Ydyj7zjYusIYcc
	 cazk+WkAzQHFkbJ+jSwOyQLWS+5SFVUh5l8u+Q6FR8uDPwi4E7NMWkE+aA4dt7gyL2
	 gA8N73SHox4ewhlHKUvDB8IRBOvFXzOejPqF0eB5GYj9dclpk2Xru3kFaTDHl/rSmT
	 iRa+NUyggTPqFYcin/yt9qiLRE5xZajTlerfEzQcUADFeeaqNm1zeO1IEbvsslfwrH
	 m0moheaxx6QWHxTOgiA6GIbc3p+IMj78eC0W8L+RJ+l7yIrC+GsAdqCmMj5GeBd29A
	 ovsgiYfaK2UcA==
Date: Fri, 11 Sep 2026 23:29:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: remove unused PAGE_SIZE macro
Message-Id: <20260911232915.a2a6f4470edc47ac45ed3656@kernel.org>
In-Reply-To: <20260910163155.1974118-1-ekffu200098@gmail.com>
References: <20260910163155.1974118-1-ekffu200098@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Sep 2026 01:31:50 +0900
Sang-Heon Jeon <ekffu200098@gmail.com> wrote:

> PAGE_SIZE in tools/bootconfig has never been used, so remove the
> definition.
> 
> No functional change.
> 

Good catch! OK, let me pick it.

Thanks!

> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  tools/bootconfig/main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index 7dc9fff9b637..2b4d9559159c 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -134,8 +134,6 @@ static void xbc_show_list(void)
>  	}
>  }
>  
> -#define PAGE_SIZE	4096
> -
>  static int load_xbc_fd(int fd, char **buf, int size)
>  {
>  	int ret;
> 
> base-commit: 13e8b7707efcea3a401d242958ba0a392f227847
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
