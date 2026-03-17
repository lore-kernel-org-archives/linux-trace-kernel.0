Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F6D3F8818;
	Tue, 17 Mar 2026 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771198; cv=none; b=SsZPylDiMW7UCazfsQ63IUXB7BfMV+T5KucPHkbDX61eLCOuMlPD2ugEF/C47oKnuc3G/lMKbspsSjZk6Dqa5Gb9I7yhDkS6fn+qh9fB/scqQgWgvidxNX4shCdTzLapS2XKh+t235nnIsErwi70YYPsJadqW1w/M2R8RIAZRT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771198; c=relaxed/simple;
	bh=JhP8heNjoiGJuJV8Awh+eKZym8f4VS/IknNOJBGKH+s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WjF0Vt9RASP1KLE/k6LCxTpy4c0H5I/DcwNNm96Np4CP1TJaJ/O4poFdvjtawQUb+sQiRtHSvIv5qEb1G5FxrklZeDjLpj/fj6wz4K8yolDQUxPbFzIFehXQU2K2ZGlghgIoWEEQUHc7ungwh3wl/FkbarSvSlVDWqkGicwwPfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id AE9721A02F6;
	Tue, 17 Mar 2026 18:13:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 027E820027;
	Tue, 17 Mar 2026 18:13:13 +0000 (UTC)
Date: Tue, 17 Mar 2026 14:13:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Josh Law <objecting@objecting.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/bootconfig: guard xbc_node_compose_key_after()
 buffer size
Message-ID: <20260317141339.36876ce9@gandalf.local.home>
In-Reply-To: <20260317180605.50970-1-objecting@objecting.org>
References: <20260317180605.50970-1-objecting@objecting.org>
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
X-Rspamd-Queue-Id: 027E820027
X-Stat-Signature: k4w7jgpbghrwsynefo7d71wpkacrfh3e
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1956vTZ+VO8IuC/RD/kbCByMLxbSS808xY=
X-HE-Tag: 1773771193-876704
X-HE-Meta: U2FsdGVkX1+/oOaDueWxHLiLnQ28zP/WaczEGPNOA1dMZ2Yll2/cBurNTEn/nGkwSydN7VKXHbeWyYzYxGZWXL8btXUd6UElK0a5kTf9YOYe9YRW8kETdv26O/dcCIJCOATDXhtrkKlacaIAs4e1jJRjEzg7TukHyl5A0K+84kyp6RTHVS/1QXlYQY1Tg+y+2uz5fAH/Mvu6A+MlPoirIU8IsL7u+QlKluYDHQfwDCZMuHknqaBvcZHzQMccLha6tFj+82ryaVPewtQZDXoBaCycQeePrMfMUom2wvYkNTGNLj+cKaZfnfRiomxo/tIax37LE+hy5GHSd+Lpq0WSqNJYb2LJ4bDWyQHIzF8jBLZbZaXOP63YKUR55hXuCXkiKA/VsDNsdEtG2m5gfTfxsg==

On Tue, 17 Mar 2026 18:06:05 +0000
Josh Law <objecting@objecting.org> wrote:

> xbc_node_compose_key_after() passes a size_t buffer length to
> snprintf(), but snprintf() returns int. Guard against size values above
> INT_MAX before the loop so the existing truncation check can continue to
> compare ret against (int)size safely.
> 
> Add a small WARN_ON_ONCE shim for the tools/bootconfig userspace build
> so the same source continues to build there.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---

BTW, you can add here:

Changes since v1: https://lore.kernel.org/all/20260317173703.46092-1-objecting@objecting.org/

- Removed typecasting ret to size_t, as it is not needed (Steven Rostedt)

>  lib/bootconfig.c                            | 3 +++
>  tools/bootconfig/include/linux/bootconfig.h | 5 +++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 96cbe6738ffe..730209c83e62 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -313,6 +313,9 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
>  	if (!node && root)
>  		return -EINVAL;
>  

I wonder if this should have a comment here:

	/*
	 * Greater than 2G isn't needed for the bootconfig. Warn if it is
	 * bigger as to not need to worry about overruns of snprintf()
	 * return value.
	 */

> +	if (WARN_ON_ONCE(size > INT_MAX))
> +		return -EINVAL;
> +

-- Steve

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

