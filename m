Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359B3D8129;
	Mon, 30 Mar 2026 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774879630; cv=none; b=tYk1x+rm+s87dogGYOIR/HY6KQOT50YVLGrbKHt912qd+afFAxz6x/6Lz2gEHc3dQ7UynnouW4U/0qKT9dFiwv03QOuUKQRIU76SELeHbeVOdFql6FE7bj6xvkCrqQ8CmGCFJwabDnNeKzokaBUGIx8o1zHSSHLnfux5GW8vv0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774879630; c=relaxed/simple;
	bh=+bMs9ERIQVvkRwL+VZTTfiM9gzFfjTvT1aLgqMVLC9g=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=oDi2iBphckNMNX43itG3Pw9B9/eVbE9ncCpgyjcmth6NjoccvlDfagJTtowlt1mpb3z8QsQFLHpkkf1HuaWBF6ZPkn/K395Z3UciQIRGdFx0twJ5laqE8nZKNk18A7Q0/ghyBVTa7UOTDOpbtz+azs98b02Rj6dPUAC58I57Xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NIeeXjtL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c0XIy9Sg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NIeeXjtL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c0XIy9Sg"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2F7E0EC0175;
	Mon, 30 Mar 2026 10:07:05 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 30 Mar 2026 10:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774879625;
	 x=1774966025; bh=tsLsTO59F2hU31zYvDPNmjaJK05UWmO5S1juGVgsTJU=; b=
	NIeeXjtLCGuQhwSHisxJkuDVeo6sAx3zUMNU/ADq9spNGlOKkx/o3htMIxzJSAIL
	fkPqlhhtsnakwpIxYC5OsybjswJo4rsW+jggqt7bSNoy65L04VKfHkSafX0OzS1k
	0ombQD8KN/GP4ea6n17u/JsH31a0uacjCSig5WShoXB4GtlEsl5zEKqgPqeXkfir
	rJDevay4iZs7rPq8xDZokkzXHiMulKbxv6coYPIB0dJbPiR2WtFyBgSBv5X+caCD
	TEjzpZDwZGxCwIpcxW53fFZNSh5sf8YR3bpG/DNn/P051CqBtgC+HrogEbbZ2j/B
	c0+CBgEQ+oYyfcOsgWMDGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774879625; x=
	1774966025; bh=tsLsTO59F2hU31zYvDPNmjaJK05UWmO5S1juGVgsTJU=; b=c
	0XIy9Sgh/cj7ZY52cwbUVbDiTpcGbJf0ZdX8JYcdQoRb+SQSZt1f4RbV8eN6WVPK
	nKVpCEpIfExrSJMbBfIFsi66x44ZS5qF7IGnJMGg7OXZHJTOLi/+bQlggvnd3iiZ
	uNi2gfhA4mRSM+QLg2LnNr/56BkonZ+L4fBwj+AfspKDcFHtRUE5Xc1IWCTCCKgh
	CjYhIVlmabr/zaGH8lRnbTJ4XVN28ljat+FvA2TiVNm3Wpm8B9Lmn23xCzRLtxcH
	eRpH05JbBRkMH2Zx3l0ZZ19KZzfXUm3YArIvYdb0i5YQ03KlbQHRd2Kyc/l50rat
	fOmw2kZ9/LVbdQ83kGySg==
