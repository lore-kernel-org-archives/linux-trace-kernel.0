Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B693B5317
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 22:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428841; cv=none; b=XJ4UB3mpEuyBzl6600/8DpjGREut3Gq79OYXEvLr2kgm7sJeK3cjcmkBUsIbEqRdOGvzCzZJJnyTWddZodeAenTsCbZxSUBBbkmNiY401k8czcrEhVsvrUZE5EzRtu+I93i28rkNJrJ0vhJd7pkWwzWY+/RNoTQklFcDpK7mrVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428841; c=relaxed/simple;
	bh=v/6ny77OEhOTDZTQ79j46inEoAHozIzSVLV54SqB5XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6qc/AbY068EidUPcVtIHjsdp4fKH0+0rKU7zzdNeTT+iXslf8i1gLMdmh92hXuyEg82DZWn/dp87kwqmp0ZRfuoOL644whSyPLOr10ncxY8dqgNamb/gbCzgU6+y0dIHOjGsHvyaWkaToCvE+mvJ2fuMffcs8vuIUY0eQLg2kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m4h4GaQm; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m4h4GaQm"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8b2f0f9e4cbso20871685a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 14:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428824; x=1769033624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckc2PkyYWXkN9ubnJOQKa6sgkDYo191+Pf3SF4+RdaY=;
        b=m4h4GaQmLps4eYd+p4N8j6XD1Cn4yDY+z9viJPYK/P+7okqaz4kgiHMQVVLTpYl7sz
         Vin+8Oo9UpDsZ3/tdYEkI9Py1gE1HcvaO7yMETh1JSO+9Z4B26oquOgunOjvWnMaDNk9
         xAPjkEds2ZuXntNuS7WHeS4jYhh+BuTKuOqkn67bUgGZdPFCxtHBSf+vjO/UnaMWSYyZ
         1BPPXCp7y6xPsm7SFLbfFbzzY7hr3fRsEWPHohX+/gr+kpIdga+RcYbfIxP61168F4+Y
         wKQ0d1Is3/aPyE7mTZhHua2wI/suXEBtiFaRzAj9TN5t69EcbZTnfkhTJmc59V+TEoFm
         ruGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428824; x=1769033624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckc2PkyYWXkN9ubnJOQKa6sgkDYo191+Pf3SF4+RdaY=;
        b=PEI8nphoHVflpmmboXht97Kq7w77q95j7L68jWOeT74FxTQCFvh53laPbTKthq4BNf
         wn22Z4wCmoamkAVAOWUzsLZ+2y4/GrtW09cFtUTl3rcrVQlRZQNCfFpXhjXnPQx3+YcU
         k7B3uduXeTl45GqKe8NOxwj6pngiFthNgUqbDHCTjS3CZ/abtnxBJN1PlMEM/Whkr5oT
         oIAzYxwLmcCJvRX10HJuwnFRI/vlp5D5Jh67WR1zcu9X4p03rPk0c3zeSVZZIupxMutB
         R5MLvvvmfmMYhQn+jPmVmsGmlQ9KBbIGLR3Fl6tXDxTr5jXKApfDJDxdcaof7dRe3OY5
         hYlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCjCKR6HjI7yN9WgvBkrv9koQ30NzDrkiknWHqhmT7K+PbuLRWN5DuAxSqqWiIX3kpuVnEOVnMjubEOb8rkOxQMMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3bFcEswuBt8/57MPOFhRH2xVKOrxBQ/z2DVNtrqGF//FKRL8q
	k2bzZwVBdZkCJdzUxDNYRJ3SxTosNX7Dc14XDYxY4QYH8GQmBn0+Cw28
