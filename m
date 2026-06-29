Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CD837E307;
	Mon, 29 Jun 2026 20:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782764801; cv=none; b=duR1habTd4u469j6mdtEVZwrbSL6GjASn6SmAYQlLUFfvQsXAEC7rb+4Ve/rGoKWJmT8D4u+Cqm7ExyPsqVeW1wfybxr5p6vkIlsZTMPvLInn9VKFpTQU9LZLzgkUU5xfq7rbJD4tvF63jPDUj8FPxVRDb64p8IEN0iRXwBJN40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782764801; c=relaxed/simple;
	bh=2I4CbeBLoOMaRweZUOoB48d3KUpXYmlkCSrdXXSTnKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDuyvNnEav+WbI1UiaN9ssdWgPTYOd6MRPS1CmgJ6ha7Auh93a+yCgoebBsq6L+8Lg27fvllOr/2LfAGHBHkrDjC30j/DXOW8E83ruedG2XYdjmXEH8Fqxz2CCWRGAHecz0x9NMOiU1wf03BbtJ+aPIf5z0Dk07tPEAlbTC929k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id F32A5C1610;
	Mon, 29 Jun 2026 20:26:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 28C222F;
	Mon, 29 Jun 2026 20:26:36 +0000 (UTC)
Date: Mon, 29 Jun 2026 16:26:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Michal =?UTF-8?B?S291dG7DvQ==?=
 <mkoutny@suse.com>
Subject: Re: [PATCH 1/2] tracing: Embed 'char comm[16]' in a structure
Message-ID: <20260629162634.0327fa25@robin>
In-Reply-To: <20260626212356.64150-2-david.laight.linux@gmail.com>
References: <20260626212356.64150-1-david.laight.linux@gmail.com>
	<20260626212356.64150-2-david.laight.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 28C222F
X-Stat-Signature: asfmxtygif8gfzcbp94hrkiuohkta1oy
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19u+oZJyJ6U6ijDFvYjl3pLAIlyHLnFybs=
X-HE-Tag: 1782764796-856443
X-HE-Meta: U2FsdGVkX18DWCWU6mEKd13jwtL2BVu17CW5I5jl5/ekpSAMmGD1FdVnJL6XAmYL/n7NViIuozJuYKxRVsxRcKcCoX6DlPswoAY64XcCYHZlh8o9qKdU5o9f2b9URYgXouZOm86THa1p/RvPVly3uZSd68pm54Xd+H4LjyM2y7RHbS8AULMS4BvGFzwQtnsYuqlHHjwWAB5BoViaUPxRUaH28b0+GxIvk1RUwO6+cB5sevbrI7pAKrG4D+KrN0hkuAg1yjXotp9zzHylvzImAlU0ztg8/1RgtsWfVp2p8p8ATZOrM1oRz1dKsCclyrodg2fJ0eeymK6DKTauqcWvhcEkR4sD6WO0Ha2lkckXn2qTBfTk/TzI/QtGP6W/9JkH

On Fri, 26 Jun 2026 22:23:55 +0100
David Laight <david.laight.linux@gmail.com> wrote:

\> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -52,6 +52,7 @@
>  #include <linux/sort.h>
>  #include <linux/io.h> /* vmap_page_range() */
>  #include <linux/fs_context.h>
> +#include <linux/trace_printk.h>

Left over debugging? ;-)

-- Steve