X-ME-Sender: <xms:iIPKaZFB-GrhmTvzoq3ienoTBxnJqZAb20GweeiGjg3e9nox3EJrqg>
    <xme:iIPKaZIE16FwTv2EDHa1Qe_DiWSQp4GgPo4QnKJ8UubMCYvhdeDyC5k4DeXwsT0gO
    C1yEvBWyV74_HJ9J0UI2zkiMfqohDteW9VB-hOCMXb1T194T_Qhoi0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeludekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefggfevudegudevledvkefhvdei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepmhgrthhhihgvuhdruggvshhnohihvghrshesvghffhhitghiohhsrd
    gtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphht
    thhopehlkhhpsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhhhihhrrghmrghtsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehllhhvmheslhhishhtshdrlhhinhhugidruggv
    vhdprhgtphhtthhopehovgdqkhgsuhhilhguqdgrlhhlsehlihhsthhsrdhlihhnuhigrd
    guvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iIPKaVgxx2YIb7Eo34DZYTkCb_DCUybuNOU3h0EUrXUPQL7XFUjr6A>
    <xmx:iIPKae_H0ZP10XVWCYIgsqCdMgwKSXuvDWUtDCtN_Arugq_AX_K1CA>
    <xmx:iIPKaZUKx31MOjEoEIv960EQd-aUylA9XZyT8cVpcePjPaiHT2nBsg>
    <xmx:iIPKaaAVP2qZrggdO8qtkck_-H0WCwX6iJckLpwFM5ABjgyYteSuMw>
    <xmx:iYPKaZk2n22YNcnWWCs43uD9GDJRwJgDOWq_lroZEC7YMbEkPWJOfbPa>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A6021700065; Mon, 30 Mar 2026 10:07:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A1v9eCq-71EB
Date: Mon, 30 Mar 2026 16:06:44 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "kernel test robot" <lkp@intel.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>,
 "Linux trace kernel" <linux-trace-kernel@vger.kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 "Masami Hiramatsu" <mhiramat@kernel.org>,
 "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>
Message-Id: <8580f943-4c37-4c66-937d-adee13b72201@app.fastmail.com>
In-Reply-To: <202603070230.Zz4BBLtb-lkp@intel.com>
References: <20260305211810.3f48aa07@robin>
 <202603070230.Zz4BBLtb-lkp@intel.com>
Subject: Re: [PATCH] tracing: Move snapshot code out of trace.c and into
 trace_snapshot.c
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, Mar 6, 2026, at 20:07, kernel test robot wrote:
>>> kernel/trace/trace.c:820:5: warning: no previous prototype for function 'tracing_alloc_snapshot' [-Wmissing-prototypes]
>      820 | int tracing_alloc_snapshot(void)
>          |     ^
>    kernel/trace/trace.c:820:1: note: declare 'static' if the function 
> is not intended to be used outside of this translation unit
>      820 | int tracing_alloc_snapshot(void)
>          | ^
>          | static 
>    1 warning generated.

I saw the same thing and worked around it by removing the function.
I then noticed that a bunch of code surrounding it is also unused
and I removed that as well (see below). This version passes
my randconfig build tests, but I suspect it is still wrong,
since the code never had any callers and I don't understand
why.

       Arnd


diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index 2670ec7f4262..87466d8df147 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -38,8 +38,6 @@ enum ftrace_dump_mode {
 void tracing_on(void);
 void tracing_off(void);
 int tracing_is_on(void);
-void tracing_snapshot(void);
-void tracing_snapshot_alloc(void);
 
 extern void tracing_start(void);
 extern void tracing_stop(void);
@@ -184,8 +182,6 @@ static inline void trace_dump_stack(int skip) { }
 static inline void tracing_on(void) { }
 static inline void tracing_off(void) { }
 static inline int tracing_is_on(void) { return 0; }
-static inline void tracing_snapshot(void) { }
-static inline void tracing_snapshot_alloc(void) { }
 
 static inline __printf(1, 2)
 int trace_printk(const char *fmt, ...)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ec2b926436a7..76fe2c758734 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -767,70 +767,6 @@ void tracing_on(void)
 }
 EXPORT_SYMBOL_GPL(tracing_on);
 
