Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8A4385D97
	for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741950; cv=none; b=L44wjtQJs9aJks2hgA83w9b8KmWbYqVPp8+iTF+2+erB6/L3W7d65itLFXR30GFeaW/R650U1tAwAhW5e6SQ+lAdlF25fKsH3Z6fIxn5TJHzJidvhe4UbgDChQ+ItNiEO6YFKjxYzTBs4cV7yOKsAqzWhfobQ6o7A+j0ykETp3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741950; c=relaxed/simple;
	bh=QD3PxjCXZ6UJPf0E8x4yo7IEgC7LOe9fpYJLiO251GI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SJMpoH0K5JV7K6Xe9T/phYEs1jZdnWA6lE/AE/vnClt78gCwIQhBQEN//Mw7yaNKVB09nVNrWmiBf3kTXH+Q9K7MDC3uENi2nfA2fvfPGpdtpBWJdsHPrxrhoUIHRTM9C8j8TwHUT8RQuvvBV6flCktyA1MBOL+qdpnIWLqayPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XulFdTz8; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XulFdTz8"
Received: by mail-oi2-f13.google.com with SMTP id 46e09a7af769-80a71781323so340695a34.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 18 Sep 2026 07:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789741947; x=1790346747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6E7ctxafzLuDLf4HoS6Tx9j17d6jseDqLEP/al0ahus=;
        b=XulFdTz8Q+B5fnHJVuKmSdzT9XulptHj5DveQoJQJX8tINg5TZ9NF5cSJLMdDkJSVa
         RtKuN/Iebk43gbHWfPje8OI8bRcXhrsJROfU0H8tIB+qWD97RCQvNzJNiLfxuvq5XS47
         1aQmS+Qq8xdCe5uzJ2lvd04NwJjNXIho0zQA7A/7r4lS4BHFP3ibcud2SEjc46LOlbbQ
         09uxngZFwCf5ipi3OeMYt1oZ7oc9jHA4fLZTFBSWu4RkMPo3erI8Ff8KmRATsNznBNJ2
         lcvfTYa6UYxF/ChtTiKi8v0BBo7RvIhGCFh6eiMe75F1pPQ1xrP9tA1FnLRHKhEXwxWn
         WDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789741947; x=1790346747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6E7ctxafzLuDLf4HoS6Tx9j17d6jseDqLEP/al0ahus=;
        b=0vPb4QaBX/Cdgn89cHk4ijKz5h8FNN315r9YMeO8d9dVxAiFwHHJYjZ9DxpJogM8Tq
         IweIifYBJcGcpYAqIK1uu3fmiJoAGJfXqGeBBuczDpd6xE/rAtfwAibI+h4QrJajU+FX
         EtHhvb8za84T8g2G/gAr0J64Ud0ueMqzkuUMKzfeA/mr+H6ow5oiUFWtBmRwmlsV1qaD
         msjBVyapwUqkKgWLRdq0ojYHQqYsZTf/kDLfFB/xJLgAFdDS8vxcoodyNwn31YcsM3Jf
         TvxtwakWETMVQGrnAROkkgorJGA09qx9RJvVlfSfWuKk+xE8rnkYxCXW72zBUKs1qnUz
         oRxw==
X-Gm-Message-State: AFuF++mIhnGbyC+325SlIMWc1Pgj3G9pp+gmDwxklwRRs9UA+CAlWJYU
	m8YqnPDbLoht7bXq5tDn5yaxwOie4C1QV4fDQfZLoXtvYHOHUj1k3Pph
X-Gm-Gg: AYBFou35Ch7NX12tC4gOinr0KTcmeDcd4sTwWzs2189pHeXuvZLZHO8m2i4JEgsWhhr
	MLDJcG/QC+ag1ZOLuhuaGSWvcDB6/hhv2c9DaU1x5G6EbuYS7UAD0w1eF+pFgFe3A+d6iwATND9
	Yub2WJE9Mi3xSKsoRHycuN4/OI4PHXXGIRNmJnNBr5PCpEAgKrvD2FlwXa/+1ulohiQrs02RJFV
	Bw3uAsUlC+yhAbTXKVcr53UXPVcEuD0NubK19JPd/H8B+W16PccZ18BG+GZIaBD6R9nNchG+vaR
	OUsFHWIXmwvp6GRlVeuHOnCAi7Z9kRGf4xWxxm4S8rKZA/EzmQjgvf013e6OpU8zIbVRtw8jIPg
	Kn1QqOieRk0t40GGVkg2TYHrcQcK5WiUFu17vRM/0SR5fBP490xH/OXRMuT0i5fafy/L55WGZYH
	vOLXVAgC5aPJTAe9Evt5BlpsOl7HHxji5eSBbhmBCkWhHnktVNagDXGsxI1eDxUBo=
X-Received: by 2002:a05:6830:6001:b0:7f3:a8ac:45f7 with SMTP id 46e09a7af769-80ddfd69b03mr2915289a34.3.1789741946653;
        Fri, 18 Sep 2026 07:32:26 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80e42815ff2sm1615667a34.3.2026.09.18.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:32:25 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Adriano Cordova <adrianox@gmail.com>
Subject: [PATCH 1/2] uprobes: Use a dedicated mutex to serialize prepare_uprobe()
Date: Fri, 18 Sep 2026 11:32:08 -0300
Message-ID: <20260918143209.709291-1-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

prepare_uprobe() serializes its callers by taking consumer_rwsem for
writing. That rwsem protects the consumer list, not the instruction
copy.

Give struct uprobe a dedicated prepare_mutex and use it instead.

No functional change.

Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 kernel/events/uprobes.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 7709ea882477..686585539ebf 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -64,6 +64,7 @@ struct uprobe {
 	refcount_t		ref;
 	struct rw_semaphore	register_rwsem;
 	struct rw_semaphore	consumer_rwsem;
+	struct mutex		prepare_mutex;	/* serializes prepare_uprobe() */
 	struct list_head	pending_list;
 	struct list_head	consumers;
 	struct inode		*inode;		/* Also hold a ref to inode */
@@ -1007,6 +1008,7 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
 	INIT_LIST_HEAD(&uprobe->consumers);
 	init_rwsem(&uprobe->register_rwsem);
 	init_rwsem(&uprobe->consumer_rwsem);
+	mutex_init(&uprobe->prepare_mutex);
 	RB_CLEAR_NODE(&uprobe->rb_node);
 	refcount_set(&uprobe->ref, 1);
 
@@ -1104,8 +1106,8 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	if (test_bit(UPROBE_COPY_INSN, &uprobe->flags))
 		return ret;
 
-	/* TODO: move this into _register, until then we abuse this sem. */
-	down_write(&uprobe->consumer_rwsem);
+	/* Serialize concurrent prepare_uprobe() calls from uprobe_mmap(). */
+	mutex_lock(&uprobe->prepare_mutex);
 	if (test_bit(UPROBE_COPY_INSN, &uprobe->flags))
 		goto out;
 
@@ -1125,7 +1127,7 @@ static int prepare_uprobe(struct uprobe *uprobe, struct file *file,
 	set_bit(UPROBE_COPY_INSN, &uprobe->flags);
 
  out:
-	up_write(&uprobe->consumer_rwsem);
+	mutex_unlock(&uprobe->prepare_mutex);
 
 	return ret;
 }
-- 
2.51.0

