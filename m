Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428F1D7E5C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 06:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764174; cv=none; b=np58HR1dLafnms5SSZbWkncspcNKGVF7NOlUgA1ohy7szzvW7YWacEAFBEMJ2AhnESdmrQs330sEMQnSI3jB/36132IFPjomc7MZsJydCNGJmdEv1KDMCPiOZAKH3M6Dt/gr//iNtXVvdW+CLLJ1+UtxdHCWw6oyhG7ztzzZbkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764174; c=relaxed/simple;
	bh=NhpmIIeSpHxOh5isXBwUScoeaVEik8jNta2lhSfppSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GofsbDt1m3PTejNKPOQXlyg8ih8C6x/LM/4DALkPlxoz5nbaVxEIwaSRditiPhkceYeei53oAGI/cI2p+UhYv8E5dNDe4n8hD+dYcuQ1uAkcjKE2aM7ze8EhL3UTU7p/twaqKdiu8KKJzqIlW/UH5lQwrSPbzvfcXDLusUomr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOFMWWUM; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOFMWWUM"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3969e82ff8fso3287267a91.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 23:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788764173; x=1789368973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mC7T3ph+JEOY8FMTTcX05SQsuupJCdCJ8BZxUfDf5oM=;
        b=eOFMWWUMzw+CfzNZP6L6skcE4+/Efkjt7RfqpsEU0/ndigMoso9Xqwt6QE6umHwDCU
         JkKbnJi9mY0iF5wNKMx5yltL2RMwvQBCnVw7GdgkdWRRDTVvSm4WrTETtoUm5SzcWkTg
         pqFp2W0gjc78QNOTm5c5ezPuOXrNo4Tre1dZxlIp+Upm2NfjTv3y7ZFryh36Z+6ykN6Z
         LuAY+yNj05UxEx+f1ismHJvQJVTcvkg24vd4AYGztBCwr7RYXV14Q23M10WmiokB6dHP
         514sNqrm22SfC/UhIb+djMokznh7kqcigzK7c2NHqod8bFCoeGGQQrul+v6gE9INA/fJ
         FV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788764173; x=1789368973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mC7T3ph+JEOY8FMTTcX05SQsuupJCdCJ8BZxUfDf5oM=;
        b=hyZexn1bLFoUHeDHNLN7Db8Gb7lxpMsS7JNTAwocvFMHGMUycV3/OTSqGm3UQXyrn8
         Edl12pmXi1cuSUum7oEK/cwwehRiQmCAApsDjoGrf4pTWDKl8JszJ2AuP6h3DFBrRju4
         RMyhmK8QUTo52sa6YsEBpdY6xwXCdwBJ8m35uhH1LVHFs+kZ7odOF3spw7BsbmBHazyM
         KVFOzIWmJcaEjL5geYFqg0XNM3R/oV3+XHCynWgMTfJvBMensWI+z7jEROtqZHN82eT9
         hsJ61H9g7wVd+Q1z00Ho4GWin1Rri2T3MRuvJ6V5Er3Os1ZvCA6fQAF3zJnx1F5uxnz6
         K3yg==
X-Forwarded-Encrypted: i=1; AKwUvBzEayNKTfDmQcNGkmkB7Yt985DRbHwcUiwuQo7orOs47rZCNwnzOVnvbFlFLO9mukTXYJLxsq/E476zMIemwj2HcNQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n+A5dq0vjHhVBCj81pwNBLlFz2dpR2at4ydKzR8GKwwMxvxTxw
	hjWOXnMKoOAPXzORnfl8kqqN8it0m+jCpQDAMkGVq2dNPAOfEGmJregO
X-Gm-Gg: AYBFou3TZzeHXzSjVIAEd+3vY94vrflXp7xcf3GnWGzgCRSevwu2zS1kSiFRF3wAkZC
	2ODpLRYEAIMPlkEKuYNRVALijS0YHHwIG82jA0YtaYyVdim4ZmPFnjXPpsKSKAey40VZm5LR4bO
	d36bfV3NbGxrkOpNm2YliTEz093bOGUvByZSBzqXmvNnXXGFhzfLAQd9/8DHmyD45psyRg0BOl5
	zIvOhoMG6pAVboKoXTZ5vKawN6E2kKjkjnSeUvEP3pq9xiBJjfE8PM2m3F5R+s4JJhHmvbZpwfL
	rvFZ4ola9PW1EkM3yZrJBn+xhAzs/b7/qmPj73DagQJt10Yy/Cg0MIXJYgmewBZ9AZKwrKg4rN5
	7vFpCiUGtkGYOpk+y+FBfmkqEYA173q9vaQuqk/OLD5DOkS7ErmMR8TB4TWeJu9j4kwqlgTBS6P
	bGtbBfnC20tL+NzNXT8P3Ped4xoxHH/6Zi+Wltg+WCh+vvAdYoGKAiqpCyfBludqvQG74XkmlVO
	5ESxdmYKjEQpA==
X-Received: by 2002:a17:90a:d44b:b0:398:bee5:61d6 with SMTP id 98e67ed59e1d1-39b26252edamr34497069a91.24.1788764172958;
        Sun, 06 Sep 2026 23:56:12 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14344a86512sm2067445c88.10.2026.09.06.23.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:56:12 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 08/14] tracing: fix typo "preceeded" in comment
Date: Mon,  7 Sep 2026 12:26:07 +0530
Message-ID: <20260907065607.36615-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "preceeded" to "Preceded", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/trace/events/timer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/trace/events/timer.h b/include/trace/events/timer.h
index ca82fd62dc30..3aa0608c6361 100644
--- a/include/trace/events/timer.h
+++ b/include/trace/events/timer.h
@@ -302,7 +302,7 @@ DECLARE_EVENT_CLASS(hrtimer_class,
  * hrtimer_start_expired - Invoked when a expired timer was started
  * @hrtimer:	pointer to struct hrtimer
  *
- * Preceeded by a hrtimer_start tracepoint.
+ * Preceded by a hrtimer_start tracepoint.
  */
 DEFINE_EVENT(hrtimer_class, hrtimer_start_expired,
 
