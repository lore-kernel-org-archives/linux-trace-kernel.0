Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78C33D564A;
	Thu,  9 Apr 2026 14:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746047; cv=none; b=ZrLOwkqZ8h16GmQzvAjZI/V+oEvZOV79e/hY7G7WG5FtY/A/Kyy/LZUsyJC6c/G7600YWc5YCsjQT+KXLy5F0UoWEf5qHTnpX0GGFUfj2E2TIHHniikpC2V7Dz7lzzyaTBuF7mGcedpZw6Drs0vPITEvhCvt45/LehWvU3qzNWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746047; c=relaxed/simple;
	bh=mBqeoolBpaG9fZBjdRJOOEjKnVG8V8l1ocEkfuhV49k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPrbnrMsinojNRre+TcBdHOtq4pvXs9+aFv6FU94ElkXmypMK1bZIu6Nl4twWta8HJ3SHuDsMsrRZ7Cm18oKePIyX4SE8xfjcD+T4LMCnnXjvYTp/JHuD6gjeAyO9Dxxj8k1eG48uBgomqUQpyY42yBnedOPrxUyluyU0on34MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=ZkfiRUq7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="ZkfiRUq7"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 36B2940B2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1775746035; bh=B6bODqCB5VwJoRo0oo8Rrvy49e2SvQavopGmfSNk4kQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZkfiRUq721tb9JF/3T8g+vJ7Okw6FNFS7l6N0Qab9PhNqc9BkIUVg0DgRUXVi5lsf
	 UIKCpnhSMd52hZcP8sYDD1p4DQrIvNv0UvzSq3QuAcXQ7GxlaX+cO3rkH9EuV6zHOO
	 z3imVNk0l3jCr36vI/lD7xw8+QFMHeBuKbiilgu+7TaD1dYhYVOarO0xo2Q/8TltHl
	 xEQvWbY3dSNlUpGnssaNDLCfpIb5kSZIkZIPcMgdPYiLY+CCELCk2OFm3/jcn3V9eR
	 ZpOpwOaOO2a0Wk7BxKTtBkFqBiQPHtDp/CpZ5YH3sH7Ycf5tLD4VXQqvQqq7J8x2Uq
	 hUPL7jMBLPcVA==
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 36B2940B2D;
	Thu,  9 Apr 2026 14:47:15 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>, linux-doc@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH] tracing: Documentation: Update histogram-design.rst for
 fn() handling
In-Reply-To: <20260305110347.31d6bae5@gandalf.local.home>
References: <20260126181742.03e8f0d5@gandalf.local.home>
 <20260305110347.31d6bae5@gandalf.local.home>
Date: Thu, 09 Apr 2026 08:47:14 -0600
Message-ID: <87bjfsb37x.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> Hi Jon,
>
> Can you take this through your tree?

Somehow it fell through a crack in my inbox, but I have, finally, done
that.  Sorry for the delay.

jon
