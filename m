Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942F721257E;
	Tue, 17 Mar 2026 00:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773708950; cv=none; b=QeXpToKiMpOyFLLCXU2EBHvw3TTTKvTX93OAWYApNRuvf6+biYt5Ru9NzlAZKGN7eUrUgLhm9OGYVdaihuTrc1bz4cPp7AVrUXCOR9pkbzeRc9Yd/mXqDDl0mfqUaNbhuxH9ntPX8qZA7tvObrWb/aleDbok32UXhvN4dLENKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773708950; c=relaxed/simple;
	bh=sCqe2v24MOgFvbB2MaxHHdh/q91ZomR5Uy07iDyH84s=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mfXpAf5NsL9fdm6dkLdiNAJ+l3EExaA5ewqy42XKa4t2RGBUvd78XgAA3iHYdJXk5dEaVlIfNlv474k9H6D8niJc0TuwnWvYOg4DS7l4wzVgw0jXt3tc++Q8KONnrr6NTNGAHnlN/sClQmbLXbm5PviYGJ1Z5LgWQVdKazuGZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6VE6osQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6VE6osQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68309C19421;
	Tue, 17 Mar 2026 00:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773708950;
	bh=sCqe2v24MOgFvbB2MaxHHdh/q91ZomR5Uy07iDyH84s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o6VE6osQ4SXDseWqCiMRzmYIup8fcl3ylKsz9G9CyQkrk8RJmo0GSlU89OQ1DirbM
	 TOnzgOhzYzb6X27rRzNpr8MqjKWdtpmi8uZhxiUuba8eXqyy3adrG/DeqnupPxOZ8r
	 6PDrozCVG4KLC1v10ImUJwAusdZobvWj/abl+nmDPMwL3UhNUcLYJ6HFvz8NHeE+L7
	 6zg7dppbXqgvsu2U+Rah2xjlS+ID1Vi3Oy+Q/fv8skL6GkVNMyaw6C8M4q4QMGSUdF
	 Fg7nxK0cCrBCjLm90zY8KRhqWv1ZeHLCttrNvInfczYDLh78mqpKMsb6MJPFNdrQUi
	 iP0jx9nc07G1w==
Date: Tue, 17 Mar 2026 09:55:47 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Josh Law <objecting@objecting.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt
 <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v6 14/17] lib/bootconfig: narrow offset type in
 xbc_init_node()
Message-Id: <20260317095547.c245a7a21781766d29558c8a@kernel.org>
In-Reply-To: <20260315122015.55965-15-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
	<20260315122015.55965-15-objecting@objecting.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 12:20:12 +0000
Josh Law <objecting@objecting.org> wrote:

>   lib/bootconfig.c:415:32: warning: conversion to 'long unsigned int'
>   from 'long int' may change the sign of the result [-Wsign-conversion]
> 
> Pointer subtraction yields ptrdiff_t (signed long), which was stored in
> unsigned long.  The offset is immediately checked against XBC_DATA_MAX
> (32767) and then truncated to uint16_t, so unsigned int is sufficient.
> Add an explicit cast on the subtraction to suppress the sign-conversion
> warning.
> 
> Signed-off-by: Josh Law <objecting@objecting.org>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 995c2ec94cbe..7296df003459 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -412,7 +412,7 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
>  
>  static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
>  {
> -	unsigned long offset = data - xbc_data;
> +	unsigned int offset = (unsigned int)(data - xbc_data);
>  
>  	if (WARN_ON(offset >= XBC_DATA_MAX))

OK, then this can be changed to

	long offset = data - xbc_data;

	if (WARN_ON(offset < 0 || offset >= XBC_DATA_MAX))

The original code is to handle data < xbc_data case (in that
case, the offset is over LONG_MAX, so offset >= XBC_DATA_MAX
is also true.) Note that this is for catching broken pointer
to find program bug (WARN_ON is used for such case).

Thank you,

>  		return -EINVAL;
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
