Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3900248880;
	Thu, 15 Oct 2026 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792026514; cv=none; b=Tn4zu0dFUyy9ePr1KDCQcQIwpLQ2VevvyY379OE19/gUmybBZEIS+/IxZwwUA2/mvPfqgDhDZJAWYHF3l6MC/kHO2k6B2c+78AF3HIcVYhTfxBWq7d0PvLzGKR5XXBmHbH8I41eFKTkwC/5jx2MumWJZKBhQKZolnsC7bbBJnbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792026514; c=relaxed/simple;
	bh=PXSobt7ixJN0xQBOg0nLuoi0sNmOI5+RizEbq3rn1KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=lxdMUOje0Z83pJ8kxCApcGzBt2O4ovqZKJSXC7FxWao6ECIoEnHS+4ABNg47FiulGWwqjd6ppdD46pV0Nb0Jd7yNVxzGpoaqivhdlTxBDCS9IHtSF9Osyuc5jTg/1Whkvx/nWFuYhv0p+zaiwSp/hzUBDWqllHlZjOb1a/GWNPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7X3NyTI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7X3NyTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25BB61F000C4;
	Thu, 15 Oct 2026 01:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792026512;
	bh=x7adodceiheTbdoC6+2nfd0HDrMHskjwnxoXA9ykBO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T7X3NyTINETcx2bbubkP/fqmH69IMNTcAXR/98huNdf+KMLHvgOy0v4aK7LQeHxLl
	 FSamyuAyVGUiHxpO04sd3GHa9aHKkKRFAf7u+E91fh6KBU5yjA7waSx+TBvxZGli1U
	 1ACM3IUwGXXhK2slPaFCSe9I5R3Q6pE08/g9GQd56O5pnZczralCJfcjw4HGSxHrnF
	 knO+SRVTjz8Dd+TAOzUQK8OhCGqR2klhqoX8EurrgJz6R1IZss6AvGV6oOYrT4WVZf
	 2FW2/akVqoPoGvraeqNPnJKlew0jt4BSIsG8gT9K06DP72Tlq56Kk/zALFo8/gq1bh
	 b5ncGyhUxp13w==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probes: error if BTF is required but unavailable
Date: Thu, 15 Oct 2026 10:08:29 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261014083838.31020-1-martin@kaiser.cx>
References: <20261014083838.31020-1-martin@kaiser.cx>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261015010831.25BB61F000C4@smtp.kernel.org>

On Wed, 14 Oct 2026 10:37:40 +0200, Martin Kaiser <martin@kaiser.cx> wrote:
> traceprobe_expand_meta_args expands probe arguments based on BTF info.
>
> Return an error if we have arguments that need expanding but BTF is not
> supported.
>
> The params variable is now unused, it can be removed.
>
> Fixes: d157d7694460 ("tracing/probes: Support BTF field access from $retval")
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> Reviewed-by: Steven Rostedt <rostedt@goodmis.org>

Thanks, this looks good to me. Let me pick it.

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
