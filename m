Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE22FC1D;
	Tue, 26 Aug 2025 12:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756212546; cv=none; b=NnWjw13pbMtbe9XAJe4KUbo33TVmcfzvhhXgM1TMAWiZM1I+pPqqJ8Rqy6U+4gDSiwntsGk3ON1bee31+Ols0rZlyRkLHbvBAiCEyvxs0Vh9P4VxfU02+DsNEf2oOfCVazQzzGgxJf9RkIahCVVZeHPMCmElmnuahyIoyxTnGJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756212546; c=relaxed/simple;
	bh=9x3y2/yFeBdmCFCxQj/2LG3T69P0gQUJaXx5PB0FGdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0FXBFj6WIA/mjpoz6iB+oEHuEzXAn8oCGWi5tvgxydQM6EVu/PEbafR6O3mjbSlHn66rOGGm+ncFiHvB0fXqq0ARuRKJjR6aUY9Bz+9cAZZWpGcrschIPeoTOHoHK8m53Qm1kJBbDeVn+Sn6gttEz9WtIXS1ts/3q5rTrIhiw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqInFqVs; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqInFqVs"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4c1fc383eeso1277641a12.1;
        Tue, 26 Aug 2025 05:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756212544; x=1756817344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oN54dxueBLE8GyKLooKDuOn8pGWg59XPMNzuBOQXkMU=;
        b=aqInFqVslq1/76DNd7XhAJETA0IdX0wnMCrvG7UFglxgY6JA3W2wnOq1Ye8RAPUh1d
         epLxAlUNakW344LkEzQej2SLZttKmFrIjR7GynZcN6A/S1ueaOUl8RSv1fG0XUkFPGqv
         oQ2v52W1BAKdrAbyZUqo2/rHMOs4fwD2cg18cF5Ixx5xi63UXdif6nLvoa9qgnd5FwFU
         cysizIevOIlYf+f57K2qwcCT0ghVPiGuqkIjOklnXYhANXxgsft9Ln6Fz+ioYiguGyOq
         ehJMV3DYYOkuWnp3NzjZemNxNR4OnHxqt8xUQpVYbTPwD7y5QjBG6K4CtyWe8kHUfrPL
         kgnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756212544; x=1756817344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oN54dxueBLE8GyKLooKDuOn8pGWg59XPMNzuBOQXkMU=;
        b=CQIm9OPssvHx8gCOC5dhB5Xys1HWdZEEcT176jk+J5k6TeMM/HCfb3P+EPC7WZM20I
         WWq8ZuFLL/YVW7E1Mlmy/6n1LzYG+pBwjv8mDWysM9XskkTeeNRylOlPf9ZmhP1RYwMT
         zJlBQEEuyTzjOo/5ExV0L9i2gSM5TVA02gcwrBPlO13nl4nNGf3PJMR9oeDkbpL4wBHr
         uQ8mCfnxS5hYUj13sDRDXnl2JP8zuCHeiYmh5Lo/mnwncME3w1ybxdipCzaEvT8PWkf9
         GLdl8WqTlQgbHv+nEW7KpSB9d7P8AiS0IG0KGyW8XDQiDvANVpBV4GFm9RVJ71yrbMBk
         xlLg==
X-Forwarded-Encrypted: i=1; AJvYcCVc3M4S6zDh+5ACLjKZ1IwpgU+DxcartG6CzroPhZNOi2GzHHlzWEV/WK+honHrbd8uNS1+BGd0SrrWm94=@vger.kernel.org, AJvYcCVjqwSxVWEoqrtgMwTuEmcQThKPgiEbhD+nVQ+l6cepEiShltbob74mH49F1+63mWBa1Bh/EDLruHA7rW0cBdmHcDQx@vger.kernel.org
X-Gm-Message-State: AOJu0YyX9ohVb+pV8pJVWlRQVnKjawi/o4R6pIVbdkTYJZNNBbtEyYTj
	ZzdjerqB9YXwv9raLgYfOuXKaMRPeyw0dZdC6DB5r6dP7oqRtSJqtB/L
