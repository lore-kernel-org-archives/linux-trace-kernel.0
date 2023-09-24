Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBE86AA7
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 Sep 2023 13:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC907C43391;
	Sun, 24 Sep 2023 13:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561602;
	bh=AKMbxIXU7jc1GL3a0yAsu+u13xMrK1/jx44MAxc/mTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CYoZ3PkFZVwXaciehrS4kgm2wS2GGAnZ6sHIabeGNpEo0nIUSdBWR8tze86LcQ9FO
	 bcnwCWdoVIlZGvwTlomDiT0YvlINr08fSSAsic7O21pat58p2ED1zaym9TT0/G9eJG
	 Wdwynd7YINRiD/6PV5MRIrNVQdhA/cw1z4WS144QNpwUgif9SdPQYU/Zc1pNmoRDDI
	 Kw+gsmrxd6b1S4hjyaWYam687Pne48C2ZEmSN2znHMPc5AzPDSChS9dYoW3jAhxqVS
	 x5ZUIPtoKRudOw/bE3bvXZgK/i99Gqi/EJDIKd/YiH61iYH1LjJcMzs8QKIdOqHw9V
	 ZsZIzbD6Rhsng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zheng Yejian <zhengyejian1@huawei.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	shuah@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 06/13] selftests/ftrace: Correctly enable event in instance-event.tc
Date: Sun, 24 Sep 2023 09:19:36 -0400
Message-Id: <20230924131945.1276562-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131945.1276562-1-sashal@kernel.org>
References: <20230924131945.1276562-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.197
Content-Transfer-Encoding: 8bit

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit f4e4ada586995b17f828c6d147d1800eb1471450 ]

Function instance_set() expects to enable event 'sched_switch', so we
should set 1 to its 'enable' file.

Testcase passed after this patch:
  # ./ftracetest test.d/instances/instance-event.tc
  === Ftrace unit tests ===
  [1] Test creation and deletion of trace instances while setting an event
  [PASS]

  # of passed:  1
  # of failed:  0
  # of unresolved:  0
  # of untested:  0
  # of unsupported:  0
  # of xfailed:  0
  # of undefined(test bug):  0

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../testing/selftests/ftrace/test.d/instances/instance-event.tc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
index 0eb47fbb3f44d..42422e4251078 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -39,7 +39,7 @@ instance_read() {
 
 instance_set() {
         while :; do
-                echo 1 > foo/events/sched/sched_switch
+                echo 1 > foo/events/sched/sched_switch/enable
         done 2> /dev/null
 }
 
-- 
2.40.1

