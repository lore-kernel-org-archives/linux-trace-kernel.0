Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2092D1F6E;
	Tue, 29 Apr 2025 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928103; cv=none; b=rboA/AEN1YKSfZLernBY6XHJFMt3HMF83CY8UnBkMJyP9AdL7D1Mrsjly/77H5Fima9y+8h6PmW480JXNjBGgC0xBPIF1UrpgN9KaD/gp069huN3yGdYEW9FTxpzgnoh/zGHjLOfzem8Yz+OWRxRb2J+9f/n144htN7fOxN6S8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928103; c=relaxed/simple;
	bh=LJj7nVWo+UpC/AjP+P4QUHQ3bc53OO1mrmdD+TgJ1pg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J6Hdrtcb+JzhOhSVX+EZhoPfyNhBcGGL5ZHLYj6Ajgea5h6I+r0ZWURnGoIXEzcYhFX5JsA4RvZnFpQvFYZ+08eex4gOIpnuOz4q/2SxYAnUWCyv/9XGQLJgK58MwMsiuIzxt5Da0pGDQ+aNByLIDHrNHy6aycQ7XbZ4+idn5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ur3RE8DO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+3THFq7e; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ur3RE8DO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+3THFq7e"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5U7tTn+vTOfYBQG/6bDT1j37fVjy3vbg6beq9KSA7wQ=;
	b=Ur3RE8DOJLbC7ibZYjiMA0pBuOju+7I5oeQC32mYhSdS+iRqdYuJT+Zip8RRIV7vxoZr3m
	uVJnqqZghQtVSpsMHc85tCoK2aiv0pcdgFZhvbPsrK8JAgqZe0XCbjPZLZ5SGI2nUBdHCk
	m21TKTbc/nFULs0sOzg/Bl/2gDY80kJP3M+p/mlZrqPFpj1fwqABDTFciwtAcJddHmhlp5
	hH081EUHwMYeE2fG8eoNPyGTo4dHZxvXz9I47HB7vouwVnXO1LQ/nM5WuAFss4dnbn0dEM
	ToANOVVjZ1OSN5iIdGvhn+Zv3RkslqWu1qGaahagjMvsLnFOBQu6EXFZFrjnDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5U7tTn+vTOfYBQG/6bDT1j37fVjy3vbg6beq9KSA7wQ=;
	b=+3THFq7emTWMOdhVTVZPlLYzm55jGnb3VVLSSIWp84K59DrvfHPTQW2486LKtXOaIz/bMR
	Qs/84VV+yAFguMBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v5 20/23] locking/rtmutex: Add block_on_rt_mutex tracepoints
Date: Tue, 29 Apr 2025 14:01:05 +0200
Message-Id: <2f7168be0b92cffe1ddc762914344136ef471220.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add block_on_rt_mutex_begin_tp and block_on_rt_mutex_end_tp tracepoints.
They are useful to implement runtime verification monitor which detects
priority inversion.

trace_contention_begin and trace_contention_end are similar to these new
tracepoints, but unfortunately they cannot be used without breaking
userspace:

  - userspace tool (perf-lock) assumes "contention_begin" tracepoint means
    "current" is contending the lock.
  - The runtime verification monitor needs the tracepoint in
    rt_mutex_start_proxy_lock(). In this case, it is not "current" who is
    contending.

Signed-off-by: Nam Cao <namcao@linutronix.de>
---
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Will Deacon <will@kernel.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <longman@redhat.com>
---
 include/trace/events/lock.h  | 8 ++++++++
 kernel/locking/rtmutex.c     | 2 ++
 kernel/locking/rtmutex_api.c | 4 ++++
 3 files changed, 14 insertions(+)

diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
index 8e89baa3775f..d83ec2eaab22 100644
--- a/include/trace/events/lock.h
+++ b/include/trace/events/lock.h
@@ -138,6 +138,14 @@ TRACE_EVENT(contention_end,
 	TP_printk("%p (ret=3D%d)", __entry->lock_addr, __entry->ret)
 );
=20
+DECLARE_TRACE(block_on_rt_mutex_begin_tp,
+	TP_PROTO(struct task_struct *task),
+	TP_ARGS(task));
+
+DECLARE_TRACE(block_on_rt_mutex_end_tp,
+	TP_PROTO(struct task_struct *task),
+	TP_ARGS(task));
+
 #endif /* _TRACE_LOCK_H */
=20
 /* This part must be outside protection */
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 4a8df1800cbb..08d33b74be13 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1707,6 +1707,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mute=
x_base *lock,
 	set_current_state(state);
=20
 	trace_contention_begin(lock, LCB_F_RT);
+	trace_block_on_rt_mutex_begin_tp(current);
=20
 	ret =3D task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk, wa=
ke_q);
 	if (likely(!ret))
@@ -1732,6 +1733,7 @@ static int __sched __rt_mutex_slowlock(struct rt_mute=
x_base *lock,
 	fixup_rt_mutex_waiters(lock, true);
=20
 	trace_contention_end(lock, ret);
+	trace_block_on_rt_mutex_end_tp(current);
=20
 	return ret;
 }
diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 191e4720e546..35f9bd7cbd54 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -302,6 +302,8 @@ int __sched __rt_mutex_start_proxy_lock(struct rt_mutex=
_base *lock,
 	if (try_to_take_rt_mutex(lock, task, NULL))
 		return 1;
=20
+	trace_block_on_rt_mutex_begin_tp(task);
+
 	/* We enforce deadlock detection for futexes */
 	ret =3D task_blocks_on_rt_mutex(lock, waiter, task, NULL,
 				      RT_MUTEX_FULL_CHAINWALK, wake_q);
@@ -391,6 +393,8 @@ int __sched rt_mutex_wait_proxy_lock(struct rt_mutex_ba=
se *lock,
 	fixup_rt_mutex_waiters(lock, true);
 	raw_spin_unlock_irq(&lock->wait_lock);
=20
+	trace_block_on_rt_mutex_end_tp(current);
+
 	return ret;
 }
=20
--=20
2.39.5