X-Gm-Gg: ASbGncslve98Wts75crOhEftnrH5xf8E6nc4NZ5C0iF5CFP3Io2UvHShPQMggSM0NSz
	Uo1Ne1m/30Ld5vlR91bpvaVScJ3ZTal8+MjVcF8RS/EmY+niH3lIeTrahBk3useA+dIK2wgcr+I
	y/c2Mfew0RSEK8eLgtR5ma/rzDlaTDPxSIyDKG2HXQDsxmj3er3Y4VQ0WZvEObO/sBky++izGZT
	e86I6tAlDO0U9zJ0lfESOlwd01HBWbo5/ey17mxOmGCQI3RR7WVEMExPF4Oyz5zovPch7fqZxlz
	Vt3tmWgYp68zruyBB0Zzo8Otwp4VCK4G75Qy5YGT4p0kgQMeGvDmjIcF0/G3UdkuUkPWp0wc8jG
	5zpiCdC8TRkdP9xiFmH4hJViO0/LvOYOm
X-Google-Smtp-Source: AGHT+IFe5NEcJ3aLAhxVqfOrpD7gNlll4Yrf2F+SnIO+gOigPccm+arwc0Qazn+LO/LGFp/ta1u6aA==
X-Received: by 2002:a17:903:234c:b0:245:fc4a:2b7a with SMTP id d9443c01a7336-2462ef1f0a3mr187038605ad.31.1756212543705;
        Tue, 26 Aug 2025 05:49:03 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24882c840e1sm5183885ad.69.2025.08.26.05.48.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 05:49:03 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	mathieu.desnoyers@efficios.com,
	andrii@kernel.org,
	mingo@kernel.org,
	oleg@redhat.com,
	akpm@linux-foundation.org,
	gmonaco@redhat.com,
	ricardo.neri-calderon@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH v2 1/1] tracing/sched: add 'next_policy' to trace_sched_switch
Date: Tue, 26 Aug 2025 20:48:54 +0800
Message-Id: <c2894f9b0c5116eeffdc19947529aef5c5d1db4c.1756212396.git.gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1756212396.git.gaoxiang17@xiaomi.com>
References: <cover.1756212396.git.gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: gaoxiang17 <gaoxiang17@xiaomi.com>

Sometimes, when analyzing some real-time process issues, it is necessary to know the sched policy.

Show up in the trace as:

	 72.267374: sched_switch: prev_comm=grep prev_pid=67 prev_prio=19 prev_state=S ==> next_comm=cat next_pid=66 next_prio=120 next_policy=normal
	 72.267594: sched_switch: prev_comm=cat prev_pid=66 prev_prio=120 prev_state=R+ ==> next_comm=grep next_pid=67 next_prio=19 next_policy=RR
	562.192567: sched_switch: prev_comm=grep prev_pid=85 prev_prio=19 prev_state=S ==> next_comm=cat next_pid=84 next_prio=120 next_policy=normal
	562.192944: sched_switch: prev_comm=cat prev_pid=84 prev_prio=120 prev_state=R+ ==> next_comm=grep next_pid=85 next_prio=19 next_policy=FIFO

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 include/trace/events/sched.h | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..00336211aca6 100644
--- a/include/trace/events/sched.h
+++ b/include/trace/events/sched.h
@@ -234,6 +234,7 @@ TRACE_EVENT(sched_switch,
 		__array(	char,	next_comm,	TASK_COMM_LEN	)
 		__field(	pid_t,	next_pid			)
 		__field(	int,	next_prio			)
+		__field(	unsigned int,	next_policy	)
 	),
 
 	TP_fast_assign(
@@ -244,10 +245,11 @@ TRACE_EVENT(sched_switch,
 		memcpy(__entry->next_comm, next->comm, TASK_COMM_LEN);
 		__entry->next_pid	= next->pid;
 		__entry->next_prio	= next->prio;
+		__entry->next_policy	= next->policy;
 		/* XXX SCHED_DEADLINE */
 	),
 
-	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d",
+	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d next_policy=%s",
 		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
 
 		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
@@ -263,7 +265,16 @@ TRACE_EVENT(sched_switch,
 		  "R",
 
 		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
-		__entry->next_comm, __entry->next_pid, __entry->next_prio)
+		__entry->next_comm, __entry->next_pid, __entry->next_prio,
+		__print_symbolic(__entry->next_policy,
+				{ SCHED_NORMAL,         "normal" },
+				{ SCHED_FIFO,           "FIFO" },
+				{ SCHED_RR,             "RR" },
+				{ SCHED_BATCH,          "batch" },
+				{ SCHED_IDLE,           "idle" },
+				{ SCHED_DEADLINE,       "deadline" },
+				{ SCHED_EXT,            "sched_ext"})
+	)
 );
 
 /*
-- 
2.34.1

