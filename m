Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0292463B89
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551235; cv=none; b=T1F5V1u+vo2kOY8brqpYYVCkAvaj6g30fNa7vw9X4QoW3G0kjZiO2fNBI6Us87TZVQL4IgLtYRysFid3xmLGcN96QatsSr9XiOi0W4vGnrDhVtuQlcLccWocGh6NLofH6lJGqhW34yE0seZ35/gXW7jq3/E94MMWN0GB3zhZtZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551235; c=relaxed/simple;
	bh=bZRXh/TnHLrfNBxG5+WfOqv+hUnm+N9puAmR8apQB84=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TNLOssM2G7/UDth/SCTlgwvQSUSaZrcFjGXsnj6HHg8O6luWAAIaw8+JzAn0NwNva2mz29+q9+0fJxUpDJ8h65DuOLuOcSENi6NisFH/NTWYE/WPYAVAivqYLMTuxurQcPJFOK5BlwpGQU0b80ymjSd4liWv9qocZ5t8KFunFsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYQifnYS; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYQifnYS"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-492488f8583so8728065e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551232; x=1787156032; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IyX30UnnQM5K2h/VuSV2hf58gL47XyVUanQanbzxkCk=;
        b=IYQifnYSKqxCpuAb9TwPvagY91cyg0Cgmv7hUVyQtpCd9IBVNfuieRBuQK1eTuoqWS
         kEXlhaPOoyQQc1DLqacp/BbhXuxEbOx2ofLUp5dIPi63AT8eSk4VQP9d9zFx+5knbO/0
         5qFvotMjHjWJpVv4EoO6XK99py+/vbjnaj1oTlFbsB8uAL0syCV+OYmjt/4rLcca1bBy
         kWRyibMfgrkdDVeukP8eGOmSohcKzekae3VyDMd9gtQufS1Xlb2gIU67uYq5D6L/cKu8
         y3LL/cHU5BeqSaBEVG+PISIy/fVdKpjKPWJeCivU3wfbG9iQ5AfspDldPbAMqjtoacpD
         KeFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551232; x=1787156032;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IyX30UnnQM5K2h/VuSV2hf58gL47XyVUanQanbzxkCk=;
        b=G6ur0/Xrm/Af1OKoQYhencJVX9GofZ6PtxZnKGOr6L/qWq0MAD6awiJ2+6V/3UedPB
         2erHoXQ5nTEaJAqx4fgz2Ev+o3x8Lm1IqQIBfdIHU8/TRHCbNlp0sWUH+DFHJ2NM+R2s
         vN8mgdYzty91YVJhV7hQpTPguJKRZFzoJJ48TcdpNunudLzD3S5invAsA13xW7koTLBK
         byG/0R+yjcWd5RzLm9hIRlwo5c1Esit4wuXYjEmiNJVUUrhXbfZGviFn7z278/8qFg79
         ZE9Dw0ZUrEJQmjYCr+dmQA4L192plJWm+6ivqVC4BYXducI+RtQfyl1vLbSHN5YxfS+H
         J7ZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr59XobZayq50XXCtKQ498Vuox2S4e3e/TSLkLmEhITRPZqpahKBdi3M2OSSHHAwYh6mSGmP2c1bx/mwznmEKAq5Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGQny5xfrMeAnioosaxf4Jg4zBmluTnicJOvXYVYVqVa061Koe
	xlvEFuBDfFw7C38qj3qnbBOD5HP+/ad4nWLe/5e5hvGHFw9ZcWbhTj0IIYnAEK6Fv7S9CCiWf2h
	/Lhzz4umyAN0Llz7l/USczg==
X-Received: from wmpb42.prod.google.com ([2002:a05:600c:4aaa:b0:495:46c3:5e5c])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:63d6:b0:499:5220:db3d with SMTP id 5b1f17b1804b1-4997c132cf8mr52490505e9.16.1786551232009;
 Wed, 12 Aug 2026 09:13:52 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:29 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-8-vdonnefort@google.com>
Subject: [PATCH v5 07/18] tracing/remotes: selftests: Add a test for the dmesg
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
index 000000000000..9d389f9d0fb7
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/dmesg.tc
@@ -0,0 +1,81 @@
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
+
+    echo 1 > tracing_on
+    assert_loaded
+    echo 1 > dmesg
+    test $(cat dmesg) -eq 1
+
+    # Timestamp format is '[    XXXX.YYYY]'
+    last_ts=$(dmesg | tail -1 | sed -n 's/^\[ *\([0-9]*.[0-9]*\)\].*/\1/p')
+    if [ -z "$last_ts" ]; then
+        last_ts=0
+    fi
+
+    nr_events=128
+    for i in $(seq 1 $nr_events); do
+        echo $i > write_event
+    done
+
+    sleep 1
+    output=$(mktemp /tmp/remote_test.XXXXXX)
+    dmesg | awk -v ts=$last_ts '
+    /^[ *[0-9]+\.[0-9]+\]/ {
+        t=$0; sub(/^[[ \t]*/, "", t); sub(/].*/, "", t);
+        if (t+0 > ts+0) print $0
+    }' | grep "selftest id=" | sed 's/^[^]]*] //'> $output
+
+    check_trace 1 $nr_events $output
+
+    rm $output
+
+    #
+    # Disable dmesg and verify events were not consumed by dmesg
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
index 000000000000..2ebb90b80b4b
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/dmesg.tc
@@ -0,0 +1,11 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Test hypervisor trace dmesg redirection
+# requires: remotes/hypervisor/write_event
+
+SOURCE_REMOTE_TEST=1
+. $TEST_DIR/remotes/dmesg.tc
+
+set -e
+setup_remote "hypervisor"
+test_dmesg
-- 
2.55.0.691.gc56d675ccc-goog

