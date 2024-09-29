Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777A042ABE;
	Sun, 29 Sep 2024 23:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727651733; cv=none; b=nMCKTDDPpSCvRIstitSoXCAJ38p8MfX0gCZo+CkT6UrpJ00zC95PyxRgsPIIDPtvsfqPI9C+2RXgDlfHrqNk/zPGLiROYNGJzvAd+d1gCBI9k9/d/uVtac8eo+MD316dOW3l1HA7P8QT55zY3mJWRD3F3zo5kMPGmUxmyHCPPSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727651733; c=relaxed/simple;
	bh=5/YnzkDO82cf/z8ilaVxj6oqNzucGuM1gwjbcIFtHRQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iqyRF75cWEJlEFv9MvHysxaTFMTFh2zqE7iI11osj74Y44j0OldyoshIIKKv6FhbV23ho7NhFAodjqzpq+cEjyHlshlsMbXvBmCyz7hOvceafvjF3FKILh5QKlr7t51ph+gqaLoDcL+m+JM46kw3z24Mzmar0tU4GK6sUOJm984=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiYz/CWj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiYz/CWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1EBC4CEC5;
	Sun, 29 Sep 2024 23:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727651732;
	bh=5/YnzkDO82cf/z8ilaVxj6oqNzucGuM1gwjbcIFtHRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiYz/CWjJpYEpDcG5rgcJoOu4EaEiyx+CI4Td52FovLiPFYM9H/lCjhbuoY6Ggxb5
	 2Q8QdwZIYkYBro4ZfN40qimk3kknDO14zDq1s4rMkE890/aLwMYlz2u1ntMpr3SeUY
	 8ILaLrxO45csa6rphvPLelqbYKxJCyr5dy7+t5EK2JVaI573W+ziyLTvjjC8go6hiv
	 VK4nzyWDxZ9g+SfE+si4QFxJ9et6jeePF5hPUG/EE3poVq43hpPo4xSFhMWxlrm7qP
	 R5t8xJTrTBIU5oXpWKNNIzkGFYOzkqH4AZSbYH2J34YlMqIhP7ANlvoclCBpX5sW7A
	 9lNIPaY7UbUGg==
Date: Mon, 30 Sep 2024 08:15:29 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Question about config UPROBES and UPROBE_EVENTS
Message-Id: <20240930081529.f6f9161c20db9b95c9b46252@kernel.org>
In-Reply-To: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
References: <1a3567d5-e558-351a-c45d-73b2e5a8788c@loongson.cn>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 14:40:56 +0800
Tiezhu Yang <yangtiezhu@loongson.cn> wrote:

> Hi Masami,
> 
> I am a little confused about config UPROBES and UPROBE_EVENTS.
> Uprobes is the user-space counterpart to kprobes, I want to do
> some small changes:
> 
> (1) since config KPROBES can be selectable, just make config UPROBES
>      selectable too.
> 
> (2) since config KPROBE_EVENTS depends on KPROBES rather than select
>      KPROBES, just make config UPROBE_EVENTS depends on UPROBES rather
>      than select UPROBES.
> 
> Could you please let me know are you OK with the following changes?
> If yes, I will send formal patches later.

Hm, I don't completely reject this idea, but I'm not sure about the benefits
to users and keeping backward compatibility. Especially, the latter one
may hide uprobe_events by default. As you can see, the CONFIG_KPROBES is
enabled by default, thus it does not hide the CONFIG_KPROBE_EVENTS. But
the CONFIG_UPROBES is disabled by default and make CONFIG_UPROBE_EVENTS
depending on it, the uprobe_events menu is hidden. I don't like this.

Thank you,

> 
> -- >8 --
> diff --git a/arch/Kconfig b/arch/Kconfig
> index 975dd22a2dbd..5de2187d3440 100644
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -124,7 +124,8 @@ config KPROBES_ON_FTRACE
>            optimize on top of function tracing.
> 
>   config UPROBES
> -       def_bool n
> +       bool "Uprobes"
> +       default n
>          depends on ARCH_SUPPORTS_UPROBES
>          help
>            Uprobes is the user-space counterpart to kprobes: they
> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 721c3b221048..7db0462a5d11 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -732,10 +732,9 @@ config KPROBE_EVENTS_ON_NOTRACE
> 
>   config UPROBE_EVENTS
>          bool "Enable uprobes-based dynamic events"
> -       depends on ARCH_SUPPORTS_UPROBES
> +       depends on UPROBES
>          depends on MMU
>          depends on PERF_EVENTS
> -       select UPROBES
>          select PROBE_EVENTS
>          select DYNAMIC_EVENTS
>          select TRACING
> 
> Thanks,
> Tiezhu
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
