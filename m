Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25D93CFF44
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Sep 2026 13:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701686; cv=none; b=U7YS/wnMXGnU+wu6Qzf5BQEMOc8ky/VULiUzlf88JNwDFNjU2XQMHmY04NFfI5p0IvvCHxLeSGh2rWsQPlT1JceuAJ62tMqhgN+Ep+ZSPpQhhvoY5aaMp7wy2SWVQUujVp412IuiLKsNIRe+DlvmkO1lEpoKu+975R9y9cj947U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701686; c=relaxed/simple;
	bh=+bYpOxR62ApVfAC6p/8ZfEAUw8ze7EuzOOD0sdUNvFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECrY4oowP+x1ufdlx/ko3Dj2B/KLbHjDkOygz1/ym64ryrWNqOzV2UXI/xZ1i6ur16R2Y+Fd3DsQBUrNxMwRS+ceTJWWUbX88ajXb+CoHo9Km4YDtdyxaB3N7QMfMKN27CFbPE8Vw3blNUEKKwnmJIbQW/nciLwLTy2V3BfYtRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+9XPWJw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+9XPWJw"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d6e954afbdso16252895ad.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 06:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788701684; x=1789306484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+bYpOxR62ApVfAC6p/8ZfEAUw8ze7EuzOOD0sdUNvFs=;
        b=k+9XPWJwk7BBj+vO2dDb7V5jvfmi3OXSnb4xMFfbckXSBiHUKLSFmH2akDM4CEcjVD
         U0oy73s2te4tqRlLTuFbPJCETh9CkyiUEuVWut9H7t9WuzkvPJER6KMcP+tPxLkUcWIx
         msMw8u0zxXPoH/quaZj2dYtNwSvt30HZyV4ZrIICING5s3UXjbAFqsQ9a4Y5YyVOF+z9
         R+LFh9sukFDTNwrbjFCCx0TmOLO6hgHuYlCrun+brM/efH8fNeG11GkItEplSypn7UGI
         U6IpnuvHi9Bgj8DL+/9KGbXZxCG/F+jsInhYfcLmD2AGEf9E0BgsXy1y32Uy6XO9tIj/
         x01g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788701684; x=1789306484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+bYpOxR62ApVfAC6p/8ZfEAUw8ze7EuzOOD0sdUNvFs=;
        b=HQo+XMDF15+hYJ+4OPlvRSKlFPnDRdnY5fslALqLX5oSriCGob2nN0uXHwqUmGQJl1
         Z2f1RECA1UPLhVAIkRw/8G6bE+ojEMEh9QNuHvpHeo5V41zi/a21P+JqRApsKNmlQlVF
         ZgEUqqKOxe1ADBSQcA47UN6WxCQReNvoXQwBlFP32J+9+K38vlVSiYUS7btosUlRa9cu
         gAo7wwpRGRB4dp16jmYBZY16/kST5eNck5dJhtYlpxCj5MzIGpjwv06rJw4It8UI7BQD
         LiDgBmiB8jUvfwrXe1nk1s8CGw8DR4B4C8ixpQsFXHSJgJE9FSAbG7mj1990N04bbwhN
         yOQQ==
X-Gm-Message-State: AFuF++lO7pitAnH+GgIom6g4o2+0IsBKVydq+Ah+IY2TWHv9673muksa
	aKIAYKLXCdChVBvAP901vmlWqrIBuztxbzhCTKGhHTBLg/AB1WRnEEGsGAXXeq2GQA==
X-Gm-Gg: AYBFou2LTrzEbuaBFVPC1b7K0ZuJ3IHStpeqDGN4Sv6aukAnbYnT4vsnN9y8TI/lMa3
	v30UFBIMMZuSKlCtKHX3lurKYij5qXHVSurn7LFpkoNTUjAe42PNfwR0Z7/yzf3IVs+O/J4f8sr
	vEb1rv2zYw8kMgu67v6Z0siuS1w03fCSyEgabTOXs0ma0kAB1XAJArh/VCWzS12U4IljsPH0wu7
	ltbSo88QvqWjjTG+DA3+0IG+1hGEyiTHD4nnCWRxPMPG0QfmzcJs3deOtirT8P2jZJf7kHPBc1v
	n0YsfA18deLoGk9IkRiBJaQq2zbkKsq1DybhTqjMOYBylhszKibBUVMLMLHECJVcknJqCfb4oVR
	Z7QfgNvCjhjNo3sWIDKCWxN263tOUuuqs1Nl1vxS0wWRDnzSDFcBOiQDb8noRNNvPogKktYJWsx
	sI1m0GicoenwS9SMG44V9Unp5BjfzUYfEc3oKRBoyT9k1X7abBNLP5hFWgCeI+lTZGOaznMeNM1
	n1nfsdlu2gO7TvN
X-Received: by 2002:a17:902:d544:b0:2d8:d4cd:dc8e with SMTP id d9443c01a7336-2db12666d73mr262145635ad.17.1788701683928;
        Sun, 06 Sep 2026 06:34:43 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:2b14:fe4a:ab17:f236])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db18a1eb47sm31199285ad.48.2026.09.06.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 06:34:42 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH] tracing: hist: free var refs regardless of how often they are referenced
Date: Sun,  6 Sep 2026 22:34:37 +0900
Message-ID: <20260906133437.3815209-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906125025.711111F00A3A@smtp.kernel.org>
References: <20260906124025.3550596-1-donggeunyoo.kernel@gmail.com> <20260906125025.711111F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sashiko wrote:
> - [Medium] Memory leak of a newly created `VAR_REF` hist_field when
> `init_var_ref()` fails in `create_var_ref()`.

Confirmed, and it predates this patch.

The call that leaks was correct when 067fe038e70f ("tracing: Add variable
reference handling to hist triggers") added it, since destroy_hist_field()
freed var refs unconditionally then. It became a leak with 656fe2ba85e8
("tracing: Use hist trigger's var_ref array to destroy var_refs"), which
made destroy_hist_field() return early for HIST_FIELD_FL_VAR_REF while
create_var_ref() still reaches var_refs[] only after init_var_ref() has
succeeded.

Fix posted separately:
https://lore.kernel.org/linux-trace-kernel/20260906133352.3815019-1-donggeunyoo.kernel@gmail.com/
