Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178164FC326
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 14:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789743019; cv=none; b=CNKlGgU7CGoXQb2sLx6cRK4StAD5SvVfl8V83T2J7JADRhnM1khLbfTOm8fby1+l9CBEuSSoL9taLyWlBwBAtDvzsyrc7UU3p5qCbhh/XCBAAVzEfAcDlQ9E81DGIa1zNbGFnOzv3giApI1K6TGXR4ERl6RGDKT1vkZ3Ltohwsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789743019; c=relaxed/simple;
	bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cU5heqKpwKywTz9zjERGR0ZLl0atwXinQVoOC3QJDitF/jI6gDI7rf+fRTOWyRCt3R92IY3hCOp6MAzgtnNlZf/NdmVF09iuZy66cAHSx2yJz4jhI0Su4Xj+KQ1tE2i7nCrMacwSg5upSkVedyQg32yrAvIhcvCb4zrFvBA1fyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=FMenZX4f; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="FMenZX4f"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-91235f46716so8088046d6.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 07:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1789743005; x=1790347805; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=FMenZX4fA7IYYaGVRJ74JORgL+Hbw07S5YoZW625s6FlgiimPPEplqFaCu1De7ETu4
         I56W5/QhtPJLAVld/nTmIBJ790mBWOk4n7LzyWhs6fxs4yoGOGz8+bA413+8tWlDifNi
         eGaqh5ZQLGJv6ATyMyx69py90tY3ihIdArxWnxgWnx20AoCpfJOmLXHZ6jPiqjewxtkl
         4hHaFlHfDqpjuhO/JTWOc9DzQIA5MDDBdiuvZ4pA2o70a/HyAJCwStZ7YEx1/81uitv+
         nayrgUTXY2IEJbJmPVoTWY8y9BjR4RcTR4F4zbD1VBRDOG+k+5ZFEiAh9VvJzwwtR+xc
         41bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789743005; x=1790347805;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MkP56mJgKixcgLXoBxrfzz0NyJo14L+hjKFrNfKE/2k=;
        b=ScXh0eLamcELjGHzvLSWd4vMP3bnmIuJvlYlDCzS7w7LHp7EoM/tlUlOXKZuqmPtPI
         oK0YTsVmShmKJrLQKxGavqn51tEiopCyXHR3IfZjKYVYmkNleuoyzPTd5BBZrtSzB/l+
         zKMFwf+UKKxYpoNa5F+WdX2WQuCKfOEB2lSlywVL+y0kG8IYuObxK3vf3ShvQUdj/+VC
         hCr5uXIUNK4rOqIkJRQDOm3mBytDz4xuE0LvOHxNASjijEX+Ck5VXMQoUhtaDS21jOuf
         QBMcPCKhykY2pQi1APiaK9AzoDToINTz/YTCswjbHWEKUalwvNKlAYdrW2veCBF0HdQP
         TB+A==
X-Forwarded-Encrypted: i=1; AKwUvBwkUKv/wQQIrqtqwnZlpyUc6CQH1eRjt3uwTcQpXPXrGqAAS67PRpOiHKvhwX1qZ/bQXMpI+Pdb9rqprd+83nduahM=@vger.kernel.org
X-Gm-Message-State: AFuF++moKjZPBZbbB24llTbSjF4AYqHSB2IUDa66hmQA6xAQCm7wGk8g
	MJpTkK0BHzQ1H3ZI9/wO1W9spYIVtp2QDmM3S6KKDD7vJkciuPHhWpN04KALN5Hz/a4=
