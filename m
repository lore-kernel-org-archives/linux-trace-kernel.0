Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7C137E5FF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Sep 2026 05:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789364106; cv=none; b=PUbdNwTqL2Kt0Vng1NlW+AQ9FAJ09femPLS6X4bN3lljcdflpdug3xSQWSSmHlFJmg0tV26Ghu8xqDqknbPSsaZBpCRu6IUT/wrErV1WOlaPrXwO64m6mYQdWHfFyVe9of1hTaE8auWete6HRlEISBA0exCH3uz8uPqdzstVDG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789364106; c=relaxed/simple;
	bh=EAtL5GAvLO8guoNp4qcczPosAY9+l1BK3hnEZ/prkhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mDit43nSSrjWzBbvPDhV86x59MaDyzNcG59Du1cUNDlD/TIzvwTMV/pM9S+gNqJYtW9osWCrWM4dB8uJ76lar5DPSgxp2I5rV9u8AET8JpBtRBPyVFisBKsrQhX+/BQI8ZksmGTWAnjirJnBpQOLV5R6vmjx7Wvt0j36+R1eW7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epWv7lNc; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epWv7lNc"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so2793064a91.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 13 Sep 2026 22:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789364104; x=1789968904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tQV2Lz18105+vTwI6s9YIFFfIpvfqowDaG0Sxm6VeMM=;
        b=epWv7lNcRNhOybE1X9TtUWaxee+0/HdIVUJ0N87AZVqMN6D5eKHVKtMWcPEWTLB/6n
         Db2HRmDQ4zjCEIz1hxZFw4OjoDrWKQ5Rm64DMwGdkXISZzg01kk81lkzvY6fDMj5EdDr
         61Zh0SOVPOaacNsP/Fj2HaNPYAcEKRxLrtLdqK2wbh+KrbEEvqV64sbZ/mX0PHwwrHgZ
         k1wzwWwX9YtuTHG500JK56NbrayCGpm/eXk7YV2z06eo1L5O2YyNMoOq2DfToZVCStrK
         FMa8rDyZ+imuJ75qUfGIkzvD6dQBVMaSD1CiK4NU6JfecxZ6uPR+4pWNKwKkPTlQWtNh
         RLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789364104; x=1789968904;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tQV2Lz18105+vTwI6s9YIFFfIpvfqowDaG0Sxm6VeMM=;
        b=NsXZ2LaiLWWcJJIatlZNSQsO6wuD342dvK/kTPwlJzyageuFt48RI4euzamLELSHYA
         8Zz1uRJ8cUpccB1jsjElyshDaaxHRqLmie052YYHEUVWqyFYYgZy/4G2o6VJAK2mdhc3
         ijwI+oFD+PSa+elqSGo2q3hqjnyI5gg0uGiskhCTT9upma0XYZATpSRpWB4MBn/2inLQ
         dQptOCB0n000WaASDwTHr+51iOEDpkfUer5h4Y+jvvlxsOYnUnO4fElsZQjHGIN8gRMC
         qvhtMu1P/JzhKaPRvhj5agTUyPHI33XHt/29j5nniTi3u7VfPV5qFdOV9OJHH1Pe1JNj
         yN1w==
X-Forwarded-Encrypted: i=1; AKwUvBzZ0UpziAnMxlIa+FmEivN2Ya24iBI8OIJ/3CLYyHpngCzGQ/6RVpjiUs9sUvq0B9xu68MRc0MM10T2XvP6MzCUwB0=@vger.kernel.org
X-Gm-Message-State: AFuF++nvAAZ05FtE4Qd2uZKFWHj2G2aCBPHNKM8fE6cKwz5O7vS3BhVQ
	ZEO19Wd4mxk9S9lqTCPG2DXTTrSW1EazOeHaEiPMLab9bhmadQpgky4=
X-Gm-Gg: AYBFou1Za8WSBjb+s9r1JIQJ4s8w1YpNDyJV/l4IEpS6RN7zCkFiom/6u91hMa9w+Xs
	xt6B48c0r71OZd1Irsv8rAQyjdeLWTwAjl+r1heTdGwD7pQj9bx22JBdyGWS66SsXKZM7mFDyfW
	6BsOZb0f2hnGyGe9jgSqbEjQIIJAENyvxItqAg1Z/s4fEjJa/h8FAtJtnNyk41d3BpR6n/ZtX9E
	rQlN8CSbHMMRlhTTTlreo2H1ZWnoxGgQX6hG8Y3GiTo7avmY1sCJCie2do21juTmrhfz0Quqhky
	uiqtlh5yqCX8zTPsJnpxYYVv+nM+Z+gIOWAVt+W1+KjLhCMNbMx8jVLoVrVmFWI/tCYedTGEBaf
	r6WJxPXBxCQqciZhUyhZ2EEm5TQBTywpDIi6PI80dwjbv3I5giOCnY/sLiioAiQfLSGAI7IhIum
	NdIZoz+QObnICxIv0lkwopl/IYKmcrm3r3d3veB1rb5ScjvMFPn2acoElafdG9X5dx3n2r+M2c+
	dfp6sK7nN/kiWwDu61DF3WbpYk=
X-Received: by 2002:a17:90b:4c41:b0:398:9c39:520f with SMTP id 98e67ed59e1d1-39dec05d384mr2377298a91.15.1789364104244;
        Sun, 13 Sep 2026 22:35:04 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:7f00:8c85:3b80:bc61:4619:5346])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d994872e0sm19009261a91.8.2026.09.13.22.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 22:35:03 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 4/4] tracing: Fix NULL dereference when copying keys for a field variable
Date: Mon, 14 Sep 2026 14:34:43 +0900
Message-ID: <20260914053443.981201-5-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
References: <20260914053443.981201-1-donggeunyoo.kernel@gmail.com>
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

The three previous patches are prerequisites: without them a .buckets
key and a common_stacktrace key each render into a command that cannot
be parsed back.

Cc: stable@vger.kernel.org
Fixes: 02205a6752f2 ("tracing: Add support for 'field variables'")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index fdd097abb0d6..11d4cf2544ac 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -3093,7 +3093,7 @@ create_field_var_hist(struct hist_trigger_data *target_hist_data,
 		key_field = hist_data->fields[i];
 		if (!first)
 			seq_buf_putc(&s, ',');
-		seq_buf_puts(&s, key_field->field->name);
+		expr_field_str(key_field, &s);
 		first = false;
 	}
 
-- 
2.53.0

