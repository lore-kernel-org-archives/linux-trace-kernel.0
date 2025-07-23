Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AAD82FCFF3;
	Wed, 23 Jul 2025 14:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282743; cv=none; b=BtJN0i9M+Yk+6fNS+Oo3MDxsjH+cUK55Dx/YDLbpS02uEED0yRdPCjcG9BRv8JmS50JTapsWD7uRy/554S86rlp3Jm50iYWtdfd83G1LphVQF9Np8jX/XH2I9bD9GUeoUl10lfJy/zvSNWClTpwutH0mYPf6QifyPBIKrlLSNt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282743; c=relaxed/simple;
	bh=QECFCx/gnOTlwaA7wOnGRIffgXsMRQVtjbJIGqUYa38=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=FlZMIDoZgJ0q2bi4Yph+uOQgA1oMyM1CFKeXgbaTsP66Ab673W6t415ruYMqJ6acIvoDWYYi5XBl6gDsVXOKdKjDBYlm8L9TBWKPBN4ApugH+4MNGnLcjUZoicHhUL6F+CbLzSWJ7rkHmd97iNsKXZuWCV+iEzshKtn5pWnlHf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvZJwcUg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvZJwcUg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26858C4CEE7;
	Wed, 23 Jul 2025 14:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282739;
	bh=QECFCx/gnOTlwaA7wOnGRIffgXsMRQVtjbJIGqUYa38=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jvZJwcUgclOAIVZrNZyxr12tZ7oYGvNtUEbsNLAPPDKjfPlNttB2nKvdayEM/XaA4
	 OqJ9EpWz2IVWEAt4CFOJW0AKgWoZybRIRCWa4tBIQOum5qqVOTg1u8yMsF1ZT18vzS
	 4zZNOuyrEx++RYTcRIuQt8UOmxEfyrrEqpovdp021aoBLlhDdenmYdJRFsMPracb+A
	 dRXRj1waot9XKqo8AWCakLnoIgkDj4qV6WKGycqr+jAbVzbCqo5hdRIJxlkl2lpAkB
	 Q4yOYNVLzaSZt6YYQJYACnBL9Klw0eO6MDdJjW+17f2ygepmxqDfII5qs0SkWUABD0
	 s69TovY082PfA==
Date: Wed, 23 Jul 2025 23:58:55 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tools:bootconfig:scripts This file was missing the
 shebang line, so added it
Message-Id: <20250723235855.7e84eb3b5ed67975e1d16ca3@kernel.org>
In-Reply-To: <20250722225351.8811-1-unixbhaskar@gmail.com>
References: <20250722225351.8811-1-unixbhaskar@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Jul 2025 04:23:01 +0530
Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:

> This file was missing the shebang line, so added it.
> 

Good catch :) 

Let me pick this.

Thanks!

> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  tools/bootconfig/scripts/ftrace.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
> index 186eed923041..cc5250c64699 100644
> --- a/tools/bootconfig/scripts/ftrace.sh
> +++ b/tools/bootconfig/scripts/ftrace.sh
> @@ -1,3 +1,4 @@
> +#!/bin/sh
>  # SPDX-License-Identifier: GPL-2.0-only
> 
>  clear_trace() { # reset trace output
> --
> 2.49.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
