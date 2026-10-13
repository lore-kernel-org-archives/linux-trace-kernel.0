Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E98723AB87;
	Tue, 13 Oct 2026 09:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883031; cv=none; b=aNxEP/Q/IGErlk/ugxQlOAdtiVeTZE9cIlJdpC6rN5eVPrftMP3dw7b/8UDgsVmdpIcT+s/k+T0h/g37MvydvYIP9oLh04WoN0cX0so5PGjKIKBa1tWXjDhKe8ihYiAO4UCVBEGQMSb7sKFz/ZySudpjDK9suivIRzz8kexJv3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883031; c=relaxed/simple;
	bh=o3hVqz2iMt7hW2IxywccrCJbpHk03oL077zjQq0SWS4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=lvkkqTIACdAFJGfMiM9CnzCMA8PIl/rthWu77eLN4ezPu0IR19hVZQ6IK3KEmp3PfBJHmhH1zLAfmGVXra5NC0BPNIDo5FMGGs9nRMfUrTOnOy/lc6ZhlHWktyP4kex+CAG8mqLP52zDm9hKbCsUAvHauK7TxxCybASEDtKapOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTTQict2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTTQict2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8CD1F000FF;
	Tue, 13 Oct 2026 09:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791883029;
	bh=xHXAoQop8Qj+PqOPWoDrnSuYWTqR2PoXrWGbU3k0ivU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cTTQict27WBqS/1txTwjla2yFEn03enH/v+zFpy12Io25skJQb3vByl0X7mllLXs9
	 Xf7Szq2PAxq0ngaB258nJS09IFu7/Zuhs/vUWCJ5nCYv73xexDXUecbGnKHKJqNmNk
	 +zMNl9y9ntpl1Ashc2OwoHfrXHfEEV7uBSr479l8dpa2jUkOQWksVQvmKjRXpMQK6D
	 jGHJ1N4Rvae5ERJ83Fnn4ui1Nn1kIeMutUYgO8A6MYCNRQFMpk2sP/QaJmmbFNf3Ep
	 L554P2Vscd/59xOsaMwQ7yq3ZAu7wCm6PnET37NPCIRDA/KPLY9IYL7uxVzI0IpC6W
	 vHJ6Jkap+qDSw==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: martin@kaiser.cx
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Markus Schneider-Pargmann <msp@baylibre.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Martin Kaiser <martin@kaiser.cx>
Subject: Re: [PATCH] tracing: probes: remove unused variable
Date: Tue, 13 Oct 2026 09:17:07 +0000
X-Mailer: UndineD 0.1
In-Reply-To: <20260502135826.146257-1-martin@kaiser.cx>
References: <20260502135826.146257-1-martin@kaiser.cx>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261013091708.CE8CD1F000FF@smtp.kernel.org>

Hi,

On Sat, 02 May 2026 15:57:42 +0200, Martin Kaiser <martin@kaiser.cx> wrote:
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1747,7 +1746,7 @@ const char **traceprobe_expand_meta_args(int argc, const char *argv[],
>  		if (args_idx != -1) {
>  			/* $arg* requires BTF info */
>  			trace_probe_log_err(0, NOSUP_BTFARG);
> +			return NULL;

Returning NULL here causes traceprobe_expand_meta_args() to treat this as
success (no expansion needed), leaving *new_argc uninitialized and passing
the unexpanded "$arg*" to subsequent argument parsing (which later fails
with a confusing error).

We should return an error here rather than NULL.

Specifically, returning ERR_PTR(-EOPNOTSUPP) is the right fix, which also
eliminates the need for the params variable.

This is a bug, introduced by commit d157d7694460 ("tracing/probes: Support
BTF field access from $retval").

Can you update to fix this bug?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
