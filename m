Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363338CFE9;
	Tue, 17 Mar 2026 07:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773732801; cv=none; b=AFhK5QH+U1yqA/6h41MIZgtD5Q2CZkoGh/NTNAU1vzR2gXy03GxahjHz4FdkDpvdi9uYqCopCx/QmQaBKfz/QkpfjepZTt9jqWyvwUMzcDo8k+uYYzc/HV+I6gqfQYQ7AaHOgC/YS8xpBiyLO3oO3s3c5sSVQWAi+IUDJO3zCpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773732801; c=relaxed/simple;
	bh=aN8sd5HQU1h3djtVWqFIAOX9YR2ziXIDHL61cRFiXYM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=d8Tldggj+TjaDLNPIpvqAmGXb/HODUE4bbcmBdXgGmHWSroVbAAWIwkRTMvUL3buP0DqlSV5xGBWPyRzIpzs11XcmyfRWPgchinKm6Jc+v1W7pK+GRFQ4o/fn9cUy85TUlJdDD7vfYGehLnBAIZNpZQoydw1RMFZpEs1D5nfJvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhNOUfvj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhNOUfvj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDABC19424;
	Tue, 17 Mar 2026 07:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773732800;
	bh=aN8sd5HQU1h3djtVWqFIAOX9YR2ziXIDHL61cRFiXYM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HhNOUfvjd1YuK8DMr+gfUZ4Roj/7qmoQdm2RGWJoNUo1HQuDP4o6tN6f1nqk2WpJz
	 PglKpQeqPxozvO43Y1HHkBAd3DOgoETbD32ETf1lrXpint/ypF9/VmL5pHJQ4NNOb2
	 PSA0lhB7JU8uJjIi/9g/quhB4cUrrM865HLmYNh7uEOCSCTIgCq2h1UISA+pca3QT4
	 wlJEsvUZ/10dc7Iv+44ps/9uOz/zsqcZVLVySnpNMNveE80c7k07aUOKlZVv+jR5yn
	 3cTIL71+e5ZguRNblAY0BIQJdPd+Qpu4iEl9oOtUjzCkPVaa88tTRLjAkeCRdi9Ug+
	 aMoWWNUYBeXOw==
Date: Tue, 17 Mar 2026 16:33:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/17] lib/bootconfig: add missing __init annotations
 to static helpers
Message-Id: <20260317163318.643e3cc7fee9e709b464fa79@kernel.org>
In-Reply-To: <20260315122015.55965-2-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
	<20260315122015.55965-2-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 12:19:59 +0000
Josh Law <objecting@objecting.org> wrote:

> skip_comment() and skip_spaces_until_newline() are static functions
> called exclusively from __init code paths but lack the __init
> annotation themselves. Add it so their memory can be reclaimed after
> init.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index b0ef1e74e98a..51fd2299ec0f 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -509,7 +509,7 @@ static inline __init bool xbc_valid_keyword(char *key)
>  	return *key == '\0';
>  }
>  
> -static char *skip_comment(char *p)
> +static char __init *skip_comment(char *p)

static __init char *skip_comment()

__init attribute is not for char but the function itself.


>  {
>  	char *ret;
>  
> @@ -522,7 +522,7 @@ static char *skip_comment(char *p)
>  	return ret;
>  }
>  
> -static char *skip_spaces_until_newline(char *p)
> +static char __init *skip_spaces_until_newline(char *p)

Ditto.

>  {
>  	while (isspace(*p) && *p != '\n')
>  		p++;
> -- 
> 2.34.1
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