X-Gm-Gg: AY/fxX5tceOxSefP1aH8daHyFsqph40X48nanVpRVLUFHwFvDVkHfAK6bRXObg3e3j8
	WYqNAKlo7NnJQKA4ytPUtjDlKWbt/fFPA+GXLway2dCCEI3JwlL+fvOU7JSdP8HOcrkHgk2nxF7
	8Sh24pPIDYHDFz2LAiKqxzdUPeH3GY5sdXkk52wT2yaXqJL1E8ujnndoPizfl07oBUW422VPCzs
	VROHQWEM4As9/X+RwY8IT0eYnvkHc0QuAghIVeX3kgqOyQVrRv6AO1JuqGFv9L8J/YQlC8Yuf8L
	lgAUhP1CWz/g2y49/ybhuN6myCcNkWe+PD7ElaPoe8sKeouBwbM2Ke9j4ZGY3tQ/R+XryyiPhrN
	fPGCEtNxWVP5dgJbixYMrOygLuawb2zuJm2jDSQo29aB46EYYY5jer6gOVfkpNMda4l27wCq/sx
	ZWDWMuvHNSbe5BmJWBuiI1g/fWluI8NwMmIF/++SXoLQtlSgumnaBzwTlcZlVB/kiFQiOAdx553
	CY2VG31eQ==
X-Received: by 2002:a05:620a:4052:b0:8b2:e5da:d312 with SMTP id af79cd13be357-8c591a02e83mr164610885a.39.1768428823769;
        Wed, 14 Jan 2026 14:13:43 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:c1bc:6046:8762:e96])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c530bb685fsm250007785a.44.2026.01.14.14.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:13:43 -0800 (PST)
From: "Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	corbet@lwn.net,
	shuah@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	"Seokwoo Chung (Ryan)" <seokwoo.chung130@gmail.com>
Subject: [PATCH v5 0/3] tracing/fprobe: Support comma-separated symbols and :entry/:exit
Date: Wed, 14 Jan 2026 17:13:37 -0500
Message-ID: <20260114221341.128038-1-seokwoo.chung130@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
References: <20251126184110.72241-1-seokwoo.chung130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series extends fprobe dynamic events to accept a comma-separated list of
symbols and explicit/suffixes.

Currently, fprobe only supports a single symbol (or wildcard) per event. This
series allow users to specify a comma-separated list of symbols, including
exclusions, and to select entry/exit explicitly using /

Examples:
- f:[GRP/][EVENT] func1,func2,func3
- f:[GRP/][EVENT] func1,!func2,func3 (exclude with '!')

Logic changes:
- Refactor parsing logic into parse_fprobe_spec()
- Support comma-separated lists and '!' exclusions
- Add / suffixes for explicit entry/exit selection
- Preserve legacy single-symbol behavior (single symbols still accept %return)
- Disable BTF-based signature lookup when list/wildcard is used, since one
  function signature cannot apply to multiple functions
- Reject mixed legacy/new syntax where applicable (e.g. list + %return)
- Update tracefs/README and fprobe documentation
- Add ftrace selftests covering accepted list syntax cases

*Patch order is adjusted: code first, then docs, then selftest

Changes in v5:
- Reordered patches (code->docs->selftests) as suggested
- Addressed review feedback on README help text to show both legacy and list
  syntaxes
- Added missing traceprobe error IDs used by the new validation and fixed
  parsing/bracing issues found by automated builds
- Removed the dedicated list_mode field and infer list behavior from presence of
  filter/nofilter and keep struct trace_probe as the last member
- Link to v4: https://lore.kernel.org/linux-trace-kernel/20251127151218.4763b25c751bb2aac4b1ee36@kernel.org/

I am not fully confident the runtime testing coverage that I did is sufficient
across configs/architectures, so additional verification would be appreciated.

Best regards,
Ryan Chung

Seokwoo Chung (Ryan) (3):
  tracing/fprobe: Support comma-separated symbols and :entry/:exit
  docs: tracing/fprobe: Document list filters and :entry/:exit
  selftests/ftrace: Add accept cases for fprobe list syntax

 Documentation/trace/fprobetrace.rst           | 18 +++++--
 kernel/trace/trace.c                          |  4 +-
 kernel/trace/trace_fprobe.c                   | 49 ++++++++++---------
 kernel/trace/trace_probe.h                    |  2 +
 .../ftrace/test.d/dynevent/fprobe_list.tc     |  2 +-
 5 files changed, 47 insertions(+), 28 deletions(-)


base-commit: f0c13b210e4366e03bd9e8967347b06b227e20a4
-- 
2.43.0

