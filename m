Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0C81C8634;
	Tue, 17 Mar 2026 23:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773788635; cv=none; b=tS9JyaHirbxvn+u3LZX3bqr+cvrM4xv6U0AYgne/N7x75boYZX1aU7b3fOSW0ALjibyTkN/fghLB8yUeEzepHzdUUcOMLfW2t304FClDtUmTd6vO35Q/LVF+o4xVGvXBr0TkFoYXM/3Kw1+hPnVWX9HOu9IBJ4AGJ2cH2yC+dfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773788635; c=relaxed/simple;
	bh=l8TMm98hSSlPEkPc9jfSARg3ix/PUBh4/19yLdPDmdI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gYTjozGshq7qrsY2TdeeRpTZuFQspE7iSUp0YjQArXx2DsIRnRcQNerHG9/Q7Y6QnSo0Qz5rcZFO1TZ70KyX3LDc6KuP9B6uk516DD7VMrOQatHkoTGfs+2f7ZRSuhVEC37J5QMjSit68hBqsyBJbemOtH06fakn8ztfOJ9+ZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QEEo1lJw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QEEo1lJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E8DC4CEF7;
	Tue, 17 Mar 2026 23:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773788635;
	bh=l8TMm98hSSlPEkPc9jfSARg3ix/PUBh4/19yLdPDmdI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QEEo1lJwpliUAIfUaVZtuTeJ6+RhaS7OzAt3Z0TQntvLO/ydMm7e1tiAX1Hhph3qu
	 q12CPQBH53rjzAChQd5ozapAhDputxEUQS7jZ+6RoNZgg+h/toTTrDePVrj8YdOAWp
	 uIFjqX0o+TBEUv5XRpxZIo/hMcf7ll5fgG98dmy8fzBdDj/X9xvGM77vDCI3TuN+nJ
	 JFXDHikWiWuVEe3DVxnAqbkX6anJfQj1gKRpXNH2SVP5HwpA1a4Rvm9VPdK6THRCb1
	 CPfNdToyLd2E4kcRWeCFTrgQTSUK5QIAk82oshmO8BMP9Dz+D9l49DuAft0hSWYn54
	 t+XS/SR91hylw==
Date: Wed, 18 Mar 2026 08:03:51 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4] lib/bootconfig: guard xbc_node_compose_key_after()
 buffer size
Message-Id: <20260318080351.dae637f4b5909bd9f81b27d2@kernel.org>
In-Reply-To: <20260317204403.72375-1-objecting@objecting.org>
References: <20260317204403.72375-1-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Mar 2026 20:44:03 +0000
Josh Law <objecting@objecting.org> wrote:

> xbc_node_compose_key_after() passes a size_t buffer length to
> snprintf(), but snprintf() returns int. Guard against size values above
> INT_MAX before the loop so the existing truncation check can continue to
> compare ret against (int)size safely.
> 
> Add a small WARN_ON_ONCE shim for the tools/bootconfig userspace build
> so the same source continues to build there.

NACK.

Don't do such over engineering effort.

Thanks,

> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> Changes since v3:
>  - Moved the revision history below the --- separator so it does not
>    become part of the git commit.
>  - Added Reviewed-by from Steven Rostedt.
> 
> Changes since v2:
>  - Added a comment explaining the INT_MAX guard.
> 
> Changes since v1:
>  - Removed casting ret to size_t; with the INT_MAX guard, the existing
>    ret >= (int)size check is sufficient, per Steven Rostedt.
>  - Link to v1:
>    https://lore.kernel.org/all/20260317173703.46092-1-objecting@objecting.org/
> 
>  lib/bootconfig.c                            | 8 ++++++++
>  tools/bootconfig/include/linux/bootconfig.h | 5 +++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 96cbe6738ffe..2a54b51dec5c 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -313,6 +313,14 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
>  	if (!node && root)
>  		return -EINVAL;
>  
> +	/*
> +	 * Bootconfig strings never need multi-GB buffers. Reject sizes
> +	 * above INT_MAX so snprintf()'s int return value cannot overflow
> +	 * the truncation check below.
> +	 */
> +	if (WARN_ON_ONCE(size > INT_MAX))
> +		return -EINVAL;
> +
>  	while (--depth >= 0) {
>  		node = xbc_nodes + keys[depth];
>  		ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
> diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
> index 6784296a0692..48383c10e036 100644
> --- a/tools/bootconfig/include/linux/bootconfig.h
> +++ b/tools/bootconfig/include/linux/bootconfig.h
> @@ -8,6 +8,7 @@
>  #include <stdbool.h>
>  #include <ctype.h>
>  #include <errno.h>
> +#include <limits.h>
>  #include <string.h>
>  
>  
> @@ -19,6 +20,10 @@
>  	((cond) ? printf("Internal warning(%s:%d, %s): %s\n",	\
>  			__FILE__, __LINE__, __func__, #cond) : 0)
>  
> +#ifndef WARN_ON_ONCE
> +#define WARN_ON_ONCE(cond)	WARN_ON(cond)
> +#endif
> +
>  #define unlikely(cond)	(cond)
>  
>  /* Copied from lib/string.c */
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
