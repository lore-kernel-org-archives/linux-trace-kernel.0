Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87686AA6
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 Sep 2023 13:21:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2E7C43391;
	Sun, 24 Sep 2023 13:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561660;
	bh=Ax92uLF+mFc+4b+RGE4rUCa62HUyHWgvfs9snGBJ8j0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jiQe+IVvB4Z0JOAcRSdoC5GvRO+Ih56xl6j4gykoLS+nC5Fj7Px5uhobHNcVOZLr6
	 C2VPZc5oiolMxooibTXOtgDfUvs8dboA14WfZwPibTJjHjapaFtEV7mstnHyDbIV+8
	 Brf18hvNeuInaORWHnoIhNL/IvIzClDeBr9VWFyj90s3Xu0aN3Nd7jPFjTmWtBkJa6
	 XP0gY4Xnh2LnJ/p9A2i6ohTrmd6EW1V9xbZpIYfYdq4wkGq5B7tKtOTn9ar3qtlH3u
	 5rfnOTOR+afceB1CFYfinE8MH1nhB11VXTTKZ6ITjQ7itWvvpzwAKXz9AHI87FcVlf
	 xUV3NpGnDed3Q==
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
Subject: [PATCH AUTOSEL 4.14 4/6] selftests/ftrace: Correctly enable event in instance-event.tc
Date: Sun, 24 Sep 2023 09:20:47 -0400
Message-Id: <20230924132050.1277021-4-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924132050.1277021-1-sashal@kernel.org>
References: <20230924132050.1277021-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.326
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
index d7f48b55df51c..ee11b42014c83 100644
--- a/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
+++ b/tools/testing/selftests/ftrace/test.d/instances/instance-event.tc
@@ -43,7 +43,7 @@ instance_read() {
 
 instance_set() {
         while :; do
-                echo 1 > foo/events/sched/sched_switch
+                echo 1 > foo/events/sched/sched_switch/enable
         done 2> /dev/null
 }
 
-- 
2.40.1

