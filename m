Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5AF63B4
	for <linux-trace-kernel@vger.kernel.org>; Sun, 24 Sep 2023 13:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45E4C433B9;
	Sun, 24 Sep 2023 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561647;
	bh=Op19wLQUKMEF56RN//vIr2TS8uWbFAexAY79fYfUeSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q7ebuWvDM7r5hasSpPCm3OopoV+xbqriTdzN7FsV4ubh3PHLfAhNT+xg8RgZ1M0x3
	 RnWK887dOScRNpcMFuen+p692u03BVqb7hNV04frwSHp40OMC5o9Ln9x9m0ImnmRQI
	 6iTK0yt24amtSZwjoqnBgDsVQDZcORFGU+AOAm57H/sP65slBzGDmHIZ3YRFNdwb4j
	 gAjHH8pfDNRkXvtwPPl+NYy8w8Ixbw4oHW9xI/nh6RIBjoB4VzynOHbRZ4Yw+q2TNw
	 5KlxJCRD1ZR6VMCKHOQXGtEaZKaVjBgioNeLAQjElltZ4YQSyjoyyNZuefyX6BugTp
	 928HtYX1vK7Mg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zheng Yejian <zhengyejian1@huawei.com>,
	mhiramat@kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 6/7] ring-buffer: Avoid softlockup in ring_buffer_resize()
Date: Sun, 24 Sep 2023 09:20:30 -0400
Message-Id: <20230924132033.1276920-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924132033.1276920-1-sashal@kernel.org>
References: <20230924132033.1276920-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.295
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
index c8a7de7a1d635..320aa60664dc9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1753,6 +1753,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
-- 
2.40.1

