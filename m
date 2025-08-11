Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C6A2D8791;
	Mon, 11 Aug 2025 06:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895237; cv=none; b=fdSTOuu9F7DKx/sqTFfQnp+LtNREdpnhUbJZtoMMMWclECZ88WxNlcQ3rH8GwT06Q1J7/mAnVknt6ax4yGcdjMt+o4Rl6nuF9wt8ATop8ZEp6MshUpv5VYdAVywAukwi5/7eAYMT4tr1gxzcSRp4YvM3R4R0PtXdSI47nBSgA8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895237; c=relaxed/simple;
	bh=BWWLk6Yq45CTnQVD+a294iwIg5FepJW6q/JaOB5I7Oo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E32E4ryXDdOF7tIc/UpVpXOjjwtZE1J6lkjdZPa6A5xRVcNBrC0SiEbZqzuY4uNdm49rIesi6mLquBIKpnK+O3ZiOjfZy0jWxNxWVAhk5Wd2RyD6wXR42Ri43iiwXVVGa+o4/lOdnmSRA/LaFsZ8O2QPTuXn8PM24Q8AyJnUGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgTsaqVm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgTsaqVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9BEC4CEED;
	Mon, 11 Aug 2025 06:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754895236;
	bh=BWWLk6Yq45CTnQVD+a294iwIg5FepJW6q/JaOB5I7Oo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZgTsaqVmGe4SDzE7edr71WQ4ZXg1s9Qfm7+ZXUnVtlp2njxbEnEkPiIpHipc9AyZQ
	 wJ+C88GPiYjJBibNWveeh6VgIEE9O3YMA3uw0MR990cbfBkdWQP2/1zynb6NiC/CN7
	 zeS3WxstlHrCGK+ryOolG5ctGfrWi6/nZOw2OxWRmVZKjtMkHZhv22ovGG2NxXECa5
	 N8UkMBJVJYcHDSDt3Qxc1ehYK1M6I0vcS+nfVsHsULA4PSdyFmlSanP1b9zYH8rYWE
	 g/u2lRStWLByaDttcC9TpDIsK+SyFi9/SJU2xFLCvEUxS6xxbaw1uJ3t0Ac2DetFr7
	 qZ2gT6C8uY3+Q==
Date: Mon, 11 Aug 2025 15:53:52 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing kprobes maintainer
Message-Id: <20250811155352.45ee7061226f3e85aeda54b7@kernel.org>
In-Reply-To: <20250808180124.7DDE2ECD@davehans-spike.ostc.intel.com>
References: <20250808180124.7DDE2ECD@davehans-spike.ostc.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 08 Aug 2025 11:01:24 -0700
Dave Hansen <dave.hansen@linux.intel.com> wrote:

> 
> From: Dave Hansen <dave.hansen@linux.intel.com>
> 
> The kprobes MAINTAINERS entry includes anil.s.keshavamurthy@intel.com.
> That address is bouncing. Remove it.
> 
> This still leaves three other listed maintainers.

OK, should this be an urgent commit?

Thanks,

> 
> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Naveen N Rao <naveen@kernel.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> ---
> 
>  b/MAINTAINERS |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff -puN MAINTAINERS~MAINTAINERS-kprobes MAINTAINERS
> --- a/MAINTAINERS~MAINTAINERS-kprobes	2025-08-08 10:57:53.686216444 -0700
> +++ b/MAINTAINERS	2025-08-08 10:58:00.237773836 -0700
> @@ -13681,7 +13681,6 @@ F:	scripts/Makefile.kmsan
>  
>  KPROBES
>  M:	Naveen N Rao <naveen@kernel.org>
> -M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>  M:	"David S. Miller" <davem@davemloft.net>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
>  L:	linux-kernel@vger.kernel.org
> _


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
