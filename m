Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8E83B8D5C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774284233; cv=none; b=CBcjejKjVHt/qdHSORzl8/qx7LA1kQSJvk9UseqgBvYDkM7A9+mvtxcm3YWI/AfhdPtcVO3XNh5PfTBh/NjM6utgVGm8z/wXfPzeWNvxnVrmfnYQuLQDOm/kYwwgvGGg9xXdR/um8ptLdJybnm3M6ZCLlg++2s/psIF+UAg1fxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774284233; c=relaxed/simple;
	bh=tarz1CIJRiWND6xVfnTAuVu8/LmSDdeXDeIbdV6STBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IBneDVnRFeuBYYiRYDN88Gsam6r4SxUNBOdyrbpT7Mb2r/v/dQ6enH4/pBVrOWHaCmZvkxwRg6BKVI6dqbcLVEbTRzYNrAMWN6RXwzAB3cs2kEfaZLLpLvntbyL9znbKON8roD3Mla6v/UUMI3rx9R78QhHlrwO2B8xLqs+qH3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=QZB5ta7c; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="QZB5ta7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=4+lL
	UWZVNvR5PoeDR//xER1BrIVP+xwcLMC44aIHEUI=; b=QZB5ta7cSrhwHbvmBXqC
	QaQ6QWgav4k39yiltqs46LLAguHjQbj/whbnp0DWWX+tnPIg/HjQSkebUfuwgs1e
	nC65YCV3cWEozrQqBebE8LB8BPKiyEQ9GDTOg3AYfeq4gn5igQl2ET9O7+etQenU
	TchSCjSBxjnn4NVN9Xrh9KXE6FdwyBeHczMybkxy6CGQlHUCLXfYDT9Gha2L+WSH
	XUcoVUvZoAyBNgm6+0PgTu+uZEX+1RYPxkg/72grAvSzS/Dizcnb0gkhc1Ueig21
	AzODCFDicsKQ/Nm+kfBVeL7KzoiwtYzk5fAy1f0vcjZJjiIzMBNN365tJGnhqQlZ
	PQ==
Received: (qmail 2748410 invoked from network); 23 Mar 2026 17:43:50 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Mar 2026 17:43:50 +0100
X-UD-Smtp-Session: l3s3148p1@zwlGvbNN7IMujnsq
Date: Mon, 23 Mar 2026 17:43:50 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>, linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 12/19] i2c: Use trace_call__##name() at guarded
 tracepoint call sites
Message-ID: <acFtxl7e9mbKn-3p@shikoro>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
 <20260323160052.17528-13-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323160052.17528-13-vineeth@bitbyteword.org>

On Mon, Mar 23, 2026 at 12:00:31PM -0400, Vineeth Pillai (Google) wrote:
> Replace trace_foo() with the new trace_call__foo() at sites already
> guarded by trace_foo_enabled(), avoiding a redundant
> static_branch_unlikely() re-evaluation inside the tracepoint.
> trace_call__foo() calls the tracepoint callbacks directly without
> utilizing the static branch again.
> 
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Assisted-by: Claude:claude-sonnet-4-6

If the core of this series is accepted:

Acked-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

"To:"-Field of the message is empty!

