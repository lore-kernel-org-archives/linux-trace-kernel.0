Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BF82FD1AD;
	Tue, 12 Aug 2025 18:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755024092; cv=none; b=faizlPnV0A+F0w2dLzjQfMz4nLCueC76ghdwZbSs1+ElkhpHbC/iOezDmDcv4ndn/Q3x/Brkglty67rB9T2SXZ2PSWdP/y6gV/XXtBInCuMdRPj0eAuLTsUc4eTidEx9n06ZM5uHS4MbD8j92uAmmrBKCv0qSBVVtKe4KStaAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755024092; c=relaxed/simple;
	bh=m1YFo2pHoa2FnHSf+idfwIE1abFhAZSNl+JJ0+8GLMY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kdRQdL1SLSlLIBmkzsUHIesVamNedMwrDMgb04LWz/r/NQuh9BXTWyLhJy8PJpf5S6Bikf1XX5QdPg51bnpViPsOQ5TxvWd1uFxxXp473J0Qx3bMXyfH0g30KdRGj443E29alnX7+1DxY7+aJ50U6jyQyQoMBvHMoFvqw/PM/tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=bFfug0PV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="bFfug0PV"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2988A40AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755024090; bh=Qz9xyrwA+51NtlPF0l7SMypdEBoz7b93XGGhwSa5h80=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bFfug0PVxFua0jbrjBW4UPzg+ccJSGnn6+athUML9m7e0hD8CCQe29cmaAN8BECrQ
	 hTQJRlXANvyE2p8jbzS55SNYyKJy+ul+wYLUgaYlupx8av/INhoWVs/p6KCwhqmTHY
	 m8RcuHYqZCkAA4McTvJ9kbPGYQQYdzXToDilYjKSwF6rbQHYRH95FfDWoGqgJqHcKP
	 xJcCAgDwsO8tb0vLZoq1EWSkXDZSlYAB8yIHGgSzJkg+jUgN35lBXdayZ8Pg3Nopap
	 sjieId9254wUOsfZuE0VjtVroRPE82OP+yoQBvQTpl22b5V5nX0dQF4dHAtWIk4pvq
	 MkGYo/QeuuhOQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2988A40AD9;
	Tue, 12 Aug 2025 18:41:30 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>, rostedt@goodmis.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
 skhan@linuxfoundation.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] Documentation/rv: Fix minor typo in monitor_synthesis page
In-Reply-To: <20250810111249.93181-1-krishnagopi487@gmail.com>
References: <20250810111249.93181-1-krishnagopi487@gmail.com>
Date: Tue, 12 Aug 2025 12:41:29 -0600
Message-ID: <87zfc4e61y.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gopi Krishna Menon <krishnagopi487@gmail.com> writes:

> Specifically, fix spelling of "practice"
>
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
>  Documentation/trace/rv/monitor_synthesis.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/trace/rv/monitor_synthesis.rst b/Documentation/trace/rv/monitor_synthesis.rst
> index ac808a7554f5..3a7d7b2f6cb6 100644
> --- a/Documentation/trace/rv/monitor_synthesis.rst
> +++ b/Documentation/trace/rv/monitor_synthesis.rst
> @@ -181,7 +181,7 @@ which is the list of atomic propositions present in the LTL specification
>  functions interacting with the Buchi automaton.
>  
>  While generating code, `rvgen` cannot understand the meaning of the atomic
> -propositions. Thus, that task is left for manual work. The recommended pratice
> +propositions. Thus, that task is left for manual work. The recommended practice
>  is adding tracepoints to places where the atomic propositions change; and in the

Applied, thanks.

jon
