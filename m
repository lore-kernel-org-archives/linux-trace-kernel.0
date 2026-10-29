Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305927;
	b=wVzTPD7hMALg2kKlboyJ1XNP9cE0UDWlIiP02m0tqsCDa2fq9GnZPYnjNe0VrVk/tA/o
	 Zeo8kUAJcW1nRrMyItdZVXnmsP00LBEHb3i2dl/KYm8Urxk6qLJ3EoCKlRz7Fd+xDdgij
	 7zmj5fnQWoNoK1WgDZdFOy6dWVDriChRn3ZDtfR2GxgnJu43CxEiv7MlHD4EwJiqhVTTw
	 og4bmnqYSG/HLfZ6+LFvTG+BCXx01Fhes9VaCZeIrXiNmueSeSErGQkl2ocnCy/3OxS8s
	 rEKpT15wVl8sz1p2Wi0rTINgACH+ATuEQntSRzXDGrfPPdEdKtQMcesmXm4UotBiV+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305927;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=8hkwVtxP+8+AhK5KECd3ruUT2wJCHZuckbGZKEwrBno=;
	b=QA/yx+o1aceDuAAUSbePmOpIB5wVtjcEoGAqVtI16FBzQtfuYnBjjlWEY+NGfDdAFD4j
	 QaNJ2yLj3JFibWD5UUi5fZ8fyXv6CW6IV08+4YSwksLl10tSqlCu+8/8cnWLcCGZ4wl/G
	 sLcid6jf5fAmx1ZJz9LJS/21vWzwyPtbzyM9dJYQVqcCeGqBOoRK9vCVoIKJWuGdkgOPy
	 +bAYWsr8VQeB7rpKXNa9hqE4AMxVvTr9y1t29+26l+yxED9J3ifyY+huZJ6q98D4JBRg9
	 oAlV2d5tc1n6ukwIsF6weyioZz6y842GD+peHXiTZ+yZ2D5MsK/NflBmlj3uiPu1Ylw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkWz5WgV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AC1606A321;
	Thu, 29 Oct 2026 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkWz5WgV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927741F01824;
	Thu, 29 Oct 2026 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793305926;
	bh=8hkwVtxP+8+AhK5KECd3ruUT2wJCHZuckbGZKEwrBno=;
	h=Date:From:To:Cc:Subject:References;
	b=LkWz5WgVnpZEt1a3TEM0o10M8tNopABZ+Bl57eZf06mIIY/8Khh9GaQpAwdWvxwOp
	 spqawlSQSk533+Tls4hkMnSoYHLqS4rkJFFUSrmxDw2BgW+HpO0eBkZ8opeQJpLFdd
	 TGypB61R2NzWu6MGut5SukI1sArr3vd3e74gZuX1slAMZPk0Wx0JoyAE8ojCrAJBEe
	 L+kxHtzfXDpaFn0vxiKAhZHGPeoFOj6i/DDfFGzsC8Qx1PcHIrV7Mv9gGwS6rzKswx
	 ZfOQBNQARKQgZUYqkTKfs7YyLwCz8yq4Qcc+bNWT2r9yfas8ukHWkNhW4sUKoDXowR
	 I/adZlc6Y3/0w==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xMWn7-00000008ybf-3zEq;
	Thu, 29 Oct 2026 16:32:05 -0400
Message-ID: <20261029203205.757392992@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 29 Oct 2026 16:28:50 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 1/2] tracing/selftests: Fix instance test to actually test races
References: <20261029202849.245864353@kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The instance selftest creates and removes the "foo" instance while
enabling sched_switch event and reading its trace file. The issue is that
the read of the trace file prevents the removal of foo, and it constantly
fails to remove it. The stress test is not really stressing the situation.

Instead of running the creating and deletion in a loop as a separate
process and sleeping for one second, call it directly in a loop that forces
it to happen 10 times.  Also update the removal to keep trying until it
removes the instance, otherwise if it doesn't remove it then the next mkdir
is a nop.

Convert the reading of the trace file to use "head" instead of "cat" so it
is limited in how much it reads and add a .1 sleep in between reads. This
gives the removal of the instance time to succeed.

Fixes: 91e6f1ce86577 ("ftracetest: Add instance created, delete, read and enable event test")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 .../ftrace/test.d/instances/instance-event.tc | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index 42422e425107..b0e9d3abbf2f 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -25,15 +25,16 @@ if [ $result -ne 0 ]; then
 fi
 
 instance_slam() {
-        while :; do
-                mkdir foo 2> /dev/null
-                rmdir foo 2> /dev/null
-        done
+	mkdir foo 2> /dev/null
+	while ! rmdir foo; do
+		echo could not rmdir foo
+	done
 }
 
 instance_read() {
         while :; do
-                cat foo/trace 1> /dev/null 2>&1
+                head foo/trace 1> /dev/null 2>&1
+		sleep 0.1
         done
 }
 
@@ -43,26 +44,23 @@ instance_set() {
         done 2> /dev/null
 }
 
-instance_slam &
+instance_set &
 p1=$!
 echo $p1
 
-instance_set &
+instance_read &
 p2=$!
 echo $p2
 
-instance_read &
-p3=$!
-echo $p3
-
-sleep 1
+for i in `seq 10`; do
+	instance_slam
+done
 
-kill -1 $p3
 kill -1 $p2
 kill -1 $p1
 
 echo "Wait for processes to finish"
-wait $p1 $p2 $p3
+wait $p1 $p2
 echo "all processes finished, wait for cleanup"
 sleep 1
 
-- 
2.53.0
