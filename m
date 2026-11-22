Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795312943;
	b=zwpXxz1sEYNdiG2M8KRcDzv+F12pb2imotW5rFfZrR9euDm2KE/op3l0sD3gI2rcjcex
	 2CpLiozR+/ipYrMSRgv478i6fw47Upz0W8iP6eC0Ec6SP3zpjvzI6SQ41Ux1icU9Agexs
	 gYD+5ZwoZEVsPHocHEsl1cyj2DoO93MT5cpAdX81ZU5y4fdksbyb4ZYWKcqQ48Ye57aFG
	 R0s9cA1tf7V2RF8rCV+diWIVEE73aBEm/VSsLeF8kG5VmSQYtABuN+5ZteKaI0dN90Yj3
	 5bTPtgw3bb9VOQfb+eH2589qB5XFMij0Qwb+KsATKAkYw4WYTbmqkECEd7whIX53wUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795312943;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ES3d8QpSXIy79RgEWQdaKOViAuvjlt/ga+4tQr4jfDY=;
	b=E9KjnbIXje2g5/GTt25fbNnBmfjv6WR14g6BOwjO0MjtppyqIHuphOI7rNq6hOV1l+vF
	 7+UdF9p2B2PABJWyUiI9rbmnx9N0lVwU8v7C/c2y4LzOfw86P2SIr2Jaz5FO7ggwSffYS
	 fJnGRlEQfuA4DPPBdtGjDVsOWRA+2/1PajLIU7Zzgy7zOd6FIdMmqjCSExrAxuZE1lBiw
	 jvdcOxpwlQyhsGiy1ei3/GJ+Plfqk4x8uPOQYGnY/6KYBSCstKQuph4heGIdPJUZomvN2
	 US1oC0MBMAUD7HdYDScNizm6yiplvHLfVJ4njKe5whED2WQdsidSt++Pc4KJqFe/caw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2vsYAkB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E396606A320;
	Sun, 22 Nov 2026 02:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c2vsYAkB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C5F1F000C0;
	Sun, 22 Nov 2026 02:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795312943;
	bh=ES3d8QpSXIy79RgEWQdaKOViAuvjlt/ga+4tQr4jfDY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c2vsYAkBULqjcDJcmA/Il26ZsD6sVKAviZtGhIC8QPQdWKa0InpSnzXPd+Wa0aiEF
	 dM1ew/gyO9gN1Q3H3iYlhkpywjRIdxbIdGD8eTtCyvl88vVV1fUZV+uKcYX6MP+ClJ
	 TTSVcOp4YGgTZD9Pm5OefpnaWym1lD/VZafniUPff4V4TxvzADTCe8dvj4m5LNcE8g
	 8O2ydBcKOCSYMzFPX/TlX8Nx0/I3Q96gJXlQboFvPVGBhWH0dtdkjw1YrBJ69jH3X0
	 Stfb1vx14g8ArJR4RcnMQYoZJIjTQKgOXhEe3MlTGuK2/kWQISM/V1CVBgQ4ZaMxjZ
	 gSkEdtDvmCDFw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Preserve arrays starting with an empty value
Date: Sun, 22 Nov 2026 11:02:20 +0900
Message-ID: <undine-1795312940919368991-3e5277c17e0a1400@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <e40c6adf42ba4b90cd16d9ca955f38c6c4783eb1.1794956874.git.edumucelli@gmail.com>
References: <e40c6adf42ba4b90cd16d9ca955f38c6c4783eb1.1794956874.git.edumucelli@gmail.com>
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

On Wed, 18 Nov 2026 00:07:57 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> bootconfig -l treats an empty first value as a key without a value.
> When the value is an array, this drops every subsequent entry from the
> output. For example, 'key = "", "value"' is printed as 'key = ""'.
> Reading the list output back loses the second entry.
> 
> Check for a child value node instead of checking the contents of the
> first string. This lets xbc_show_value() print all the array entries
> and keeps the existing output for keys without a value.
> 
> Add tests for direct arrays, appended values, nested keys, empty
> scalars and keys without values. Exercise list output from both a
> configuration file and a test initrd.
> 
> Fixes: e4f70b7badb4 ("tools/bootconfig: Add list option")
> Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
> ---
> Hi Masami,
> 
> Thanks again for reviewing the earlier bootconfig fixes.
> 
> I tested the list output on my Ubuntu machine using plain bootconfig
> files and a temporary initrd image. The two new output comparisons fail
> on the original tool and pass with this change. The full bootconfig
> test suite also passes with the patch applied.

Thanks, the fix itself looks good to me. However your test case looks a bit
wrong.

> 
> Thanks,
> Eduardo
> 
>  tools/bootconfig/main.c             |  2 +-
>  tools/bootconfig/test-bootconfig.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index d3f840c5adce..b189ca0935b9 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -170,7 +170,7 @@ static void xbc_show_list(void)
>  			break;
>  		}
>  		printf("%s = ", key);
> -		if (!val || val[0] == '\0') {
> +		if (!val || !xbc_node_get_child(leaf)) {
>  			printf("\"\"\n");
>  			continue;
>  		}
> diff --git a/tools/bootconfig/test-bootconfig.sh b/tools/bootconfig/test-bootconfig.sh
> index f584f7637e12..85d56b7e4ac7 100755
> --- a/tools/bootconfig/test-bootconfig.sh
> +++ b/tools/bootconfig/test-bootconfig.sh
> @@ -156,6 +156,30 @@ $BOOTCONF $INITRD > $TEMPCONF
>  cat $TEMPCONF
>  xpass grep \'\"string\"\' $TEMPCONF
>  
> +echo "List output preserves arrays starting with an empty value"
> +cat > $TEMPCONF << EOF
> +flag
> +empty = ""
> +array = "", "value", ""
> +append = ""
> +append += "value"
> +nested.array = "", "value"
> +EOF
> +$BOOTCONF -l $TEMPCONF > $OUTFILE
> +cat > $TEMPCONF << EOF
> +flag = ""
> +empty = ""
> +array = "", "value", ""
> +append = "", "value"
> +nested.array = "", "value"
> +EOF
> +xpass diff -u $TEMPCONF $OUTFILE
> +
> +echo "List output preserves empty array values in an initrd"
> +xpass $BOOTCONF -a $TEMPCONF $INITRD
> +$BOOTCONF -l $INITRD > $OUTFILE
> +xpass diff -u $TEMPCONF $OUTFILE

This second case actually reuses the $TEMPCONF which
already overwritten by canonicalized expected one.

Thanks,

> +
>  echo "Repeat same-key tree"
>  cat > $TEMPCONF << EOF
>  foo
> 
> base-commit: 381b391bfaa3f10d52da4740529804b0b6b8160d
> -- 
> 2.53.0
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
