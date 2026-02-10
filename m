Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61501319877
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 11:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770723290; cv=none; b=XNaYTv17C0+Y2L8xKGgDWndvfVU9waGwXqn3e/Imnm6j//vU4bOCqBjU1S7P7ImVwsYHjt4oBSh+pjs7XuFxQXmAFY1MlSXe1Gd8O1D7AGPWs2PLg5LfF3ouaKY+PjfxUmsQ6/69QSpFZw3452mDIPVLHH4VYLfykY0UZf6uBrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770723290; c=relaxed/simple;
	bh=PXlGXTF7C9Bp5wIkua6cbQY1E4bz3+QGknS3RgTSj9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kGNs8oNRVZuvtTjkl5VLBdscaU0dLrBCvnFjeLF/5GeHA371LRCyVR8aEkXAlPYbahkC+3eHGzFYDALxoMzY7HvA4gKqysNEgEiLUQJd9kP7WddsYYAAxH6dnX5aDq9JDrj/Ow1AuiPwyujpN4byLFmt282KxmC0WJErcW3ziHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RAWuNx+e; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RAWuNx+e"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so6252075e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Feb 2026 03:34:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770723288; x=1771328088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yd5/B16dd/gyIVErXzWIVHUVhQJfV39zul1oatkB9Rc=;
        b=RAWuNx+eQvDnVnhemRPs/nCO+gWFxawBIyBvzSdU/ZPZQoo77RB9t2/lc/wgijTG7J
         YDmp0xIxVtKClJ4NE0on2u9CFDiQO97GTUfEyvbmgu3fRxRMzE5aoa0lGNr7qXease0O
         bHUQuP0r6zXD9SiQeWENDvyy+bfw4iERng7Hv6dF8oUM7EAk2neOssRcLsNGS7yWC5Yp
         HNg2NffcgwwXhTtz98qJEzamK1v7Upe0Wlmvk75r3o7+3MGj5CMTRr16x8+SwY/twT4V
         /zzkTA0tV3Y0PxWp37h/uLbPsr33YmWtsNMESrpqhbBd3Btk/8OsyLx1vKgyjQ5UvCqj
         NSUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770723288; x=1771328088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd5/B16dd/gyIVErXzWIVHUVhQJfV39zul1oatkB9Rc=;
        b=I9iztbQzPguKvwSgglVACxt4eujTFQjyH+rXtraIwqhwhcrshsCIZkRZm4PzKG5EOQ
         rEo1b09yieyaKyM/zAdlxe9AP3m9fcK34ZSdPdN6S6lzf9oVkSU83V3X0lzJeUdvNP73
         I3GECXSjlSyOKEU0cIW+Xtuyf7W7VSK/Ut9of6pEQC6W806GRlAuobKumEILhE13vl+s
         Pn8A+GsXasBV//7Dj2uW9i4JNTmbguFouPXfVwzk4NgwbZKH2QbC8cFccrcwabqjgeRl
         Gpyo8KA/8kmzi/L2Ju32bKNX2WiIWEAupw+zsGk4z1cQHTXeCoNnxnkC+DIyOSOGoxD3
         gGVw==
X-Forwarded-Encrypted: i=1; AJvYcCWvePeExdrtKFmJp7250m6Tdl5g2YR0fmxVeJtADAqrYqd3jp5nSYutieUP6qS1PVbPsOdONlkSRb3Jsm3LWBZUVcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyVbSMI5F7w/z8COGERfD4+rx+G30w9FRfCNQBZPTr0V0XYgQd
	ORTrpVwahzw4+ZgG1yAFzTfvc0c2guIV8s56ldjtKTWbnZISMIvwm33Mgkd9bm1hbKQ=
X-Gm-Gg: AZuq6aIHKwSjvvcWA4Rmn/uF9lV7x4d+1DmjzKksUSs3uncUNnqtG5I6wb5pXNh9mrw
	bXcglzQ6dZjV7dCWSfcsDVofqq/mEsxjv0w6YKmEI1nrSoNkYUyjxXPSU5Pyeka4zY+3gZ+LpfN
	BqMCiCNelw07cH7/JQd6t5DEKZjw7joOF2AYhKx6kTu7IRVH/zGteT+lvgvVVJaPMDfASHmzpCX
	6RqvykXVcjOnlsxSOV1efKTZ4UB0BWtk0eTCXggd5UdabWJxgBBdJd/584z+NvLxW2S72uqMMKQ
	FU4b8hGF7+gVWijFHVbCB4i1rItrReSu+X/nhftSh/LccnWye5rYK2NjhuUBqw28xuobT7j28GD
	k41q2gzj7ZGU638gQ4fHAWFfVKSCYODQtcGES/a3pZkH2AoBwOy982gd387VhIwyK2KvqYxKd+0
	OfAVGBf53uFDjNKpy5K2fVM9l7VmbvWKySzpqjIAGAhbmUK8TGmu1bOn3i/WbZZZdBwyehmYOFj
	WRFcX0bk+B3LYMebeeoRmYH
X-Received: by 2002:a05:600c:3b83:b0:483:4a95:66da with SMTP id 5b1f17b1804b1-4834a956702mr52477845e9.13.1770723287740;
        Tue, 10 Feb 2026 03:34:47 -0800 (PST)
Received: from zovi.suse.cz (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483209cfd77sm120182275e9.14.2026.02.10.03.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:34:47 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 0/5] Clean up access to trace_event_file from a file struct
Date: Tue, 10 Feb 2026 12:28:15 +0100
Message-ID: <20260210113427.1068932-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series includes several patches related to accessing
trace_event_file from a file struct. The first two patches are fixes for
edge cases, the remaining patches are minor cleanups.

Petr Pavlu (5):
  tracing: Fix checking of freed trace_event_file for hist files
  tracing: Fix checking of freed trace_event_file for id files
  tracing: Remove unnecessary check for EVENT_FILE_FL_FREED
  tracing: Clean up access to trace_event_file from a file pointer
  tracing: Free up file->private_data for use by individual events

 kernel/trace/trace.c             |  2 --
 kernel/trace/trace.h             | 17 +++++++++++------
 kernel/trace/trace_events.c      | 25 ++++++++++++++++---------
 kernel/trace/trace_events_hist.c |  8 ++------
 4 files changed, 29 insertions(+), 23 deletions(-)


base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
-- 
2.52.0

