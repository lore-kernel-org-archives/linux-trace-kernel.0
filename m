Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884C92BEC4E
	for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789331506; cv=none; b=VONfZfM21zoqvttT24eaQ8G3EHtU+8oRChZ9PpmnSZe459QfZ2+n293lXv2vS1WPs6827DAr06t33j07pzND5xu+DmjQMaXNH5udIzXRk1J79aXYPAo1MnkregztZTR08kJo/v0dhEuGUaM/0EenPXrAECRBAFjnbilXPaW/yYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789331506; c=relaxed/simple;
	bh=ZxKFKkRM8oXFOFl97A/fFfxND2n+rPDeZs/wlH5nD1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hjQ8pdkbitUmYlQ5O8s8Y8CNt0rsBWX0Yjjao1uppyTzX6WhfLPppNlL+KNHIekbaG5IPwN7HqgZS8F8iXUAGLK5IlDpoXRUYvE3/HYbncHw1yiXVQ2s4kHh8Z2srMfq+DE/ZWzNbTXXBFpsjZDGkV7LMIR0nayqcwgBpUtscv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7JWDkOt; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7JWDkOt"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398c066106cso1060382a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789331505; x=1789936305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d5jASMuUqBprwXkBkHSWhbe8r2/E5/xJ7OJmCuBUolA=;
        b=a7JWDkOt+9MeYruo4fRFTgsm6zQ88d8VrKV3jMuHYErofOEDhMrbzM8eFlwrZS5DPf
         k+Dcl5h3zP1i9gptSWPjNBLOUJE9uxZSJ5RYDv24OU993pAx8lmJpq6YWxuUscniOVjb
         ExwGraszTG9uUbdKUrfB4HpPYQOMd1V57hhWINpFZ3VFolsI/MjdS8JGpochhEZAYgyh
         fBH+oLVuUiICxpRSpijY3zMUxSY/l1r9aCxefFGIO6oRSzQxxk3JYJzgH3CTZO8C/Xu2
         POH7cKsS4XHsK9akATj1RsveY6lQQYytoBcR6jjS7Pmiyf0wQARmoaoAkT4XTLIu5O1E
         eB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789331505; x=1789936305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=d5jASMuUqBprwXkBkHSWhbe8r2/E5/xJ7OJmCuBUolA=;
        b=DNJzj2D0L0qGAas9RjqPZWAhl+VfmcuDAgbQHoKYFHq92tHsZ16apL7AnO6w99TbJF
         DLS7YZCtrfXquCKQ5t5SqYC63jnHVkJDyzPtA5zHtOn5jPALYVuQcvieorMYawUjlAl5
         rTkSQLhFeHtETeil/iZlQTnhb7wOiuQfGG6nsoQbEfAyESAht6/9fEDXtFVtjj9ohC/n
         n6FkJ3OGQMXSuGkCl03FWXsYIJRhxknFHm+uHU2q3Fppbt5zZ6B3KRODM+B9WEkOBAHO
         MatGghkYpYUiJuEpL7jvW03V+WKU+VTcqgK4wdh3n9fXzidIlfhUMiM9d/teP+za0Y7S
         i4ug==
X-Forwarded-Encrypted: i=1; AKwUvBywjY0KNcEBxZi5ITBtPQnT8gciuwysTFnyvRNubLV69HPLLPxpMyloUGFrf11+6cDuulY0o83/xQUSgdaoWVIk1tU=@vger.kernel.org
X-Gm-Message-State: AFuF++l55p8K0alljhMiy7+SsX7rR9W5tvkF+YCAfUVHvdsYF906WA7i
	Yy9Dom4+KxBX/cKsJfxtdfnIcJ6MScnSxNxug0MUjTHDhys+mDBbYDo=
X-Gm-Gg: AYBFou1Z9z9hU41tPvgI6XEUwEOQON67o/iD5h7In20Ff3m4/Xps6Ywyl7/NSHutmpP
	bvCAG5PPi3WHvKSHc1+nbsYatQkK/h/lBNG9NIyGJrYe7CRUpfPWJGM5FffIYSy59sT4hLRAEJv
	CivY7GSjtBnFjqGVp7QDwYrX0WbMA21NiDJ4JrVTdLCQzSO6OgxbK37PUjs6hbiYtvMI8ierDAw
	uWqsPFfBDsajHD+w08+4J2UkiVXqpQgFbHN2bna9mAjVgMYtvJpPGLt6kjd6U1DG+mi4UYiSCOn
	e4NVvLmtLxqZY4QkeibsrHp2sXwZ0mvs8G1OWcxdp8dBB4jXaz2IAxtCCNll6fW1F6TNNFAvFzF
	D69qbU3nelwni4joqXsTo0+i6hXY+uzEOpS49IPR+fNgHgHHoi5kGDjZKpJp72q9XHNfas8lVmP
	x4BSXSEY2uFvMlQe7Lvoyi7VIwkgZVYdeGgROVx0GgAR9J/6GYdOx7Wwfn2Ga68WywGBmuF7vWe
	3wa/eTJHguOxn5OZVkSMlLaGw==
X-Received: by 2002:a17:90b:5785:b0:39d:e9b6:cec9 with SMTP id 98e67ed59e1d1-39de9b6d48bmr415809a91.7.1789331505011;
        Sun, 13 Sep 2026 13:31:45 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:b91:ff81:c860:362e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94744dfdsm17530220a91.0.2026.09.13.13.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 13:31:44 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] tracing: Fix NULL dereference when copying keys for a field variable
Date: Mon, 14 Sep 2026 05:31:29 +0900
Message-ID: <20260913203129.941270-3-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
References: <20260913203129.941270-1-donggeunyoo.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In event_hist_trigger_parse() where it needs to create actions like
"onmatch", it calls:

  event_hist_trigger_parse() {
    create_actions() {
      action_create() {
        trace_action_create() {
          trace_action_create_field_var() {
            create_field_var_hist()

Where create_field_var_hist() does a loop on the hist_data
representing the keys. The issue is, if the keys uses one of the
pseudo field types (like common_cpu), the hist_data field element
will have NULL for its field member causing a NULL pointer
dereference when accessing the key_field->field->name.

  # echo 'hist:keys=common_cpu:ts0=common_timestamp.usecs' > \
      events/sched/sched_waking/trigger
  # echo 'my_synth u64 lat; int prio' > synthetic_events
  # echo 'hist:keys=common_cpu:wakeup_lat=common_timestamp.usecs-$ts0:\
      onmatch(sched.sched_waking).my_synth($wakeup_lat,prio)' > \
      events/sched/sched_switch/trigger

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:create_field_var_hist+0x771/0x1380
  Call Trace:
   trace_action_create_field_var+0x360/0x600
   trace_action_create+0x393/0xe80
   event_hist_trigger_parse+0x3e47/0x69e0
   trigger_process_regex+0x1a6/0x250
   event_trigger_write+0xce/0x160

Instead of accessing it directly, use the proper handler
expr_field_str() to get the name.

A .buckets key needs the previous patch to render, so apply that first.

Cc: stable@vger.kernel.org
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 9d7ce01fda36..b43b83d7c6f3 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3097,7 +3097,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0

