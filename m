Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB61F1DCB0A;
	Mon,  7 Oct 2024 17:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320970; cv=none; b=jEFaOdvlDdu35n9T/bVZ5Canoj02Czv3p2aqqJD+w5of1/fEyc96lWJu7+bBqvPzWF+ZzAkdqpR3LMJjZtho9ltJ3jp8eU6rqL+FrCA69s2GteQYP5AJYHqYQovANx8sW6q4Ylj6+O614tksEVx7YmdbfTqhj5Rm2Pmzsg6R3yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320970; c=relaxed/simple;
	bh=8QtiTrPq+vnNdTEmG0dB4hPOrEwkXA0yBJnMemaot5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ugs/QvQNq0MJruycSAGLNu6AYTHzqan9S34x5ZejxT6y9r1gswwwlW6sPhb9CSmtDcYgGAde/jUqXgUZ56c1l2omHoezPGFbl8/tdwqKFltraUT2D+kC0Gv3NMEoynRZkk8hP26tNL+imP5VZNGBzZTlvIIX++lZV3GW9n9ulh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=CuWuSpuz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="CuWuSpuz"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DE0F242C0D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728320968; bh=3sv9BCwao8j241sA//vFMAl7XpICVcPJJIxzAhkQeqU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CuWuSpuzhO9pImNXnU2hKa21vpWMMRls+IAH15YxEygb9tiGjxw+nAAP26sPaGanW
	 ecr/mzSNVW/stgLl6YFOgFVPH57F7HAtgyti6fS/a+R09EKADU1bTRPpEz15yKuEtJ
	 //0bkf3VQ1mxO6P2iyQ9ODRjR73YChUI1D1KfLNWPHdpLGoLa7X8yIxhbT2gBBj2A5
	 gkXQ/3m0WBUIgB9rnDOANdcDrhzHWaHoQe64sGUQ56U6fmDy213XdzIf2Qy57qgjeb
	 6cYWH2nwWMePEOdDSJ7S85BQQx5tRCNUD1oGNwNWRgrXb7caLyF8Ouy9LmXaZiwTOL
	 BoXu35BnGYakw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id DE0F242C0D;
	Mon,  7 Oct 2024 17:09:27 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: SurajSonawane2415 <surajsonawane0215@gmail.com>, rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, SurajSonawane2415 <surajsonawane0215@gmail.com>
Subject: Re: [PATCH] docs: fix WARNING document not included in any toctree
In-Reply-To: <20241002195817.22972-1-surajsonawane0215@gmail.com>
References: <20241002195817.22972-1-surajsonawane0215@gmail.com>
Date: Mon, 07 Oct 2024 11:09:27 -0600
Message-ID: <87iku3kfg8.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

SurajSonawane2415 <surajsonawane0215@gmail.com> writes:

> Add debugging.rst to the relevant toctree to fix warning
> about missing documentation inclusion in toctree.
>
> Signed-off-by: SurajSonawane2415 <surajsonawane0215@gmail.com>
> ---
>  Documentation/trace/index.rst | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
> index 0b300901f..2c991dc96 100644
> --- a/Documentation/trace/index.rst
> +++ b/Documentation/trace/index.rst
> @@ -24,6 +24,7 @@ Linux Tracing Technologies
>     histogram
>     histogram-design
>     boottime-trace
> +   debugging
>     hwlat_detector

Applied, thanks.

For future reference, please use your proper name in your signed-off-by
line.

jon
