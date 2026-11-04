Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793774982;
	b=Tht6I6OR20NRw+xvgsPZXoXu25GB2UboxJf/npzt57TID1K9zUcxM3w5fJFKbMDHrZpo
	 Ihs2yNfAYxtv5HlGFb5QuS8f+uFNrFn+rwSEniPBLhVkUQ/HzgkTASH3qkvv+Si13E6VA
	 lOHrXuZ03log52xl4WdYTSs8eI9xSmy9Ma1EyKpIM/Lpp9vAoElkDjBraG8V0oYPRe/Vt
	 qTjYHaGtb5qnPNDTVInFS03SOG69But8koBESElbcgiA3cQ+TT4xXO6o4E0afM8aEyKup
	 hLEJsiiZZzIggeikzvpi8BHgV4BUMwhzXjRDE382D4BHUxlpwTXPKIGWNUeJwjrAApA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774982;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rBuJWvGl//54hFC2z5kR6n8begZ2UvpTjmCvo8jJcjY=;
	b=RHJ07dPh/tFKZft1vN3Y3XifQhLYqk4VYl8nFKAk84hgPp//YPwgO1mdfYGxvYSStPmr
	 pSzkR/hFH85LnC0+Db4iD2dekjxa4bRNWt1bB8UAZm0jhltntpRpfj1AWlrZJN38/cR4g
	 Egd/JLChs1w5mXnQAbBqsFslAD5WNRQCj6C7qSqxIwwEl9wmzuyez8sMesVHBEUB56YuV
	 OsqFH6NXD52q2ocAqKBGGZwWa3YYVkt33f0UN9SSZXR02TYC0mW0qsjjp7H5o4i5saNrv
	 UcU7hhqU99xKVsBxaleprLdLPZVZflyDNn4eJjiYmlwRXXKk1wVJpPEbB2tX5kHiDHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRM4kNi+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65F2606A31B;
	Wed,  4 Nov 2026 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRM4kNi+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC67C1F000C1;
	Wed,  4 Nov 2026 06:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793774981;
	bh=rBuJWvGl//54hFC2z5kR6n8begZ2UvpTjmCvo8jJcjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NRM4kNi+hppqEumsF51gVlrk6qCXT9cPGGD5YtKrHwsH6j0t5nsFMvmbHs5KEB1K5
	 QiiFw+9bAtCclSGjjbk/i07VnHlLJEywZdKkaBvAN1G/R6rUl0ektfPBYJgjQJ+kew
	 xTQXRwIeczF4/oNK2qDymKm2++idFU7/ST/5EkaxgzpYgEQEhkyZL3wmkoja/mC8WL
	 6pIiS+khJxh5NpwmhUIdS19UtFxMjrQ1jjEVmuFOXWdT5jwAEY0YZIujqTWtJQSgtE
	 yOMKMobg602m8ck5aHT2jxCZMW9qNz/jkDV4kSgWdmFXLGzOfte9j+4NIJYV66M+sE
	 EMu0O5JT6ovVw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Mani Tofigh <mt4022@columbia.edu>
Cc: Naveen N Rao <naveen@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, "David S. Miller" <davem@davemloft.net>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, tz2294@columbia.edu
Subject: Re: [PATCH 1/3] kprobes: Disarm disabled optprobe on forced unoptimization
Date: Wed, 04 Nov 2026 06:49:38 +0000
Message-ID: <undine-1793774978716527957-f663985e05904ff3@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261103-kprobes-optprobe-state-v1-1-6aaac612abe6@columbia.edu>
References: <20261103-kprobes-optprobe-state-v1-0-6aaac612abe6@columbia.edu> <20261103-kprobes-optprobe-state-v1-1-6aaac612abe6@columbia.edu>
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

Hi Mani,

On Tue, 03 Nov 2026 13:45:59 -0500, Mani Tofigh <mt4022@columbia.edu> wrote:

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
> @@ -1006,6 +1006,9 @@ static void unoptimize_kprobe(struct kprobe *p, bool force)
>  					list_move(&op->list, &cur->freeing_list);
>  				} else {
> +					/* Disarm probes if marked disabled and not gone */
> +					if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp))

Nice catch!

BTW, since `kprobe_unused(&op->kp)` checks `kprobe_disabled(&op->kp)`
(see definition in `kprobe_unused()`), both the `kprobe_unused()` block
and this `else` block execute the same `arch_disarm_kprobe(&op->kp)`
under `kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp)`.

So we can factor this disarm check out above the
`if (kprobe_unused(&op->kp))` block as below:

	force_unoptimize_kprobe(op);
	/* Disarm probes if marked disabled and not gone */
	if (kprobe_disabled(&op->kp) && !kprobe_gone(&op->kp))
		arch_disarm_kprobe(&op->kp);

	if (kprobe_unused(&op->kp)) {
		hlist_del_init_rcu(&op->kp.hlist);
		list_move(&op->list, &cur->freeing_list);
	} else {
		list_move(&op->list, &cur->cooling_list);
	}

This makes the invariant clearer: once an optprobe is forcibly unoptimized,
if it is disabled it is immediately disarmed, regardless of whether it is
queued for freeing or cooling.

Thanks!

> +						arch_disarm_kprobe(&op->kp);
>  					list_move(&op->list, &cur->cooling_list);
>  				}

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
