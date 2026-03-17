Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C07344D91;
	Tue, 17 Mar 2026 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773779842; cv=none; b=qqDpOSIyreIKl7W4CEKuR5L5Ua2POyu2KjEGXRNL9zZAGMN1kGjAQ+YeAuwXCfYgF0psxKQKDgWKohxPWLUm4YgjHDG/AX7VCNhH+DxOMAhJx3378qQcLB99Wljyl6GXJtpQd8e4iTriHSohjXgcPDRQxdidQ/hIrCVDVZoDN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773779842; c=relaxed/simple;
	bh=evwv/GBM7IyoQ345IoREJIKvgaHEPvIT2C53V6XAwnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WezgQ++BRJ9ssF/1qPKqYILpTlUxIYEb7P/hAJAzKsv7vEXO1TOjbn9/72YAYqP+d/+9M8ZKe6trXl3gHCRNyrI9lmT2Hy0dt6lhzq4VOAn2JEmh2v9UWA2tvne3jpSUNyEUxyqEU3HPRD/d0/J6UP3DWiof7FvOSXlCtA2HgvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C19C413A948;
	Tue, 17 Mar 2026 20:37:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 19D5A20027;
	Tue, 17 Mar 2026 20:37:12 +0000 (UTC)
Date: Tue, 17 Mar 2026 16:37:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Law <objecting@objecting.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lib/bootconfig: guard xbc_node_compose_key_after()
 buffer size
Message-ID: <20260317163738.3a7863dd@gandalf.local.home>
In-Reply-To: <20260317181556.53417-1-objecting@objecting.org>
References: <20260317181556.53417-1-objecting@objecting.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 19D5A20027
X-Stat-Signature: 8pjc34iug9iueyeagkzo51d5cufuij3u
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19aukN4RZQouCr9Y9Y1sV8jQTXY/oqy0Lc=
X-HE-Tag: 1773779832-942121
X-HE-Meta: U2FsdGVkX18TfMTSlbs8X4Av5D58WLhL0HHa8Qt5fqj+p0+gC4rj6L82qTNfbH/YkfMS9KTBp+7TRv2+rvgFFBbCxkI0CUkyHEMpGUbi08JV+cVl3uPg3WroDu+TSCvxnTx8Oyoov7m6gsIwuSiEEIpOVlm3Z3Wg7ESUqvLaZ/1taILasPMHLhYDs6xaOkoYCgVwH25wslqDTxcRmDeD3vnjJGcZhnN8O6rgXIrh4devvgKQE4vIEA5rpFwo6H0a0h16ohMAlTvsJt8fssBsfwjRoSgrq9WaIUigu0L5C+Ux1p7Gf+WLyOGCEbYn2iUg/yQ6pnmAAj78exKT95ggL8LW8ZzEJ1PpmH+aqu2Rs3zFQBX61PnzsB0du964vmVan2R0lvWWel9V8rjWQ0xV/evN6ptET+uQ5X9XShnNud8UZ38BxEw9oRxBuUb6DylJD/Ndd3SexL9glLuA+v+B5w==

On Tue, 17 Mar 2026 18:15:56 +0000
Josh Law <objecting@objecting.org> wrote:

> xbc_node_compose_key_after() passes a size_t buffer length to
> snprintf(), but snprintf() returns int. Guard against size values above
> INT_MAX before the loop so the existing truncation check can continue to
> compare ret against (int)size safely.
> 
> Add a small WARN_ON_ONCE shim for the tools/bootconfig userspace build
> so the same source continues to build there.
> 
> Changes since v2:
>  - Added a comment explaining the INT_MAX guard.
> 
> Changes since v1:
>  - Removed casting ret to size_t; with the INT_MAX guard, the existing
>    ret >= (int)size check is sufficient, per Steven Rostedt.
>  - Link to v1:
>    https://lore.kernel.org/all/20260317173703.46092-1-objecting@objecting.org/

The changes need to be below the '---' so that they don't get pulled into
the git commit.

> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---

  <here>

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

Other than that.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
