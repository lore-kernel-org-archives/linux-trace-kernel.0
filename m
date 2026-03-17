Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003203090D9;
	Tue, 17 Mar 2026 07:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773734152; cv=none; b=gXP+CPSSzNqMRnMcXNwN6mrQiLjY7EHZB2q5r8Cj95xBEFjVi/Nq4vokTHPwarXRLpL6SeG9oOy5Q6fw/wZfcEcydPaG08DL+Zv0Zm96J+YYV5T9z5nhBJ2Wb47ViYnW71FG4x6RLMNcYEE/Fj5AF/BW29XonmBx1KbV+CNXdpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773734152; c=relaxed/simple;
	bh=oWMue7rfVl/WbmH3iDFcZaU22QQLUEUXN7ERiTUmWJQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=cVkHaiizNkX5Q4uBKUH/f13/yIkDkAgWjAL9OfbfJ1d9THaZ9MpASW6r9hMusG4xqoafT2m+nlPNPFVdbHeIjCKa4yZgYVZ4HD80Z/OInk6QxS72ZNYUoiJmbxJsg2VAEGpRgQR99wFAje/pUHLI2hw2scMR6AByUk7GqJhhmuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H97YzAqL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H97YzAqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF58AC4CEF7;
	Tue, 17 Mar 2026 07:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773734151;
	bh=oWMue7rfVl/WbmH3iDFcZaU22QQLUEUXN7ERiTUmWJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H97YzAqLo4E6dD+QwRA/yRldjO0zbhE/n002eB+BTgoVS6uq7N9O1eGgm+M6NcQ9r
	 HEP3srlE9X6f69eZpXUCQ4Fk6+SGfirg4ZzLPuDhqUqtxIneYvATkK6GHYrni7YLVm
	 vIGb3vr4JPTnD+Z36zIlFBEXLnkO36In25jl7pAzFG7jPGohYoZzbFzY1bvs/heBtj
	 vGhnxd0p+HMwjwBUAqAJr514LQheLM8NcC5j16HwVhgbFbmrQnH7uMwF/Aq1d0/D03
	 /CvpOEFDs/kIrxVZcELzQ1o1rbZDVTG8/rslP3F13a9y7E5/db/YqtMQ8ZzwOQTxK2
	 hgEAmQgF9426Q==
Date: Tue, 17 Mar 2026 16:55:49 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 16/17] lib/bootconfig: fix sign-compare in
 xbc_node_compose_key_after()
Message-Id: <20260317165549.99ea4171d7672f83ec3b6fc4@kernel.org>
In-Reply-To: <20260315122015.55965-17-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
	<20260315122015.55965-17-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 12:20:14 +0000
Josh Law <objecting@objecting.org> wrote:

>   lib/bootconfig.c:322:25: warning: comparison of integer expressions
>   of different signedness: 'int' and 'size_t' [-Wsign-compare]
>   lib/bootconfig.c:325:30: warning: conversion to 'size_t' from 'int'
>   may change the sign of the result [-Wsign-conversion]
> 
> snprintf() returns int but size is size_t, so comparing ret >= size
> and subtracting size -= ret involve mixed-sign operations.  Cast ret
> at the comparison and subtraction sites; ret is known non-negative at
> this point because the ret < 0 early return has already been taken.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index e318b236e728..68a72dbc38fa 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -319,10 +319,10 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
>  			       depth ? "." : "");
>  		if (ret < 0)
>  			return ret;
> -		if (ret >= size) {
> +		if (ret >= (int)size) {

nit:

	if ((size_t)ret >= size) {

because sizeof(size_t) > sizeof(int).

Thanks,

>  			size = 0;
>  		} else {
> -			size -= ret;
> +			size -= (size_t)ret;
>  			buf += ret;
>  		}
>  		total += ret;
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
