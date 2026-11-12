Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794444529;
	b=I9aK0n0WXjk9xxRK0EtZcbmJJu4y0dS0lsIvhbUZQBAb6G0LOkeLbd/Isdn6/aClrT6q
	 Aj7Grgy7LIRqWIsfxM7yLmcS579iuSRECSau9JQz3Fr0PPTtd69ULMGGM4/qnsi6QxTYJ
	 z91p6M/CL2TcH6pLqt/ed96TW8D2AIBvAzAbeIkBOvtb8fJhQXciRNNvWWolkN4xrivoS
	 3DQ0V0T8nb/axSlD63XcAaWC7pGC6H0OdeLh6AgwfnZLF9Ou3Xo3Ltd6Ea/EvoC37Olyl
	 TA6D0BfZ82iiSC5dx7DB7Jod+oDbHi/kk+Jz4100x2iemNSnMc20MDvrmS3wSxmftjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794444529;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1zyXYhT4ZOjKHFljY1yybFov03hN4yF4aUJ996zXCJ4=;
	b=HKTGRID99Lq2ogVVvieyttAY3tKXjuvFvCSsp6fGyovhQvPnYDBg4R5+L4BtA/Yq6Rqc
	 JBVNDaSqDLosC7MdKd9zie+4Xga+K/b53IxgUaVxqBSms/FkNSKyKjWwMzTfq6/K0uH2O
	 s1sDTtd0IpF/VqbpBvMSCBOIN1l1lq+xJ+MjgYvl8XanB6GkRjZ2sHJtbN9WRFfY8mCXY
	 uAgCcDZAo+iaB4O537ZgcFmM35XJEncw12HhJSnrt/emihTA0uMm2HxxBfM4+Cknronr8
	 ZqXAug1wTsU08GdsCf91ep9Zr609JSk819Fu1aoOTcxTIk+d2ayuqH5gkbSpH3b7rTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+JHv7OI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC69606A33C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m+JHv7OI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3611F00A05;
	Thu, 12 Nov 2026 00:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794444528;
	bh=1zyXYhT4ZOjKHFljY1yybFov03hN4yF4aUJ996zXCJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m+JHv7OIeAbAAse7E20Hi0qCd2GSgf5mattKcaMGhM8+wdKo4BzRY/e3TFbkmtepn
	 Y8DBx0bndD6l9nbiU4iVK8BZOKH//GpZwK2qF5B4oBVovMSbUtoc4H0j6mvVtEQZ1e
	 yySOBEQU41eSIC9EG2qYVkYrvFKnLQf61LIpt38VGdUEgTzyKBqFiP+5trYl5Zwal2
	 e3zmgZGTjAlmTXNSvmlbnfmWXia92mUpF8GCxwMUkG6T+2ywiuPTBk57yRRipJ/kEw
	 O/mS29QlY2h8eR8lTX9jxwRiuvx0ZA40DwOc14gO3Z2j1NgzqjwGw8H19gFyltjWyZ
	 7HghHgZ1nAD6Q==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: sashiko-bot@kernel.org
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] tracing/probes: Propagate error codes in eprobe and fprobe creation
Date: Thu, 12 Nov 2026 09:48:46 +0900
Message-ID: <undine-1794444526180508856-8b12d389a453b4cc@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <sashiko-outbox-204255@kernel.org>
References: <179418408457.227715.1485179201014819821.stgit@devnote2> <179418419198.227715.15433232608137637935.stgit@devnote2> <sashiko-outbox-204255@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Mon, 09 Nov 2026 00:46:05 +0000, sashiko-bot@kernel.org <sashiko-bot@kernel.org> wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue to consider:
> - [Low] tracing/probes: missing Fixes trailers for overwritten error
>   codes
> --
> 
> commit 435aff670b6c20ffbcde000e1c0b092b53b663a8
> Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> > tracing/probes: Propagate error codes in eprobe and fprobe creation
> >
> > In __trace_eprobe_create() and trace_fprobe_create_internal(), error
> > codes returned by helper and registration functions (such as -ENOMEM or
> > -EEXIST) are overwritten with -EINVAL.
> >
> > Propagate the actual error codes to the caller.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> [Severity: Low]
> Since this fixes overwritten error codes in __trace_eprobe_create() and
> trace_fprobe_create_internal(), should it include the following Fixes:
> tags?
> 
>   Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
>   Fixes: 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is a return event by $retval")
>   Fixes: 8275637215bd ("tracing: Adopt __free() and guard() for trace_fprobe.c")

OK, I think this is a kind of improvement because anyway it returns an
error with error log.

Thanks,

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/179418408457.227715.1485179201014819821.stgit@devnote2?part=12
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
