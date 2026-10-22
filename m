Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792630377;
	b=ZBRZ9TbMO7bE3SU6XmiH1KxBxCNZ1PTbRTjD7UclgyCzOQPJP6NTFRsDhcjJaMTDuUwi
	 TL0Hflga+RVSfzZRXFxht9dg70KV7C58PjH9CZZQauH2X1WZnuzXe4ZtJxrYwoMG3IYBm
	 Jz9AelmKsBVEgFRFiTlihSZJ10Hh9XSPRfxgOs/7NCZVs3+St/4Hot6MvJ2wp4HYVdcor
	 C9v2t3U0TE2IZ7mPddIAH0vPNxtxREjfxYtzlW9GEdPJ2WEScCzA8E0bFFIYFCDNkSMsA
	 wnUZwbob1/GseC+7G7y0YVTYUPorX7QLU4/LRQQ++OrI+1ygHlv9heNJG0abOalGcFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792630377;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DIsSrui0nuSUXZUq2N0vFF9rZ4Ejgd/EeEz07HzTAD0=;
	b=rj/DDtHWEkqrQctn0YApbMS2yGaGYmMumw7PVXHyHk5/CSDsxmTNtj+cEHkrjQcg4+he
	 F9uXKZd9fUDZvpt7ribUfOpNrh/48oQbzXwRWnZI426eCByUfKBaIj7Udk/sDPgRnai/P
	 dzwliyw6D3NLbsES+fi5+b1SyIsEAWN1KSnBBIM2EZEa9BRMqmSZSOSRJbXWOS2DUN/Cu
	 hqPJtSmuKxqXPJQQG8L2yOEutdn/u2xYncniIR8V1rVc14c7yo3kMKovAcxVHPfNFWYrn
	 0toptH/fdsu7PEu+Ze3txMs40nSuvAuwgdMoCzYn5mkR7aPe9xyCnwazMz81CgPFMMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDd9UEZG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE00606A319;
	Thu, 22 Oct 2026 00:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cDd9UEZG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B921F000C1;
	Thu, 22 Oct 2026 00:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792630376;
	bh=DIsSrui0nuSUXZUq2N0vFF9rZ4Ejgd/EeEz07HzTAD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cDd9UEZGUO/s+PaDYBGvqoNl4p3HhJzNDh079fR1kI0R85BztHzyPCjKr2P/SAD6T
	 ofdh2m98NCDIXib4oPtxAbU+BiXfaoJhGTl5TFaac/Ua+JsGEYdsuKpPMjdjLhYtvu
	 C+4kdQwdP2ndGo6zaEIOKAssWISJ4jPWHDIezTz8RA0e0XVo142NpJMSyzcnyevNF+
	 MqtZBwU9a87ZwWD0qvRndvjhJlFktVx/htExi7Y5IpgZqrAgiOO33kCD2Qww4+1KvB
	 PL8ndQX+QfxW3RFyMgJFx9QNFroCJzpN85pYWCbapX8nk+gVVU7xWkcQiHXal8zoH9
	 QiZOdwvP1IeWw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Fix enabling all events in bconf2ftrace.sh
Date: Thu, 22 Oct 2026 09:52:54 +0900
Message-ID: <undine-1792630374135671788-0c3e675ffc202af4@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261021181626.2004489-1-edumucelli@gmail.com>
References: <20261021181626.2004489-1-edumucelli@gmail.com>
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

On Wed, 21 Oct 2026 20:16:26 +0200, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> A bootconfig containing ftrace.event.enable makes bconf2ftrace.sh try to
> write to events/enable/enable. The per-event loop treats the global
> enable key as an event named "enable" in a group with the same name.
> 
> Since events/enable is a file, this write fails. With --apply, the script
> exits before it reaches the code that enables all events. The same thing
> happens with ftrace.instance.NAME.event.enable.

Good catch!

> 
> Skip the global enable key in the per-event loop and let the existing
> global handler write to events/enable.

This looks good to me. Let me pick it too.

Thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

