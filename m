Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C914913635C;
	Fri, 21 Mar 2025 16:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742574956; cv=none; b=TnI0oQT9A+DMnRMsvES9AXbrSe3NXJZTXGY8UnD0Q7rlUwGOI71zPnVLJi7XVD7DNDUbDoafMjiYnhu9u5NAU57OXxLO9FWVtyRWP8jLHFoJ1vZ67JZHJzk+cIUu/U1Tkj+0ltx4Mfq70IPcxRiEqgPjKNddTkE5U6C5OD6Yb5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742574956; c=relaxed/simple;
	bh=ILlemZsayEdRfxZ61YOCOgsOyqKPjidLCoD28+dx1t4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5HrCBeAHBEz8WpTw1eZ/ke2oKZd3QWVmBOQx7XJs/ZyyFcK4SuVJLFDl16ZXK5zd8ZwVbY398Pb+B0//Dr4EeBnfx9tIXuJCjWdH+Ec3LNjXeCu+1O78JXCll2f3eNMi6vYmYXtbMVqCVsio7KfNBAXQa41khutpaaOSdycHgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693F2C4CEE3;
	Fri, 21 Mar 2025 16:35:54 +0000 (UTC)
Date: Fri, 21 Mar 2025 12:35:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Vincent Donnefort
 <vdonnefort@google.com>, Huang Yiwei <quic_hyiwei@quicinc.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fix build without CONFIG_MODULES
Message-ID: <20250321123550.31efa14e@batman.local.home>
In-Reply-To: <20250314155052.4170214-1-arnd@kernel.org>
References: <20250314155052.4170214-1-arnd@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Mar 2025 16:50:49 +0100
Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The tracing code fails to build when CONFIG_MODULES is disabled:
> 
> kernel/trace/trace.c: In function 'save_mod':
> kernel/trace/trace.c:6041:45: error: invalid use of undefined type 'struct module'
>  6041 |         entry->mod_addr = (unsigned long)mod->mem[MOD_TEXT].base;
>       |                                             ^~
> 
> The problem here is that 'struct module' is not defined in this configuration.
> 
> Enclose the functions in another #ifdef, just like other parts of this file
> already are.
> 
> Fixes: dca91c1c5468 ("tracing: Have persistent trace instances save module addresses")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Thanks, but Masami already sent one fix where I commented on and he
then sent an update:

  https://lore.kernel.org/all/174188321162.3845006.12665585959241736399.stgit@mhiramat.tok.corp.google.com/

and the update:

  https://lore.kernel.org/all/174230515367.2909896.8132122175220657625.stgit@mhiramat.tok.corp.google.com/

-- Steve
