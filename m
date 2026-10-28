Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150047;
	b=DEiaVc9JAGNuTyTBIq5ge++ToZu+vRbggL140yze872qTggS5xWjn0skXJIJijH571rI
	 SXQUsYRDASeuog3XlKMj9AFqs/DRbP38Th2Ky/eFDgNrq7xBLjCxY5HEN13q/CCGdjcyw
	 tGlWp69oI43T3rP0d+XOE8Q0kgsH0tpylEHsFgc84HC+wP6j5lK3+7yiluCTSli2PRQ8q
	 v5ijXyZFbic5CWbPN2UC4kQnjqG27LzHOyqo08wtcjmTFa9Tbzr8ePoaPB2xPdiW7bIMs
	 +GNEq+10nbGYOMJbIXbuov1RoDhleCSVON7L66OKPACY5cvKimt59CG1eQe8lUJaVAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KPm5ZXyBlqneN6iKbRT90h5X1QBRtvo9o1Bey5K8fyg=;
	b=svDWOVqVO3qhhs1euswH3KOenlzhflpQPQTypJl4hQNCf0z9Iy60mzxQMnq8utK4FBQC
	 ETT6XFfqFybNngSXh9k1XtV6xefbbU+H9DEG4nKsRIZeVW4cOzoGQNEqVeCZNA2U3eKhW
	 X9Cwh/KREohINRecUanOIDCocP6pD+44utZJyZnBelC/7Fz6ZH2+Ev7bl9MtMHlKVhR2N
	 5Bi8yxflOeZEVXHZ0P8+g31QBT8HJdmQxu6awG8vfCFoOKt9usoNv1Tqz0lrPV8+8Cl+n
	 kYGsMUK119IeBdLkEtM6BOKGyRKYujaaKvuK+gsS0NjXJzBaisN4iBexGMEHsjmgM+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlE4D53L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67B606A33F;
	Wed, 28 Oct 2026 01:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlE4D53L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819291F031F5;
	Wed, 28 Oct 2026 01:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793150046;
	bh=KPm5ZXyBlqneN6iKbRT90h5X1QBRtvo9o1Bey5K8fyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nlE4D53LOnUOmmfpXDdRXcu6yYj6frsqWBF5pUMSlACMPKXJOsVSlLGZzb3dFfA2R
	 KxCF1u3IxLXsGfzbca0Ok2UhO20Gyxps/wp3Bw1HgWyMOuUTvLfGs6Kafn6G/Avnt4
	 pOv32GfLGj2EcRQjWUMSBFZSJLnkLvkonkcAU5+LWf20UEIE54rj/1+E7KYC10EnGl
	 KxMBhg88URX2oJUsSojkx9pHKyqGu3c6GOGEfdlApV0+PaVFz9/NpLR3GdcuWQiOjw
	 0ULi4A38Cd16CBcPcvTeozFko1NvuVbRMsj/1yea+MMtQ0KhjXO2/iD5sd3cCE0lEl
	 zgJHSTRdyW1qA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 02/16] tracing/filters: Fix MATCH_END_ONLY regex matching for fixed-size strings
Date: Wed, 28 Oct 2026 10:14:04 +0900
Message-ID: <undine-1793150044117136431-e10c2ffa40b9a4bd@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <179314822364.684037.9099512445135198750.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2> <179314822364.684037.9099512445135198750.stgit@devnote2>
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

On Wed, 28 Oct 2026 09:43:43 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
> --- a/kernel/trace/trace_events_filter.c
> +++ b/kernel/trace/trace_events_filter.c
> @@ -1087,6 +1087,20 @@ static int regex_match_end(char *str, struct regex *r, int len)
> +{
> +	int slen;
> +
> +	if (len < r->len)

BTW, this is required for skipping strnlen().

> +		return 0;
> +
> +	slen = strnlen(str, len);
> +	if (slen >= r->len &&

And this also checks actual length.

> +	    memcmp(str + slen - r->len, r->pattern, r->len) == 0)
> +		return 1;
> +	return 0;

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
