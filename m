Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC61A2FC007;
	Fri, 22 Aug 2025 10:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755859890; cv=none; b=TCuZ4gvbITeni++gLtDAPW4jNvv66seQxw65P0I14qR5KY1Lf5BN9/J83o3bBtNWQxt0Wn8O/bKQMew6IPc0suri7tDKXVVRUN+2vNMfImnoDh58XHgChbvv4+VH+Q/MIvprhcilt5Zwxx4D848eG0oKsph0cTx7LWRULLAMTfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755859890; c=relaxed/simple;
	bh=R/Us8yoOUcf5j5xnjaV17VoKHLl+swRAnzktObdcvKs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CC/i1DX+B+XV4FsBEE883jNRCiOJcEl6Zk+G8vl0eciIewu5Ffp0wTt4Pm/reZnszw2m3GQF4XzqPLjmPAFC/7kfaSdPqY3Djz13/DDeH2CUZYbY23buoGkwla/NZbtxzezi/H42R2hfr+gMU3cD6qLWO8csoURogcttYuEYDIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CcASr3xG; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcASr3xG"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so2297329a91.1;
        Fri, 22 Aug 2025 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755859882; x=1756464682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=un4jbsZMsu5Iv1MpmtizVBR2W4fFWImeX/sc7t3gpHg=;
        b=CcASr3xGinv6dAIVm3g1b//7aTiHDUWM2cX6pM+pg6qaA8ewYG683ErCTb3aMVK02b
         iGc3rE+D1H5cSuoBst0e7XibC1tiQcDOTuIUlsxALseejlxvjgV3AYnnvvguX6dzVseP
         cKRAGIjQiQ+hBRagIXD3x+sukwfQxZygt8eiBSnVb/UHSFHYZ0nrCmcobOHdcrlI3uDI
         nU3pZUqxmDOpAd+cGwgpYDNp2/Lw+4h5ZdMe2LoQO3yaN7uHI7K7ZtbYT/PUvwYI3Tle
         CNttDjf1XRjyMESTrX+9ocdSwNzoyMJc5g8X/X1i5vfLSGrd4AUiubj2aLAaKmwYxonw
         kaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755859882; x=1756464682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=un4jbsZMsu5Iv1MpmtizVBR2W4fFWImeX/sc7t3gpHg=;
        b=xTKHnsYR4W6qnyvr2oDi0i/PIRqMUsiGKpcJCV0Ynodq7d5abLGW1SexXZP6JZDgbN
         mPGXvwsNkSlhBnQG6QLjTbOJeJVjftSiIK/jYuxCAOfjYm1JgcmYNq5/yqfPEdDq8u/J
         tMbjxX6cWlrt1hYiFOfouqc0SL4ZdpdvrvEoG+o7S34Ylx+yFNNwsUq+X1Rse9T7actv
         veoiTL4Xlk04xhVJiVRqIb2Qq2m+uWqXN1GfDuEd4ZsB18/3oL+0cNTi4aFyg4sCu6ji
         4V12bNXge8imyVtqpgQ+3BLbEetmgh7UqyyVRqKy6ZMnvMnfxajwSEQnDjX7jvZa24Om
         zcYA==
X-Forwarded-Encrypted: i=1; AJvYcCV42OZmWtwuiK3AGC4TYwgoRtdQGdNKJxBtkssdW1+za5j0ZHyv1qPuWQdXY0c1N/QH/ZXyQfqDL5qpKdQThh2TVqGe@vger.kernel.org, AJvYcCXbYFobGuhKLXZ2GWMY2RrYnVbmDGlrzAZ1mPMbgr95ONwHjMfhpN4DX/lgE1TaPMnVRHDqsxaUbzWS3dg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY5r+ElGnpJKmVaYVgV7/Zj19cTpfEB2QWm5SwrxMZTAOhei94
	F0Fu/XCeP3SopTWiAeTLUHhZBu5bTZceb/cjq+FBUJI0YP/qhB4mGH5l
X-Gm-Gg: ASbGncvK3OlL01JGOMVqSp3w9e3aJt2p1qASPo5VyDX5JPK8ybcOS/6ufTn7o6If6CS
	KlQRXPX/1ljUVC8jwREEniqn++y77/vOmHiSubicDTt1HQjSrbbZ9HYvqr8QoJXxhy4RmL3shO4
	Yu+Up6dA6yZEwXJl4rPO8ie+3xjK+qD/tc/TiBKW3ZrtQUlrnOOogTf/s5FOIr1OJGB8B76cXaI
	/OVHTjqW+S5gQ/Q0YU2mUQCdwbQv/2Ct+mYh75Bo66HX2yCNjVy8tNCOwC+0NuV4tFnTrK55QPw
	cwMFPOPG1opXwKfq2s2cM9PMFXzNbXo0Pm0CJ3LNcLrBWMG4MSDIsPL1QYCGMYAh97j4zuUyFIG
	XumgPLA71CB/NGB5ygrEtKCxhHW2e6uN8G0P4S0xBhxCD//2V9eOcvw==
X-Google-Smtp-Source: AGHT+IEGmRPx+pvADQ5BS9POnCBNPbi7RCM7VTnbnNlJyfxmWrWAFu9k6jtf+4PRkb7DiKWBfxeAsA==
X-Received: by 2002:a17:90b:3b90:b0:31f:35f:96a1 with SMTP id 98e67ed59e1d1-3251d5640b8mr3179310a91.15.1755859882073;
        Fri, 22 Aug 2025 03:51:22 -0700 (PDT)
Received: from xiao.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-325123e82dcsm2201750a91.3.2025.08.22.03.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 03:51:21 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
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
Subject: [PATCH] tracing/sched: add 'next_policy' to trace_sched_switch
Date: Fri, 22 Aug 2025 18:51:13 +0800
Message-Id: <20250822105113.1102099-1-gxxa03070307@gmail.com>
X-Mailer: git-send-email 2.34.1
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

      113.457176: sched_switch: prev_comm=kcompactd0 prev_pid=30 prev_prio=120 prev_state=S ==> next_comm=kworker/u4:1 next_pid=27 next_prio=120 next_policy=0
      113.457282: sched_switch: prev_comm=kworker/u4:1 prev_pid=27 prev_prio=120 prev_state=I ==> next_comm=swapper/0 next_pid=0 next_prio=120 next_policy=0
      113.461166: sched_switch: prev_comm=swapper/0 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=kworker/u4:1 next_pid=27 next_prio=120 next_policy=0

Signed-off-by: gaoxiang17 <gaoxiang17@xiaomi.com>
---
 include/trace/events/sched.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
index 7b2645b50e78..b416b7bafee4 100644
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
+	TP_printk("prev_comm=%s prev_pid=%d prev_prio=%d prev_state=%s%s ==> next_comm=%s next_pid=%d next_prio=%d next_policy=%u",
 		__entry->prev_comm, __entry->prev_pid, __entry->prev_prio,
 
 		(__entry->prev_state & (TASK_REPORT_MAX - 1)) ?
@@ -263,7 +265,7 @@ TRACE_EVENT(sched_switch,
 		  "R",
 
 		__entry->prev_state & TASK_REPORT_MAX ? "+" : "",
-		__entry->next_comm, __entry->next_pid, __entry->next_prio)
+		__entry->next_comm, __entry->next_pid, __entry->next_prio, __entry->next_policy)
 );
 
 /*
-- 
2.34.1

