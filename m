Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793665158;
	b=exy2tMI/aj6CpHMI4rsfYIRmnO/ztSuMg1tGXO3CZKYyuyoFOtMIsVSMl01kiv6O69OX
	 CHFjsz+91ZO57iL86ERNDxJKCFyamB3SI++kDL4GU46A+gcSWkinRu9NUV6HfcTY8zcZb
	 ZuoOR5PQcwOVD6X5exBPH+vofmWeE2MuYcZjvDObc7yGsy8RsmqDpBVaUN71lwVfjfJb/
	 89rRc4Bl2dOLoSsjYJw/Jw/lP4ufw14LO/IpXFJxJMDzm+651vcY2Wos49/JKKN5RTjCO
	 egQthwfxDGZw6760YrNJBS7HIYFl6Zc/nGoRuW6bhlSbgEZ3ojmge2mcADtlUgPqjew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793665158;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=C8Gp+TCIwTQWBEOlS19QUKuObuqoBQ8yKptYR+HwXTM=;
	b=xgwDZ75SVQd4GdJgnGLhXNKcaiFi+NMVdXvLabGSR2KFhvAG4mAh/L+On3DZuS8hjT9V
	 EpM04o8Eemh6q8uW9zCJ5QJsSuttIrqfRRdF+4blhAVir7B0L7ucFVt/D63Y7sdR2aXxS
	 ph6uv0Mcbw4yzGUfe+CL1r4+qErKj/IZw1oi4xPx6vy5TtIXDamTXPK3JhadNNBJvMT6i
	 j/weeTPHD5MISOIYK/51ZUPOWhpgBhN+jfxwSpNg+/jm1RNbqUdEtltMrs0TjxOJGsiyy
	 3EmUpurRFkh00uM8sGKWOlvHRkOxLk816WapUgbsaXrVKRTuwCxg5NiIO9sRqHB36Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f573S8Iq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF92606A326;
	Tue,  3 Nov 2026 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f573S8Iq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CDD1F00919;
	Tue,  3 Nov 2026 00:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793665158;
	bh=C8Gp+TCIwTQWBEOlS19QUKuObuqoBQ8yKptYR+HwXTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f573S8IqxWmyKwvZHJ5+WPxVwSHrK6KdneEhmXC8FsyA6f+LeP6YdaNK+YywcIun1
	 Qpz63/Dow/gQi8sk8knEFVOvT74RF8hwjme7WROGcndmpYHEiHWjvfrzGvSm2e+Q/o
	 Wqa2mbu8Uiu1VGWQG32G+8csf2l9JRdQej/9a7B0fVQKuUIDhhNHd7OWrHmWhCJ0GV
	 PEPVo0zorGlXfINUURehDlBBr1Rvj8bimy/VoYSuCc9BLLrRigNPBmSHhDfxXeWYPw
	 NWqpNdOeXnJNGBZdqFwQHWffDHrQxJSLQNzm1wW9oizLPaM+cvLNIaq/w3tvjzzhFq
	 ZXhU6ragAbENw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, "Shuah Khan" <shuah@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel <linux-trace-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Sven Schnelle <svens@linux.ibm.com>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH] tracing/selftests: Fix false bashism in kprobe_non_uniq_symbol.tc
Date: Tue, 03 Nov 2026 09:19:15 +0900
Message-ID: <undine-1793665155348284042-31145736d231a8b5@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261029211218.3749963a@fedora>
References: <20261029211218.3749963a@fedora>
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

On Thu, 29 Oct 2026 21:12:18 -0400, Steven Rostedt <rostedt@goodmis.org> wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>
> The checkbashism is giving a false positive to the kprobe test of:
>
>   ($"foo" should be eval_gettext "foo"):
>   if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' ]; then
>
> This is because it sees the $" at the end of the grep as a bash symbol.
> Instead, escape the '$' with a backslash as it is within quotes and that
> '$' is for grep to process an end of line character and not a bash
> variable.
>
> Cc: stable@vger.kernel.org
> Fixes: d22c3e0088e85 ("selftests/ftrace: Fix unique symbol check in kprobe_non_uniq_symbol.tc")
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Oops, good catch!

Looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Shuah, can you pick this?

Thanks,

> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> index 03eb9e70b438..f8e18ea8c268 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_non_uniq_symbol.tc
> @@ -6,7 +6,7 @@
>  SYMBOL='init_once'
>  
>  # We skip this test on kernel where SYMBOL is unique or does not exist.
> -if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}$" /proc/kallsyms)" -le '1' ]; then
> +if [ "$(grep -c -E "[[:alnum:]]+ t ${SYMBOL}\$" /proc/kallsyms)" -le '1' ]; then
>  	exit_unsupported
>  fi
>  
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
