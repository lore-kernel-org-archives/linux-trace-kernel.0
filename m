Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A659393DD9;
	Sat, 23 Aug 2025 03:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755920747; cv=none; b=Y92H9u8M7EsPCzirGdAliUVeiMwD29+PluP/ROOhMHjZFou5eMF+4j2eY4GQT6tMm+6+yftWVq9qdTs1DheWEdsV4zBqLi5w8uikIMADvldNlOLUUByZtfDC/Qk6YCzdEPKOx9rmOU9CifEwTkQn1aoH4EH+OOtR+wRmuv8MCMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755920747; c=relaxed/simple;
	bh=9x3y2/yFeBdmCFCxQj/2LG3T69P0gQUJaXx5PB0FGdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTeq91IPDNp/z4mlwILW8kIAHFc1zi8zI6HOLIdqGen7E6uO72YDw0FiebCizzTPyHQqwnMKW4gSNmt3yC5vWnnHVNXRDChGOY0NK5frPoKdebpy/vg9OZI25RIrHX9OvU0WezmDA72+wLSg0zQUt+UuzLcHxm5POg+w8wb3T+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=at7p+bfG; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at7p+bfG"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b47174c3817so1839239a12.2;
        Fri, 22 Aug 2025 20:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755920745; x=1756525545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oN54dxueBLE8GyKLooKDuOn8pGWg59XPMNzuBOQXkMU=;
        b=at7p+bfGjlVOJpbMQNnRClp0uHSNlA4e8MSk4ata2lzFLwRI/XRxjHapraWCbB8Z++
         qnU5xRrp4i4WGxeHj6n26cTfSqCbpp58pznzancKpCWu9yh/Ui4Et2ygiKfTHLnUomJj
         mPkmq9MuETI6snlanZqRt6YFbLFRTx5jSwEYBXNdeK1VEIBwAS0aSj9KmP0IwKc/7PXA
         q3CVmKhroK1gPCYoCLc+zS8rhM6XLOCxrp1ZjNHVIoNhch3kq4iQ+5IO8IQZF3rf42e3
         5D4QY3bGW+xihJbDxvzfDL+Xlc60I9vkkhjz7Wd7C6c/z8MjeSrxUyp2sBqV1kyCsCm2
         z7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755920745; x=1756525545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oN54dxueBLE8GyKLooKDuOn8pGWg59XPMNzuBOQXkMU=;
        b=jPiZA9u8cQM6xoYESFNtS98ytHnqzNxGavWkxBDKATu+7Oqf8p2JXzNPMoSH6kvLuK
         rBXsEyIkSD1GlVCEd98YnqvNaD2oAnBKCcTLWCUBCTiTvJBLzomcvOIqHTV7Z98JJn7N
         DjFGXZI59RfthKchEtlzw/ZsDg3YQYAUbR14C1ryTc5xOoAES3JB3nKYXj3+0xbRyufV
         Ktxc59/5NNjkSy8OUZOJFwTm7kh395pLrRcjPLSQskqGvnA63LQxcq8MPxX2q2/mT4hO
         fNyZfRC7opfqcyYyux/pTdSP2DwGOJhQKAqmO2Bpy9MQAxm9Vvg078Rl6Fu07PWMTasW
         SOnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVosJr66TuvCuPG7fwBoC7PW858JG1EgLxqBDWLDWK3EjyKxDY55tbvTGtAIlx7faCNKcLMf6/ZP8OP/c=@vger.kernel.org, AJvYcCVpNR7I9v/Tle/169dbvhy+LCEisOBvLJP5i8oMSuni7mnK/o8WkT6icY1anI2OwzB8y/TZtMFwfwLAOBtjSDr/BK90@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/uNxr608O0YeFb0MMFH1ayT1NrmzRaIJ9Gro5dskInpGyZKV
	pBxm4FAu4omg6QMIvuNpUYtwt0w/K/nFtkJHpeQ1iQO7aHigh5A9p4T5
X-Gm-Gg: ASbGncsvbtq1rGjw+W0b50p40TYAb6IG6uvmgEKLFa4YsH8zTHeuqwM9WOYmgmA0lwy
	A5YGFrucWWen8efTjhyhceLI7kKE5lTHPRthv46TfbLQixq8L/dmdaLT+ZuCQ2UrYZMWDU6JFpl
	eAUL2Dw+PkiFDevpe3W3cFfFjlHBFIfJM+aumtMkSFXxOy5iYum7afW4lWFqsO5w749hQe10p4s
	bOTjnndlaG/5oV+xUcxgQDYesJD1xomUkcp9dTUyz+TOaRuQUE/3c/3vfcgkFFW0fJ61e4Cyf6V
	FgnQXJFx5gNgvSylRlHUvApcJ4gmPuG0SB896VTyBQHrBeI8JvOXq8EdHrL7ESCN8icVjHeOq2f
	Xlr8kD/TBbxL2AZ/nixPuCzGhwVei+nuf
X-Google-Smtp-Source: AGHT+IES+3yASvnpwBwvDfVDi+wAH8UfWJUE+JZiAoKr3xxgdCSHs8AWlNbUdWcBxkPh5MnRLIl1iA==
X-Received: by 2002:a05:6a20:7f9a:b0:243:78a:82bb with SMTP id adf61e73a8af0-24340da1088mr7556049637.53.1755920745443;
        Fri, 22 Aug 2025 20:45:45 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb891bdesm1163698a12.12.2025.08.22.20.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 20:45:44 -0700 (PDT)
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
	libo.chen@oracle.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	gaoxiang17 <gaoxiang17@xiaomi.com>
Subject: [PATCH v2 1/1] tracing/sched: add 'next_policy' to trace_sched_switch
Date: Sat, 23 Aug 2025 11:45:35 +0800
Message-Id: <ad2236efd94c1b061934b3ca2c4c82123dace1ab.1755920363.git.gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1755920363.git.gaoxiang17@xiaomi.com>
References: <cover.1755920363.git.gaoxiang17@xiaomi.com>
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

