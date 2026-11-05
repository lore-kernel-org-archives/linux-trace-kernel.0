Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793840629;
	b=SOUP9/9LacrGZcPOF9T9XNk8yxcfrCpnJ8XTsskJCdB+y4YknrRKkwnMv7P/TXy0i3js
	 ldRRMUy8AH4FmZg3GrJhMOhIvP+nIwLETx4FaQLl6gxJzZK+AVDgXRY+sqcpHs1yQhZwW
	 tlftmJpMQQiHyyln1fVFlrU6bTAS5fmNOKcs/u7c+3GvciZq9VuZHbUvRIK1Edqf8LEQy
	 dgKfu0GrfoKNa08pEWgq1LCL738pPKEtASCrdYkhvHKPvHW8FOnPv01uVhkwOhUqtkuJy
	 BFuRmKjWYZxLOAh0LNRegLMHo/H7+pCx2dEgrPIlj2tvkgd1B3MgSfeP1DScYt2mNQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Fv78+LB5sCU/1qjmS8UnRJz33uLZYiq0BfE+tEhtIXs=;
	b=gOdNzvmW3JjJqJEZ2+1BKROS+/2PRVXlhK+L7PcYw1Iup/H42yE1pRc7AI0xXQW5w3Ab
	 bvIQ3CnhSROmn+BdR9u+tyIGrTbHGYJbLCGs8QGYEvrBWgfNs+FeYJ5eOFz4Gpb53yj+N
	 Cd+F/ODtlNlv4gR376gkdn8btBhbTCe+tkr/XP77XguJI7XRmZYaE88ZP+q/MkmnCMwDp
	 22LDHgpxtqR83XcWUrnyt9u/TsPrjqjhdVlX/gRj5jf7x95BDMCxTMZfezX4loj4DYe5Z
	 7cjAlcknkxzG6gTSDv95XaeYoosxGfbdvrSm0EG1wew3gb/KuGyfuSz7scvEhdR7zqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlhaWu7j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52A8606A326;
	Thu,  5 Nov 2026 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MlhaWu7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E01441F000C1;
	Thu,  5 Nov 2026 01:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793840628;
	bh=Fv78+LB5sCU/1qjmS8UnRJz33uLZYiq0BfE+tEhtIXs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MlhaWu7joO+SJjKKNZxbmdN51EYPLK4jKXnkge2s+qfW8Y2Xm43UloDt7sgEV2eYo
	 FGdPWWCTFO5894vA2XekYZcrDI9JvKN2hrN8Hf1qkkWNxWURvEkhH8xCf9/hEq2xiC
	 +iL6jgQqwWICEHpdA2X6UccKrkBNK2T/dfg+wXc36R+mumGp46z263AEC9WV3kbxv7
	 qdvBtEw6xPwxCuo+Jsxd++IWpObu+JGCYbt2du8f9t1K1GJMJvlrRVTU9zvvJ+4F4Y
	 27NKOrMgPyPiMDsQoS5M4OyTuGZVCVtloAqUb/HKOsiR6LeHm58yyfBAIBGv1HmT6q
	 u7jdqcFZF0eMA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Mani Tofigh <mt4022@columbia.edu>
Cc: Naveen N Rao <naveen@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu
Subject: Re: [PATCH 0/3] kprobes: Fix optprobe state after forced unoptimization
Date: Thu, 05 Nov 2026 10:03:44 +0900
Message-ID: <undine-1793840624744635023-c869c5456423bd51@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
References: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu>
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

On Tue, 03 Nov 2026 13:45:58 -0500, Mani Tofigh <mt4022@columbia.edu> wrote:
> Since commit 06e0d3b89da1 ("kprobes: Make optprobe optimizer
> multi-generational and asynchronous") a forced unoptimization can leave
> a probe's int3 in the wrong state.  A disabled probe can be freed with
> its int3 still in the text, an unhashed probe gets disarmed twice and a
> reused probe never gets armed.
>
> Patch 2 relies on patch 1 since it assumes every disabled probe on a
> cooling list is already disarmed.

Thanks for the fix! Can you update the series according to the comment?
I'm also working on fixing the same commit, so I would like to rebase
mine on your series.

Thanks!

>
> ---
> Mani Tofigh (3):
>       kprobes: Disarm disabled optprobe on forced unoptimization
>       kprobes: Do not disarm unhashed optprobe on dispatch
>       kprobes: Arm reused optprobe on cooling list
>
>  kernel/kprobes.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> ---
> base-commit: d4d028a7ae6401ce70825a3eb663f0a2dfc49db6
> change-id: 20261103-kprobes-optprobe-state-90dbf55b246c
>
> Best regards,
> --  
> Mani Tofigh <mt4022@columbia.edu>
>
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
