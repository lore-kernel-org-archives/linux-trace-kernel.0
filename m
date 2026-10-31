Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471753;
	b=OQPnz//dqThacG0mWCPFFc5PqLrnInQKGuAt8wzKY3pn9JbigricdiNzJH5lnUm2rCll
	 Z9iWvR74ZGTbjB6BcAeIHoHmf60Zg1zKGsXegtPEUBfNXUn11s9xXP89o0LOt+W5WfRj8
	 94V9abTCs1U7lEMrVHQx5diSO7vGso9n2x4b2x/lVlvG50uhb2DE//ixTWthD39EgsJkj
	 wPDaYw/+gF4LyJ+xX/ytWOnvrcHbRkjS1Ra9/7pUtH60rjhkGUHvd/rVkVowQY3HdGE1W
	 F+ovecR3ANA/BBK9fu4g3CwFv/pK1TlgsQseiRLurQ1zGiugVIpIPdpuMLAC4AO3JTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uM1TWnDaqn7LCDjuvyUG6xslJ/pzNvqVUkZmu6lToZU=;
	b=u58op0gztNndjHIrELqjftvN7QCfu5H0ZKvg50Vdrd4LxGccHRwNmCinhTMkHSEBKQuZ
	 RMkslw5y6mH2vLfqIzdAHbv14RCOMFdSETC1dOc9dwE5lslvjffq9j29GpnE5CGMeVHT3
	 c9B+m0SF0AdOqoVrpMayrdgv3R0LStGxHrkT6UsySV50WpBUSUy8Kjp1+OvwHLaA6ZehE
	 Jb1PV3DaoySKytmufkBk3KUL0xrxz3D5k/eqqkLArOPI21kp2Ilkmnh0FWf4cqBaCtjj4
	 ophcv+8hk5lG2zZ+7pMX62qm7k2TQKSDReNnKF7Y0SLD5PIGp4ElyPxbbM1//eYEWnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTVqTvXO;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF6606A32A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 18:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BCF6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NTVqTvXO
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a5b2be99a8so11004075e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793471751; x=1794076551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uM1TWnDaqn7LCDjuvyUG6xslJ/pzNvqVUkZmu6lToZU=;
        b=NTVqTvXOJEefS1SAYjWb/RbX7SxkXrl9MmKpyEFsV2YUyRdNUOH/uu5b3WCgoa4CVo
         nA69LhEoWoQiHS7hXpJB56hIoBP8ao3ZtAvv9UkzW2OpL0XSTga+uL02oOQsi2d/txQ6
         zcU2Mjo1DRubUotkURIV0ra6+kij0u2cXggzAeCUr5gltxZyZZ7b0insg1OH+M8wgcXq
         4tvBJSBYX54tLw4MBW7hl3agtpQuGy33AzUsqPPfdZMfjxj5TCGwFrPWbm9jH2fU5nfm
         H8n6a+XYXA3ghHsWx1e6qhZf2lxC/ext13NV06LdaouqA3zJToVFx6MAmlBGRvCWpPL7
         GcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793471751; x=1794076551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uM1TWnDaqn7LCDjuvyUG6xslJ/pzNvqVUkZmu6lToZU=;
        b=sx9sGzCo2lycJCS8unDAAvAPWuO8/bFSlFa6J1Gqruk8YcUJFa9qGtf/rOfSD2rnkB
         YTW2UsoJi8zkaNALICNoHLBvCXjWVvXMv2GRJWvcYhnU6MlgvKCrcVhUNpMVUxiGgMt4
         3NVALXbWKuYyZ+QB8qw5s2GfC9onl4pWF8u50dH0aGH1WtowizA+JAG7Fo0evyDT3Lwu
         ivkkapYmlGbIGciFDR2QT6di0DHP0vbK04b15242HzC0SMVt6KxrHNwUyNinMCjOXJAi
         QgDYQHITZU3oYdww4UKUSFDC0DRWb9y6jEQsaLVv2150rNlM7Rbtat3edfefQDrFbd1L
         cOTg==
X-Forwarded-Encrypted: i=1; AKwUvByhNJldZgG3i3Nl53pyptukCMuWst3RDddUBqoKoXS6nngBHrcIKzCu9CMVUJiNM4ZD1j/WO5DNTqzuh4vwrpKcqms=@vger.kernel.org
X-Gm-Message-State: AFq9FYLA6OVi1OI6Yu1ks/0qxJioEIJ8JWqDdNBvnFRghk6tpl3jQXLX
	ENkN2ymUKtUhZIGXMSsedXfDiEEut1jdW7eqLr6nflS2bHnkGQSTGUq7Cj5eogJUMrIGJA==
