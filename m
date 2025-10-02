Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D792942A99
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759424986; cv=none; b=ThFZwl1Ef/bYR2OIjLdlZiXot+7h0K80Fl/y0TqgrVPI1Go9+cWU1sq2AzLpZevh2USYUpffk991YpqFYV/SZ3gWwyQtZh0KwryDVUmffolyYG2dAHh5kQdIXh6KEVR//Lj5DbgehQHgWfMiTv9ptHriLxNBRpuXc3L9RRqdNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759424986; c=relaxed/simple;
	bh=wV3apveSRN76n364Q4Xgge6Ku/7v8/2U94tI1XcIKwU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A3m6i+rdo9kZ59/JLkp8OmFB2k4OyVRtNB3b+w5MapRrqRINsNnfxELCswtO3is+4mqlwIStBSlVHAHcSnZrCAbTwz+897v3VCfKo7k7cNNvFbOGRF7Y1D2XySI5j5PsaPKiq8qdEcZybkKS8vs68Bd2pMBQNMpGf3TnOegWBMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e2c3b6d4cso10724065e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Oct 2025 10:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759424983; x=1760029783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALhMC3B+HG9RzOr8Fvsyhus8tagwxCMBXxlTBDad21U=;
        b=mrgjs/cA6v7TBTVz1f61YDj5STJQU3WsZLph7LLmWc65K256rwxO4cSDAAvRrtXkZy
         J6F5EFKtWCoWwIwCebkDUX8JwIgc17Tnq1nzTjqWSoLpinY8YdedNJwhdFPNC51xQ7Xt
         ltPAiJEEVaATyoTScsluN0RnPtYb4Iu28EP3+ZrWCcZOyhf3dY39jF67hdhNF03NEWWp
         nJbBRUAoaeujrwXI/hDi3UkU38S5jNWeDN85vYXlOqmh2bSZVYBbQ/8YDOrcZVJLDN0O
         6yuSWm4vXdc5Rn/LtD9Zm03839+3UV9klIcVCNLeNMlP2uUrUn6XRbZet7x7wiQBTcxW
         cOBg==
X-Forwarded-Encrypted: i=1; AJvYcCXDqgJpGBCk1kBs1nfXyC4H2+rNbyINyxQebX5aobN8od9RUzGBb/PdprpkZ1EVOntY4DgE116Xr+wgu30k5c5C73c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxATiGXZ/g0y079Bf4tOo8YJ34fsivls8zvAQILDsOvuOVvhkq1
	AKtgQKWBGS2whA6cMIRO45XbbA5vNeBTO+pZ+qNc0NZ6xDXdihiFFnAa
X-Gm-Gg: ASbGncu4f+HRT8RLttXQDD2PQs0DPDyUv4WEzr8eJ9jWc/+bhVlgq5FXkgw6m/H7jCO
	4zR/Nxhju4K8p9ODQw2ClkqChdfnaksE1dvMzVEimlzgtaywlusgJfshhkuPfqAmfetGQkyJtOF
	QbR8JAl9TtzObiBvLZfWPlvquwDzmCrBKF7wvjWitOKcffIZvXK3tbDsV8+AclixlMeHyBGMUI5
	rorIuOL99dB5snStMYmuxDVD97v50ZY8gT3sM99KdtfQT+Ue6THOzxMDaRMXr7EHj2GSCnBegij
	A2+AeNraN1o3GmP+qgASM1TfzGPPlLaMuMS/uTRNgDbTnwoily5sPdmcmu7K/N/QPEBaVGHYiYa
	sIouEqmLAG8QwTwiokEZJuOcDGNTgeJVMuzgoFT6X+vJZSbySqzc=
X-Google-Smtp-Source: AGHT+IEYZDN8Vs/SGTNR8tAG0UxJGfa0XX0wxDzajLCBKTWIabOxTdsv/uzzOyq0NfdbKIuezVvROA==
X-Received: by 2002:a05:600c:3556:b0:46e:4004:a296 with SMTP id 5b1f17b1804b1-46e71109df8mr282575e9.9.1759424982964;
        Thu, 02 Oct 2025 10:09:42 -0700 (PDT)
Received: from localhost ([2a00:a041:e2eb:5500:8728:d68a:a687:c89b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8abe90sm4407649f8f.23.2025.10.02.10.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 10:09:42 -0700 (PDT)
From: Costa Shulyupin <costa.shul@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	Crystal Wood <crwood@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] tools/rtla: Fix unassigned nr_cpus
Date: Thu,  2 Oct 2025 20:08:45 +0300
Message-ID: <20251002170846.437888-1-costa.shul@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In recently introduced timerlat_free(),
the variable 'nr_cpus' is not assigned.

Assign it with sysconf(_SC_NPROCESSORS_CONF) as done elsewhere.
Remove the culprit: -Wno-maybe-uninitialized. The rest of the
code is clean.

Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
---
 tools/tracing/rtla/Makefile.rtla  | 2 +-
 tools/tracing/rtla/src/timerlat.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/Makefile.rtla b/tools/tracing/rtla/Makefile.rtla
index 08c1b40883d3..1743d91829d4 100644
--- a/tools/tracing/rtla/Makefile.rtla
+++ b/tools/tracing/rtla/Makefile.rtla
@@ -18,7 +18,7 @@ export CC AR STRIP PKG_CONFIG LD_SO_CONF_PATH LDCONFIG
 FOPTS		:= -flto=auto -ffat-lto-objects -fexceptions -fstack-protector-strong	\
 		-fasynchronous-unwind-tables -fstack-clash-protection
 WOPTS		:= -O -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2		\
-		-Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
+		-Wp,-D_GLIBCXX_ASSERTIONS
 
 ifeq ($(CC),clang)
   FOPTS		:= $(filter-out -flto=auto -ffat-lto-objects, $(FOPTS))
diff --git a/tools/tracing/rtla/src/timerlat.c b/tools/tracing/rtla/src/timerlat.c
index 28ea4f6710c1..df4f9bfe3433 100644
--- a/tools/tracing/rtla/src/timerlat.c
+++ b/tools/tracing/rtla/src/timerlat.c
@@ -213,7 +213,8 @@ void timerlat_analyze(struct osnoise_tool *tool, bool stopped)
 void timerlat_free(struct osnoise_tool *tool)
 {
 	struct timerlat_params *params = to_timerlat_params(tool->params);
-	int nr_cpus, i;
+	int nr_cpus = sysconf(_SC_NPROCESSORS_CONF);
+	int i;
 
 	timerlat_aa_destroy();
 	if (dma_latency_fd >= 0)
-- 
2.51.0

