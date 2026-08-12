Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43F546B5;
	Wed, 12 Aug 2026 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493110; cv=none; b=iFNRyKG8d2CCiBFtPG933cQsmUIGLDCTYdKBvLbLdC0Uk/fEnWkGoZOUz2vFJzVXfBkQrIIttgxiyyfazHNav+Tvq43R21XBHBmuOgZa3oSkXTXJzptp/m5go3oksQyavhQZZhRUWPgEpJPqTxppykoom3mrwss6GZBFbWceN0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493110; c=relaxed/simple;
	bh=Pl5lgiQiNfgqGh5dNJMoSOQfg6eXJwJBZzHK9rAdOY4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=JurWqw1Nr8efPwc1lCRPZFFiSPwU5JLFcut16wLcp2v27vKqVAC4NKHBXnEkKmB/YjcFLpMWyqlUeuaIT4EuGdP8SFOYGKzrYZOBt6DPHXHOQ2nJPPYNDsFTitutAPm6lVKLyc2nDFmz5jlkcWI3vhsJyy8xfM2Idp/U6MWgVxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2HMtloO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2HMtloO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 863211F000E9;
	Wed, 12 Aug 2026 00:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493109;
	bh=PA1ySDh/OvMXGeiaz1aFzqS2UjX707YzhZPwFrp/Rh4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l2HMtloOz9fE/ypdHLaeuFAuYWmK+BEYLNRFY0RNHiLdAkTGMN53WpZ3Zw7CcHefe
	 jxhjXEvQcpRiW//YtxZ/sQj3DXtFq/P/Bg/RztZQGKn7F8UxeQ6UIvHNLD/us3orj7
	 AUUr0vVwCGQPh3yijG4jpgle4GLeimbwBJkcHkQr4wPaSope3QjlQrjM5ofcA/9xVM
	 OixEhg+v19/M2VXe85RAk/lIWsq2Lbk7s/O2uT9bdshXHhJBXYTvqqP/BIcHV7vRfW
	 5sgur478EjxbuGYpyhK/9q/W4TQY57MkiNjrU8EmqWB9Oyolyx3nLpK5qOr6P3o7c9
	 Uug44J5qqufTw==
Date: Wed, 12 Aug 2026 09:05:05 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Shuah Khan
 <skhan@linuxfoundation.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] selftests/ftrace: Add generic boot tracing test
 framework
Message-Id: <20260812090505.4ceb89ac14a93c56c352ad8f@kernel.org>
In-Reply-To: <178646246740.428104.1537952219449559438.stgit@devnote2>
References: <178646245730.428104.4400499381224001727.stgit@devnote2>
	<178646246740.428104.1537952219449559438.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Aug 2026 00:34:27 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> +# Verify busybox architecture compatibility
> +if command -v file >/dev/null 2>&1; then
> +	BUSYBOX_INFO="$(file -b "$BUSYBOX" 2>/dev/null || true)"

Sashiko pointed:
> 
> Will this check skip the tests incorrectly if the busybox binary is a symbolic
> link?
> The file command is invoked without the -L (dereference) flag. If the provided
> busybox path is a symbolic link, the file command will output "symbolic link
> to..." rather than the actual executable architecture. This causes it to fall
> through the case statement below and incorrectly skip the test suite on
> supported architectures.
> Could this use file -bL instead?

Yeah, I forgot that case. Let me fix it.

Thanks,


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
