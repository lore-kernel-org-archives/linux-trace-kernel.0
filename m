Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0DF3B5314
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768428756; cv=none; b=K5VezYD+yH0jVQzKjBpQ2I34NWmII97f/UTlOjxlRCXpl+ubvCS6xOXFeh7HFQA1F75MA1r2Wj9/AehJzBjKdBApLvo5R77FrOgvnHmrc0yRRfhuR9iwFsQlzUwk/TGCBpEyKJmLIIOy3dZZxQVb4o0i+tlhjWTOoURs5nDYodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768428756; c=relaxed/simple;
	bh=v/6ny77OEhOTDZTQ79j46inEoAHozIzSVLV54SqB5XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rz2kAhbm+gcHiS/f9CSr+Q3FooZlTP6wf0QkvRXjrvFhFcUROXRNkMeCs2hDTum36UfaeYtpTePcBHgsif93t4SRI5Hq83PJpllqwSkBpzUCKxGNk/PMArGuzwTdsfbwtfGCqbCUnG0OaDUc+K4N4i14HzXW2TCgUFMt8jEjfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddWWI+FR; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddWWI+FR"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-501502318b1so2278571cf.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Jan 2026 14:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768428743; x=1769033543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckc2PkyYWXkN9ubnJOQKa6sgkDYo191+Pf3SF4+RdaY=;
        b=ddWWI+FRLumCuusgHg2nvzmSWJc0Ve1vPjN0qxW3mKB7ybPluQdol7T3MJfDcaW840
         woR2r49G1wj9G31aWOSJptkBrwK5yQYUUWort0yJMvFhc/eCEfv3tvIGBv1BFkACMkOt
         k/7Z03hf5gKEn9FPVZ58A/PM4/xQ4vSZHtGzS0iInqeZP1ypwBUJ9XYby7Lprs1gXkCD
         9DhW9BUFb3+5iWGkVHx7MvOzySCwUNXuSIq5Y+xraCVPkYooFcBqV09c97aPqYY5VMbN
         K24M39GB9uTFdiYO2lx/wA6VfiNWIEupMYhnCT8UkuSeT0dhtFZAlDx6qxzwcRlsLcIW
         2seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768428743; x=1769033543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckc2PkyYWXkN9ubnJOQKa6sgkDYo191+Pf3SF4+RdaY=;
        b=iqfD0INxQl44E21a0FcXMEweVDGHTm4pNxOU3N7L3Pxghz4G57qgZ0MYgHUqv9T5ZR
         p2AyaYI07rX8d4UQrK9xoQcKAmSobV4F3lxdBkhz37xX2LA83RZ/dm+nyaUlM5rPCuuo
         bsLfrBiqVKxTMSF4zhTGedoYl3wddhM36tBZy23EdaYYPFAEQj0qW/6BVNeljjuPzALV
         yjSoflixv2oUDDXF6HsQi6NzL+lBaKYTY+OCwM0t+JlvoyX/sTAMgnjGvZLTVCiTCDEF
         b8akC1FxBt8E/FTMf+jU52w3LU/RyOFS9bPmag2RsyxvRRBlk81amjCF6jJwTgejwO+W
         jBXw==
X-Forwarded-Encrypted: i=1; AJvYcCV78WeZPh840dnFPh3Vbg6E+56ihMzFS2J6HcYUaem2cxD9nUKVk7GUMtRckSxxe9BIu5A0DkSxW9wKMXaO0jz7PM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwywVXjs4g+q5m9yvbFG8Ae2MIfi2fvF0bs+LR5WTnwS9pl/IXR
	zTFO5tS86km7bOD0YyHvansTAyR70aywVwPD46TY+Q2hgLXEDdFmlzPo
X-Gm-Gg: AY/fxX6itsF0xoeU0ppaALyIu3Pe05ztxYYAXhZNN5NFjIcKitTcofeE9SUKufNLH1h
	I2D3efxojNcp4vL2cxxuxybKtgBhRZVyqXM2ZVhKk32UEWt5tUR6vW8RC8p+KZfVTFOtweIQMhV
	ZpV+4hFIDYF+GqlsIBYT4wg3GEYwxaKscNMNYbb+8+dXDM0pFWhCwLhUQmC6vcLsIabj/jX3xQT
	MkS6+SfsePJrV/pxJzQ3Qa2fJL1s1VUrWvOzTWBZl13aUcIu10CWJ/BORtlL9DeanyjKS42qPVq
	73b7YnkAijTXrFQmeLH/GmIA34qqV3dXsopYAPQABKuWgTWh8d5pGMZBe2eZYWhmkcS20IpPWx3
	ChL5VBAexPu1XGySUYJFKvvvFMnI3f2TVHMvj3etIYX2bmZMm9vresCRZZX88bT80gag7cY+0Du
	6JM9hrIcqtzdU84VhmsToS4XL2QwjfDWgEBa0LVXd740Jqw0YrsQbbbPZr6Thj6sneypkfkFA=
X-Received: by 2002:a05:622a:ec2:b0:501:48c4:28dd with SMTP id d75a77b69052e-50148c42c2cmr38121401cf.72.1768428742964;
        Wed, 14 Jan 2026 14:12:22 -0800 (PST)
Received: from pc.mynetworksettings.com ([2600:4041:4491:2000:c1bc:6046:8762:e96])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50148dd766fsm21715341cf.7.2026.01.14.14.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 14:12:22 -0800 (PST)
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
Date: Wed, 14 Jan 2026 17:12:16 -0500
Message-ID: <20260114221219.127777-1-seokwoo.chung130@gmail.com>
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

