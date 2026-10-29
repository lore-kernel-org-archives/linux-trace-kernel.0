Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305927;
	b=3z6IxhhBzpLqUeMbjn4jQlxQsKTMiXx+o5mQzC7ndC4bpQqI0KPCZ2JzNUyMS28s/nBi
	 DXxAertjLihHTnuBE86/YaJD5QNvEZH4jIAT8V3LH8DzhDDVm923R2y4zEDh2Ydh+Bj60
	 oTwc7otOoBhiRJueZYV9PgbhcQMNAeYcxNwaJr1WcFRIIeipKrw9EMAMujdn/dRi4xFQ6
	 im8h9CsMvzTDjbSga4Ja7o1JeexvJJKncHj0cMVnpoBybCEeKluhyLUiXSiO+WHdQ3NHU
	 Xnl/V9t7TDWi6FUzzJAmr65G4MgTnwuGGAwAs7WM0GNd4KKczm+XndsSuYyn+hkPeIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305927;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject:References:MIME-Version:Content-Type;
	bh=lOXsVk/LOAYRFlKc/sjuVZNXV6wF1VG20Uf0h1t9Qsc=;
	b=WdGY5bMq6pQm6KPYd1uNzS4y9HuyQP0l0ZwrF+1u+B5SLuC2/kuREr3ppHq0i0wJUd5k
	 FraBP/YE65Yj0ap3aPVO8lVbyif0rEKRvqwKt02JE/VMHabXYxSp6T7CT4ll6EUiwZYZt
	 ZZUyi6BonNYup5ow53KloJoSPrg264ujAqW0xe/ky58ymsI2SR5iRJ5trZ7Daxa3c4UHZ
	 Rjz6GrZ/dmxWB5awluFiQ98iVXedExVZhk4o538g+DJ/Um6iN9axdfAzLl3fRbovC1ve+
	 duO6jjcPB57GMT1sRT0VNLNENR3E78KEJbML2hPflsR4rCH8Epv0lt21kObgQuwOZsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiGoFy2g;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5A8606A325;
	Thu, 29 Oct 2026 20:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UiGoFy2g
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C09B1F01828;
	Thu, 29 Oct 2026 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793305927;
	bh=lOXsVk/LOAYRFlKc/sjuVZNXV6wF1VG20Uf0h1t9Qsc=;
	h=Date:From:To:Cc:Subject:References;
	b=UiGoFy2gbzskAAj0Z6M6bHjNWh3V+kiunvHu+vzx48rodgrID83UCnH0Jf3b3dtE+
	 Mb6IkDeyc9JEIiCmU2ZH9o3B2atdjK1n0G2ZPZMPITFq56LchLp6r/uanUIgTfQz00
	 iVxIpbcXTjiWnf5UKbC5dLZRI55/XDzjRVyrrYoagC5Rkr0cwCq5TMZNKXFSp+Mgg3
	 ar1Cst73iOjWqjKDI4lbEMTPzXes5+/ZtMRv/53vlfLAr1Cqa7Qh7SGvWFdmTLAGWe
	 Uzw13lJMtMq+DHdyVhpRbqe2yDmqcllycqF9Ypp9NVARiDaVZtfRDEoGJTu2xQjLjb
	 LR1cp/jevsg0g==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xMWn8-00000008ycE-0d0a;
	Thu, 29 Oct 2026 16:32:06 -0400
Message-ID: <20261029203205.969033931@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 29 Oct 2026 16:28:51 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 2/2] tracing/selftests: Add reading all instance files to instance test
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

Commit f4a771cc684c7 ("tracing: Have show_event_filters/triggers files take
trace array ref") fixed a bug where the show_event_filters and triggers
did not take a trace array reference allowing an instance to be removed
while active. This would have the reader of these files read data that was
freed by the remove.

Update the instance test to read all the files in the instance,
instance/events, instance/events/sched and
instance/events/sched/sched_switch directories (with the exception of not
reading trace or trace_pipe). This would hopefully catch issues with files
not taking references.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 .../ftrace/test.d/instances/instance-event.tc | 20 ++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index b0e9d3abbf2f..9374c20c6aaa 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -44,6 +44,19 @@ instance_set() {
         done 2> /dev/null
 }
 
+instance_cat() {
+        while :; do
+		find instances/foo -maxdepth 1 -type f  ! \( -name trace -o -name trace_pipe \) -exec head {} \;
+		sleep 0.1
+		find instances/foo/events -maxdepth 1 -type f  -exec cat {} \;
+		sleep 0.1
+		find instances/foo/events/sched -maxdepth 1 -type f  -exec cat {} \;
+		sleep 0.1
+		find instances/foo/events/sched/sched_waking -maxdepth 1 -type f  -exec cat {} \;
+		sleep 0.1
+        done 2> /dev/null
+}
+
 instance_set &
 p1=$!
 echo $p1
@@ -52,15 +65,20 @@ instance_read &
 p2=$!
 echo $p2
 
+instance_cat &
+p3=$!
+echo $p3
+
 for i in `seq 10`; do
 	instance_slam
 done
 
+kill -1 $p3
 kill -1 $p2
 kill -1 $p1
 
 echo "Wait for processes to finish"
-wait $p1 $p2
+wait $p1 $p2 $p3
 echo "all processes finished, wait for cleanup"
 sleep 1
 
-- 
2.53.0
