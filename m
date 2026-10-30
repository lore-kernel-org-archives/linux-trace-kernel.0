Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793364736;
	b=WL4OULWVhSJrBqqmNx3u0fN9AvLh4ih6F8OS9cHpPPZ6JYEYj+vEtdaq3ZesNQaxFgZk
	 mPMe63I3HqJSIiGZOXSqvdREVfgN6H7Ninh6sAK0m456Q8mqmmVtUVgb8v08WDNf0OAtH
	 NZLXUJI3sB9xt/1wVLVj6dzdoyWctZhXZHfMEkocxhv98KpT1KiPKox5hklq+Htf+q8RW
	 wsmdclMCudf6T3I9geVK9gPoX1oB/T341RqpN3iVwGG7zsDKOW0z5sl/PEtn2wI14+0X+
	 qADCvOcSWdaRpMBqKcOPJwwlVhgxG2FxPDUH/HVcj5T1Sq9PbkzNMpOsP1jbbzGGpyQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793364736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=jlQZUr+lfyU+BwYrVoDCooNI8opcaovsjvfRljhTeI8=;
	b=pIV+72sMkao3GB9wwI3+CebCP4J64VZVYo5EYzMgA7DTQAs/no6VxQh/Ca3roTsVIfcU
	 /iCGvxpNXygWOYeZTuvA5//315IKVmqLJXX/3ytMlvPyJCIHSPsTLgiMnrdCbGJB9/Di8
	 AaQypjiQRgkJF95Jh9In648NHekAFU5l8CKnJHmvVyeQZu7q1sNVm4A/51/jz3l9U2Apc
	 2jxvkryNf2MaFqScFywiIkerNSNlFLX6PuVNXeZzAxoczMLqY9GsIcIcA2kTjaIOevt9o
	 CnZkhmxJ5GNuOxSNtxd4RE5PdMCwSUHuRx37nGvUfWTlRgVj9cwruN2Oy5i0POun95Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BpTH3AXF;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB660A2600
	for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 12:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21AB660A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BpTH3AXF
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so3005625e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 30 Oct 2026 05:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793364734; x=1793969534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jlQZUr+lfyU+BwYrVoDCooNI8opcaovsjvfRljhTeI8=;
        b=BpTH3AXFoX7o71pKSUHHr5CT6lRB8RlH/mu9zk4FATSimhehH7FmBXZwbZt2mzdMek
         8AhDCzUJz5BmqcwuvC4iloh2iyilwFjWY7/cYvwPjf6H+DX1mDG2KzbQAMiym3/cy+2L
         +d3LprCQO4gb+Zxo5c698muoVAZJphtCnVA/EEU0Wr2F89ejN2zOxi8lcccjQbWiivlO
         bjjSlEGCbQRJ6scqROw5AYv+0oQ8mVQN+ROm7LgXlruPdXrz+mnWX+84ZR7IESOs7lM+
         AmzsUCDRS2tRhjAbfSMb21VKjJs921ynsmJTVwaV58e+s5PEvplrlmdWAwqgcHsajFTK
         o4ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793364734; x=1793969534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jlQZUr+lfyU+BwYrVoDCooNI8opcaovsjvfRljhTeI8=;
        b=Z1qAS+jrd+lCSMVgdILIr4TyeKcfVdLUKlHMlalfSx0KPf+Gnw9zv5W/QOQ42BClPj
         S87/T22qS0bhiXvUStuTdENljDUHX6xpGl+M4TrB2pENd9Fh9bgjxuqszcwu/XY13rIV
         U7ZBPaZfggLS35d5VY1GIGDCeeVujilFFEcopMcbga8UKdjl5C4o9qYrlCCJMCxBQ5Vv
         iAaPID+jDdpgOnzZRLWvEgsXiwQ0uZ8zTexXSIxJRqk/ahoi4mVRzSrQwkCBzZdAPwPj
         imyMthZJFx0p9VYN10ugce8YK2CBtsAVxavHLEPdPXtWFYRaNT9LBAYRj5aIHdou1Pon
         wJiw==
X-Forwarded-Encrypted: i=1; AKwUvBwJLHtJZgBA5xG8jraZ1ePLwV2dun+/O2y9OBfiC1uiXZ7j+NwPdCHBlMoPl4R0YskvULNs6QCl8CTnUWN3rlmaMAc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKHCbsLq6iI3V+WoYu3RzKqDoqvphAB5gWsKaPgAZtj8j9G+ybR
	iIRWGUVHB6+SuhF5aZW28zZEL4D9TSY+evfqGcLlR5jjz4D+FCy6yrVs
