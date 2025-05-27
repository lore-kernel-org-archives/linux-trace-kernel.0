Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D2A126C02;
	Tue, 27 May 2025 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354449; cv=none; b=Xu6XVa326qRwtEx18/bg9YyIlCItfnb+yS4L1Ku2Bzqlf5lDPtOOGaWl774W+l+PVPwjnsD5VBSb7YRKgBn4U+QCbL3c3TqStKfo7MbbemWqO0JKqxIshvSlAmhUcFRReun8M1Ny6zp5zPLZcALLI0Q2AovarNu7zr7pNLfeUR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354449; c=relaxed/simple;
	bh=4oU+gJtv7JS0pDGXHWNzGUoOkFjODoRsk1FV5X827V4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YH2hnQiJ8R9jSi+zQliuXqHum340FiEddnNNTNdpZMyzfjo56hz1MwyvRnMEFzpW5pwBScf2G1lHkHPsz0QwZ7JWKDohm3p9HA2E26qvd0AzHxg/aBh4Eh9aqwvKC8p83ekp4drRKtZZFCpRmh2BKTrJJTobxMPE3ZBqbeRUeAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB38AC4CEE9;
	Tue, 27 May 2025 14:00:47 +0000 (UTC)
Date: Tue, 27 May 2025 10:01:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Runji Liu <runjiliu.tech@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: trace: boottime-trace.rst: fix typo
Message-ID: <20250527100145.1e974c21@gandalf.local.home>
In-Reply-To: <20250526134046.1042-1-runjiliu.tech@gmail.com>
References: <20250526134046.1042-1-runjiliu.tech@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 May 2025 21:40:46 +0800
Runji Liu <runjiliu.tech@gmail.com> wrote:

> Replace misspelled "eariler" with "earlier" and drop the stray period
> after "example".
> 
> Signed-off-by: Runji Liu <runjiliu.tech@gmail.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  Documentation/trace/boottime-trace.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/boottime-trace.rst b/Documentation/trace/boottime-trace.rst
> index d594597201fd..3efac10adb36 100644
> --- a/Documentation/trace/boottime-trace.rst
> +++ b/Documentation/trace/boottime-trace.rst
> @@ -198,8 +198,8 @@ Most of the subsystems and architecture dependent drivers will be initialized
>  after that (arch_initcall or subsys_initcall). Thus, you can trace those with
>  boot-time tracing.
>  If you want to trace events before core_initcall, you can use the options
> -starting with ``kernel``. Some of them will be enabled eariler than the initcall
> -processing (for example,. ``kernel.ftrace=function`` and ``kernel.trace_event``
> +starting with ``kernel``. Some of them will be enabled earlier than the initcall
> +processing (for example, ``kernel.ftrace=function`` and ``kernel.trace_event``
>  will start before the initcall.)
>  
>  

