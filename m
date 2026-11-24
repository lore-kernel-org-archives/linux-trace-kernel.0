Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559525;
	b=BNEp/Ya2VXbUdNzsHVd2Jt2C+aG91Ozw4sVUU0a9xHJzRIZX9x/6N4ousa5m75VJ6eOI
	 VVcGuLZrsY6qA7ELSvIY6np9St5hlEJ9qpoEw0H18FOfmG7KCtjYkdVxf9i0pEJTggF6V
	 bHpPvpUCvkfbOoDBtYPXw4iQU/P56+WaN/MjMomIre1XTJ/e95zJ1PXVo0x3l36Acrajs
	 OG9yLoVVEo+6q+9CclmAc8FIqek4bYsho3uQwJsa1NhHbqXuYWzTyL+VZzuZkdye4szL6
	 QQ9x/Y4AWPaq2Np83dnvpO5F4KZtRhzzVjYNyxT8F9M2X+AZ89UZYkHsA+YBIhq9+8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zhXhLYouXI+/ilM5ux2BAJbi8OfjZQO44+/aDAECVQs=;
	b=qbSb9y1AN0fiNA7YxB7Uy1mfW6pRIg+miPQeqXPtcZvXCAcm8YaD+1W7kNbBTaw/FvJP
	 w7aeqf4XvUgfB4Mxsc5COC+4F9PPH2yMyCtbAnYA/0ib+qEzgiLLGnGDqgbghLQs8XXtF
	 nzW/f4CCAn5AHZzQthyoNtXL15vM4HLIQXiWCbdsp3TKcRz8JjaC8ux4JgMUL1sjy55H4
	 weVWOw2yVoFZs+LYK+vDidL5dYKl4Amr4wrrNs3KVqbT4KL5LneOCViHGdWW5ZoDs9VDb
	 TuOIDaaNPL+7M6UI/E0eaRc5POdQm2suja0hvWQjpGC6Cc7anl00PuWouUEKu0ID3jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV5RsC5n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97DC8606A31E;
	Tue, 24 Nov 2026 22:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RV5RsC5n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E56E61F000D1;
	Tue, 24 Nov 2026 22:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559524;
	bh=zhXhLYouXI+/ilM5ux2BAJbi8OfjZQO44+/aDAECVQs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RV5RsC5nBYdNnxVHt6rk2eaYiSw7YuYcSIuNduneK7+H825yJBu0qV2bYeNDiTVcd
	 CluC/UwHwmPbP7tY0cCJDseMh/xGpeT8M5hhQjjFA1o97+SvIjLSqTABoDOQxQwTry
	 EWrLQVVhHcKHdgcAUe93XP7/yZIBjFc9ZsfnTmwlJgx+OKAtCwL60C3cPj5kRIbO3L
	 /YI/yPY+Cz8DnpcWmY5+9/CJAvuc26TgB8ImtsiWYc1uGNBM292A2zEMeyjNBF/2ql
	 qRTsLa/S8x3gNoZ1Bcw2eYDiBp+Gds97NgktPvyqnIhcrk9zNCCFSSNC7W5XgIP5zm
	 CkSpBKMb/hleA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Report initrd append failures
Date: Wed, 25 Nov 2026 07:32:01 +0900
Message-ID: <undine-1795559521975902210-96f349a574389b64@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261120061917.98169-1-zhujun2@cmss.chinamobile.com>
References: <20261120061917.98169-1-zhujun2@cmss.chinamobile.com>
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

On Fri, 20 Nov 2026 14:19:17 +0800, Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:
> The signed return value of write() is compared against a size_t.
> A negative return becomes an unsigned value and bypasses the error
> path, so applying a bootconfig can claim success without appending
> it. Check for a negative return before comparing the byte count.

Good catch!

>
> Fixes: e1cef2d4c379 ("tools/bootconfig: Align the bootconfig applied initrd image size to 4")

This bug was actually introduced one commit earlier in a995e6bc0524
("tools/bootconfig: Fix to check the write failure correctly"), which
changed `if (ret < 0)` to `if (ret < size + 8)` where
`size` was `u32` (unsigned). Commit e1cef2d4c379 kept the same bug when
switching `size + 8` to `size_t total_size`.

Let me pick it with changing Fixes tag.

Fixes: a995e6bc0524 ("tools/bootconfig: Fix to check the write failure
correctly")

Thanks,

> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
> ---
>  tools/bootconfig/main.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
