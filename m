Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEF915A86E;
	Thu, 11 Jul 2024 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696049; cv=none; b=P+6Y/gAoLuoh0gLthBcoZAh9WzjEyKC5tIbdJBSmVD4OKufkRvzBFeq85zvhVcFTjT1RJzGEllsENREVshZAlhfUN3a5mXIhwGW5eRkcBRrpq/Bc7fTevbtAy6H3Ie/GvmtaqHUiltsqPK6UTcT3td8dt6wTsKVkLfONOENbJbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696049; c=relaxed/simple;
	bh=dTtktbIQzPN0M1WT/SSamB3BTYm0QnUYyOtyVkFgo2s=;
	h=Message-Id:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=oTtAnyZpsFrn+uKj0v6KX1/YKuuoKp/RqRSHQ1G6HrwtE+NRgPwoQHRU3NNm2UWJpOVCO5yHX6lnHBoeFpB6kgZB/DUxXnyu1MmN3KUKGG4IIOhnznX2BbZ4HuyMgxBrI0XKYkpfYRvvit/i2p7vX2cEmwGwfYIDx7dD/6gUO3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RndYImWa; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RndYImWa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
	Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To;
	bh=epm86oBKZwoCXF9Cm3n9QKwfFnScPDeksYSx49nPLjc=; b=RndYImWaa5OLJ4qUo6PNRFfl0z
	asshekHfKR47hhffhSeHfY5CEqgsE/mJ6w+CEvXqNBWOkAmM3LHGQRUhnW9WQPGVnBQTBHhbqFGYW
	40meY4NDRbKM2OzMdXpu7qz8tZ2/aXJprbc8MhjmrAsz1SNf5N5p/AmIYaXYY8WfNm9vJOu4bQYf8
	c+XRjXRxpRAM8nXEMZ0txOngr8EJ9I3PhOeMN1ZpyaNV+IPTtXNjLZjCmj+wWxNxcfqZScjISHFCj
	xUfIJuhC//fItau7KRqAQua0JbF6uN8OzuQkW5sRYKwjT8XiTD1erOaG+fc8dVxkvm0EHC71eRzGA
	cSQgylpQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRre0-0000000Ax6Z-0Gxz;
	Thu, 11 Jul 2024 11:07:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 0)
	id D65EA302EAB; Thu, 11 Jul 2024 13:07:22 +0200 (CEST)
Message-Id: <20240711110401.203782356@infradead.org>
User-Agent: quilt/0.65
Date: Thu, 11 Jul 2024 13:02:44 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: mingo@kernel.org,
 andrii@kernel.org,
 oleg@redhat.com
Cc: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 peterz@infradead.org,
 rostedt@goodmis.org,
 mhiramat@kernel.org,
 jolsa@kernel.org,
 clm@meta.com,
 paulmck@kernel.org
Subject: [PATCH v2 09/11] srcu: Add __srcu_clone_read_lock()
References: <20240711110235.098009979@infradead.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

In order to support carrying an srcu_read_lock() section across fork,
where both the parent and child process will do: srcu_read_unlock(),
it is needed to account for the extra decrement with an extra
increment at fork time.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/srcu.h     |    1 +
 include/linux/srcutiny.h |   10 ++++++++++
 kernel/rcu/srcutree.c    |    5 +++++
 3 files changed, 16 insertions(+)

--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -55,6 +55,7 @@ void call_srcu(struct srcu_struct *ssp,
 		void (*func)(struct rcu_head *head));
 void cleanup_srcu_struct(struct srcu_struct *ssp);
 int __srcu_read_lock(struct srcu_struct *ssp) __acquires(ssp);
+void __srcu_clone_read_lock(struct srcu_struct *ssp, int idx);
 void __srcu_read_unlock(struct srcu_struct *ssp, int idx) __releases(ssp);
 void synchronize_srcu(struct srcu_struct *ssp);
 unsigned long get_state_synchronize_srcu(struct srcu_struct *ssp);
--- a/include/linux/srcutiny.h
+++ b/include/linux/srcutiny.h
@@ -71,6 +71,16 @@ static inline int __srcu_read_lock(struc
 	return idx;
 }
 
+static inline void __srcu_clone_read_lock(struct srcu_struct *ssp, int idx)
+{
+	int newval;
+
+	preempt_disable();  // Needed for PREEMPT_AUTO
+	newval = READ_ONCE(ssp->srcu_lock_nesting[idx]) + 1;
+	WRITE_ONCE(ssp->srcu_lock_nesting[idx], newval);
+	preempt_enable();
+}
+
 static inline void synchronize_srcu_expedited(struct srcu_struct *ssp)
 {
 	synchronize_srcu(ssp);
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -720,6 +720,11 @@ int __srcu_read_lock(struct srcu_struct
 }
 EXPORT_SYMBOL_GPL(__srcu_read_lock);
 
+void __srcu_clone_read_lock(struct srcu_struct *ssp, int idx)
+{
+	this_cpu_inc(ssp->sda->srcu_lock_count[idx].counter);
+}
+
 /*
  * Removes the count for the old reader from the appropriate per-CPU
  * element of the srcu_struct.  Note that this may well be a different


