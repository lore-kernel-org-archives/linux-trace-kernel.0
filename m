Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3F5187346
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 15:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415548; cv=none; b=WX67ttOihDYZ4lxbnJV8oST1K0bd286RlI/bu4wKb1zGutY8Ju8aToNw+9Rgga9WpXT0JOCvj88V7z6p/Wb/ETPLQzxh+V6dM85j+Xuyg8MdP3eF7+A/P+Ufo1Xy6B+lOOEfNuhDn/0GTmPoazJfN1EiKd9N2+GkmLNWYCblrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415548; c=relaxed/simple;
	bh=FYckr4FFZBlaLk+9y89W4SP3wfP6O5lMdB+oeUjRrYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nfyo+PIbrIKfEgyo2QZtMB2bibrumgoIOF5oIuHXsKIbTX2mcDliUvOC5Dx+vwJcH0zcb0uWP6MJs6UIWvtj2oNcfvwKCfoNH4gC/ZWZEtg+MSIEubfpf9Dv95oFpuS5Jn2FDCBMeMXPA6y2/3/LNFoQDKTiTEU7q49e1p6rSL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fTJ8SgZP; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fTJ8SgZP"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-51761d27612so17236581cf.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 08:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415546; x=1781020346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GS7uQD7/dVRcIOKlI8X91PbNQiNSL1LkFvltxQgrYVM=;
        b=fTJ8SgZPZSrvzTLLgCael4g/dVYyM1BB2Jlr3GYcWGhN7R96G9kzZKla3Htbxsp0Nh
         /8+hHlwR2PmFYVPs5djWU6f/hcXKTVZ98h9hULiP68kTtGkN9LGlzKVaXfld8qX02QPw
         Tjapw/PnwRnD25Gw5Jgvmph875vfT/Ft1fYrDgyPmWgS7XVatBSz8mUKc/V/AmVwMO+C
         s2kKBtNiTWE1bcEBakAOyVqLgsuIdRyVeVGLfMWHvhY6SyIxwrPGg/m/VPiiflVykIE6
         QgKVhP/NnO6oGMf0zGXLVeeaySOKCD7/bF65or14RnyO4BZUL6gnvkvN/agJQUOx9ZhT
         OV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415546; x=1781020346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GS7uQD7/dVRcIOKlI8X91PbNQiNSL1LkFvltxQgrYVM=;
        b=O3zc4lhlEEm3t+EFpco6xHocFyv29fPY3CStaUV3WJ0uCTK+V602SvU+rCD3F4KuKa
         8Mt++8IQDGVXQungqytfRhvSpFME1iYvZ8ZDSxicyZG/tFIKuN4I1YIB63+tt4LTSMyL
         YFsOG95//T7E2H1Mwf9DsPL1mp/boKRL0ZZJ2Pi1hcqXhWO8QQwNjp1XLiSmQ/pYxkgZ
         lOtHxUH+v4OjSHdk7NSUUVnnTL/oq1o9158tZmaOFeINWaKVNsiH8jVTCpZbK41UaItA
         P1vxXsP1tPRqFV7SXx8FqjxUqrFupQA+Fpho1nR/BQZEVHntxd0vTeXB/Q6t31Mxudb0
         /w4g==
X-Gm-Message-State: AOJu0YyJgsnvucQjJ2ryJaZ7IuPqfbUVNfO1qXVqzSJPlWLrrQ/dHP6P
	bjSUXgnk60b+taGjiFn9IwZQRItai59BNgLav2Sgz5yzpjWKwLIpirnhMplxmA==
X-Gm-Gg: Acq92OH2hJyNWVZ7Lse5i799XlyWYmQwAN96/uzLAUGvs53SWpHCjO/MiOPX6NZJoUS
	4/INOyITJ3VGD9B4R7Mv9tCjxBXTI83rhn052WeSWRS85NHmQurILp+iA/Wl0MJ3HCdWyJC6Nqf
	8+JyzeJ+NPUZlTWhetzB3PHyLpREdzTE9opuWaAjLXGRc1txGsQe9Q+n7ncQ5qG9Jfk1iEbtPwg
	NLgs1g7SlUS2ztEigWa33fjYNi8WfprQ8/8Awv+V78+RzR9zVULbGuoA2sjz7c11WrbPozRq/QH
	id+gMUAJMgjjisU3OAeOvs67RqBXSOguWCBagHSGms65cvXCO8qkhBCoQiHxfuEfr8gIBukJC1V
	46Ba6obMKFA9vrzOvk04wimBv28KLIoCDYqgeYKNoLAO+88jZhpFU7/lEYz7F41T3BvSeFVv1Ok
	4jboxX+YqZne0pBWfs6/XSbrf63rNPeq708a65+pFmGbzRtQVegkOSmSu9SG1S20qjChXD0CCZ4
	BQqCP74hWFvWnMx9K4kCXvGLKrKpA==
X-Received: by 2002:a05:622a:c6:b0:517:63a6:e1bb with SMTP id d75a77b69052e-51763a6e8d3mr81558651cf.39.1780415546238;
        Tue, 02 Jun 2026 08:52:26 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775e27cc7sm1520351cf.29.2026.06.02.08.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:52:25 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] rtla/timerlat: Add tests for option parsing with attached arguments
Date: Tue,  2 Jun 2026 11:52:08 -0400
Message-ID: <20260602155210.60439-2-jkacur@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602155210.60439-1-jkacur@redhat.com>
References: <20260602155210.60439-1-jkacur@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests to verify that numeric arguments work correctly with both
attached and detached formats:
  -p 100        (short with space)
  -p100         (short without space)
  --period=100  (long with =)
  --period 100  (long with space)

These tests prevent regression of the bug fixed in commit eefa8af46ff7
("rtla/timerlat: Fix parsing of short options with attached arguments")
where -p100 was incorrectly parsed as multiple separate options.

The tests verify that:
1. All four argument formats succeed (exit code 0)
2. None trigger the "no-irq and no-thread" error that occurred when
   the bug was present

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/tests/timerlat.t | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index fd4935fd7b49..1a63301f5d70 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -42,6 +42,16 @@ check "verify -c/--cpus" \
 check "hist test in nanoseconds" \
 	"timerlat hist -i 2 -c 0 -n -d 10s" 2 "ns"
 
+# Option parsing tests - verify attached numeric arguments work correctly
+check "verify -p with space" \
+	"timerlat hist -p 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify -p without space (attached argument)" \
+	"timerlat hist -p100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify --period with equals" \
+	"timerlat hist --period=100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify --period with space" \
+	"timerlat hist --period 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+
 # Actions tests
 check "trace output through -t" \
 	"timerlat hist -T 2 -t" 2 "^  Saving trace to timerlat_trace.txt$"
-- 
2.54.0

