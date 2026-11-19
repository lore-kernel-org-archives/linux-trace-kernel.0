Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795050740;
	b=4tuOyhxy0XMH11A4nl1qbQ3QcNWBSoKjbZL0k4+D6N0m1LA9e/nmpLV44SHtdPEDRskY
	 aZsAttwKXEZ0RUeFC+eeoxf7Pg7oy4AJp2HOrhxxJIlbhI5bG6E9cXeQhgr5GuLiJ7pOg
	 vXdg3yQm66wE8n0UbV+jCcGPOzvxtnH5icSqigCQCP0B/Fn3wUQCgv+gL4i/+Me4rk1/t
	 O/hclyByJpLqyF0NsdWWsMo8zw9wRkRkZ+b8wrTuyuzCm4RsiluybC53MPfF9v+ZdnGu+
	 9gxh7rC2oyzTRn93VCztvw1tX6/p7ztx67t7XBBKV4RUaWY+aiuaxqkMw1abrJiMzJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795050740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=OsR8evBrjj486Hyj/oPni6delmu+mn6IpG/4Cx9Gl3I=;
	b=q+yjVebi0mupptFRG6ybBhBzT++4P25yZbbhN8AhRQ5vqNkEjI8WMph52WLfDN//oLV+
	 lR6k2GXql53CB/N5MjgZXLszQdkyomcYi0Hq7JwdHe1AWfPKnpahx+rYaFkUo0Iz+bP+2
	 1Ajln00SZITAwrrxAzUgKNraRst9KyxSVy/n7BeF6L6hKbW+zvAu2Ja14HbY1ajOzikVA
	 3XY48CO1r+8vohViq3o1TYOdczgrkrQHPhLwpQr7IG7RgzNpd3Dd1aioB7Zb6uemGQP38
	 uHFkR8givf7GTdQZajWY26qpMul34R2aalYIFx2SjRuohUFWMwhY2yH6IqhWo8XOA1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmxI2sKo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB3C606A31C;
	Thu, 19 Nov 2026 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NmxI2sKo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBEA41F000C5;
	Thu, 19 Nov 2026 01:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795050739;
	bh=OsR8evBrjj486Hyj/oPni6delmu+mn6IpG/4Cx9Gl3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NmxI2sKoYbjDxAm40MPG/kudnRpRV+sootWAKE/iLLOrXHZ+E4V9CPsFZ+G07zgvP
	 RZAxQf8IiWA30+JpKi87Ky0wJc9dLHqP1+4tLdusCcQP2s/yK2Z0oHY0vAusEvHRLt
	 A6rVi6Xs8dm4JhosmowHv5Kvfl0NdQ7WaJ42aDNQKddvvEDbieqq48AhRXm66QsdWe
	 VJQ746Sd+TLqbP33QIHehnWzW2YNUTRmZKgklAkyS/YiJcbMzOepBCUEfeVpXthQL0
	 Z4Q3J79/0L7JGJaqalK71ddaCU8biVs0wKhg3IaomqukPpj8AwR4n0PYPnSvZ6TgA2
	 3Wevx3BTosM0w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <shuah@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v4 07/15] tracing/filters: Reject empty unquoted operand in function event filter
Date: Thu, 19 Nov 2026 10:12:16 +0900
Message-ID: <undine-1795050736875941862-1da229c4d1949de6@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261117191544.7b60ce1d@gandalf.local.home>
References: <179323784538.740114.15323117974242744566.stgit@devnote2> <179323791027.740114.822862076687011726.stgit@devnote2> <20261117191544.7b60ce1d@gandalf.local.home>
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

On Tue, 17 Nov 2026 19:15:44 -0500, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 29 Oct 2026 10:38:30 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > In parse_pred(), when parsing an unquoted operand for function events,
> > if the filter expression has no operand before a delimiter (e.g.
> > '(ip == )' or '(ip == && x == 1)'), the loop terminates with len == 0.
> 
> Please show actual examples for this too. Not just showing "this breaks",
> but the actual echo commands that are written to the tracefs file system
> and how they fail, or not fail.

This also requires `perf` tool to reproduce the issue.

# perf record -e ftrace:function --filter '(ip == ) || ip == schedule' -- sleep 1

But actually, this is rejected without this change, this is more
like a cleanup.

So please drop Cc: stable. 

Thanks,

> 
> Thanks,
> 
> -- Steve
> 
> 
> > 
> > While an empty quoted string (e.g. 'ip == ""') is syntactically valid
> > and denotes an empty pattern, an unquoted empty operand is a syntax
> > error where an operand was expected before the delimiter. Previously,
> > this accepted the predicate with an empty pattern.
> > 
> > Reject empty unquoted operands by checking '!q && !len' and reporting
> > FILT_ERR_INVALID_VALUE.
> > 
> > Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
