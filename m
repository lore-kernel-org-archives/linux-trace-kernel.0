Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF126EEA8;
	Sat, 19 Jul 2025 04:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752899743; cv=none; b=aiZDRsjavLxb+T2AbiOrij9FSWVWIzxqTQ8xlHfFIW6bM0Mi0TiFxviB4q9NkupLWYAapk2nR2/c5opTcWwp3N95y6BGNjuqq6+PQn5r5u0BtDdW68KhGjEImc4v4mLxPa5M54KWutVbFHaXH/yMjkAsLXqHLjvY23JU0EPZstI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752899743; c=relaxed/simple;
	bh=4R4pb5oijYWaS7DBGG9pgvNAm0MO0W1G15IlWB4af4M=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RTXaI5kbsgLZKj1UbLlaBY1641ZIBpAu1OdgQE3sTH9wVAp+NwlsGO/eHtAm2/aGXv56Y/qfkvXRtk0DRtoLbQim9vziTdBXCz2NqBFkQaceX/Xsd+OESybtyRnGxe/UMzl0bCsue+KleK48rtBERc2rtq8ytf4Zx4leGwIEAXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca5jIUgA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca5jIUgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0001C4CEE3;
	Sat, 19 Jul 2025 04:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752899743;
	bh=4R4pb5oijYWaS7DBGG9pgvNAm0MO0W1G15IlWB4af4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ca5jIUgAHOyCF5t/XlU8Gj1tbm1sWzSHyH7FbGnjB6bO+R6mSjbB1fr78XCfQFpnd
	 gjIaxEvtMslrlr5yLRZZddVv6WiPzOXCC8p3w1NNnC1ZFXQWhNFgKR9mI6JQmGZduj
	 RTPjdokhA3GyIe52sMj8hzgSu2f2CLz9zecgUT8u1dczEl3lCzraI54p5RNS0/V2T6
	 /sCgRp0CuXlY53Eu7SbqTyFMoejPZv/bTlb8h4u2NPqdgNhMttxiDXJxz8oL0dsw6v
	 3c/pixduGiTcH31qqY2uTdr3TJtB4pcp4NpxTuRC0IzKJPq6Y4gsrKiXshk7vObL2v
	 x9afWTxFGgNIA==
Date: Sat, 19 Jul 2025 13:35:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] tracing: fprobe-event: Allocate string buffers from
 heap
Message-Id: <20250719133538.599ed567175c54262879b62b@kernel.org>
In-Reply-To: <20250719095733.0fd0cc95a41a2f0bde589c2a@kernel.org>
References: <175283843771.343578.8524137568048302760.stgit@devnote2>
	<175283845881.343578.10010946807218897188.stgit@devnote2>
	<20250718133907.6e56a3fa@batman.local.home>
	<20250719095733.0fd0cc95a41a2f0bde589c2a@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Jul 2025 09:57:33 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> In this case, gbuf is storing splitted "group name" and
> ebuf is storing auto generated "event name".
> 
> Oops, and eprobe does not handle this case. Let me fix that first.
> 

It is my misread. eprobe does it correctly.

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