X-Gm-Gg: AYBFou0szWi0uEx29F58ElXSqSyS7Ae13EOjQSFZcVZntBGL1ox7H3LlOtgQt7ikWu5
	uE0I8YPMp3AoJJHdVqeVseDmvYj8I8xaaqQnZAyyhgdXQZ9Yufn5cRLYicdTCftG1xzTGiEjhaP
	9ZF0JSEiID2Tn1q+OR5TzaTjF3WzyR5xkm5Bkuay0FUVGCxq5RNJVsX8lfZGWIh6oBSPU+QrKTK
	kywFYNK85kACSLLqwvxrYafaoXyOzsUSDFKd4mEF+xTBX4HCmd78UIjuXM1U3boL2TQTFZHXj+y
	c9A8AIoBHlOrDh8oAbZOs+ZIu4R9ZhnBdQNQ9Nz8VA6eHU55+pMDKQYl4g5tVuVIz0nErhY2lv9
	Ouj6x7RicrX9Ru1FhuqVmUYmUZxv+YhNcFQ+6gTIgcx2Zt0qBjnwwx6O0NCnsxwMfJ+4Iq/A3JX
	/6A/J1cgyUVSPsuFPa5rkVxAIeHWNhhTG71jJTUZZPpA1+lLJDxC5MfREwcP85dbHSJYRWEJ91C
	vRG26mNPTIeZWv/M/CumTLgdLk7uaJH2im/BjTxAXyWzGA0tPFxo4dlN0rT+bua51ow4FsE+8YB
	jH9ifyTWvX0xRPXA4jV2Z5+7a4sj6rl1ZuLrrcQqDDryYx1dkXNBGnAJy+AaVbCs2acMBZHVbXF
	6qcOobuBqWEHAdpAFZslBBeGrBP12lT1ozVWVLWOIpTeRXGM8tsIbevzw5YRAboIxQK+sEdYRZ5
	WHfWjiOKZ0MGmy0dH3CRs2XvFw//4lNddejNKw/wLcs6Mah/Fte+sDArCwZeaq+P0WgM+miDP2u
	2tTCfjkwukETaSu
X-Received: by 2002:a05:600c:34cf:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4ac150b3d01mr140074775e9.2.1793471751479;
        Sat, 31 Oct 2026 11:35:51 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-0247-bf06-1f38-d09d.rev.sfr.net. [2a02:8434:fda5:4201:247:bf06:1f38:d09d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm219745075e9.1.2026.10.31.11.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:35:51 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] tools/bootconfig: Ignore filter strings when resolving histogram variables
Date: Sat, 31 Oct 2026 19:35:32 +0100
Message-ID: <12880872dd9ffba9c334c3c2ecffca0b45d64b4c.1793471731.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793471731.git.edumucelli@gmail.com>
References: <cover.1793471731.git.edumucelli@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The histogram variable resolver scans the entire trigger line, including
its filter. A literal string such as "$not_a_variable" is consequently
read as a variable reference and the histogram is deferred and omitted.
Conversely, a filter containing ":dep0=" looks like a definition and can
cause a consumer to be exported before its real provider.

Remove the filter portion before looking for variable definitions and
references. Leave the complete filter intact when exporting the action.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested literal dollar signs and assignment-looking strings in
histogram filters in a temporary tracefs instance on my Ubuntu machine,
running kernel 7.0.0-38-generic, with recording disabled.

The original exporter omitted the dollar-sign cases and treated text
inside another filter as a provider, putting a consumer first. With
the fix, the literal filters were retained and the real provider was
exported before its consumer.

 tools/bootconfig/scripts/ftrace2bconf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 77ec17c94a17..8ba1a698611e 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -86,10 +86,10 @@ synth_event_options() {
 # Variables resolver
 
 defined_vars() { # event-dir
-	grep "^hist" $1/trigger | grep -o ':[a-zA-Z0-9_]*='
+	grep "^hist" $1/trigger | sed 's/ if .*//' | grep -o ':[a-zA-Z0-9_]*='
 }
 referred_vars() {
-	grep "^hist" $1/trigger | grep -o '$[a-zA-Z0-9_]*'
+	grep "^hist" $1/trigger | sed 's/ if .*//' | grep -o '$[a-zA-Z0-9_]*'
 }
 
 event_is_enabled() { # enable-file
-- 
2.53.0

