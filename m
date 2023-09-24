Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C9046AA6
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 Sep 2023 13:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A802C433B7;
	Sun, 24 Sep 2023 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561661;
	bh=ZO2LodoczqZs61F4E2XaTs+zsj1/EX5byibDy/w65QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hWjKVGwIMRUcqSW8AJqgMEy6coFSTAB80pwj57t/Dcp4fNG5U6y3QYc9UfY/gLAdh
	 K51rPMrCdT80n8C2VqNdKPF0lae/fIiIPEOXvGVxCWwvZAqNrZLbFoULP+pF6qOpiF
	 y/R8S/PwxOkMtD768ALmxXbYdM6xECks5bg7KFtLqKn9D0HGtWpsON1r4VWKOPnDIA
	 DHhB1lfHhngksnU8WU0ZqCFJCV+YRJiS5vlRTvl5BnwvLBEb3RgFEQoMf/YlWGnQzV
	 752YHgQK+FOGzZrWU55roq6PZpiRmBbasGDQllSkbERvJ26oeZO5sMP4fzbKcwCFn0
	 yN0vWg9bdyjVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zheng Yejian <zhengyejian1@huawei.com>,
	mhiramat@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 5/6] ring-buffer: Avoid softlockup in ring_buffer_resize()
Date: Sun, 24 Sep 2023 09:20:48 -0400
Message-Id: <20230924132050.1277021-5-sashal@kernel.org>
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

[ Upstream commit f6bd2c92488c30ef53b5bd80c52f0a7eee9d545a ]

When user resize all trace ring buffer through file 'buffer_size_kb',
then in ring_buffer_resize(), kernel allocates buffer pages for each
cpu in a loop.

If the kernel preemption model is PREEMPT_NONE and there are many cpus
and there are many buffer pages to be allocated, it may not give up cpu
for a long time and finally cause a softlockup.

To avoid it, call cond_resched() after each cpu buffer allocation.

Link: https://lore.kernel.org/linux-trace-kernel/20230906081930.3939106-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1949d7bbe145d..f0d4ff2db2ef0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1686,6 +1686,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
-- 
2.40.1

