Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A82F7F14
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Jul 2026 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784860405; cv=none; b=ccf1eHuyQtd9vM4ExjjweXYIKcy5gNQPzovQe6mEGfAhRIazWOGpYqyd9kLOZDGmTjlrh5hSB1kJRE+XK5uv5V7y1fkEmFl817xNUeCHPsPaHITwdyJhXyQZe2Kq9hDX02chLQCjmSOjyZiZUiK+MChw+5rxyQ7xlfkvr+Mf2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784860405; c=relaxed/simple;
	bh=nuRw+6p67qaHazyhijHeIaFQfYRohH4J45oaItgPOiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K97517qwDIA96f8CNLLfzLxCaUV0Zo0srTZf9ChUau3fXqprwJo0n33UsL3sfvakjLzdkSxMdETVFFBhEG5/O7OMlPGYTA2/E/MSB6vIGJUuS3pdJXPqEBw4TGpG1/xNeucfdkGebJk+otm/P0StTKRauid3XMKG5fxGX5Q72Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8n8J0HM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8n8J0HM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cc73e322dbso14428175ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 23 Jul 2026 19:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784860404; x=1785465204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRpZaMx5e+nGKMC8zc7uMAUN5qp/LA2gF83ppDblymU=;
        b=a8n8J0HM9Zy6oat7WvZ60201RtAjbz9f5A3n/9iz/qgVXZysY5xOiE8I1GaCYSqqHo
         LebkMdsUYP9/+dzDoLwCvE2LsjVpWsSqmpVzFXkfyW5/4voOoD6VgTmlNGJYnHZgwtox
         WC256pCSexpYAp9AdCGWxxijmSEZJ6M+n2mEPjptkUE/yOWeioSBul6Xgxhcj8PQqN2I
         l3RqHYKWcQwR1KOwbTIqBfT0BEhAfc5NCbp4albLBQaqKmDprXFFmf7DY9aEWHUPfaYJ
         LM0K/4O+2c5WYF+MP5YtAgQRNoD90ZFzRKsKIKeARfsl6njp+CXYf0OEf90qtQ+czcD3
         sDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784860404; x=1785465204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uRpZaMx5e+nGKMC8zc7uMAUN5qp/LA2gF83ppDblymU=;
        b=o0zmvJcLEoO4YvVK8QFbCrzPFM6bv5TLhEiN4mKYvyLLEz7I3A6nXdnvyL6GrXph+Y
         opTENKrReaXFbbiEODzEz1HQPywh410r8EuEucFVLIKr4lFMrrsuv+futT92XfKZX5mZ
         f5ZaotRLkqiZAR46aqw5GSo+Q9sIbIHvv+N7GRgSWuoWXW3mI+vaEZ8Ms+sP/N1E+EWx
         WJLkR+WCXaXIoR0FfQOcVljcHp+5ssoU7DOixOJ1eXTq45ntVHDx0qF6kPnRIo6iZNQ5
         fC3ytTeKd+ae0A8tzHulRaqa6yDG6zv+wyKokTA24FHUETEiQ4uwpQiSJojYkgvlK59j
         RCoA==
X-Forwarded-Encrypted: i=1; AHgh+RpiS80IuZzlAoTN49d6jBQ0BX9qCObKZEMpXcDa2jqVUwzvBQ1LOCKVBoyW3+pMRJMAvwXx6jUURdw7txL5/QUQ3y4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy35Ak9vz3kZDd6lqcxlF4pGlWCKQrKfo5f9Iu7iUBDqECrES8c
	aI+KyVpQiLuyo40Mt21WrQwiJvUXnKK97NeglqMaREPBMc/kSb2oSzxn
X-Gm-Gg: AR+sD1354qQ5wItm8HakhSu764Gzs2T8TRlOOxxBdQdkikde506xceqWZLJpBrHTnWk
	mSbxC51h9UqEoRRhw9awIoG7KHrzwLDJz2EwsBQLCe0Wyu3eyB91VrEwqjAHFEZa1tGJXMZ6GsT
	QxH4lQevE+ehNch7W+TKE/oklyMb3Cp2Jdz64MUSAZh1s4t3SaJSMjtnIhBQPgPPmN8isMv8OKJ
	vGnnuPn5UyJJ0Kuooh+vW/fBNxO+EDpBeh/nrdSjSvsQbC/pAbw2n+POFJQmDF85PONjwZ3CIxh
	L7M+pEKb8kzn2C44/rQ+w2wdZ13dgrL/prQgPttgZ5L81HD7gBlX1ZQNEmvytaG/eTfAPuF9qp0
	/cLvZU7DQYHZbgGfQJWq7OW76KM9WF6iHm++mbdnvGK4ZalxTwlTrdd75vXRLgkxK7/au//iikp
	u7o5xQkP13zzP1YA==
X-Received: by 2002:a17:903:2341:b0:2ca:d975:5bbd with SMTP id d9443c01a7336-2cfa6b995b6mr65133375ad.20.1784860403839;
        Thu, 23 Jul 2026 19:33:23 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f350560sm43044905ad.68.2026.07.23.19.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 19:33:23 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 4/5] tracing/probes: Extend max length of argument string
Date: Fri, 24 Jul 2026 10:33:17 +0800
Message-ID: <20260724023317.624074-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178399140457.27810.11387684872148824707.stgit@devnote2>
References: <178399140457.27810.11387684872148824707.stgit@devnote2>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Jul 14, 2026 at 10:10:04AM +0900, Masami Hiramatsu (Google) wrote:
> -	char buf[MAX_ARGSTR_LEN + 1];
> +	char buf[MAX_COMMON_HEAD_LEN + 1];
> ...
> +#define MAX_ARGSTR_LEN		255
> +#define MAX_COMMON_HEAD_LEN	63

Keeping the head buffer at 63 avoids growing it to 256, but it also
preserves a pre-existing truncation of the kprobe/fprobe head: both
trace_kprobe_match_command_head() and trace_fprobe_match_command_head()
snprintf() the symbol / function name into this buffer ("%s" or "%s+%u").
Kernel symbols can be far longer than 63 -- Rust-mangled names are
routinely 150-200+ chars (KSYM_NAME_LEN is 512); I see 199-char symbols
in /proc/kallsyms here.

This is the same delete-/match-by-command path you just fixed for the
args matcher in commit 15f197856d68 ("tracing/probes: Avoid temporary
buffer truncation in trace_probe_match_command_args()"):
dyn_event_release() passes the symbol as argv[0] to
*_match_command_head(), which then calls trace_probe_match_command_args().
The head runs first, so for a probe on a long symbol the head strcmp()
already fails and the probe cannot be matched/deleted by full command --
before the args fix is even reached.

Would it make sense to give the head matchers the same direct-comparison
treatment instead of a fixed buffer -- compare the symbol (and optional
"+offset") against argv[0] directly? uprobe already compares its filename
directly, so mainly kprobe and fprobe would need it, and
MAX_COMMON_HEAD_LEN could then be dropped.

Thanks,
Xusheng
