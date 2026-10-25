Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792936919;
	b=cIhVuRhhBjWRxZNeq40/4QBZJtaEGrUgL9S4QfVToTDMrBSZfy84Tl1PgFqOg++bin5Q
	 QXDvCLtRwcoZwcCEusL0qo7/DPTc5QCwYrjBofmowYQUwJRFQYBe3UmEFy3wqqun+ob3y
	 GpikIQzOzB2IxbwZPKGlNv2ickYcfoNLPyK0jVO3Pq0OK706j6oFF1NN4V3zh5zqkwWvN
	 fcvPiyZkfcbPgKCa9FGQ2RJGDicAEZHX0jZ/FOsygcDY2Acu7TdX630VoqJsuu5eeiPV5
	 rTwJe1XITQWoYOlHPz4ecRJck8I5MCbL/dzFeg884nd7LjHSNWZPodDAvCTTJWV1siw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792936919;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=C9bF8ItVrT5Pnl1wKl7DV+qN5+WpyfI82oBXf/gZN4k=;
	b=q3L3oCL0nBjeiXKCaR2VydATWweQZB7BN5O2M+IHdWv9tgtk2MnjDOTB7uVYLAq6iV4N
	 QgxPQI3NLvuY7Hz3puo5kMIjkRcajDYTzj9iTPj+z23OsT4Zu4XnCDaVx9UKmuLQd6kEB
	 p5BbRWa8RP2KNbSQUb7d9Yiwl/SHSHCb4TgDkvBA5IHf8n/04kTMTC1BR8HikuzwWOZlX
	 tePxwr0RVpdrth5cOuaNCVhJPl3Q1XL/44bhHLmpuHcylHtRWeghm63PFFARTlfRRtELO
	 CJlG9baTylQg8e3hBLi3fTK32QLvAa9KayIGMarjsiGMzpmPIvJeXHbUW7WlfNGLLmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7s57O4a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C322606A31A;
	Sun, 25 Oct 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O7s57O4a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA7B1F01825;
	Sun, 25 Oct 2026 14:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792936918;
	bh=C9bF8ItVrT5Pnl1wKl7DV+qN5+WpyfI82oBXf/gZN4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O7s57O4aWDcPKRf0gqugVW3Qs7sPdQL3/7GTNV0ptkhOX1kZjvTvI+KOUoUhA6fe4
	 8HzR8HhcqiwS6FnA9VgZU8ZC9UsMcI9HJy6exqagG3GBWBg/jCfapINnjEq2rZ6OPA
	 4dA0AbcV5ugXj6h+MKF0F4Sw5bafdp35nliZFJM5u7EvD5Hg+TtjC0sIfCjh3ll3JU
	 3b04uELWskTUANNGwPE0BHvJopSGo4gJBhJN3apSOCzNXkyBnGvaU+xy42mdasN2n2
	 XA9Xqsas/iBcLkKRKhjOtAMvlciABiuzj+Hh8ZCBbW9NTv1oKCSeiEGQQa1DXwgiIj
	 hQf1R3rokcjLQ==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Preserve event trigger filters in ftrace2bconf.sh
Date: Sun, 25 Oct 2026 23:01:55 +0900
Message-ID: <undine-1792936915899334889-d965251e73c20670@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261023084947.3264289-1-edumucelli@gmail.com>
References: <20261023084947.3264289-1-edumucelli@gmail.com>
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

Hi Eduardo,

On Fri, 23 Oct 2026 10:49:46 +0200, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> ftrace2bconf.sh reads each trigger line into "action active", keeping
> only its first whitespace-separated word. For example, a histogram with
> "if common_pid > 0" is exported without its filter. Reapplying that
> configuration installs an unconditional histogram instead.
> 
> Read the whole trigger line and remove only the trailing histogram state
> marker. Quote the resulting action so that whitespace in a filter is
> preserved in the exported configuration.
> 
> Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
> Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
> ---
> Hi Masami,
> 
> This is my third submission to the kernel. Feedback is welcome.

Please make your patches as a series of patches. You have sent the below patch
on the similar topic. Those should be one series.

https://lore.kernel.org/all/20261024110837.696216-1-edumucelli@gmail.com/

Also, the \[\(foo\|bar\)\] seems gnu extension. Can you consider using
more posix style like below?

-		sed 's/ \[\(active\|paused\)\]$//' |
+		sed -e 's/ \[active\]$//' -e 's/ \[paused\]$//' |

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

