Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795859151;
	b=xxRvnVu7d4E8qOon381PFHNLPVsP2vAJDIpdAxJaxVluZmuur9iYc74iPwfDLNoF3rmo
	 c6Dsv62X+fK0+J3hlU/BoBPER5BEM++4Al3wVwkCNf76nui9yzGvc0zYDFv2HAIE0STeh
	 mQhj2NDBWUm5KrCAwoqlMZj3nDseYfJM6Kgx5rWU547bXdyVxKng9wB1xwnzIupQFWUIB
	 n2hPKhkUaJDjedxrRyUiQv0h2Ycy3Sy2bUuENBD84a+wMXW7Hhpc5bqAwWKw9OrH6Vnvd
	 RYN6i6/2bK1cFjQNyCPrrNBRjCvZt0sBOFIM3caHrZgH5f12k/rQLxao82NXK1EBdgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795859151;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=3duadoI5cMbrpBpkjaOojq5fk/vrpMla0+OafY6QSEY=;
	b=mfZOuF54PHog+VORWMTz3V/h99Vzbwn4eQdlfmyOvE2s0sH1E+CaRNdapHQc7dqaMKPS
	 XunrUc33DHk7Wx15eyGGLionuECU9WoI/sLPfX1xO20bKJaA8EAYzuflW1SZV0/ZcYAzQ
	 XXOox9zJu5SUPrOamuex/NhHfKd+I6wUkcor8z9gxXM8b8OgyHD7h+FpEyL775Shc7CJQ
	 W7DN51q5Eiwi7VE4ZeAp9OQdRRezJg12X5PEYaETjvgKIOw+Hd40/FIUApOQp5w749sun
	 u7NxgpGaTtyORM5TLOaEhpcrq1G9ZaCBx02akoBmsZIGhScx2PWrhH7VpGakqi/sIbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIGR2Ysu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E81606A31F;
	Sat, 28 Nov 2026 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIGR2Ysu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1D41F00925;
	Sat, 28 Nov 2026 09:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795859150;
	bh=3duadoI5cMbrpBpkjaOojq5fk/vrpMla0+OafY6QSEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IIGR2Ysutw7AuV568EuusrLYN5fsQ+JHe5xTFUKrlyFTWVVgzpS67PYm6OuAsWyCL
	 qBwgQzF6gr09AZaaKU6qKvArlNSsjhiWEA3AOTuGe8UjxPK8e1hOk7LVyXVi/O3tAJ
	 RardZKxVUEgxBiTVubX0kh7FcTp6ryxVuFrIXjPEf5xIbIsecmgg7+36U7QRaeVr3I
	 Z21jOx/+H6SiXeAMnHkAoSstQwxsB73xdMQShyBtMfaTvusEF/2L2hZ1IvuuudldrZ
	 vdolYei8tRurAHyzpsXDVzk+EMAWTKw3bJx2INQ+GvYGnMwzkOKTgGPlGTwMPuZyQ0
	 ruDXfUPofnZig==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Jaewon Jung <jaewon8868@gmail.com>, "Shuah Khan" <shuah@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Check for dynamic_events before clearing
Date: Sat, 28 Nov 2026 18:45:47 +0900
Message-ID: <undine-1795859147374307219-792c74b3de9f0713@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261016032655.82009-1-jaewon8868@gmail.com>
References: <20261016032655.82009-1-jaewon8868@gmail.com>
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

On Fri, 16 Oct 2026 12:26:32 +0900, Jaewon Jung <jaewon8868@gmail.com> wrote:
> Trace instances do not have a dynamic_events file, but
> clear_dynamic_events() is called during initialization. Check for the
> file to avoid a "No such file or directory" error.
>
> Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>

This looks good to me, and need this Fixes tag.

Fixes: aaac2820a367 ("selftests/ftrace: Add clear_dynamic_events() to test cases")

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


Shuah, can you also pick this to your selftest fixes branch?

Thank you,

> ---
>  tools/testing/selftests/ftrace/test.d/functions | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
> index 826141e299e5..4f2abb05e365 100644
> --- a/tools/testing/selftests/ftrace/test.d/functions
> +++ b/tools/testing/selftests/ftrace/test.d/functions
> @@ -84,6 +84,8 @@ clear_synthetic_events() { # reset all current synthetic events
>  }
>  
>  clear_dynamic_events() { # reset all current dynamic events
> +    [ -f dynamic_events ] || return 0
> +
>      again=1
>      stop=1
>      # loop mulitple times as some events require other to be removed first
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
