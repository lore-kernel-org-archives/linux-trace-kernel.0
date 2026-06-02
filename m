Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D83F1AD6
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 15:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415549; cv=none; b=jhTy9YF3J4SmEfwV07VC426PQAcjEIkt+SD2Y0Z/UOU5nPoFGgCuxADaDMocuZKO4KzF/bhO4eDkY9yKw72qYRoGlwE70TKN0fjkUDm+b8l08lAI32C+UkR/pX8CXyt3rBa532AQwy5fTStuAbKH6fFqcNZ8tU1jxehGs8/iRq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415549; c=relaxed/simple;
	bh=GwT9o00dmaLqOv61Un1yDWpqIcsCAtOZcLhfVIcYHpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QqLz6kKuS4AcNM0r9gI4vRXjswP/hZgdfZdvAa/yKHF6DXn2xi/Oyy4iBNN1KqqrGo3lF8dGC/MS9sJUWivv4WmTiKIbtJYvs9iTHjpnE2NIVnkqhGlJNcI2rcaSREBTLU2cAlrAKiA0FDunKUkXyP0Bu3clagWfUUfelkcbtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8FdeZre; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8FdeZre"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-91563abd6a9so109988485a.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780415547; x=1781020347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzVQlUS6Ma27cMpUQ+7FK5Q0dPa4ejPpWzIeqaSTbGc=;
        b=C8FdeZresXpX7RR+sTmfJxQtbZaxg3GKb+78FnRrOXIahPM7dUOzs0r/mVBZ1JFPmn
         eISxfntHtLTFHesDKr4+l5jdCzrnGgvh7DEhgKgPqWgD6a0Hqu+ZsMrffTzU1l8mnCqz
         4ULDDZpD/L/oo3Ob+lUma/NIgaJouknHzPTwXY/MtRQH2Px+oMmjRKFDWE1FEdVGWtA2
         imNnnVnCkxkPw0XbK9co46nq1sCW8ByJ3uWCNabnqB+xsRxl5yIlrQWirMi2D/vqck3I
         TdDKwoMyvacT8wy/hWYrki1IFDmExo/is2y0MIHWqm8WBVUdKTn4VrV3i73xoRsOSwJa
         hPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780415547; x=1781020347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzVQlUS6Ma27cMpUQ+7FK5Q0dPa4ejPpWzIeqaSTbGc=;
        b=gwUoR/f9dB93oK4Yc/yBt6oXkNSjefXLKmSKP5DLpoLClfBRZy0FBe1p4UjeFQKLFV
         4cMPpZKi6hoXVJyBzzfTOVqGFmrFtKiNqsTN3OiA1dbfYdI4vEvFbMwWre84e90H+Xgk
         AldIMg5PKgZ1R+stbzSVc1ZPskmerdK2zstASoArDEjNhzyl7oofD91D1EI9o8dK7GWZ
         05/exyacpadbGwynX5q/eD293d3FSzidANMid9TiaE8MZRt7LJW3On8IKDuKcO3CzqJ+
         A3toof5bNbAQHrIGLlzG5MyT+he3UBS/0m+LZbgl9zToqPBISEOVG8Ws+dNuKL5H6oUM
         vCDg==
X-Gm-Message-State: AOJu0YzsDmYSRpTPj5hMD49l5jNBfag5hyQlzbfbikyemYF9MRCWyRPr
	NAz9ACFVQchNXYj/f5yfVwKIgoOz8D9cJ9EpxaQIseHXw8hmlMlfRGXhjcgbxw==
X-Gm-Gg: Acq92OFeuPZW+trvq2/YwPqkFk/pO9flMIERJlNt1O1bgpyczdl6x7nQD/4+D8QFH8W
	mkDfZDp16+E1/3A3NqztbsvLjQBpp2nPVcOfDZE4lkdlPWoV4VGEpdNPSz+4fubXliwGaYmfdzo
	pGH+ZbLyjUCfpVXDLXE8pAHdLtqVXQdldnVdXFJveCkxXpuQpyxbiTINz3ZrYQd0LQEXAsUW8lW
	cxrVr8dhRbWlVpodCSsZLnzA6xYjrqvtI8cuukNoSLbVGMIpr7mSzRiq1nTIcoJ5zBtvJSSnrN5
	GPCGcej4ioSLu41SEe+6/9/eHYi3GdrOSpQazJNXgZ6eD0ZXOw1ukavXVKk0+FG4BQvnpn7cilR
	/Hh0UML6wRr2903jcPq1IoMpbt6SSu/dRjAydt2p+F5Gk5Ie32/m+kMyNy11/uvHlngkNwAtiaN
	0xBZKu+OqkwVh554u+naELuwH7qeQCUko1J0TbEM+VA8zYpJhVhym/zQkfay94V/BfLO+i781wt
	GPZhFfwi3/yxmCVSo9hq8QFEgGOxg==
X-Received: by 2002:a05:622a:6843:10b0:516:e74e:cc51 with SMTP id d75a77b69052e-5173a85c1aemr185342511cf.51.1780415547263;
        Tue, 02 Jun 2026 08:52:27 -0700 (PDT)
