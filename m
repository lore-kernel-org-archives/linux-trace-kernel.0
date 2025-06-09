Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6BA1CF7AF;
	Mon,  9 Jun 2025 20:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749501324; cv=none; b=AspqIJCVcTs3e17MywiBeK7m1Ebjv5cU3TC6eReztcgWpP/ywb0+HjXEIcFo2UosLzdD5CZMUo/9E5B5WQpZo89Chfm72m5GMNP/5bTBJNVfXArsQh3x6Fcm3DejXv4M4soIxBXB3Ldr+jsPaZWKpzHUjtzxYGwlGOOzoSeeuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749501324; c=relaxed/simple;
	bh=/NnDTFdjCFkPmclTl0mdPw1TwCh0WABS5UCtrmC2Qeg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ocBRWoUX85iFNKX8OmYzd8z8CYGEwJMX4Mo4+xDQWISd25cXXaMxaaNPBPv96vY9yypGQTk4IkyLdfARwnYS0xlhXd6xMrZ22PjfrrJFDnFEKAR8FliP+H8Bh7ngEPpdb0kkLY8BwCKkUAlL188fM96R0UYE0HJB5f8gWiLtY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=fGlPmQFf; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="fGlPmQFf"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1417741AA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1749501322; bh=7qoi8FqZUVypp8M///kON6KYM7W4iGgaA0RxKJB6R2w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=fGlPmQFfeDeSpOZkByT/ECiQTKgkGY+hAzU1IpsdK38QOxW8sBUIW962Hq99ixHb5
	 poccqi1mR19UiH7esqX7sasebyj/bIoaA4U4IZPRThLDtrAL5TP+OyRozTau4iS/3N
	 9lADbZaHEdKkYg9zSYQzcjFWo60uudVMfmrdd+8BEm8hSxFZO9m4fgIcP/jzcrx+aw
	 rAI06v8Z1zO3SyONs1exN14AbM8jYszDUQRR+se5W9c7hRMId4qDtJqZedL90THlHG
	 z8GyNHY1VG7fOYBU0lOj/+lWJPLD1kSIOq9kYWHHuA/PV9eGsPjNJnl2I4UP/mf/ZX
	 EJ8Y7JMRMqgXw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1417741AA1;
	Mon,  9 Jun 2025 20:35:22 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Runji Liu <runjiliu.tech@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Runji Liu <runjiliu.tech@gmail.com>
Subject: Re: [PATCH] docs: trace: boottime-trace.rst: fix typo
In-Reply-To: <20250526134046.1042-1-runjiliu.tech@gmail.com>
References: <20250526134046.1042-1-runjiliu.tech@gmail.com>
Date: Mon, 09 Jun 2025 14:35:21 -0600
Message-ID: <87tt4oac1i.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Runji Liu <runjiliu.tech@gmail.com> writes:

> Replace misspelled "eariler" with "earlier" and drop the stray period
> after "example".
>
> Signed-off-by: Runji Liu <runjiliu.tech@gmail.com>
> ---
>  Documentation/trace/boottime-trace.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
