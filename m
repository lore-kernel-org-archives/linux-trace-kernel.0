Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546717;
	b=LpCxWNBQOBbweqRvSsgMbMV/LqdOyP+iPvR2UkfZ5UkQE/hJIzuIhysaJXLOH3o/bg1T
	 KvAmCueYFMrtWFf15rPAm8ZE5+Ne26fsKWd6m63nS+3Y3JzepcWH0bBKbpBA50uRvF7gt
	 p4DmEgNCnZLcPcIjA2B0HQ9EOyJCoo6OWUV7vGMXV7a80aeyaBUwlk2gcuAvKlTwnLKCg
	 hoXAOlkN3yyd2uxts0TRlfqCwBbqCWfBWu00d9Wa6vABWIgSGcf6hMV1iQtZquXhvk8yS
	 E3FrJK4FPsEdwSYZSs+o+fpDRoUomQnU2pChBulI4SVkHM6RAV+YweFAMOgxVc/s1DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546717;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eJCeJm0SzOPFgAQtVHYOI/wNOE8f6A/g91ADM21Bu8Q=;
	b=OaneuGTeZio0XNqjzL/JaM2zLWEtlg7LI6iGc/yrQmTl6cU4od+8u8a3Oui9Z2GR3OXZ
	 +NkqTqHQ6sXuNHs4eDNf2FFbse5RzrG8BdXzymkmhqbqIPvkKKf20OghJChLZJZ1XGX6q
	 MOY3qm4HtWkdSSRAH0h7e1dUsjpRLLfwWiZaEhe+RBQpySX6JlyQ341HTfPNMXGdn1mfV
	 EN2++sh4zon+SoMstA0l6TAZB92depELLyE4RYQFeqK5vmAuPoueqHhqxEn2UCGWAlF9t
	 QsqgVuHTl4zLKNG8GiKzsbyVFvR1jxhWUA+mdpklWLtJ55Ru9tYVdChodDdYgTBFafQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+q2wKae;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED2C606A31C;
	Fri, 13 Nov 2026 05:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T+q2wKae
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1911E1F000C4;
	Fri, 13 Nov 2026 05:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794546717;
	bh=eJCeJm0SzOPFgAQtVHYOI/wNOE8f6A/g91ADM21Bu8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T+q2wKaeJWVDZoNuzPL+dHZmn4h/20cPbzFesJV9p7V6puAp+JWcyJOzJeUS8NObP
	 HMNJtGI+BRr8d6R8D71A8cwSZ4xyDkFLWWxcf/CpBXCb1jIa/cUCDdsZN4MkNqmHUs
	 dPjnd+HzePrSM9p/5Kt5OFjE1ZaLKLCwbWgqSkaX65f/USdHAJTgEnPqFrvR3zsNfK
	 cow/1B8XJ29NrK8P06oNKTylXfMcjk8N11t9MkSpJ00STJUK7Q8GSp2fvphjy3B2DV
	 a2v0PsMOrjrg5NHNALAClFDp9QmGZPziGS9Pdfdo87wMRQR8wCtl+Ww3chPm6SmNLk
	 ePpMMTn44ig/w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] bootconfig: Trim unquoted values at end of file
Date: Fri, 13 Nov 2026 14:11:54 +0900
Message-ID: <undine-1794546714483023333-db7a7be5c2ee185d@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <31f248f330e716b925add3a0ba76f62826527312.1794337724.git.edumucelli@gmail.com>
References: <cover.1794333957.git.edumucelli@gmail.com> <cover.1794337724.git.edumucelli@gmail.com> <31f248f330e716b925add3a0ba76f62826527312.1794337724.git.edumucelli@gmail.com>
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

On Tue, 10 Nov 2026 20:08:46 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> __xbc_parse_value() trims an unquoted value when it encounters a
> delimiter, but leaves trailing whitespace intact when it reaches the end
> of the input. Thus "key = value   " has a different value depending on
> whether the file ends with a newline. The extra whitespace also reaches
> the rendered kernel command line.
>
> Trim unquoted values after the scan finishes, including at end of input.
> Skip trimming after a closing quote so intentional whitespace in quoted
> values remains unchanged. Add checks for scalars, arrays and quoted
> values without a final newline.
>
> Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
> Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>

Looks good to me.

Thanks,

> ---
> I tested inputs ending in unquoted spaces, tabs and carriage returns,
> including arrays and appended or overridden values. The checks compare
> the parser's actual values and the tool's rendered kernel command line.
> Quoted whitespace and inputs ending in delimiters are controls.
>
> The original parser fails nine of the 18 focused checks. With the fix,
> all 18 pass, independently and in the combined series. The full
> bootconfig test suite also passes with the regression checks added.
>
>  lib/bootconfig.c                    |  5 +++--
>  tools/bootconfig/test-bootconfig.sh | 18 ++++++++++++++++++
>  2 files changed, 21 insertions(+), 2 deletions(-)
>
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 819685d6c68d..bd071c394c36 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -793,16 +793,17 @@ static int __init __xbc_parse_value(char **__v, char **__n)
>  				return xbc_parse_error("No value delimiter", p);
>  			if (*p)
>  				p++;
> -			break;
> +			goto skip_trim;
>  		}
>  		if (strchr(",;\n#}", c)) {
>  			*p++ = '\0';
> -			v = strim(v);
>  			break;
>  		}
>  	}
>  	if (quotes)
>  		return xbc_parse_error("No closing quotes", p);
> +	v = strim(v);
> +skip_trim:
>  	if (c == '#') {
>  		p = skip_comment(p);
>  		c = '\n';	/* A comment must be treated as a newline */
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
> index 530ce7e28d63..a2e8311d4d19 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -171,6 +171,24 @@ $BOOTCONF $INITRD > $OUTFILE
>  xfail grep -q 'val[[:space:]]' $OUTFILE
>  xpass grep -q 'val2[[:space:]]' $OUTFILE
>  
> +echo "Remove unquoted trailing whitespace at end of file"
> +printf 'foo = val \t' > $TEMPCONF
> +$BOOTCONF -l $TEMPCONF > $OUTFILE
> +printf 'foo = "val"\n' > $TEMPCONF
> +xpass cmp $TEMPCONF $OUTFILE
> +
> +echo "Remove trailing whitespace from the last array value at end of file"
> +printf 'foo = first, last \t' > $TEMPCONF
> +$BOOTCONF -l $TEMPCONF > $OUTFILE
> +printf 'foo = "first", "last"\n' > $TEMPCONF
> +xpass cmp $TEMPCONF $OUTFILE
> +
> +echo "Keep quoted trailing whitespace at end of file"
> +printf 'foo = "val "' > $TEMPCONF
> +$BOOTCONF -l $TEMPCONF > $OUTFILE
> +printf 'foo = "val "\n' > $TEMPCONF
> +xpass cmp $TEMPCONF $OUTFILE
> +
>  echo "Showing correct line:column of no closing brace"
>  cat > $TEMPCONF << EOF
>  foo {
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