X-Gm-Gg: AYBFou3FD8RJ8x0ZEkxIf0tSkJNi0aRrtfbjwQ4ZhOWB1gKKWHg9VfSzdie/URSW2ye
	lsGAxWeGB9vcJt200EsWbo8lLi1xwfP2WGeiKRBHff1/UCq1T4Ur6lzaFSqvnH+sc/zkMeLAcwa
	VojCgPbHvszFj55Uy5lfDG2CKhwnAaVX60LwbOrdQ/gqUvW2TuSVbGc4IUmo3QTTXou4WzRMB4H
	H99l5Yj+ZFvG9oGd9QzTOXYCMTFt5q+7FuW52+N9ZgmD/uC4zlCVJrOMs3HK1J5IdW8xdiz7gdh
	yj5HuJ5BraA+i00bhoN4783JDsFk3J0gdJwmQ6VWgxE1Tx/WKj0TTHoVZO9KfKjRJlL0ydc5kAI
	zMYswiox0ZNMgVX4ucQofhHpeRcCSTaYaqEWZlWWioYG9Fk+4N5Cm7LX8OMFPItlGN7jjpRgSS4
	hJ88peQVI7EMnzdsz75cfKbmXmS85WCnRAJe69tpYqiLQPXo3RCwlydmYGbOpH1M8CI5BPS0RNR
	B8OHYlV0cSre7v79GMDj0Citoy+4FnS4TAqH0YR4K/sM7yNyOGWzfiM
X-Received: by 2002:a05:6214:1307:b0:910:4a86:5969 with SMTP id 6a1803df08f44-91254bd5293mr46077526d6.23.1789743004909;
        Fri, 18 Sep 2026 07:50:04 -0700 (PDT)
Received: from toxicpanda.com (ec2-34-228-114-98.compute-1.amazonaws.com. [34.228.114.98])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91258056195sm14090716d6.29.2026.09.18.07.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:50:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 18 Sep 2026 14:49:30 +0000
Subject: [PATCH RFC v4 11/13] rcutorture: Make Tasks RCU readers Tasks
 Trace readers where required
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-b4-rcu-tasks-preempt-qs-v4-11-63f0e9d69661@toxicpanda.com>
References: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
In-Reply-To: <20260918-b4-rcu-tasks-preempt-qs-v4-0-63f0e9d69661@toxicpanda.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>, 
 "Paul E. McKenney" <paulmck@kernel.org>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Boqun Feng <boqun@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
 Xu Kuohai <xukuohai@huaweicloud.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Andy Lutomirski <luto@kernel.org>, 
 Josh Triplett <josh@joshtriplett.org>, Uladzislau Rezki <urezki@gmail.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
 Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, 
 rcu@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789742980; l=1716;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=O8YdW4YSHUYyF3GwEQN16WzJM7UkZZFfh8RzVwv7xJM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCK2SKWNSvb8uUIHABRfNQrEJPCWCZeIZnAqX/3f5X/BpUmomCy4y1MVWrdYzX/ihyvEJhShdIA
 kincQ831+1ws=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

rcutorture's "tasks" flavor has empty readlock/readunlock hooks because
a classic Tasks RCU reader is simply code that does not block.  Under
CONFIG_TASKS_RCU_TRAMPOLINE_READERS a preemption outside trampoline text
is also a quiescent state, and the thing real readers (trampolines) do
to stay protected across their call-outs is take rcu_read_lock_trace(),
so have the torture readers do the same there.  Otherwise a preempted
torture reader would rightly be treated as quiescent and the test would
report false-positive too-short grace periods.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/rcu/rcutorture.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 794937e13e7c..ab870ef09af0 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1142,13 +1142,23 @@ static struct rcu_torture_ops trivial_preempt_ops = {
  * Definitions for RCU-tasks torture testing.
  */
 
+/*
+ * A classic Tasks RCU reader is any stretch of kernel code that does not
+ * voluntarily block.  With CONFIG_TASKS_RCU_TRAMPOLINE_READERS a preemption
+ * outside trampoline text also ends it, and what a trampoline does to stay
+ * protected across its call-out is take a Tasks Trace reader, so model that.
+ */
 static int tasks_torture_read_lock(void)
 {
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_lock_trace();
 	return 0;
 }
 
 static void tasks_torture_read_unlock(int idx)
 {
+	if (IS_ENABLED(CONFIG_TASKS_RCU_TRAMPOLINE_READERS))
+		rcu_read_unlock_trace();
 }
 
 static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)

-- 
2.55.0

