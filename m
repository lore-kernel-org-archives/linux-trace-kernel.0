Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B979538C422;
	Thu, 12 Mar 2026 21:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349750; cv=none; b=E3tV5UfXD+jOvcSJGB12UbbmW4oqfXQd2hvgWZgyrD8DuSbhfu6Ar6aIa9znQy8iazwCuFXTaHigtfDWRjM1HrftJPF4D+7v2qjkCRWFAXUVVoWZxYgv51rb1wWIB5A3kncnzKyF1wHKDsBKVKbu1125JNeq5eInt/QKGu/Wfcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349750; c=relaxed/simple;
	bh=RvRLlzwS5bXbjnFR5ttMdTC6WjslB7Xx0Q1MQqUJNM0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRM9L1I9s8eYXlItqGP/LkK3+H3s0LkMC+yz/h2QTIlnEff/3hLsYdNXCQMX71osn1Xz+irSx2KnJv+4pUq71reqI9YAC5y78Ogk/p3Zv/sUWEXJNpfFmXqRIli8RFLEW1Smg3tT3FMjk6973kHgPJ7/QUm7G3QvRCyECsTF0ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 6E0EA1B7ECE;
	Thu, 12 Mar 2026 21:09:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id A829330;
	Thu, 12 Mar 2026 21:09:04 +0000 (UTC)
Date: Thu, 12 Mar 2026 17:09:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Law <hlcj1234567@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Josh Law <objecting@objecting.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] lib/bootconfig: fix snprintf truncation check in
 xbc_node_compose_key_after()
Message-ID: <20260312170919.6eda3a75@gandalf.local.home>
In-Reply-To: <20260312191143.28719-4-objecting@objecting.org>
References: <20260312191143.28719-1-objecting@objecting.org>
	<20260312191143.28719-4-objecting@objecting.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A829330
X-Stat-Signature: qrjegww8s1nrrzx3wriqk8eyax35iijk
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/MHWsWlFmNE87fdQ/I5SXFtquiqzJjC48=
X-HE-Tag: 1773349744-276432
X-HE-Meta: U2FsdGVkX1/IgwnPk1y7FGaSZOYFo7DqtDFqzGl75VWASbRy0otPc91oPG072JePWzEVx7y9pqHaAoKxBSnel5watjbL0AIGQJSUtDxx8kBUkhg48SjPsz+Hx0FD0zxZvKDDhR7AerjCcXcj9nMSmTg+75BiDV0niA6lLuWWBB0fRLg7oPs1/hpTWGx0VP+gPshELl9WEZouiJmPdZlI52hPJMWhZdIioxy4uebsRMW0Gax/QG1bjJLBQG3a+++b0JYugohgaGrjryhQj7cipWQiwfRg8qEyEhYLtrtkSO1SWHSITtHbf3W2FlR9c8DzCZwUd2dYG8IINlavNx2LFFLr9BNghV9dUUgYKK8xOqeC1zBImsCbktizAt2z2s5vsTCPp+4KRsPMNVNegfLHZsqqx7gjN86ZbaGdx03A5Afa35ThI5Ddy6JPqbPd/RqoKil1MvHPWZk0rSvooB8qdA==

On Thu, 12 Mar 2026 19:11:43 +0000
Josh Law <hlcj1234567@gmail.com> wrote:

> From: Josh Law <objecting@objecting.org>
> 
> snprintf() returns the number of characters that would have been
> written excluding the NUL terminator.  Output is truncated when the
> return value is >= the buffer size, not just > the buffer size.
> 
> When ret == size, the current code takes the non-truncated path,
> advancing buf by ret and reducing size to 0.  This is wrong because
> the output was actually truncated (the last character was replaced by
> NUL).  Fix by using >= so the truncation path is taken correctly.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 62b4ed7a0ba6..b0ef1e74e98a 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -316,7 +316,7 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
>  			       depth ? "." : "");
>  		if (ret < 0)
>  			return ret;
> -		if (ret > size) {
> +		if (ret >= size) {
>  			size = 0;
>  		} else {
>  			size -= ret;

