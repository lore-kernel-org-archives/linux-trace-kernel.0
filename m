Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA741EEA54
	for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 07:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760253198; cv=none; b=V9jD4p8ki6ua8JxWZwa+N1ZsHJwZ+EEY1B15viVVGOL9oR468lsLHzpMRmVlNLnWLs+xC9daDvXEOBfIszTJpUYEAiM9gsBlRJv/wQ2nUbra/KqvEgwrETLiijBOngBuhIG7OpX8r0zPaFSLPfoe+6Tr1Lrz9Ykh3PqRMwTTH9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760253198; c=relaxed/simple;
	bh=dq5XPpWQTqVeWFkmnGSkYSvTd/fKLsCFTZToTBBOTOw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=tT0UbrEb9IWbNnc38o9K5+UxjKSTeMXzYNfd5TjP3yaMpiAs92iKY7MkFhaNfwT0l1hME1mYmQ3iaCCixsSsfmfe2RuM7uHoc7GR07xKOCyMtqpzWgF4gqomeRI/xertcV36IlKG5MnxygHGg2lFp+q9hQ5W28HLN8BmN4R57/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OB2TGr4t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OB2TGr4t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760253195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3dh6DzbfDhE6jtBd8N1O7na8tQoQioGI90EhyrkbVps=;
	b=OB2TGr4t2/0WtmiSp7P8wjKSjZcoGQy96Rfvc6274J0PP5FeVnxpVqwBWuuK8brM3CrE/G
	a+5t4cfGehAjbT5Rlhb6UyZGUHNKpcncVsWBNdI0F6puQmxEVi1lDuAsMtw1IJCiezSEce
	Y70yR5CBswDhL1A2cYkqeavL7e3jANQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-kaxCcSHYPLyVMX6qJKytFg-1; Sun, 12 Oct 2025 03:13:14 -0400
X-MC-Unique: kaxCcSHYPLyVMX6qJKytFg-1
X-Mimecast-MFC-AGG-ID: kaxCcSHYPLyVMX6qJKytFg_1760253193
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3efa77de998so2938210f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 00:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760253193; x=1760857993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dh6DzbfDhE6jtBd8N1O7na8tQoQioGI90EhyrkbVps=;
        b=w4H+ozuldQG22i3wEk1Cn5er5EPpKVyaiNFjtcR3g+OImQk5JJ74boDt7GFk6bU1dO
         JSVf7sc/riH3FsT4Cv8WCot1ir483l/4RP9WzEQPWjWr4fpf1xtcv0IiH0Y+Wb8Ge3AI
         L1naM3xTPKUt4R0t1p5rYSAc/g55qcJruvGv7rSdMTTv1OWiN8MPpSP7KDXxxIolM/zt
         GFs7Xznh52gq+Ofw6pkU4L7HOOHJy2PvKDfVk1FnipDK/jFpuAsEyQbtqeVRxgv+5Xok
         UT2QkOpovKrTEoC56dvC1bFmWTaIX06d1R7KhmAEjsdMmmQSh/tr3x3mw3hjMcRU5Tzk
         R5fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3DTdPjqlpIx0KQIJuVnkCpN3Wm/33chAfDPG4Pcv8LXejdTWEvpz3wVE8vaJKkiQEK7ZyQ+WatTVJp4fKv3qE4qY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0XQHmEZ9xyPjbbg+stVR5tC6By04HDPnRunTlugIYKh4pXtc/
	vrmuCIY4FGkojcmGB8SR0lw4JcFPaoQc0ukbv4swJV+HypTncHd94GO1ZDg18DhiRI01aTYdv4k
	MkmUpAzgqsOFcDuzf4rtNwQ3Qz9VfeZmhM5CwPY/7RVZbrN6Lr3KUdKOdic/Qa/22mHg3xtdaMg
	==
X-Gm-Gg: ASbGncuJhmR05LqsN7Sm55ouR6R0MsqqnbS5P7Mbz2KGTO/GkHO5IyVS7rUFvzevjku
	+0KWlfJna5x4lNJ1P+kxNUrFviN8EOdwI235P5IObqioOLcxFEUDXEVHNwDfGXyPNK00aCcQJwn
	ud8arxqa+y/AGPLNF+/sAWeaUhDrIc/ZlaVUiwzxem7dBQU7zUGbb8jKThoOVG7XMgg1BZJ161X
	3Ub0U4zelKga+pzcFMV/568B56gE54GKZjUj/gtlgd2FYCXIgYCTLmPpPJeeLn2DSv2sgWaWCeg
	4tb+YDz2KyGp8QGjEoPmSF9HwLwrNuY/UZeE+Mxua2Ji
X-Received: by 2002:a05:6000:3111:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42667177d9fmr11209007f8f.14.1760253193074;
        Sun, 12 Oct 2025 00:13:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSnULVC4RtP3jhP2wpaC2RxEg1kofWPk7jIyzNCabwbJaYfRGXjLljv/qa0jpgkSz1lBvR3w==
X-Received: by 2002:a05:6000:3111:b0:40e:31a2:7efe with SMTP id ffacd0b85a97d-42667177d9fmr11208990f8f.14.1760253192719;
        Sun, 12 Oct 2025 00:13:12 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8141sm11824513f8f.48.2025.10.12.00.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 00:13:12 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Remove unused function declarations
Date: Sun, 12 Oct 2025 10:11:30 +0300
Message-ID: <20251012071133.290225-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KqZZo3kgO9ktOict3pAFOoq3JWBMpZBpwVaQcDLXm8Q_1760253193
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Historically four function declarations remain orphaned or duplicated.

Remove them to keep the source clean.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/src/osnoise.h | 3 ---
 tools/tracing/rtla/src/utils.h   | 1 -
 2 files changed, 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise.h b/tools/tracing/rtla/src/osnoise.h
index 895687030c0b..75de0d5c706a 100644
--- a/tools/tracing/rtla/src/osnoise.h
+++ b/tools/tracing/rtla/src/osnoise.h
@@ -58,8 +58,6 @@ int osnoise_set_irq_disable(struct osnoise_context *context, bool onoff);
 void osnoise_report_missed_events(struct osnoise_tool *tool);
 int osnoise_apply_config(struct osnoise_tool *tool, struct osnoise_params *params);
 
-int osnoise_hist_main(int argc, char *argv[]);
-int osnoise_top_main(int argc, char **argv);
 int osnoise_enable(struct osnoise_tool *tool);
 int osnoise_main(int argc, char **argv);
 int hwnoise_main(int argc, char **argv);
@@ -68,4 +66,3 @@ extern struct tool_ops timerlat_top_ops, timerlat_hist_ops;
 extern struct tool_ops osnoise_top_ops, osnoise_hist_ops;
 
 int run_tool(struct tool_ops *ops, int argc, char *argv[]);
-int hist_main_loop(struct osnoise_tool *tool);
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index a2a6f89f342d..6086e246bd85 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -23,7 +23,6 @@ void err_msg(const char *fmt, ...);
 long parse_seconds_duration(char *val);
 void get_duration(time_t start_time, char *output, int output_size);
 
-int parse_cpu_list(char *cpu_list, char **monitored_cpus);
 long long get_llong_from_str(char *start);
 
 static inline void
-- 
2.51.0

