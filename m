Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340243;
	b=Nk/Zycr8SrecmLK96kphOuEuSnl5MquiqspYWbtWnkU0suTnfVyydVHnsiO2slz1PGwZ
	 trGc0G+HnY+gcsOZ9jLFK3h4oAQWM3M42jf/acL/6mr0sRNCJG2CzA4zLKo0HSiYhvHuv
	 60FT8SwW9B/5OogxdluUds7v0bwLXKXqOPCBfHvVfJ+l9RDmbSTRYd0kY5/D7nRbl1Ybb
	 T6Ij7Gi55HdG/yjaY1Il2iw0XAUIVn1Ixru1/3kqCx6Wga0lzmou7rubE/f0/V1l+KQ1d
	 NYYMga9sU8UmZbUgHZuAR7u/LOquFCinXgCOIGPaVNYJlnFDmB+hkZY0+dUN4CwPMpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340243;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=uGm5+Q+bg7RLevTmsUWVviOyHCsV6tux0kj64LnT9pw=;
	b=j8nyDnR1ljjJGWA4tSktIpq8v6zu+DCNMHCebW8iK5CZtc8bs2xCLGQYb+8t6V1G7fst
	 3RbCrUBAoXcABL0PvMXNLH0KwYPnRBxbua7eHrE+YqWay6ugCWbQ9qJxcKMjhXWF+EOEU
	 r/t2Bf/cJt1mdDPu/ZPX1UXl1cVaVzyb/XEmYaza6xIv+K5RLrydKEuFPDnweUoa8i2B4
	 GwyCGjqp3q8oyHkZByVj+jmYTfEoH5P7A7pTzwhKFnLRH0R5qB3PuPqCsvRBl8+Sstid1
	 4QMQbCeQVgvzVhXFSPv0VeRgJi+9+fyMRW0laWzTe+kRkSbAkBVp6jSh0v8VMdexOFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oW69gayd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55724606A331;
	Sun, 22 Nov 2026 09:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oW69gayd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5C21F000C0;
	Sun, 22 Nov 2026 09:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795340242;
	bh=uGm5+Q+bg7RLevTmsUWVviOyHCsV6tux0kj64LnT9pw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oW69gaydXSlZyudPmA1K2uXAdYlF4JMExjQGSpUGTsObgS9BnxYggoOp8Y91f59Tw
	 8ZFl5pOaXHVV6wEjBbXLDRA5lZ1TtQYdby9mikD2A0emwD/dqSGyYRjLu1m15qGWrM
	 upjOCCeeBZuigHWP6wgr66T4bE0HfXX6Pjnm0So6a0LWiGM/V/TgG1FVnqN76caQQk
	 LuXFFrGlZxhZBSRLSZP3PG9AO1/Zj6qDk05pXYC05l8VbFJod0u08Gr2lf+pQVlADi
	 hNJ6I9Sl0MtCFopxlsMICUmZS4mPUUqze/3USxlzkB2C9k6w0K+2TRqgb5GMU+u0uo
	 GPazBA5Ok1n9g==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, corbet@lwn.net, linux-doc@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tools/bootconfig: Use the registered global tracing parameter names
Date: Sun, 22 Nov 2026 18:37:20 +0900
Message-ID: <undine-1795340240141573056-b3b8376c0d49c0eb@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <fecf6e33d4f7e2ddf031526e7a1abef27e28f754.1795307698.git.edumucelli@gmail.com>
References: <cover.1795307698.git.edumucelli@gmail.com> <fecf6e33d4f7e2ddf031526e7a1abef27e28f754.1795307698.git.edumucelli@gmail.com>
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

On Sun, 22 Nov 2026 01:34:58 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> The boot-time tracing guide lists four kernel.* keys that do not match
> the parameters registered by the tracing code. For example,
> ftrace2bconf.sh emits kernel.fgraph_max_depth, which bootconfig passes
> as fgraph_max_depth on the kernel command line. The function-graph
> tracer registers ftrace_graph_max_depth.
>
> Use the registered names in the guide and the exporter. Teach
> bconf2ftrace.sh to read those names, with the previous script keys as
> fallbacks so existing replay configurations still work.
>
> Fixes: 47781947947a ("Documentation: tracing: Add boot-time tracing document")

Since this patch also fixes the key names in bconf2ftrace.sh and
ftrace2bconf.sh (which were added later than the documentation), consider
adding the corresponding Fixes tags as well:

Fixes: 7e66ef0046cc ("tools/bootconfig: Add a script to generate ftrace
shell-command from bootconfig")
Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates
bootconfig from ftrace")

Thanks,

> Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
> ---
>  Documentation/trace/boottime-trace.rst   |  8 ++++----
>  tools/bootconfig/scripts/bconf2ftrace.sh | 21 ++++++++++++++++-----
>  tools/bootconfig/scripts/ftrace2bconf.sh |  5 +++--
>  3 files changed, 23 insertions(+), 11 deletions(-)

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

