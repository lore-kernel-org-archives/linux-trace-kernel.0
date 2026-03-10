Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8734844C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Mar 2026 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773125264; cv=none; b=hUbnG2TAfG1e8HrpSeUwhRAl/XjItpPaKD0ApvRKOO25BAJENPC1Nj3k2mjjVoSKp/XEKyvSJggsumRJ2990QhmhNBQeegjdT8KUO5bh0amAhqxU3db+sl2fHUyf7nIHVtsN20pBU44Y0jWM0iOB7wO2y/nW/+8UJ39mGUYI1Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773125264; c=relaxed/simple;
	bh=0EJEd3P4J84Lpc3/olGmNZUeyvOQ0lRb2ve9MrVzkRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sgz5kjokA5gIja/U+xtfo/5xejzHUhD55t8tJrB7P/q78PlJGxCXLhMLpAwQjgq4ctYH2k6ViEX2QLLDnDmqOyNrd8Afd2TPTOOfSQa4w0/tLEKseUEslD1HViLueCe+3dgcf9aLPMcMpRGoQWDbgZPrC0LunRBGN+IzQ48OAhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uvki86IS; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uvki86IS"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7d75371d873so1598534a34.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Mar 2026 23:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773125262; x=1773730062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hKDdoVBKtZmwxQAbbxNIdkk0aLXW/mXKHyUCjCyO2P4=;
        b=Uvki86ISU9/AZGs/QpqKaN1BOTlKaBbEmNxdDQLP0XtXN46WGx5paf2jMs/okWU88h
         IeVEK1zxAxUWKSbAGbGwW2oCxoaNcaSoPbSl6PZR2JDZy7NsldQb+kj6qdhaGoMUPoA0
         33m8JeaAO4E8BHtxrLPSEhi7R1l8m0TvTxJme5dmeatqZT/Pwg4bnn3tuYSpR8KGJBwh
         WrX4KkYY1pkcDl1abrvYFFGYWYLg2n9WdyRFUO8lQBLCLkRyjHGjhG2QanQip1Q/rBXO
         IYAZ5tLiggO2sBybpzH3FIEpkm6pPPNVvWwwOdei9yexirReZwAZRrfkkYsuYQNY8Epq
         nSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773125262; x=1773730062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hKDdoVBKtZmwxQAbbxNIdkk0aLXW/mXKHyUCjCyO2P4=;
        b=HdkYkFTn+4EiYpWt9GygnIQC8bIu+egHCTSVEvDrBWCaBOz03kjHirZEdWkbf0+S2g
         AAbLbF/Jtp79JHOqyn0Snc70BI1H1PlOGxLDAUBycvBuumXk2joMUobrUO9QMYhV+QKV
         ttDpjQ6hZYyAqWmekh0XXmfYl96bLeb6VWVJgHTafrP5UbsI6lGOpS0QDLiPv9zNIkUC
         WLHPs9TpVGBWyuC31SWgDfD2+bjBTrIe1YSX0GKwKmvbQg1v2v/3X6v9wnEBjYWuzN/s
         PCMOl3nW+w1PJNapLE92a3LE72YATDIrvIxLvCY/0O7QVAFtrtOkKjqJIBiU8pJfc+6P
         SsSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz90AnLLWIPJ9yFnJOH3oN4JdabUSoWzspgyOhL5o5ve6GUtSsz/wa5Ge9QaLEdZzWwSzJbJGAtmkQQQJz7zAuXMk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDHD+F62nw3eyTne2PzDBWDYVKwOFsG0ATUs0mpt/RIGiVchiT
	xjEZgim5y79pNvOkc0aUlUEjY5HBMhgba1krrIUyOSE33B07flc0rPR+
X-Gm-Gg: ATEYQzzpsdVIz4mIqN2avvdXeh64H4/yFA9jgj9IkfD2OBSktP4iSzittkfjC4Qt0cS
	/PKPquLCjWufYyvi43L98IGbUwQLhyNyHu5EXf9vf6TF7rJVNfa1bsJCHisRJmV7uZeN22K7XZF
	AN4krzP6iW2tlR2acYg41laWdpBRgSBB71f0fYYJ3V2vrFm/4aQwKYOR9EFKEXiZJW0kGRHkeuY
	8O3u4YDGJVB2eWfy1K+p8J0cbY/fYOjRg75tfiKvmV4o6coVmBLf7Lh0dAIsZsCxfHGMFBAaztj
	ETubZQV63Na+FW+nsmE+c6l7Z7nzMkf6AwDKcMq+29M8C4CiKohdnHW5tie4VUxm0C+cgfTrPa2
	/ItpKZOSTiz8xQ6AlXvH41W6s7WfLIyCObWwT8G1L4WF+a3Z/R/ZWbADpVljlVAgjIgRVhxFgLW
	43DUiDnnv3mdv10jc2b/US7ByiI7TocL/WyJbQaLAAiKi90My9Z4t4LrWQNmUqGJ24asCAE9RZb
	r2CaDLR0y23cOyMOuvcC/mZWdArb60ZPdcoAH3c5SW+iq+E
X-Received: by 2002:a05:6820:168a:b0:67b:bc25:2675 with SMTP id 006d021491bc7-67bbc2531abmr1725902eaf.30.1773125261880;
        Mon, 09 Mar 2026 23:47:41 -0700 (PDT)
Received: from localhost.localdomain (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb666de5bsm2600618eaf.7.2026.03.09.23.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 23:47:41 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v3 0/2] tracing: preserve repeated boot-time parameters and drain deferred trigger frees
Date: Tue, 10 Mar 2026 00:47:13 -0600
Message-Id: <20260310064715.527906-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 updates the affected early tracing boot-parameter parsers to
preserve repeated instances in the format their existing parsers already
consume, and documents that repeated-parameter behavior.

Patch 2 fixes deferred trigger-data cleanup so boot-deferred frees are
drained even when the cleanup kthread never starts.

v3:
- Patch 1: use a shared trace_append_boot_param() helper
- Patch 1: document repeated-parameter behavior in kernel-parameters.txt
- Patch 1: reframe as an improvement and drop the Fixes tags
- Patch 2: no changes

v2:
- Patch 1: no changes
- Patch 2: restore the dropped mutex recheck comment
- Patch 2: clarify the synchronous fallback drain path

Wesley Atwell (2):
  tracing: preserve repeated boot-time tracing parameters
  tracing: drain deferred trigger frees if kthread startup fails

 .../admin-guide/kernel-parameters.txt         | 18 ++++-
 kernel/trace/ftrace.c                         | 12 ++-
 kernel/trace/trace.c                          |  3 +-
 kernel/trace/trace.h                          | 29 +++++++
 kernel/trace/trace_events.c                   | 26 +++++-
 kernel/trace/trace_events_trigger.c           | 79 ++++++++++++++++---
 kernel/trace/trace_kprobe.c                   |  3 +-
 7 files changed, 145 insertions(+), 25 deletions(-)

-- 
2.34.1
