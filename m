Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793433867;
	b=UezEp1t1qV3EANyy/yv/t65WGoF/0ITBdc1sm08RxBinEXul9L5huCpEqeXvIjNYoaWO
	 Ka7HlPkvlmH0BAIfYDimcFWvmnxbvlJe690/iPfppoKzi2m0sa/6Z5zcXEa/OuoyULfH1
	 Is9b0rejwYfsFFNP03NkJG5hTb0ps3gIU24M5l64k4wWnRUZKhfHaPY2ZppIlqy+xkOss
	 h2KeCpmagfJjJvbAU0no7gFIdmWNSRcMF0m4//OtPYyVt1G2io1LRAjd19ZvJ0DIQQGIA
	 zmvp8hz+X9E2D81cnS/CvbCYUAqS0J5iIYPwdNASlwgKBtsjL1ZyBo0vc5ggpvryy5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793433867;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ETjKGxRJZQwL/tHZCGSwYQ2xBEYiot88BuBKkLvLIzw=;
	b=XyPB/Yp0MruAG86+TpH5GaIRwDlxMcPF5dr5IhdaKB/oNEKyShMmZp1cEfEIcb51zt+m
	 nneEXVEsd+3ZVO6KYSo6NWKr3di0NUDzqD/XAGAZiKTlTLV+lzWQUGrczD96rhMNa3Wz+
	 rgWoaNwiR7ze+gsv0uoaYgmdWNJ/5IHhf3jf5U3N7Fnmoz7ktPgsX7u+se9U7DIDYfOly
	 npc7VhtdEZKgt0pSMaoLjiQe6V6Y45xAiEhRb2MxCyXsXO1czBvAKnuqtErAercq7xEoX
	 8XJQn/nWD/bmjsbHtJXfseyqGhzoGPXqnrk2DZuLeg0U+g+EpfeusQM1woWAwCHfyng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVWAi3lN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE9E606A31F;
	Sat, 31 Oct 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CVWAi3lN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 034081F000C1;
	Sat, 31 Oct 2026 08:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793433867;
	bh=ETjKGxRJZQwL/tHZCGSwYQ2xBEYiot88BuBKkLvLIzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CVWAi3lNo20du4GUdREDNuvv66dXelZf1zat5HN4FcLjXRhhob90rj61B8IL8Zu6i
	 tB8ofaKtGGCFaQMM25KzHnM42dV2lssbD4jO1uuI8XC+4fzWDKYpbUD8Z+Zx1MAnq3
	 VWLIq9d0DEgaDLKc1vhBx3BBVOtAuFrtbKojzDu0q3LchcCdkNv3gNaG+wmyq/ALzs
	 9uCmL/hMm8pMWg+0u1VA9Bb3QRkW6uA4LqE8P/CGR48iyP02j++QfURH4k0Ws6GJ70
	 FN8pZzBvku6373hOqUi6OFjazxS8m6+Dd5wtK1CtnfoRVLChw++y+SjPnY4na0moXg
	 VpKUlIzk9+ISw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tools/bootconfig: Quote event filters in ftrace2bconf.sh
Date: Sat, 31 Oct 2026 17:04:24 +0900
Message-ID: <undine-1793433864042937644-94b6416c3135cce3@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <a60d6ff14ecfc1ea7a20444fd61c5ca47385e163.1793364709.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com> <a60d6ff14ecfc1ea7a20444fd61c5ca47385e163.1793364709.git.edumucelli@gmail.com>
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

Hi Eduardo,

On Fri, 30 Oct 2026 13:51:48 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:

> diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
> --- a/tools/bootconfig/scripts/ftrace2bconf.sh
> +++ b/tools/bootconfig/scripts/ftrace2bconf.sh
> @@ -126,6 +126,14 @@ per_event_options() { # event-dir
>  	val=`cat $evdir/filter`
>  	if [ "$val" != "none" ]; then
> +		case "$val" in
> +		*[',;#}']*)

This expression is a bit complicated. Could you explictly escape the "#" and "}"
as "*[,;\#\}]*" ?

> +			case "$val" in
> +			*\"*) val="'$val'";;

If an event filter contains delimiters alongside both double and single quotes 
(e.g. `prev_comm == "a,b" && next_comm == 'c'`), matching `*\"*` unconditionally
encloses `$val` in single quotes `'...'`. Because the value itself already contains
single quotes, this produces an unescaped single quote that will break bootconfig
parsing at boot time ("No value delimiter" / "No closing quotes").

Since bootconfig does not support escape sequences, such filters cannot be
represented when delimiters are present. Rather than outputting malformed
bootconfig, please detect expressions containing both quote types
(`*\"*\'*|*\'*\"*`) when delimiters are matched and emit a warning to stderr
(`# WARN: ...`) similar to other unsupported ftrace options in this script.

Thank you,


> +			*) val="\"$val\"";;
> +			esac
> +			;;

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
