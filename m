Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66DF47CA87
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551243; cv=none; b=MX1eAOl5usYAA47FNh5FSX3MqiY36kn/XKoCojcm22kkWOJv4+26xIGpEWajTKGPXgBo4cU0X2/69aWBm/aOkOfsq5mgOOWzcKtleNFUKeIBzCXdGZG/GtILaJvsMm8YuMrDqgHxY5ApTbwRfcVIMpIQhTxx57xZgUEnjVvomQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551243; c=relaxed/simple;
	bh=Q3kaC7y6azYi2qsxU5Tx8RlcvUUiR5/BoTSyGNe7H5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T7UNltjFhUltaVnA3DXfmrUtz8VpyO3MLQqn65OXvg1iwFjgEsOky0zXgU3R+G5CBu0eZ17HLm3xbvaw+jeYDfULEWfBfTq6VXttC4RbfzJKribF8s3IINx/G9BuHrmbze0vueAnwSKTGfR6Obhvv8HDb8twf+ZX1h5q96Isq/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VVL1dIYb; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VVL1dIYb"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f84ac1990so759957f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551240; x=1787156040; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gptDZ+SIOu9XP4iw4DNNMjlkLg35QG9nhQ8OcIEot7U=;
        b=VVL1dIYbdrbOdSZW76BcKjKamd5DaR4v/aFrkcKXoCLzYYHR6GmuLPUMvQbUH9vddL
         gb6YKzM9L+6jJ7A12OPG8uYaaif+RZK8/D+ebALGrj/Cq0wwuQX9d0mTL3zFMh7dwnja
         4/1jXUfGOJ4LdAx+MzBXxzyMnhWMvVDTUAo3jDtrUehWo3qDlN4FYg+SMcYaQM22ZmwH
         177uCXfYzN8uz8qa5SzQ+z7OLprQ/QE/tNqFlo3tAf+KenpWpWH9ULfaoEr8dEVK6ZX1
         BiMPXefuQ8rWPlqMRVmDyDioEgLp4IE7AMhMKhd9JhRJ3hENGaI7D41t+TuqVBejrbf/
         PM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551240; x=1787156040;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gptDZ+SIOu9XP4iw4DNNMjlkLg35QG9nhQ8OcIEot7U=;
        b=b3RWeXWUk4OuLSqGyVDz5iHCKEElWwWRRNKq/Ykliem6+ZAuSW15R7qkRWnjBj+hno
         ZeN6+0qVoWCVHa+m+3mV3OoEW7nJvu3oTBty2i8ql4TvBLuOn+i6YY5LIihMDGrNC0pM
         u13EDDY6Isie4xp0G+j2ghVaGON+/DAJLXaXgyY7BlPjDzSek0c3ItHUUC2dI2kgVapL
         84W5rL6K+55kcf8naZbAs0JQmJLzFdQk3g2OLbirdXgP3CjDlopBlj01v3AV1Vt1ZVxq
         Cq6f98PV3Af3UdLbipPFmdOEKrnWCB0eompWZNZoPoBZolBrz+0Tl+oc1H7BZd2L8Ytw
         kSoA==
X-Forwarded-Encrypted: i=1; AHgh+RqSraHKwZ4HcNvHZcLSPgQFDPmH9OU1QOkUbW0Hche5BLi/DBE9T2gy++1v+zcTWP18RDrTIFLY/E32wl7NUFxsz8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8SzEcj2sqJdcgAHVjuol8zbQbojz0P1GpCbT3HNiojXz/qoDF
	QZzrWi7R0OUBO+w7BxHP2CuFv4kP9BkfjSq1wIYzTtJ/dJiAIG3R9l6yjoRGLxjHVuCxWAfHncO
	i/EW7IdRFxqNS5reM0AIezA==
X-Received: from wmaz26.prod.google.com ([2002:a05:600c:6d9a:b0:495:4837:275e])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b20:b0:493:f318:3bc6 with SMTP id 5b1f17b1804b1-4997c15729cmr82969795e9.13.1786551239673;
 Wed, 12 Aug 2026 09:13:59 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:36 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-15-vdonnefort@google.com>
Subject: [PATCH v5 14/18] tracing/remotes: selftests: Add a test for the
 dump_on_panic tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Exercise the newly introduced dump_on_panic tracefs file that turns on
or off the trace remote buffer dump on system panic.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc
new file mode 100644
index 000000000000..5e3d3c412ecd
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/dump_on_panic.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace dump_on_panic
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/dump_on_panic.tc
+
+set -e
+setup_remote "hypervisor"
+test_dump_on_panic
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
new file mode 100644
index 000000000000..cb9b4c6dc86c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dump_on_panic.tc
@@ -0,0 +1,51 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote dump_on_panic
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_dump_on_panic()
+{
+    #
+    # Toggle when the buffer is loaded
+    #
+    assert_loaded
+    echo 1 > dump_on_panic
+    echo 0 > dump_on_panic
+
+    #
+    # Toggle when the buffer is unloaded
+    #
+    echo 0 > tracing_on
+    assert_unloaded
+    echo 1 > dump_on_panic
+    echo 0 > dump_on_panic
+
+    #
+    # Load and unload buffer while dump_on_panic is enabled
+    #
+    echo 0 > tracing_on
+    assert_unloaded
+
+    echo 1 > dump_on_panic
+    echo 1 > tracing_on
+    echo 0 > tracing_on
+
+    # REMOVE ME FOR A PROPER OOPS TEST
+    return
+
+    echo 1 > tracing_on
+
+    for i in $(seq 1 32); do
+        echo $i > write_event
+    done
+
+    echo c > /proc/sysrq-trigger
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+    setup_remote_test
+    test_dump_on_panic
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
index 4a14aa72fdf0..bdd28b5b8596 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -9,6 +9,7 @@ setup_remote()
 	cd remotes/$name/
 	echo 0 > tracing_on
 	echo 0 > dmesg
+	echo 0 > dump_on_panic
 	clear_trace
 	echo 7 > buffer_size_kb
 	echo 0 > events/enable
-- 
2.55.0.691.gc56d675ccc-goog

