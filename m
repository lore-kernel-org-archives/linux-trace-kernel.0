Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A0F1E2312;
	Mon, 21 Apr 2025 16:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745253497; cv=none; b=Eg23auBxUK7mz+17zeXoSnHUPxJ0nock39CfsLJYBzaF3JCF/Y5YFpwfCJQNlMgAlJUUtz3ahc15ZNtGV6mz1GnjQDkNx532tAOBNP/dDbILeJWnm9TRzZi4pkLjyQX1jx8PQra8b9uoCfZGQrhHK/mL5okoD1lQ/+6b7laqgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745253497; c=relaxed/simple;
	bh=EdZDfWaAc1YYAR7hK9LmZmi2LxNyyi+Jyw4ziBwbD5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Gim1IrozOUa8R3cF/2Mo44ozSVblkP7ATawEJNBHJqmgrcw04XWi3WKEJ8Wz+u+zR3UE+rB7BYQ6W5yekMRn28McbjdG/xf/Te42LnHzBF1sJVYmRLO3HYKGABnPk8A4W/+me28FFfyPq7PhYjlaPLV5hVBHzwo+HtuTUikFv7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=pL667kt9; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="pL667kt9"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 77FE741060
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1745253493; bh=4j2nut6FhIwwAYJvOOeNtxESa6jafJ5Qjc4ROU51RFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=pL667kt91ucIOPzVe1YKqPZ/ZUPYvAt0nh9oifqnqEig3QUDnAlWixWm4mpUFYsdd
	 3jmLzgY0GX5hJ4qW7+M/4SmHFXFEpzKTjnZn9DA1E0JvBmDrXuyPuob8t2OLJOLkVw
	 lapmXIkoA3zZ6I8gXAK0CL2LlMM+8wg2TSs57wVQ/oDscXnYHjFNKvKxLij593RHqG
	 ApM0j66EUFeXIz9fImjXW9RfIpjYt3304zribP+fyfpVcWkXQZuzgZghMWtoGGpPd0
	 otBKjtfKASr7c/MKFcf/qwGeAxEpRW0oCexEWyixOpZaLz8JgOp4UYDiGN0y4RobNo
	 9T8PRSpY1NpwQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 77FE741060;
	Mon, 21 Apr 2025 16:38:13 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/2] Table of contents refactoring for tracing docs
In-Reply-To: <20250416024050.19735-1-bagasdotme@gmail.com>
References: <20250416024050.19735-1-bagasdotme@gmail.com>
Date: Mon, 21 Apr 2025 10:38:12 -0600
Message-ID: <877c3dzczv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> Hi,
>
> The trace toctree refactoring series [1] didn't make it through 6.15
> merge window previously, so I forwarded it targeting 6.16 via
> docs-next tree instead.
>
> Enjoy!
>
> Changes since v1 [2]:
>
>   - Remove mention of individual docs' toctree as the generated sidebar
>     toctree don't include them ([patch 1/2])
>   - Move uprobetracer to user-space tracing section (Steven, [patch 2/2])
>
> [1]: https://lore.kernel.org/linux-doc/20250318113230.24950-1-purvayeshi550@gmail.com/T/#u
> [2]: https://lore.kernel.org/linux-doc/20250415034613.21305-1-bagasdotme@gmail.com/
>
> Purva Yeshi (2):
>   Documentation: trace: Reduce toctree depth
>   Documentation: trace: Refactor toctree
>
>  Documentation/trace/index.rst | 98 +++++++++++++++++++++++++++++------
>  1 file changed, 81 insertions(+), 17 deletions(-)

Applied, thanks.

jon
