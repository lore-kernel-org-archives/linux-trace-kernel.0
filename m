Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2502451C0;
	Wed, 11 Dec 2024 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733890141; cv=none; b=V3xGWgp+PO4EuHHeXHIXuFw9t9xb+BfMvP7l2IWhYxC0gSZeo7GWNj4ojn7x+fyQoVZvrSJgMwg7qWbhvxiNVSJFNkK0Qz+AmZ1SqOMVxJo/u0q39QmLNQ56vbPIMBgR/HcmMIjUXmujCkQ0PGAwDxqrOk4m0ORCXWosr7Zgt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733890141; c=relaxed/simple;
	bh=QiMaimw4aRsQbi6cS1aDUySjZuQu274e7bOktDP5CCA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/X3Ewe27OwaQbXq+XdcQS9u3OSgG128e9LG6YwHMJVDxlsG9t6htacDX618cdrbP5hsz8kIiO+2ei7JERUkzCHL3JQ4joPAB51uNqzVmdjRaZIChwQp0s02udtciEVdFbYCnGdrvigpKFLwB+bBC58/NtYpy+GwJVhwJEfjasg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7405AC4CED2;
	Wed, 11 Dec 2024 04:09:00 +0000 (UTC)
Date: Tue, 10 Dec 2024 23:08:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] Documentation/rv: Fix typos
Message-ID: <20241210230859.6b0d93b2@batman.local.home>
In-Reply-To: <20241209130640.10954-1-algonell@gmail.com>
References: <20241209130640.10954-1-algonell@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Dec 2024 15:06:00 +0200
Andrew Kreimer <algonell@gmail.com> wrote:

> There are some typos in the documentation: 'a' -> 'at', missing 'to'.
> Fix them.
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  Documentation/trace/rv/runtime-verification.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
> index dae78dfa7cdc..c700dde9259c 100644
> --- a/Documentation/trace/rv/runtime-verification.rst
> +++ b/Documentation/trace/rv/runtime-verification.rst
> @@ -8,14 +8,14 @@ checking* and *theorem proving*) with a more practical approach for complex
>  systems.
>  
>  Instead of relying on a fine-grained model of a system (e.g., a
> -re-implementation a instruction level), RV works by analyzing the trace of the
> +re-implementation at instruction level), RV works by analyzing the trace of the
>  system's actual execution, comparing it against a formal specification of
>  the system behavior.
>  
>  The main advantage is that RV can give precise information on the runtime
>  behavior of the monitored system, without the pitfalls of developing models
>  that require a re-implementation of the entire system in a modeling language.
> -Moreover, given an efficient monitoring method, it is possible execute an
> +Moreover, given an efficient monitoring method, it is possible to execute an
>  *online* verification of a system, enabling the *reaction* for unexpected
>  events, avoiding, for example, the propagation of a failure on safety-critical
>  systems.

