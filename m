Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CF31366
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 Sep 2023 13:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C39C433CD;
	Sun, 24 Sep 2023 13:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561362;
	bh=I9ozwPOUqR1/WfEFWtXGaNdaEyw44SzolIDl8WwYI0k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ff4RX48wbbbNi+sDvsaBqfV06loLZWZI6cDVtac14DqtX96l8dqxptOzn8+iibq0A
	 22ADCFvgUOwjL+MFmdBZsoZE5bjiviJ/mSSt4oIiZHnGHFG5KNqgu+d/51X/7zURbu
	 gOKt3ogpr3YzG937R0fyMREuYfduN06WXkkg2LJuCo9wkpWBzeTTLBs1jlTXBBhigg
	 CDj1R/uKwsLPHsw46p3kw5TNqb46YOynJxAeHPijzSbKvjJqqzAG4zYLBdPaYvfRum
	 PbLr0yc1SfJVlS9dm+0TEqJW2n9u6RWoyEorRPSfEtHTgLXxBI5hBO9ip7HAO4N9ys
	 L8THYsoFvvlVg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zheng Yejian <zhengyejian1@huawei.com>,
	mhiramat@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 12/41] ring-buffer: Avoid softlockup in ring_buffer_resize()
Date: Sun, 24 Sep 2023 09:15:00 -0400
Message-Id: <20230924131529.1275335-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
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
index 52dea5dd5362e..1267e1016ab5c 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2206,6 +2206,8 @@ int ring_buffer_resize(struct trace_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		cpus_read_lock();
-- 
2.40.1

