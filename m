Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7669A34BA53;
	Thu, 18 Sep 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219657; cv=none; b=Y6QFJ7W0axNHdpRD+1qOatfQr1TQQu0vpgk2w0P3Ws6ZCir/IL95Ddn5zKNfv3sSNt8cS7mNDbJ+rS+FxrgHIJaSIdAtHzk1KbXCYTreZoRJzsbM1yW4E/24Mi0LD8qEouowfHKkrgyLOYnpbYLaTkvbsO9rwmsNOv6Ttqx4CbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219657; c=relaxed/simple;
	bh=1uyYpaAqpKBLNg1Z0PaUZjOwJuwW+urmuFhvuTSAuuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LY5dr8nMnLHl4auOaTmKJ4QVcvLHCQ0/eGdGuxlhqbVYI/KRLk7hHG+/nFj4w06xk+98UE5PtiFc/aRmmoLMRseOZB5nfBbgQ3E5qHiOrILLlYyx0SjPljNKM/cuz8dTnTDno9+FGr/xXnZsfuhnw0+cm8Q/ZG5FUhg5DFxq8tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=iwppwDwo; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="iwppwDwo"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net A2F0A406FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1758219654; bh=1uyYpaAqpKBLNg1Z0PaUZjOwJuwW+urmuFhvuTSAuuI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=iwppwDwoKBd4AzCFIyHhExSmNIM5C5Ucg7eUcoDFD6Z3hXuPH5pWfXFfYTvjUBxOk
	 ZOSCwoiihFscX/yVRNfgCv7NQoqQxvXQUfUalvWO+StWKpJblv8i+5wHIUT+k94oT8
	 VeYnsHmEoAmAvlRUZR8iiYLkucLO7x7Cb+7Cux+sb/qPO3ekN/Z201mucrOmaf8WqV
	 /xAvxNHQvUSp1qJtXrpMc6f59hGn+hvmDf0CELzsBPJrMtv3o/FQ1SqkcpN0mm433Q
	 F7UVgMFBNSMZWUCqzkeILPCIaOGCqm/qzSBCsakUnHgg7Qu0vtHelBnbtylxZn2G5Z
	 3eO37Dpaodw/Q==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id A2F0A406FA;
	Thu, 18 Sep 2025 18:20:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Documentation
 <linux-doc@vger.kernel.org>, Linux Kernel Tracing
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Tom Zanussi <zanussi@kernel.org>
Subject: Re: [PATCH v2 0/5] Histogram docs formatting cleanup
In-Reply-To: <20250918130519.06294a16@batman.local.home>
References: <20250916054202.582074-2-bagasdotme@gmail.com>
 <871po390m7.fsf@trenco.lwn.net>
 <20250918130519.06294a16@batman.local.home>
Date: Thu, 18 Sep 2025 12:20:53 -0600
Message-ID: <87h5wz7hbu.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 18 Sep 2025 10:38:56 -0600
> Jonathan Corbet <corbet@lwn.net> wrote:
>
>> Steve, will you pick these up, or should I grab them?
>
> Can you take them?
>
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> Thanks!

Done.

jon
