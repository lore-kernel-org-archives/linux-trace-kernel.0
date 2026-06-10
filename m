Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DEB385D69;
	Wed, 10 Jun 2026 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079464; cv=none; b=Pn7HzVhqetHD/HezLMac1GqUW1R6f51AjsQcsIrz1rG/UmJyEHNnoSU9gEtPnoCwi+m6ODItZ1FCjjh8ocSDQeCxyTswb0BKgkpHI+/fDv7tMhGWz199UfQ3YbknI/EHC8WWb0LOrFkiJCjS2QZYbhmUVSpwjqawEsAs8rs89uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079464; c=relaxed/simple;
	bh=zIEEMQ53Vbwmwti8t+9WWQEvBfbMa7h4mHZ7DCV7yXQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BL0FX6AelQxD2ukputfFpjK/rpe25EcBJMQ/nE3rTQbXbU23/fX28mAG95HnU3GtMKmfbhUSdmDBY4rKC0nW0yLzmPvdFF014VO8QqF/5G6MoKTcNMjjJPNdqTE3HnFfQSe3jraLn14VVR5E0tPwdmNUce0qYyqTck7lskRsiEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXrnJinG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXrnJinG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308041F00893;
	Wed, 10 Jun 2026 08:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781079463;
	bh=sBN42bZ4vnTN1lTAOH17o8IauQAyyLgIKkq1IqkXyPA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fXrnJinGxds0QM/O0gaIqu3xa0x5ysNSxav1shpMTKcMVlMMaa/r3W5hmIRib/3cS
	 ksKfUgj6KpEhYfDUyTT/f6qPcRS1HUhXXD5D9ysI1wBgeLHn1/gB4l2otOaGkcPUXb
	 yAAbu+nWwYSOQyrV6zlUFvZ6AMfqtJHNDyrDcdfluQpUsPaww/olT8NOazpEOrsZME
	 tBs1195QhN0U1mSkRJDZ+WFOQ55J7Hx0uRQT4XKVPValPbPoksdT72pJdfpSX/NCgd
	 dISTEQ/zUQ3OdiB7hNPFb9OULtPzSsxwTRRs+tgn2eDjU9E0HPfC8kvucCEKwpSuLF
	 zLUp8bN+rX57Q==
Date: Wed, 10 Jun 2026 17:17:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Heiko Carstens <hca@linux.ibm.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: fprobe: Remove __packed from generic
 __fprobe_header
Message-Id: <20260610171740.c30c43c5faee0beac3ad7546@kernel.org>
In-Reply-To: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
References: <20260428-topic-fprobe-packed-v7-1-v1-1-9abc9b866b4c@baylibre.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Markus,

Thanks for ping me.

On Tue, 28 Apr 2026 10:30:29 +0200
"Markus Schneider-Pargmann (The Capable Hub)" <msp@baylibre.com> wrote:

> fp pointer and unsigned long have the same size on all relevant
> architectures that build Linux. Furthermore this struct is only used in
> architectures that do not set ARCH_DEFINE_ENCODE_FPROBE_HEADER which is
> set only for 64bit architectures (apart from LoongArch).
> 
> Both fields are aligned on these architectures so the struct with
> __packed and without it are the same.
> 
> Remove the __packed as it is unnecessary.
> 
> Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")

NOTE: This is not a Fix, but just cleanup or minor update. Or, you have
any problem with this __packed attribute?

Unless there is no problem (or any concern), I would like to keep this
as it is.

Thank you,

> Signed-off-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
> ---
>  kernel/trace/fprobe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index cc49ebd2a773..21751dcdb7b9 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -181,7 +181,7 @@ static inline void read_fprobe_header(unsigned long *stack,
>  struct __fprobe_header {
>  	struct fprobe *fp;
>  	unsigned long size_words;
> -} __packed;
> +};
>  
>  #define FPROBE_HEADER_SIZE_IN_LONG	SIZE_IN_LONG(sizeof(struct __fprobe_header))
>  
> 
> ---
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
> change-id: 20260427-topic-fprobe-packed-v7-1-f44f9bbdedf6
> 
> Best regards,
> --  
> Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
