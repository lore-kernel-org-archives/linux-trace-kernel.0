Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795557263;
	b=GU1jU1h39Y1dJ1A0Gj9c4vcQRnGaBJNzYvxlRpyBZ4VuFLx9YGo6WW3vnHW5iLTryHlX
	 TjuQeWcTjnK+o21w6pds+W8iYSG45YW59UBUWmpId9jY24MFzQqf+0js4ta3LeVbOsgej
	 KPYBHihFr+1hwveB0X6GWSHzByJtoXPijBAbvO9LK9tuBbfk7kVCA5VikJxg9FwT1HDDU
	 fdM72khfIdOFvYVw1v6TBlplWOBEX/YIIv18JGOA3U2e1ZNv2KueCTUo2RPhHKGeEMWfR
	 K+uf/rOpcP2t5JchjEI96/HsPOP0V9F1UbwnRwi02YGtwNY6AMz2JycwAlfbBA9dX7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795557263;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=DPI6tqsOsb2ZW56JDaO2GTE8unnmk4hX2IzeaebFPY8=;
	b=swJC9D/uQN0scQ0VH93xzcdpNj1tnJy5ZfWsv4y5ulBfoV0WyyE3dy1fA17lDvnbAxto
	 8QEKW6nd3AFncXlW2i0P/OIkdR//xYkj6EBbe8qOS+EmIG3y+89FgGGTnVVvw3cN6f2o6
	 B+kLkB0BApT4w4jw6WWTnLOaEY3S37YtrTN4xiZoutv/DZg2NeyZchZyuIdrEttOs5BN3
	 aaOentWmPvDS3TSeHdn6FfAEstbjtjC36P6PAbqN8Awvc5CqyRVgHcD738k6opig7yEj3
	 LkYmTjytmvP30/i0fkXB1FS7hpspt7/qOaKIr4JkAGo1h2G4i18Srcd2m4aeHwAgMag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXFhp55B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548F606A321;
	Tue, 24 Nov 2026 21:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bXFhp55B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6941F000D4;
	Tue, 24 Nov 2026 21:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795557262;
	bh=DPI6tqsOsb2ZW56JDaO2GTE8unnmk4hX2IzeaebFPY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bXFhp55BRMGD++RNx51CBV20nnzegnzuSlx7ez2NhMn5T6YIc3AtRcoqD0RAgK+Df
	 qVuyfEWuClCod7ceqfnu6sCbJXeHVv1X9vhOBIX/zXzo9bTkqt1yNvnRWdBVhNUtLz
	 R3w/4oBcis0gm9WdcD+bJ6qC552UJ8IV/su9NZ4Wk14TNW5utCMKlfsZhPmdB8oFow
	 /HgG4hllHw4Hmr9I6vBNWRj+uU2GSGAJsj+ZuF0V1GteQObSno3wfFMRy5ojRXyAQ5
	 lv1OKJOdi1QisyP4Oc1eh2BJsAwAsX0X7w6Fz7JaLPmyHAMJMEYzybLsSrUFkg59Hj
	 C2aN9U/bqeizg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/bootconfig: Reject short reads of configuration data
Date: Wed, 25 Nov 2026 06:54:19 +0900
Message-ID: <undine-1795557259610595967-b07838a664370b81@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261120061912.98156-1-zhujun2@cmss.chinamobile.com>
References: <20261120061912.98156-1-zhujun2@cmss.chinamobile.com>
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

On Fri, 20 Nov 2026 14:19:12 +0800, Zhu Jun <zhujun2@cmss.chinamobile.com> wrote:
> load_xbc_fd() places the terminator at the requested size even when
> read() returns less. Its initrd caller then computes a checksum over
> bytes that were never read, while the plain file callers can parse a
> partial configuration. Reject a short read and release the allocated
> buffer on both read failure paths.
>
> Fixes: 950313ebf79c ("tools: bootconfig: Add bootconfig command")
> Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>

OK, this looks good to me.

Thanks!

> ---
>  tools/bootconfig/main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/tools/bootconfig/main.c b/tools/bootconfig/main.c
> index d3f840c5adce..a3935e1a8c6b 100644
> --- a/tools/bootconfig/main.c
> +++ b/tools/bootconfig/main.c
> @@ -190,8 +190,12 @@ static int load_xbc_fd(int fd, char **buf, int size)
>  		return -ENOMEM;
>  
>  	ret = read(fd, *buf, size);
> -	if (ret < 0)
> -		return -errno;
> +	if (ret != size) {
> +		ret = ret < 0 ? -errno : -EIO;
> +		free(*buf);
> +		*buf = NULL;
> +		return ret;
> +	}
>  	(*buf)[size] = '\0';
>  
>  	return ret;
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
