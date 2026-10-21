Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792592454;
	b=MDgVQceSymWIdca96l/JeNYyC9xx2R3UVa38cUyyvMpb0synYgEyTcZvbHz7/KgPp8K7
	 bEpVnWkVI1ilI5/9hnJgaXLFfmrkx8yCaqEoCLcPtRRtutLidd3JngSTlWhq0meyINiKN
	 apQSzFNhOgukBip6NuMxBGB1Ey3/+dP35Hl7Jzj2f0kAcRkZQ/1wk/NT1L1Grbz/nDaoy
	 3LWHFZ+ZyXLocVxU7HeETG32/C8je6QuxHx3d82qzNnQFuVv+14y/D9kgqKr+Bpio+3BN
	 ks5ZacpAXZEXHMRLbIsRWbCkhF//enV8v11pvlr7zG4pDOKH8I2/SIUYi6D3UUbIXwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792592454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=il9Cp27d643gcWMcqV/gyhk68gchoGQ2Hu2FDC7dH4E=;
	b=z+s+ufKEfO6Hmg9GEt6J0dwSjvnX/+SRBSdAngrqFcDZp9OCr6rqrOUjRNm7Ny/HqHg/
	 VJAEZgUIVNpgBzHK3p6ngYvcmthDu4Rsa/oCOowwG5Z/Ac3aYKwJHw3BDWRWNry+5m8UJ
	 q8tlkZq7PjPEyNZlTyL9+kHXxjXL2rVhKLXlrwJufnQwhfrK6iMoLowhKKQZwcKx/B8fI
	 qIBOnEhTT4In2TSVQLRWoGw63WnbN6+NbNwAVMuzFjoDbo4hnGD+PaFYb1zdexrNuThtD
	 b7hk08KnF3NrPAFbPHFLkFHd34/hJK6m74buHv2vuZ9jeSIPPdhVawwFCrE71d2AcUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acz8icf8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EF5606A31A;
	Wed, 21 Oct 2026 14:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=acz8icf8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3211F000C4;
	Wed, 21 Oct 2026 14:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792592453;
	bh=il9Cp27d643gcWMcqV/gyhk68gchoGQ2Hu2FDC7dH4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=acz8icf89S6fKqtpuFO5cccr/lrjrnTcc7FyqljPBhWst7D9VH8hmSp0IE7voR8ST
	 oXb69tInphf/YolsZu0OlMBLXc6jR2nP0Do3S22CHG5ChkjjkigU4B0gJqM/9Q36qt
	 h7zO0FuDUw5iw6hbj2AoLLNTctxyk18mIuaaFPeLxzmwVk2bEq6gwsOBrFWVx1QVJA
	 WpEfOmDrmPJyE3qBMT7UY0geaAQgq0fBGN76HpX0CVWo5LD0ZzY4SxJxQ+VdAs5KYq
	 bGowKlfRH52EjhiabkREhWEJriAnz4vboGYjLDhgWfto+NOmyc+vUzk8P2sj6E3HY8
	 nqTwidP9BG70Q==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Quote CPU masks containing comma-separated words
Date: Wed, 21 Oct 2026 23:20:51 +0900
Message-ID: <undine-1792592451008617538-5620f2dc569b3038@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261019120332.553567-1-edumucelli@gmail.com>
References: <20261019120332.553567-1-edumucelli@gmail.com>
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

On Mon, 19 Oct 2026 14:03:32 +0200, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> ftrace2bconf.sh writes the CPU mask without quotes. For a mask selecting
> CPUs 0 and 32, the output is:
>
>   ftrace.cpumask = 00000001,00000001
>
> Bootconfig reads the two comma-separated words as separate array values.
> When bconf2ftrace.sh applies the saved settings, it writes those values
> on separate lines instead of restoring the original CPU mask.
>
> Quote the mask so the commas remain part of a single value.
>

Ah good catch! OK, let me pick it.

Thank you!

> Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
> Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
> ---
> This is my first kernel contribution, so I'd appreciate any feedback.
>
> Tested with the exporter, bootconfig parser and generated replay commands
> using tracefs fixtures for 00000001,00000001, 0f,ffffffff and 1.
> The masks containing commas fail before the fix and pass afterwards;
> the single-word mask passes in both cases.
>
>  tools/bootconfig/scripts/ftrace2bconf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
>
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
>
> diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
> index 8eed445c2..f8f288f90 100755
> --- a/tools/bootconfig/scripts/ftrace2bconf.sh
> +++ b/tools/bootconfig/scripts/ftrace2bconf.sh
> @@ -238,7 +238,7 @@ instance_options() { # [instance-name]
>  	fi
>  	val=`cat $INSTANCE/tracing_cpumask`
>  	if [ `echo $val | sed -e s/f//g`x != x ]; then
> -		emit_kv $PREFIX.cpumask = $val
> +		emit_kv $PREFIX.cpumask = "\"$val\""
>  	fi
>  	val=`cat $INSTANCE/tracing_on`
>  	if [ "$val" = "0" ]; then
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