Received: from Cumhall.redhat.com ([216.209.112.32])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51775e27cc7sm1520351cf.29.2026.06.02.08.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 08:52:26 -0700 (PDT)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtla: Add tests for option parsing with attached arguments
Date: Tue,  2 Jun 2026 11:52:09 -0400
Message-ID: <20260602155210.60439-3-jkacur@redhat.com>
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

Add tests to verify that short options with attached numeric arguments
work correctly for all rtla commands after the parsing fixes.

Tests verify four formats for each command:
- Short option with space: -p 100
- Short option attached: -p100
- Long option with equals: --period=100
- Long option with space: --period 100

For osnoise and hwnoise commands, the tests also include -r 100 (runtime)
to satisfy the osnoise constraint that runtime <= period.

These tests complement the existing timerlat hist tests added in commit
d489b602c669 ("rtla/timerlat: Add tests for option parsing with attached
arguments").

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/tests/hwnoise.t  | 10 ++++++++++
 tools/tracing/rtla/tests/osnoise.t  | 18 ++++++++++++++++++
 tools/tracing/rtla/tests/timerlat.t |  8 ++++++++
 3 files changed, 36 insertions(+)

diff --git a/tools/tracing/rtla/tests/hwnoise.t b/tools/tracing/rtla/tests/hwnoise.t
index 23ce250a6852..c61f02bc42fe 100644
--- a/tools/tracing/rtla/tests/hwnoise.t
+++ b/tools/tracing/rtla/tests/hwnoise.t
@@ -19,4 +19,14 @@ check "enable a trace event trigger" \
 	"hwnoise -t -e osnoise:irq_noise --trigger=\"hist:key=desc,duration:sort=desc,duration:vals=hitcount\" -d 10s" \
 	0 "Saving event osnoise:irq_noise hist to osnoise_irq_noise_hist.txt"
 
+# Option parsing tests - verify attached numeric arguments work correctly
+check "verify -p with space" \
+	"hwnoise -p 100 -r 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify -p without space (attached argument)" \
+	"hwnoise -p100 -r 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify --period with equals" \
+	"hwnoise --period=100 -r 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify --period with space" \
+	"hwnoise --period 100 -r 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+
 test_end
diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/tests/osnoise.t
index 396334608920..1807236431df 100644
--- a/tools/tracing/rtla/tests/osnoise.t
+++ b/tools/tracing/rtla/tests/osnoise.t
@@ -17,6 +17,24 @@ check "verify the  --trace param" \
 check "verify the --entries/-E param" \
 	"osnoise hist -P F:1 -c 0 -r 900000 -d 10s -b 10 -E 25"
 
+# Option parsing tests - verify attached numeric arguments work correctly
+check "verify -p with space" \
+	"osnoise hist -p 100 -r 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify -p without space (attached argument)" \
+	"osnoise hist -p100 -r 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify --period with equals" \
+	"osnoise hist --period=100 -r 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify --period with space" \
+	"osnoise hist --period 100 -r 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify osnoise top -p with space" \
+	"osnoise top -p 100 -r 100 -c 0 -d 1s -q" 0 "" "no-irq and no-thread"
+check "verify osnoise top -p without space (attached argument)" \
+	"osnoise top -p100 -r 100 -c 0 -d 1s -q" 0 "" "no-irq and no-thread"
+check "verify osnoise top --period with equals" \
+	"osnoise top --period=100 -r 100 -c 0 -d 1s -q" 0 "" "no-irq and no-thread"
+check "verify osnoise top --period with space" \
+	"osnoise top --period 100 -r 100 -c 0 -d 1s -q" 0 "" "no-irq and no-thread"
+
 # Test setting default period by putting an absurdly high period
 # and stopping on threshold.
 # If default period is not set, this will time out.
diff --git a/tools/tracing/rtla/tests/timerlat.t b/tools/tracing/rtla/tests/timerlat.t
index 1a63301f5d70..506227412027 100644
--- a/tools/tracing/rtla/tests/timerlat.t
+++ b/tools/tracing/rtla/tests/timerlat.t
@@ -51,6 +51,14 @@ check "verify --period with equals" \
 	"timerlat hist --period=100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
 check "verify --period with space" \
 	"timerlat hist --period 100 -c 0 -d 1s" 0 "" "no-irq and no-thread"
+check "verify timerlat top -p with space" \
+	"timerlat top -p 100 -c 0 -d 1s -q" 0 "" "no-irq and no-thread"
+check "verify timerlat top -p without space (attached argument)" \
+	"timerlat top -p100 -c 0 -d 1s -q" 0 "" "no-irq and no-thread"
+check "verify timerlat top --period with equals" \
+	"timerlat top --period=100 -c 0 -d 1s -q" 0 "" "no-irq and no-thread"
+check "verify timerlat top --period with space" \
+	"timerlat top --period 100 -c 0 -d 1s -q" 0 "" "no-irq and no-thread"
 
 # Actions tests
 check "trace output through -t" \
-- 
2.54.0

