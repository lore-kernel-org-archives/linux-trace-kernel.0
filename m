Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792913402;
	b=KxqqiDzSqnFrM9v2gJ7Us1a62rlbSOWPht6xeWGPiZBXeL5ErslnnaZpbU7d8Ekx12M7
	 HQbPrlkQ+nGx+jsjkg20HJZ3pdJIKyobvhxVMQxngAUsBFoA40sEbY7rBtcdTrBZYPVWx
	 1YZgaeShTu6wUwYSfV2EmhzDmeVxSMp+yT/+pUQaSjtQ8610h5p3WtVYI3Vdzs5w7LOfy
	 IT3Khz5SnXLs6WCNbedNFO18GQu9M8BYsXffRaADaw87LB+ZdU0F+tHJ+uIhMJ60xIRpz
	 uMMaCkQkasclacfCFvUqOB3GOA8r7LtqdgE6b54oc1qcv+SAjjJNOD/WJIKuN4oXsRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792913402;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Ca84V1D9B8Ybj/7LgOQ6VhiC3u886cles4dpmUcGdP0=;
	b=Vcd/EUEmg52yXM0eI/bao1oU3s4wf/aoHxIjMsLa68W7XlZ9a7VJCm3PRIfMxwJEIm/R
	 S9ddXyqgjLe0/342s4ytXWf8pdBTPU0gn2xsHfyJmiZAutDOpkBO4RicWuZ8ir1frzmd1
	 1GEHFFRwTRsVXJlRKodvTfpkEDKQALF19lYbqEaEQvvJlmVb9pETMHOURUFOAt7EB/KYS
	 7yN/yECDq+EbhWzgZjX5x4Se/YuGgc9ertHWn+vcPTH7Tov6g+LKTbJpYKkGAhIN3goj9
	 iychstfM4OKYw1WZawwT6LhbgAFXCb72ydvgmqWxIJNHCnoDFVDN4q9SNz7tLWyWruw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sbXu8TmW;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B4606A31D
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 07:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 239B4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sbXu8TmW
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e977109392so11506345ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 00:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792913401; x=1793518201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ca84V1D9B8Ybj/7LgOQ6VhiC3u886cles4dpmUcGdP0=;
        b=sbXu8TmWoOHQrI8owKBYY+cShhIySq2CbLFlzir2i5fc2R9j8kIlcd1bA32HTv1ljK
         s1c2pu7rkeKozyEjYZYB2Se7ES828YwyltBHAF4G/PBj12X2ENqFNv/QOHoiHY85ldEr
         Er99edSVkY9kP97jiC21DjEYoMpySlGGzgtBxikkbnOTpQEXQa+wAMHSOZ2Y3lnJEcjn
         XcnLmHktz3Z6c3s1dTd4bxl3NmpHIGbdFh63JcXGLlyERo9Jc0iuoGSp+HNZQzv9KW1g
         njhcF7ceKgvztm6cz8xMA+PAGFaFY/iqmp6RtdZFZXfbcQ7PimdO446S0ZuU/OBO4xt0
         U6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792913401; x=1793518201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ca84V1D9B8Ybj/7LgOQ6VhiC3u886cles4dpmUcGdP0=;
        b=y21+LD6WgMFu78l9ckl2Zulb9T5kWATg8QSLatSRAwJjbiI2VbGtjdO5twYO4KxtAc
         ukX+KQVWrPKTpfjrFXxpl65kNJq7sLokk7e6QyPIqOHHmgLx4WWzrsqJ7Ye2Dl5/2kyC
         mAHbFwuQvRO3wtroxOGysWpjj5Pb+dIJDie4PlLqhL6YmSQqVx8ichWt+qYy+DouPb+e
         d1Bb8PPEt9LPJF/LcdWhD/GDg6ier09EsDCYrGTc87cKZWl3bq/QdPrl/dkmQxasmmHT
         5ytBCt/N6Dxexfluv8aiR0jS30Xup76D/7juspNVPlzs3h3eh37mGbgFDlF5sS6mmtrw
         FWcA==
X-Forwarded-Encrypted: i=1; AKwUvBwUcVTVIwbhWdMYz+8uhjBInOm+SAORYYGIZk0CmvVt1wrTnhIIiuK9v1xDvUS46hAXZZ/2B6Tw2cAFttowiV4MRyo=@vger.kernel.org
X-Gm-Message-State: AFq9FYI/I4vmyRKlpxEvbhfEE95scXiH/tU6u47zFCIxtpVp0Ek8xTlV
	P17eovbBzRLvcZ4XqqLeZBr/29gO2B+Ok6LbVNXjMFAJgLexJ+eiSBZh
