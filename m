Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423517;
	b=i08JnTzjaj1r8S/z6Kn13TCREOAJ86yToLtYSnkIZ6V1RX0fsehW3GAaoJU/3WSDEzSe
	 U1Ud3nHMZTS0R0xXds0yhs3izv+TF6K8LfvPpk2Bi48LUIFtpNr2V8RvT5tEWyAqLXSeq
	 T46Bwi8E902FG+v1Bv8xAx/xWQQyizB7xddyeaLuK7zHGw21SGwC/X8J0VVu8KQ5YLNC2
	 j9NAlOFw8Xlh4ZREBD5ii4Ze9E7ZS21acP9LZYqvsKSvsqugSUOC8kVHEITWLTTFkheoo
	 9/VvKbWkbl9tV83pgDI1Lqb4t0W02aX/VbF8S1B0ZrarUbs5armjZdbRF7ILL58d73w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423517;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/plKL1aEUrkGga0cecEwRSsj4gDe/zZfGm2fHE0kYJU=;
	b=I1ngNHpFxBo2cnnan+l+ES7AXyhkOkCGf1kfqj+4MFTXICwI0Apw604tENHdn6PZKtOz
	 OCwwie9KuF7rdbNVU5QiVeMLi5tARZjZeuOWbk/mPvdaRHvwfM/XNZFY7sKuMAbBFpzie
	 olfyAr7Ly0gZIIwLWe/yPQJRRTxGnqjdmIY6iV3sH1S4JKy4LFfTl8tLU8IanLnLpiwh7
	 wT5FXul8EYORnJaT/YG048QlK+onJ90aiuzmXEfgyT8WDJ4KpABnu87+M6LYVXbmGwMjZ
	 ivdOr8EIcKlJrWJCRSjO0KzI0y96QJt6GAWpAY6a6naIIuuVin/v6nzSopSP6S1D7RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0jAQLyP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id B0E5D60B0982;
	Mon, 19 Oct 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0jAQLyP
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0A2041F000C4;
	Mon, 19 Oct 2026 15:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423516;
	bh=/plKL1aEUrkGga0cecEwRSsj4gDe/zZfGm2fHE0kYJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j0jAQLyPBq5gkoJeVI7kZT+b03ukPiScuLVIx2xJN7it++Z07ivdy2dPsIz6gqO/E
	 MYWvFg1Dvmoc+a4y2Usjakp7EYVDJFRaa+dBqCAvUiIZ32XapLhTR8dFCaObGtJEqd
	 fAai08D15Udi7we9hFQ7A3B5J64htxN808WUWeVeeIjQklJoR/+IZLamakvLQP10fw
	 F0lHJByWf0dXpwN363TOvB0dGluUJpntC/gwhY7jlSo6Lbz5KELIsiATQqdhpQUgUE
	 3L7D++MLCgj4TeEL0V7J28RS5Nq1R+8WcydcRMdio19QFz83mZey+sd4OUzp2sHaMW
	 QQccyiKZ+eXQw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yaxiong Tian <tianyaxiong@kylinos.cn>
Cc: rostedt@goodmis.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] ftrace: speed up module enable by binary searching module symbols
Date: Tue, 20 Oct 2026 00:25:13 +0900
Message-ID: <undine-1792423513137811483-832e0e20f49f84bd@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
References: <20260916082715.320853-1-tianyaxiong@kylinos.cn>
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

Hi,

On Wed, 16 Sep 2026 16:27:15 +0800, Yaxiong Tian <tianyaxiong@kylinos.cn> wrote:

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -8010,11 +8011,137 @@ void ftrace_release_mod(struct module *mod)
> +
> +	/* mod->kallsyms is not replaced until do_init_module() returns. */
> +	rcu_read_lock();
> +	kallsyms = rcu_dereference(mod->kallsyms);

Consider using rcu_access_pointer(mod->kallsyms) or
rcu_dereference_raw(mod->kallsyms) rather than a transient
rcu_read_lock()/rcu_read_unlock() pair.

> +	rcu_read_unlock();
> +
> +	if (!kallsyms || kallsyms->num_symtab < 2)
> [...]
> +	 * ftrace never came up, where the loop below would not run anyway; that
> +	 * also makes reading ftrace_disabled without the lock safe.
> +	 */
> +	syms = ftrace_disabled ? NULL : ftrace_mod_syms_alloc(mod);

Because ftrace_disabled is one-way flag, if you find ftrace_disabled here,
you can return from this function soon.

Thanks,

> +
>  	mutex_lock(&ftrace_lock);
>  

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

