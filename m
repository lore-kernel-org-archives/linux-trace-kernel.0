Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3043F8ED8
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420329; cv=none; b=YNELyia2oe6Gcn8ghb8cJ4MiU+PBjTj8oaLHb/Z3x2QduB0D6I7vWpt98zNuJzHEoVtVn7BeT9zm7gJqOVV7+zXXD0yRsdDleRMYOP/C42MjZ1/sJW/hFfhy7lQaDh8xCMFOj+E8XykgS9TyYi8ToShFjP7Uu/gxiR//Q3VXcKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420329; c=relaxed/simple;
	bh=vTprPBJOvANENpg/OMmSfVGiFw64Xlum2zkLJQM9vFg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aS4Ad88KGc40gGUyhPcLi+ayS5qwrZIcryeAp9NpLroZqIby+VY5q4S5u1F4HLRg8wUeJqqNgHdLLQPZ16GPgLucasxXTP0wEdAm5j9G3LwCTIdG2SzRZRJJikUxtMUJ9nt7A6eVHOrthqA7eS73eT7kD88A25bWPKI2cJwDJNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=c3L9B+Up; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c3L9B+Up"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-45eec2ba533so3973957f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420326; x=1781025126; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fijxRpUtwWebZSoIxVCctPN4xNPYzLYlfDMdHnsAC60=;
        b=c3L9B+UpAs1KNEYG2qrX4wOtyR1SJd1pI5ivwaMBffP2472jxkqXP6CFwfRA8Cs2TJ
         GvSlBNCVdXQNU8CGr6JB79eVNlU4p6InRL+qDnDszyJNyvK8vsUb+axkfJV0ExWN8MX4
         ARRteLH6Kl0Feak5oL2DOZg839LFY4ryllpkqyOZJPxrjuU/j+UINDXF3NfM+itbh8XS
         Y6chsCly6LfT46PgutJBzLXE+/9hYnAKCklKz5UcaTd9Q5EFHy70FrR6/sp73L6d6C8w
         2NCdZK2VrH/eeb7YllM4THRIgS7TjdtUWM214dENabok7+CePli0Nsf9b5KWDxpKyc2d
         lHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420326; x=1781025126;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fijxRpUtwWebZSoIxVCctPN4xNPYzLYlfDMdHnsAC60=;
        b=s+cNEG8kwYYDW0Y5wT7HuV2YxbnTQAR+bpV8HOtOxBXaJiwCEX1Q1wLRdpD00GadZv
         9M27GexcVM1ihIxYSebHc1H8pMRFP/jQPHeCxoxxv9j4CfrJt5JjHj4c2r7TJyV4FdRA
         xojKgCM+vhEV1EJX9RwdCeZZBSH/igeKLNHT6rc9LZceMHupgzHdoOtAb3JTLQ929Cjq
         XLiUF/OtPjX6QaT982N3Q0mkLCjoBNmCa4SNH7lXDuwYGOUS7nzzAp7EktnnEMKoJX6h
         MWFiSX7p5Zvabl+RqR4+EXpBYNM80LjZ3vUREZAY7c24srK/R9dFDH9ojVAphol7MVy6
         cq/w==
X-Forwarded-Encrypted: i=1; AFNElJ/V0mJCzRRPAoBp3/5AdDO+n2wk/BQM995YxYaZMX5edSMEX1gNPo6O4yXidccAliiAwmgqM9EyD+9Rcczi8k8hyBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIXSsMEohSlVe/WMVQSRZJbhzI1buBzWadi+fRqoG5/RyLZ9d2
	LaUA0t0VlnfuwKyPS502A9tSgmDQ2tsWmmir3enjwEvKXaiT+1XKg+Yq52MqgDzARNtYNtxxQI5
	XaBrxqoGM1rZsSnx916p42Q==
X-Received: from wrtr3.prod.google.com ([2002:a5d:4e43:0:b0:43d:7611:5aa5])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:6211:0:b0:45e:f228:830d with SMTP id ffacd0b85a97d-4601f6334e8mr221325f8f.23.1780420325431;
 Tue, 02 Jun 2026 10:12:05 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:38 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-7-vdonnefort@google.com>
Subject: [PATCH 06/13] tracing/remotes: selftests: Add a test for the printk
 tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Exercise the newly introduced printk tracefs file that turns on and off
the dmesg redirection.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
index 05224fac3653..8dd9c961977b 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -8,6 +8,7 @@ setup_remote()
 
 	cd remotes/$name/
 	echo 0 > tracing_on
+	echo 0 > printk
 	clear_trace
 	echo 7 > buffer_size_kb
 	echo 0 > events/enable
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/printk.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/printk.tc
new file mode 100644
index 000000000000..aca7a2bfe293
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/printk.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote printk, the dmesg redirection
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/printk.tc
+
+set -e
+setup_remote "hypervisor"
+test_printk
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/printk.tc b/tools/testing/selftests/ftrace/test.d/remotes/printk.tc
new file mode 100644
index 000000000000..80eaf13e240d
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/printk.tc
@@ -0,0 +1,72 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote printk, the dmesg redirection
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_printk()
+{
+    echo 0 > tracing_on
+    assert_unloaded
+
+    #
+    # Test printk on/off when tracing is disabled
+    #
+    echo 1 > printk
+    test $(cat printk) -eq 1
+    assert_loaded
+
+    echo 0 > printk
+    test $(cat printk) -eq 0
+    assert_unloaded
+
+    #
+    # Test events are logged to dmesg
+    #
+    dmesg -c > /dev/null
+
+    echo 1 > tracing_on
+    assert_loaded
+    echo 1 > printk
+    test $(cat printk) -eq 1
+
+    nr_events=128
+    for i in $(seq 1 $nr_events); do
+        echo $i > write_event
+    done
+
+    sleep 1
+    output=$(mktemp $TMPDIR/remote_test.XXXXXX)
+    dmesg | grep "selftest id=" | sed 's/^[^]]*] //'> $output
+
+    check_trace 1 $nr_events $output
+
+    rm $output
+
+    #
+    # Disable printk and Test events were not consumed by dmesg
+    #
+    echo 0 > printk
+    test $(cat printk) -eq 0
+
+    start_id=$(($nr_events + 1))
+    end_id=$(($start_id + $nr_events))
+
+    for i in $(seq $start_id $end_id); do
+        echo $i > write_event
+    done
+
+    sleep 1
+
+    output=$(dump_trace_pipe)
+    check_trace $start_id $end_id $output
+    rm $output
+}
+
+if [ -z "$SOURCE_REMOTE_TEST" ]; then
+    set -e
+
+    setup_remote_test
+    test_printk
+fi
-- 
2.54.0.1032.g2f8565e1d1-goog

