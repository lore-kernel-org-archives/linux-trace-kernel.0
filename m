Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45FC302750;
	Wed, 29 Apr 2026 17:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484552; cv=none; b=dYOiKmcJVWUoBPKTPU/m0ODE39Iu/gHZ/V5RhcuktqqY9Egbtny8dvGQY+B/WAy4WqnbdPnawrkmHnbsmcY6EEmMRcrAUI1jxbyhpa0fjNWxi0SuKn3q8rzG+YBtsQ4MLSxV8OuzfVg+wghSrflGlevODCNmRo8Q5rH/g8y0uc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484552; c=relaxed/simple;
	bh=GnQNlE3dLkd5eY5ofU0G0Lz9m7FTkHEbUyzh4lF36ZI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3w8dmIAPVuF5CPvdmfzHBPuqe8ivSbXkIBp7pdSdGoeNLCPQYbUUO8glQI5ixnoLnNqOx5LztcO0QjIqR3PpjF0P2s5gAdJGNfzdlvkZcdykVFxl3bLyHaiFlUDcUIZLLnjpjc4RvLgsi1wFMI+wt/5XQ75F370WGHeOJg4LR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 4328C1B95F8;
	Wed, 29 Apr 2026 17:42:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 859072001E;
	Wed, 29 Apr 2026 17:42:27 +0000 (UTC)
Date: Wed, 29 Apr 2026 13:42:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Qian-Yu Lin <tiffany019230@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] trace_printk: replace _______STR with __UNIQUE_ID(STR)
Message-ID: <20260429134226.49e95e9d@robin>
In-Reply-To: <20260429165707.7020-1-tiffany019230@gmail.com>
References: <20260429165707.7020-1-tiffany019230@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xegnp5oihgq8myp3op38afesg6nqasf9
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 859072001E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19sTfFgLojF2y2IW0Pol4bsqu/lGfU/m0Y=
X-HE-Tag: 1777484547-570017
X-HE-Meta: U2FsdGVkX194Pdo0vy0xgymXnY6teuFRbDlBSWDgAvkvI1zqtojXTef7RmHsFUjw4EkDAhwa4chZrzwUsyzgBCMAuQfFce7qhpPemFu7mGp/qmVBKPQeSd1Kd2G16E4QC2NnkwM1Axv19zOmpMsUop5uTUu2cZ7KYFnY3aCXVliHXkBSolQcv5O+a8twXFEFocAXBLUeNsXFiKRTiPl5Drgl74/tzzdow5HVz9a6OBsgw5KKKgSLz7UOdp/tlS1F1qJgTM29IsTG9BArV9bDtbdvt496PAUAQQfAtqs+IccGIBQTPkYsdwUXpmaq3/9cfiXMEJxrxYNa2p1wRNfOvBStALHsWyWeIPw3idN47GT/uI4xnYrz3rbX2nncjTTo

On Thu, 30 Apr 2026 00:57:07 +0800
Qian-Yu Lin <tiffany019230@gmail.com> wrote:

> The macro trace_printk() uses a hardcoded identifier _______STR
> within a statement expression, which can lead to variable name
> shadowing if a caller happens to use the same name in its scope.

Has this ever been a problem?

> 
> Following the pattern in commit 24ba53017e18 ("rcu: Replace ________p1
> and _________p1 with __UNIQUE_ID(rcu)") and commit 589a9785ee3a
>  ("min/max: remove sparse warnings when they're nested"), replace the
>  hardcoded identifier with __UNIQUE_ID(STR).
> 
> Since __UNIQUE_ID() must be expanded once to remain consistent across
> declaration and sizeof() within the statement expression, introduce a
> nested helper macro ___trace_printk.

Hmm, so we are replacing one name with underscores with another name
with underscores?

> 
> Signed-off-by: Qian-Yu Lin <tiffany019230@gmail.com>
> ---
>  include/linux/trace_printk.h | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
> index 2670ec7f4262..060eccb40838 100644
> --- a/include/linux/trace_printk.h
> +++ b/include/linux/trace_printk.h
> @@ -2,6 +2,7 @@
>  #ifndef _LINUX_TRACE_PRINTK_H
>  #define _LINUX_TRACE_PRINTK_H
>  
> +#include <linux/compiler.h>

People are already saying that trace_printk.h slows down the compile.
Does this add any overhead to the compile?

-- Steve


>  #include <linux/compiler_attributes.h>
>  #include <linux/instruction_pointer.h>
>  #include <linux/stddef.h>
> @@ -84,15 +85,18 @@ do {									\
>   * let gcc optimize the rest.
>   */
>  
> -#define trace_printk(fmt, ...)				\
> +#define ___trace_printk(fmt, str, ...)				\
>  do {							\
> -	char _______STR[] = __stringify((__VA_ARGS__));	\
> -	if (sizeof(_______STR) > 3)			\
> +	char str[] = __stringify((__VA_ARGS__));	\
> +	if (sizeof(str) > 3)			\
>  		do_trace_printk(fmt, ##__VA_ARGS__);	\
>  	else						\
>  		trace_puts(fmt);			\
>  } while (0)
>  
> +#define trace_printk(fmt, ...) \
> +	___trace_printk(fmt, __UNIQUE_ID(str), ##__VA_ARGS__)
> +
>  #define do_trace_printk(fmt, args...)					\
>  do {									\
>  	static const char *trace_printk_fmt __used			\

