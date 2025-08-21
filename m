Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED1E341672;
	Thu, 21 Aug 2025 17:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755799165; cv=none; b=KGwwwkC+g6lKRiU3pCRDIvLzrqQLA0rO+BO3qOpncB4N5k0yIUzHFuvlcuqQEnEuOY0V0P5Qq0f2eiE4ZXq1mq1MAzGTotMi4xJTWtuSVTNeqkh0Ut47Xm8qU8M36v13zoZc+Jip0wE17FQkOuAHNYoCXdjYnNTLhMecnmA6f4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755799165; c=relaxed/simple;
	bh=QyvN0chavbF7pHok0nk/fd8jnLoH9sTCzcEOhaPLj2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wyrl4pVXY9vyBnqaUWLU4qYcLk9xxl5Fo1/IEe7TN2gepW+ge3W7E0XG06hgZpi/T4qiOszM5Te/JKqOk4dwXgO/8tb70LV6EArOB6RMPk/4dn/fKO6jS/A19EFl0UYHd27Nnp51Ws5aSXo1cpfp2Cd25SqO2OTJZ66+GWdwPLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=A0UoMTOD; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="A0UoMTOD"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D699A40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755799163; bh=CJCSwL0zZ8uZbHkPUOPzTdq4BfEPTqZpTH09dUEDAqE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=A0UoMTODod0NJhM7kPsgHwqFd8QubuK2DFfPq9tEtVGyJLZ8m8CkhLXCsmDonfCph
	 rYL05V68W7NdAGGYnW0QajDabQohYGWtl+6OsbLUWn9WmP9jrax+zg2mXCf02S5eQs
	 E+dYpWtmnvZtOtRiNYx4WHKN37cl+0RxNnfCK+j2xntdR6yxkfS3GnE9Apyj6e+q0D
	 l+/27rRT1U6hoZGy8sfHUhil5bLTTfFMI4/RfkX8X2HttOkt7g+yxSPueh5VzzoCU7
	 cgNazUzQVxiFilXfmfngZVTbI9BcwIy24Um+gy/gWwrYvWyONTAvwfAx407hOxi4JA
	 Eqeojr569XB8Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D699A40AB4;
	Thu, 21 Aug 2025 17:59:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
 linux-doc@vger.kernel.org, skhan@linuxfoundation.org,
 linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com
Cc: linux-kernel-mentees@lists.linuxfoundation.org, mhiramat@kernel.org,
 rostedt@goodmis.org, Mehdi Ben Hadj Khelifa
 <mehdi.benhadjkhelifa@gmail.com>
Subject: Re: [PATCH] docs: Corrected typo in trace/events
In-Reply-To: <20250819085040.974388-1-mehdi.benhadjkhelifa@gmail.com>
References: <20250819085040.974388-1-mehdi.benhadjkhelifa@gmail.com>
Date: Thu, 21 Aug 2025 11:59:21 -0600
Message-ID: <87bjo87dza.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com> writes:

> -Changed 'Dyamically' to 'Dynamically' in trace/events.rst
>
> under sections 7.1 and 7.3
>
> Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
> ---
>  Documentation/trace/events.rst | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index 2d88a2acacc0..18d112963dec 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -629,8 +629,8 @@ following:
>    - tracing synthetic events from in-kernel code
>    - the low-level "dynevent_cmd" API
>  
> -7.1 Dyamically creating synthetic event definitions
> ----------------------------------------------------
> +7.1 Dynamically creating synthetic event definitions
> +----------------------------------------------------
>  
>  There are a couple ways to create a new synthetic event from a kernel
>  module or other kernel code.
> @@ -944,8 +944,8 @@ Note that synth_event_trace_end() must be called at the end regardless
>  of whether any of the add calls failed (say due to a bad field name
>  being passed in).
>  
> -7.3 Dyamically creating kprobe and kretprobe event definitions
> ---------------------------------------------------------------
> +7.3 Dynamically creating kprobe and kretprobe event definitions
> +---------------------------------------------------------------
>  
Applied, thanks.

jon