X-Gm-Gg: AYBFou1HlqsEnB151m8rkwreAH30/5BfXiBr6cC9rV8B5GRj0U60Sq431Ntw83k0lha
	CwID2rSr20h2hWmWCQS8DYo2yqxjkpx0UMiqKFYnTXKu/rLA8wtIxQBNkpe40zvjGaI3XPCEMUa
	McF6YiSWAMr89JQHsGoKLf9+aWpMj0igO4Xxsj3171sMrzZRwYIIZGKyrj9BDe/Q46TmpgA27hr
	8Gr969OJlx+IAfsWkKzwPE1iihbbFgdDCpXuDaTA35UygnfII3F8MaWG1Y2fvFXY+jaaywtyxgF
	TUo98C7lWl8nBgLZ7DFb7TfA1eGHUyO6/Wri8nCyAD0HW5BT5owx3ogJCW1juRdTX08CEk2BERG
	rn82huCO62tukV8xJje2Dbqyro1WPqarR1eT/KPErydqmQmxgIRoJMS36oD3fIRYQvqP3GXtpBl
	EyvJ9H9n1HcOiW5OAcKpWWPWQy+e4v/kuOH66AA+BhHoJFrO6J/jcfu+DcFfR7pIbTAta3KjOnU
	eIhu/PmenfgvsxWksVDWpjG8etrKdcRs7h+l0BBfWu982pk6+5C+vsQPT02wLzBM+mVfjv9+/Gk
	wXxQo/NDz8NiPhg010db3MLQTFK22iifaSJY0z/RUWx86eOqqVTMYrY+mSMNuy4Ghgx4UL4LZx3
	++NjTpwqvVrNu6XvLb9+zOqObFQ39HwPYFZ+B7K4anKN/J3Iy90xLWZGFB1DvQw4iaYh2AQiNCD
	3tF6ZSolP8ebmZi7M+BQ88mOOzxL4OB9KLGn9/jnd5OUOLZ1Uk6GYtMy7qjQ==
X-Received: by 2002:a05:600c:a30a:b0:4ac:b0b2:fa12 with SMTP id 5b1f17b1804b1-4acb0b2fac0mr19920875e9.1.1793364734284;
        Fri, 30 Oct 2026 05:52:14 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-a479-65ed-4521-39bf.rev.sfr.net. [2a02:8434:fda5:4201:a479:65ed:4521:39bf])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b723cdsm3170047f8f.12.2026.10.30.05.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:52:13 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] tools/bootconfig: Reset histogram variable tracking for each instance
Date: Fri, 30 Oct 2026 13:51:50 +0100
Message-ID: <a97b10be8978ecc64a7c5251af1cc2d91fdd4958.1793364709.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793364709.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com>
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

Histogram variables are scoped to a trace instance, but ftrace2bconf.sh
keeps DEFINED_VARS across calls to event_options(). If an earlier instance
has defined ts0, a later instance can export a consumer of its own ts0
before exporting that instance's provider. Replaying the configuration
then fails because the local variable has not been defined yet.

Initialize the variable resolver state when starting each instance so
that its consumers are deferred until their local providers are exported.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I reproduced this with two temporary tracefs instances on my Ubuntu
machine, running kernel 7.0.0-38-generic, with recording disabled. Both
instances defined a histogram variable with the same name. In the second
instance, a consumer sorted before its local provider.

The original exporter put that consumer first and replay failed with an
undefined variable. With the fix, the local provider was exported first
and all three histograms were restored correctly.

 tools/bootconfig/scripts/ftrace2bconf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 82c4fe021fb7..6d36219eb997 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -84,8 +84,6 @@ synth_event_options() {
 }
 
 # Variables resolver
-DEFINED_VARS=
-UNRESOLVED_EVENTS=
 
 defined_vars() { # event-dir
 	grep "^hist" $1/trigger | grep -o ':[a-zA-Z0-9_]*='
@@ -159,6 +157,8 @@ retry_unresolved() {
 
 event_options() {
 	# PREFIX and INSTANCE must be set
+	DEFINED_VARS=
+	UNRESOLVED_EVENTS=
 	if [ $PREFIX = "ftrace" ]; then
 		# define the dynamic events
 		kprobe_event_options
-- 
2.53.0