X-Gm-Gg: AYBFou1RohWxVemJ7qS0QnzIfwDmCbToZhnFypFdG22DWlOy1BxkZypr5nr5DPo/q0b
	o9PDysEagASzw8Z2ZQz8UY1yX1uxK7gppBrsHo4ipCFHDq7MRafpPU0998fklaK3f6oOocmtBVY
	xFVeLGl4Z3ljrP/SB7wdkPz69GMZLlDQU466bbESai9e+Y4o5DJJ9VGQD0vJWQiLvRGl8POgf3V
	+CpdsPLFB/l036365Ruf6Arp3O3e/5dFSNy/qgN8PN7RUJpQ37rE/T7lwULXRXf9GwHEYZI3Q3Z
	RbFUc41PXbDPsjx0YTuZfsIbkz3U9mznPNbL5+SVYWtq9v5r6/n+ekjYCh4G2Sr/DY+Z2UEU3BY
	okzAxm6gmKjk8lNr4UozHbG1Kx1wmlZVuh/+qbt75CIWC+mz5/nCHxBGKWejhKw0LJ1Efk+nara
	M0F5sujzlQCOHlpaxhoYOqhGbsZpdX+MkJ7FOscqkqfCcs1wNC14DSWEgQDZOAzGNrNO0HJk4Qb
	9uEipHziix8pirltlpXaKyMVCXVouEGaOpY/V/ErUNG6qKsV3qL9aU=
X-Received: by 2002:a17:902:ce03:b0:2e2:e3aa:7a35 with SMTP id d9443c01a7336-2ea9c7fb4c2mr32015315ad.36.1792913401389;
        Sun, 25 Oct 2026 00:30:01 -0700 (PDT)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b121725sm7788525ad.14.2026.10.25.00.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 00:30:01 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Add debugfs requirement suffix
Date: Sun, 25 Oct 2026 16:29:41 +0900
Message-ID: <20261025072956.1739981-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Add a :debugfs requirement suffix to check interfaces under debugfs.
Use it in the kprobe optimization test to report unsupported instead
of failed when debugfs is unavailable.

Tested on x86_64 with QEMU:
- debugfs not mounted: UNSUPPORTED
- debugfs mounted: PASS

Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
 tools/testing/selftests/ftrace/test.d/functions        | 10 ++++++++++
 .../selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc |  4 ++--
 tools/testing/selftests/ftrace/test.d/template         |  1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 826141e299e5..3cf8ac5fb4d4 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -145,6 +145,7 @@ check_requires() { # Check required files and tracers
 	p=${i%:program}
         r=${i%:README}
         t=${i%:tracer}
+	d=${i%:debugfs}
 	if [ "$p" != "$i" ]; then
 	    if ! which "$p" ; then
                 echo "Required program $p is not found."
@@ -166,6 +167,15 @@ check_requires() { # Check required files and tracers
                 echo "Required feature pattern \"$r\" is not in README."
                 exit_unsupported
             fi
+	elif [ "$d" != "$i" ]; then
+	    DEBUGFS_DIR=$(awk '$3 == "debugfs" { print $2; exit }' /proc/mounts)
+	    if [ -z "$DEBUGFS_DIR" ]; then
+		echo "Required filesystem debugfs is not mounted."
+		exit_unsupported
+	    elif [ ! -e "$DEBUGFS_DIR/$d" ]; then
+		echo "Required debugfs interface $d doesn't exist."
+		exit_unsupported
+	    fi
         elif [ ! -e "$i" ]; then
             echo "Required feature interface $i doesn't exist."
             exit_unsupported
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
index 9f5d99328086..25f7192f887b 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_opt_types.tc
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (C) 2023 Akanksha J N, IBM corporation
 # description: Register/unregister optimized probe
-# requires: kprobe_events
+# requires: kprobe_events kprobes/list:debugfs
 
 case `uname -m` in
 x86_64)
@@ -22,7 +22,7 @@ for i in `seq 0 255`; do
         echo  "p:testprobe $FUNCTION_FORK+${i}" > kprobe_events || continue
         echo 1 > events/kprobes/enable || continue
         (echo "forked")
-	PROBE=$(grep $FUNCTION_FORK /sys/kernel/debug/kprobes/list)
+	PROBE=$(grep $FUNCTION_FORK "$DEBUGFS_DIR/kprobes/list")
         echo 0 > events/kprobes/enable
         echo > kprobe_events
 	if echo $PROBE | grep -q OPTIMIZED; then
diff --git a/tools/testing/selftests/ftrace/test.d/template b/tools/testing/selftests/ftrace/test.d/template
index 2cd8947edf72..d4a2500498f6 100644
--- a/tools/testing/selftests/ftrace/test.d/template
+++ b/tools/testing/selftests/ftrace/test.d/template
@@ -5,6 +5,7 @@
 # The required tracer needs :tracer suffix, e.g. function:tracer
 # The required README string needs :README suffix, e.g. "x8/16/32/64":README
 # and the README string is treated as a fixed-string instead of regexp pattern.
+# The required debugfs interface needs :debugfs suffix, e.g. kprobes/list:debugfs
 # you have to add ".tc" extention for your testcase file
 # Note that all tests are run with "errexit" option.
 
-- 
2.43.0