-#ifdef CONFIG_TRACER_SNAPSHOT
-/**
- * tracing_snapshot - take a snapshot of the current buffer.
- *
- * This causes a swap between the snapshot buffer and the current live
- * tracing buffer. You can use this to take snapshots of the live
- * trace when some condition is triggered, but continue to trace.
- *
- * Note, make sure to allocate the snapshot with either
- * a tracing_snapshot_alloc(), or by doing it manually
- * with: echo 1 > /sys/kernel/tracing/snapshot
- *
- * If the snapshot buffer is not allocated, it will stop tracing.
- * Basically making a permanent snapshot.
- */
-void tracing_snapshot(void)
-{
-	struct trace_array *tr = &global_trace;
-
-	tracing_snapshot_instance(tr);
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot);
-
-/**
- * tracing_alloc_snapshot - allocate snapshot buffer.
- *
- * This only allocates the snapshot buffer if it isn't already
- * allocated - it doesn't also take a snapshot.
- *
- * This is meant to be used in cases where the snapshot buffer needs
- * to be set up for events that can't sleep but need to be able to
- * trigger a snapshot.
- */
-int tracing_alloc_snapshot(void)
-{
-	struct trace_array *tr = &global_trace;
-	int ret;
-
-	ret = tracing_alloc_snapshot_instance(tr);
-	WARN_ON(ret < 0);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(tracing_alloc_snapshot);
-#else
-void tracing_snapshot(void)
-{
-	WARN_ONCE(1, "Snapshot feature not enabled, but internal snapshot used");
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot);
-int tracing_alloc_snapshot(void)
-{
-	WARN_ONCE(1, "Snapshot feature not enabled, but snapshot allocation used");
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(tracing_alloc_snapshot);
-void tracing_snapshot_alloc(void)
-{
-	/* Give warning */
-	tracing_snapshot();
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
-#endif /* CONFIG_TRACER_SNAPSHOT */
-
 void tracer_tracing_off(struct trace_array *tr)
 {
 	if (tr->array_buffer.buffer)
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index e4cf6703b301..6abd9e16ef21 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2306,7 +2306,6 @@ static inline int register_snapshot_cmd(void) { return 0; }
 # endif
 #else /* !CONFIG_TRACER_SNAPSHOT */
 static inline int trace_allocate_snapshot(struct trace_array *tr, int size) { return 0; }
-static inline int tracing_alloc_snapshot(void) { return 0; }
 static inline void tracing_snapshot_instance(struct trace_array *tr) { }
 static inline int tracing_alloc_snapshot_instance(struct trace_array *tr)
 {
diff --git a/kernel/trace/trace_snapshot.c b/kernel/trace/trace_snapshot.c
index 8865b2ef2264..926f395e5af4 100644
--- a/kernel/trace/trace_snapshot.c
+++ b/kernel/trace/trace_snapshot.c
@@ -237,29 +237,6 @@ void tracing_disarm_snapshot(struct trace_array *tr)
 	spin_unlock(&tr->snapshot_trigger_lock);
 }
 
-/**
- * tracing_snapshot_alloc - allocate and take a snapshot of the current buffer.
- *
- * This is similar to tracing_snapshot(), but it will allocate the
- * snapshot buffer if it isn't already allocated. Use this only
- * where it is safe to sleep, as the allocation may sleep.
- *
- * This causes a swap between the snapshot buffer and the current live
- * tracing buffer. You can use this to take snapshots of the live
- * trace when some condition is triggered, but continue to trace.
- */
-void tracing_snapshot_alloc(void)
-{
-	int ret;
-
-	ret = tracing_alloc_snapshot();
-	if (ret < 0)
-		return;
-
-	tracing_snapshot();
-}
-EXPORT_SYMBOL_GPL(tracing_snapshot_alloc);
-
 /**
  * tracing_snapshot_cond_enable - enable conditional snapshot for an instance
  * @tr:		The tracing instance
@@ -391,8 +368,6 @@ void latency_fsnotify(struct trace_array *tr)
 	 */
 	irq_work_queue(&tr->fsnotify_irqwork);
 }
-#else
-static inline void latency_fsnotify(struct trace_array *tr) { }
 #endif /* LATENCY_FS_NOTIFY */
 static const struct file_operations tracing_max_lat_fops;
 
