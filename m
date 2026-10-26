Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793023742;
	b=ar4jB7RQ93FbMkMYsfvu9Rhu2QHF/KF7qmuEKE+B98kxVK2Ok1Mud4jNc86qooc/6iPU
	 gBDuZTC+WSsg5Pc2YTVHcOLhMhMctVXpbMvHKxsNlHHu+64NSc7ROR2s1w1AF5CZ9bHGN
	 6knu3X/sJaDQQy2GoVyyGPdl/O8QketAmtqKN++I7RmI/Yk8RrOh3zpB+6I/0KJSPOcuZ
	 mRtg/aJKeosYpesDceoApEXg7iQrgONxFuB57y1tqcoJpIGktccvyObaJIBuk1NmnsOh0
	 ySfm/P1gfO+MbisCWz/5lwjZgKfUeStZlb+xDfyfYET4eDtyeXz0phWAJJodoDE33RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793023742;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=a1WmV4QAtGrFp/Wbi4toS+hF3KEftfKLEYN8Q4lCxC0=;
	b=cJL3BXAOx+0HydtRGfi7BANWere1+D8h+++BC1EVKy85oWHNEqmml9fQI8ZKTActu56c
	 FTFR5eOdNmsqAD9yZIAKep8QKOuSbgJmq+YBYr36Z7i3+Siy6jc2XaerB3YllbJiN3eyi
	 SVmsXpniY23/I8iIN9+/HFzSrhy/d5PRzGy5rtWtMvepJ0Ug5w3sAnSNAZlAa7jqcBWux
	 qRv7MSpDh6H6ejewcfgVGgGmxs/7BI2v2k6hdrXGEiejnHTuJaymcXPPrP/mmNbZvRCp9
	 DxFtVZuphlNtA9n0h/PGGE7caJ+Wr3itCP+9XDcu57YFRZ+APvYMoRek6INt+H9kvCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDOGWW1p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48233606A321;
	Mon, 26 Oct 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDOGWW1p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602831F01825;
	Mon, 26 Oct 2026 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793023741;
	bh=a1WmV4QAtGrFp/Wbi4toS+hF3KEftfKLEYN8Q4lCxC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDOGWW1p/w01kTwpcgzRE65r9HDbMD91Wq39zeOUcpxYlfHCUb6EGuILi0aGYlMjj
	 lMTIOQ1E0aQWk53Ao+ZlZOri4tFmi3tiyWyolTKfQYr5auzVNpnRKCbES6ylksEJnT
	 GaQTfJnWG7TYmiU2hOPzZs7Cd1saEXrDdYdyuFSgQdH2MUBIau1zx3776RjX67FU4A
	 GjXXzgHeFk0NXzDbyvxKEZQk3yOQnb7KrApZl/iq9K0wefkeZeygA1xqJ9bLybv1rs
	 cMTdDcufQQy/A8UajwXQbTPF/Yig36oGbTd5U6CvSjd9RJN19gljL6u2MA79FTr7XG
	 VIbdtL4G+iAgA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Jaewon Jung <jaewon8868@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Add missing spaces after ! in probe syntax tests
Date: Mon, 26 Oct 2026 23:08:58 +0900
Message-ID: <undine-1793023738390905423-e7126e9971bd4f80@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261025075044.1750113-1-jaewon8868@gmail.com>
References: <20261025075044.1750113-1-jaewon8868@gmail.com>
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

On Sun, 25 Oct 2026 16:50:42 +0900, Jaewon Jung <jaewon8868@gmail.com> wrote:
> Add the missing space between ! and grep. Otherwise, the shell tries
> to run !grep and reports "!grep: not found". This always skips the
> conditional checks without checking for kernel return probe argument
> support.
> 
> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>

Looks good to me! Also we need followings.

Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
Cc: stable@vger.kernel.org

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Shuah, can you pick this fix?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
