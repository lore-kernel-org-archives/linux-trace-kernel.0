Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551129CFE;
	Tue,  7 May 2024 14:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715090450; cv=none; b=SWxtzBkR+3h2T6GS/glpi1z8KWnEQ7JXMYnGE2KjAb1lChTyjjc8iNGLoHtNagCX5HdRWb1yNKw1B/xorQwG0angscmV+8Ikocm8qfz/lZIJsVUwdHsBXzviEqMm+FnaVFdNoFVfVMULWv2ADMUsW3kG5ubS8K5h73uBIwvaT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715090450; c=relaxed/simple;
	bh=WLATgfjM1pgw+mH4HNiEcyXSQ/A0N59wyznIiC0EcKY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qWkmjOjIb9tiE0iV8+3WWkbiPZmtR/0awIKK8UaP2Xu/61s/vHVc/7R7YHNLImGFITQPPIkjSafC2fQyAp6nbmyGaEYnDCQu2Xc5UCSmptovQaGHx7Yzmi8CQJl0ZP3irQkXv3dIcG/qX+dqEAZqcISE9Iqawoy/FmB6waBtTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=PorkDEb1; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="PorkDEb1"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 157B247C32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1715090442; bh=ZFy3ZvIDrVlfpMY8020FpW1aYPWVe03uD8xoVvbmYbk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=PorkDEb1m5SLntV0q2Q/b1R07BxCw2Oou7hd+zi945orA/8wIFDztLfwJroDOm6i2
	 h6S4wsvLYoMT5rNT4dL8BA+VhP3sAXA9Mt1Qc7n5sglNuzPP0j3wIzOyRy6uSX8pYr
	 llO0yxhEid9Tu8YjkiWHqJ1t/1XMJZ71NsBMoL62naIn8SViz+gTCPzvHzW61TA7MA
	 tT75jrHRkSJgplFGZsmIzlTUWs6acg8gZC4Kqcubv50VvjOjLck4i+UYoU8Kh+qOct
	 93ncRGNqy3fIKu8zBNdGSd7jeUpU+4mW7M2420Li2HbygDyUvViWwDaZT6sZv77w+d
	 wngw36rDTr6dA==
Received: from localhost (unknown [IPv6:2601:280:5e00:625:67c:16ff:fe81:5f9b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 157B247C32;
	Tue,  7 May 2024 14:00:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Saurav Shah <sauravshah.31@gmail.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mark.rutland@arm.com
Cc: Saurav Shah <sauravshah.31@gmail.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: tracing: Fix spelling mistakes
In-Reply-To: <20240501233659.25441-1-sauravshah.31@gmail.com>
References: <20240501233659.25441-1-sauravshah.31@gmail.com>
Date: Tue, 07 May 2024 08:00:41 -0600
Message-ID: <874jb9hgc6.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Saurav Shah <sauravshah.31@gmail.com> writes:

> Fix spelling mistakes in the documentation.
>
> Signed-off-by: Saurav Shah <sauravshah.31@gmail.com>
> ---
>  Documentation/trace/fprobetrace.rst | 4 ++--
>  Documentation/trace/ftrace.rst      | 2 +-
>  Documentation/trace/kprobetrace.rst | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

jon
