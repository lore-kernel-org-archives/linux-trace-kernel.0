Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740FB126C17;
	Mon,  3 Aug 2026 05:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785733969; cv=none; b=QS2RIyYNJF8TUw1t9QuIJ1cI2zVmbbFAfc6fmBrv2qyKWHwPrAB609EZKjToerwdITzM7eJLNcCPGOiNWp8A81Kv4ivhSgsRLbhkdU2AdWQninckTAruGSJ8tGGgGwlr3yyNOV3rJbARyr2AAULkRz2X+unt2TkKQJ+XvYG694U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785733969; c=relaxed/simple;
	bh=U50cXcdFuF39Z4ZCHe1T+gw7F2DWBx1+dW/YRpu+Sqc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MlUbI95mHyeKYbo2cx/WmQMZlYfYl7J51y53OHJPdxaub9bTv5GgJbIzuZ949JsIGvpC3Xi6X8t9XwKaKLTTmfX6W11rb9XQmCuWbwdxJ2HqNIsXe/7KpEJw7jrqXsQLQG/MFCNhplDUGSCA/j17JMvNl28L3iZX5KY1haEEm4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QecewONo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QecewONo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3439E1F00A3A;
	Mon,  3 Aug 2026 05:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785733968;
	bh=YcXLau01/GxQVKV99V9hUJQODNODcrjR2nX17z9N6Rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QecewONopJldKm+bs2zPCARR+17DsQ2rDSGrVRIsMNGWU/lZ7OAnXMEfuEv1Gldf+
	 K6EXRGttv1k6YChMpbP/IzhWb9Uiz2NHHnKYAeoa82ph1waTj+i6cxMQ4eb7V0qqY4
	 U+sVFTGbkKGi4ZziGIe3LZAEXxrjcxDxhpbd8ecCtmPSylUBSw8Vhk+yaNezW6bH+g
	 kkS2Sdg4+H8CF8+8pae6voY6Oy4RgWhsk6Mr1WoA4gEcIYAGYU7RvPpVxv5TYki0pd
	 dI33NWxrWTjrkdkerDHTOiRl0LrR+TptG3o1pcnSOeVqO1wYclo9F7gysPCXOcXEud
	 7H/kdyDaMQWPw==
Date: Mon, 3 Aug 2026 14:12:43 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Steven Rostedt <rostedt@goodmis.org>, kernel-janitors@vger.kernel.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: drop unneeded semicolon
Message-Id: <20260803141243.26f277cde804b03f37f2f126@kernel.org>
In-Reply-To: <20260801191002.1383835-6-Julia.Lawall@inria.fr>
References: <20260801191002.1383835-6-Julia.Lawall@inria.fr>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  1 Aug 2026 21:09:52 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> When a function-like macro expands to an expression, that expression
> doesn't need a semicolon after it.  All uses have been verified to
> have their own semicolons.
> 
> This was found using the following Coccinelle semantic patch:
> 
> @r@
> identifier i : script:ocaml() { String.lowercase_ascii i = i };
> expression e;
> @@
> 
> *#define i(...) e;
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> ---
>  kernel/trace/ring_buffer.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 8e2485bb3..7749dd2ac 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -405,11 +405,11 @@ static void free_buffer_page(struct buffer_page *bpage)
>   */
>  #define alloc_cpu_buffer(cpu) (struct ring_buffer_per_cpu *)		\
>  	kzalloc_node(ALIGN(sizeof(struct ring_buffer_per_cpu),		\
> -			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
> +			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu))
>  
>  #define alloc_cpu_page(cpu) (struct buffer_page *)			\
>  	kzalloc_node(ALIGN(sizeof(struct buffer_page),			\
> -			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu));
> +			   cache_line_size()), GFP_KERNEL, cpu_to_node(cpu))
>  
>  static struct buffer_data_page *alloc_cpu_data(int cpu, int order)
>  {
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
