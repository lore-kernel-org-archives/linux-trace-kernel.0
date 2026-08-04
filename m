Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AC46C833
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852243; cv=none; b=XikNwuK+kYN4E0Imj5d/1wYpJXLSZM8C+ZwMP6aXpqW5SJLeN9bLpZz0U4tzAeoT8yGzgKycCS1XvTijxgDQw7RzP5Vf0SPMFxVNuS8NdelzS88LXuzjQaJhARhhsPgXLJXDK3tu5Y+pAWYwC2iZ6dDjzi5VHhSgu7hb8rhl5WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852243; c=relaxed/simple;
	bh=IsHmUPcqi9NIP82lQ7ezs1gMk5K5q+JXKl7YBMvC2I4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H4h3zSCQ9MfpzggiaeplexjFTA6xx2PvGQPpeyeKPFJCnIhkVugllVCSAocK0LtHE6kXBpWfgWsrR1VmqSi9ywa90OnH9RNmQCixH5uyzRdOu5xc4syQKe/T5Ch35kUAex+yMWbLD8XfFuFbAXwvRnRDvFjKRqizAJHfdWW3xv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=de1hIETp; arc=none smtp.client-ip=209.85.221.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="de1hIETp"
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-47f8f8fde2dso3510445f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852240; x=1786457040; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Dl6nk6KZuL3gAoZ29Y5S3I6bxjuO0XPO7F46zwNpZc=;
        b=de1hIETpTh6HuelitKecoan9rv3yNCYeDBOKHzx6Aw8YNE/H4j3zP+OMMFu/tZ+Aze
         KCCJwhzulmU0CWc+jTW/9p7UCULbqhEUZFyo2pThJNudhhjLLa0VZFBPAlTNen5D7r+i
         eoaZRgMUoDGFYVE52zo5PZN23tFTkhomhe+iRYp17rJdp38xp5bb6v3NBTQ8N7l8MeJg
         d8hR7EfG62MR/GwLsfvkw9WEPMDDhnopXmrFjwTPWLRQnptYGqRUWu5HOxqWi4JSoiaE
         HBLuKLYeaQi7+fVLeaHrzFDIty9lSYaPDTlSddxdG+oJ+uXF/7+S/tHryJLdnOpf6M37
         B2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852240; x=1786457040;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8Dl6nk6KZuL3gAoZ29Y5S3I6bxjuO0XPO7F46zwNpZc=;
        b=J8Gqac4gTYdNAoLs4VibPvqcC0K05o9xXYAp3eRIPnO6WCoSl5lja7nFKHqCX2G82x
         vWWL0xaNF9HlEfGFkAetAyQz/IcZTkTHZXiZHELVtkaf9irtSaWOIrqOGg0zF2EpbB/X
         0DkSsXJrRDuM2syj3rxHbEFWUnzDTNQsYM//IZrOau7zmuJ4FHsjFWxnBVxGrlaBMCsJ
         yEI8cwPGQN00CEt6i+83FsX24aGQSgKmXSIhPEy961l6YcoW6fTzVCSntTRe6C/wjeW2
         sgkaWgv1m18jlIGvoEMCdeZ9CSW8eRwGhzST1/1GQkT2ujpKQydOyXnPjQKRbFkJHJxh
         PgHg==
X-Forwarded-Encrypted: i=1; AHgh+Roo3IG5wrOEDu5NgJavA697O5Rst/djv0dnbYzt3RLma7pGWsLkXI23KFV7ly24RY4kt/V4NoBkQfVBl3L1NpWNBRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjRYq9GxwllWt2yBB4S56JgwLGYAwnf5FwRtD/VhSEEye+ySmi
	hzEwcniIcjg8oQrRtSXzI674GPXb6nG8lnHSFDIF6ZV2UDesinqw7md9IIbmgqYuVmBNLKXwhmO
	OWG1/tAr5A6kZCX+Rv4HzKA==
X-Received: from wmqg13.prod.google.com ([2002:a05:600c:4ecd:b0:495:5422:15f2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:470a:b0:499:4892:e84e with SMTP id 5b1f17b1804b1-4994892e891mr144535735e9.11.1785852239416;
 Tue, 04 Aug 2026 07:03:59 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:22 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-8-vdonnefort@google.com>
Subject: [PATCH v4 07/18] tracing/remotes: selftests: Add a test for the dmesg
 tracefs file
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Exercise the newly introduced dmesg tracefs file that turns on and off
the dmesg redirection.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
new file mode 100644
index 000000000000..aebeea9dbab6
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
@@ -0,0 +1,72 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test trace remote dmesg redirection
+# requires: remotes/test
+
+. $TEST_DIR/remotes/functions
+
+test_dmesg()
+{
+    echo 0 > tracing_on
+    assert_unloaded
+
+    #
+    # Test dmesg on/off when tracing is disabled
+    #
+    echo 1 > dmesg
+    test $(cat dmesg) -eq 1
+    assert_loaded
+
+    echo 0 > dmesg
+    test $(cat dmesg) -eq 0
+    assert_unloaded
+
+    #
+    # Test events are logged to dmesg
+    #
+    dmesg -c > /dev/null
+
+    echo 1 > tracing_on
+    assert_loaded
+    echo 1 > dmesg
+    test $(cat dmesg) -eq 1
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
+    # Disable dmesg and Test events were not consumed by dmesg
+    #
+    echo 0 > dmesg
+    test $(cat dmesg) -eq 0
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
+    test_dmesg
+fi
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/functions b/tools/testing/selftests/ftrace/test.d/remotes/functions
index 05224fac3653..4a14aa72fdf0 100644
--- a/tools/testing/selftests/ftrace/test.d/remotes/functions
+++ b/tools/testing/selftests/ftrace/test.d/remotes/functions
@@ -8,6 +8,7 @@ setup_remote()
 
 	cd remotes/$name/
 	echo 0 > tracing_on
+	echo 0 > dmesg
 	clear_trace
 	echo 7 > buffer_size_kb
 	echo 0 > events/enable
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
new file mode 100644
index 000000000000..bf4a3c145e7a
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test the hypervisor trace dmesg redirection
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/dmesg.tc
+
+set -e
+setup_remote "hypervisor"
+test_dmesg
-- 
2.55.0.571.g244d577d93-goog

