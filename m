Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D3188
	for <linux-trace-kernel@vger.kernel.org>; Wed, 22 Nov 2023 00:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RAfudj74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBAAC433C8;
	Wed, 22 Nov 2023 00:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700611444;
	bh=5oAfyrQ54eQP95rCl5KFP1aGqc2no3aE5cb5/AYs2mY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RAfudj746OLK8bT5EoA0b8TJUszsB11Wrbf856H0urW/Hlz/0v+bl2IElv0nQ0I3a
	 hzt0bDPB/w3pXh3ynlyvXBBJxs4Kn4LY6tnryG8g+zrCYb2k0OTrKDK5IP8SAN6dJW
	 OwpM4yEe6a9/Yh692WViISP/wfle8dJcY7IrMLyJglZ9fuACqW20myLe9KaZ8ZQZfG
	 d1NUquMumhtK89p1i3vt3UweR5/hphaW0N26Bo+YPcLC8vYNSbzXytuX8lezlF7XTD
	 ZJuXjerdCnQv+KCkzwQKM/J1VYLAxLncilqxShybZ4UzVe19z8tKoCbFI1xuQoEETK
	 DQv27B7Gg2XVQ==
Date: Wed, 22 Nov 2023 09:04:00 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: TRACING: Add Mathieu Desnoyers as Reviewer
Message-Id: <20231122090400.b6af7c22775db1f7daa9c45b@kernel.org>
In-Reply-To: <20231115155018.8236-1-mathieu.desnoyers@efficios.com>
References: <20231115155018.8236-1-mathieu.desnoyers@efficios.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 15 Nov 2023 10:50:18 -0500
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> In order to make sure I get CC'd on tracing changes for which my input
> would be relevant, add my name as reviewer of the TRACING subsystem.
> 

Yes, you should be a reviewer for tracing subsystem :) 

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: linux-trace-kernel@vger.kernel.org
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4cc6bf79fdd8..a7c2092d0063 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21622,6 +21622,7 @@ F:	drivers/hwmon/pmbus/tps546d24.c
>  TRACING
>  M:	Steven Rostedt <rostedt@goodmis.org>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
> +R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-trace-kernel@vger.kernel.org
>  S:	Maintained
> -- 
> 2.39.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
