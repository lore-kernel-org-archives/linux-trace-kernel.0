Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CDE4FDE42
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796255; cv=none; b=tGVqWCdrY0ZynSYBu3R5zD6M80Yqu4/CORt+WjHbu7bGzyP27EhUuE1cjJXny2LwQeLHLCvLykXs7seXISM+IaNKkspnekf3jyDExTnFRmd4Fqeoe9VdVWT0H5MeVyK/KQxxe/ZvDJGXe1ZJqc+vPPCotvRHaPeX66lR2PvO/w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796255; c=relaxed/simple;
	bh=XbEajAij+9bjal3xgeldoWcC3SEeH4KbsCQ0L0UgERw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QFbGt2GwAhihYzug1HsV2m/pc8RpLWG+XcontvROkPeOQf2LzzVEEM6eLibOe1Prz8sE7r5Lxl0ibF+6p6+x8HzRWYVj3uUzfNxCkSRoLbyyIqRw4SZabzBhMir1OITuQAD0+aj3blWQf2g4SdDB8ipSlA6ak2jHrSHO4HGnZ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Er+JkYTJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Er+JkYTJ"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d944747d41so38202825ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Sep 2026 08:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788796252; x=1789401052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=d+COVii/mw9vZd0KWYD/rs6aJweAew8DwpyJbPVtFlk=;
        b=Er+JkYTJ+qTtK6l/jomhKAZFrezRrM40++TGlcJheIpqv9mfIX/E7SdCl/o9cd9KKb
         w6iFsAwhnSetTdnpxPqDe7JlIrO/nI/Z7S+29JuhIVRFvS0U9Ucz/UYvMUz9qlett05x
         6TxqMrwksaoZK2KetF8KkXZKr0DskXTBVllmJZIrJgPggX1T6Vgy2SApdIAu0eVxSD3M
         FMzrWOSTW+dvpIw1xh9kBKF0blrti5nFkSQqZFlzR64adEINkXdnV+UyYuTgb3prFaa1
         XHpEPD67rF8yg+3/nySZP0zm0McqS5Hh8HOHn2WONZunNZ4K6couLKEvhRCDWI5cCFZl
         1RSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788796252; x=1789401052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=d+COVii/mw9vZd0KWYD/rs6aJweAew8DwpyJbPVtFlk=;
        b=q1+wvtGNjKDRzJNgpcETxqJuLQOl1RGKijlrq6jzKsABr06Sz0LPzkgFxl/bKvvmEf
         LKxFdto9fsK1OI8rePzcg6lUxBB9SZK0Sj1X5RewkoqRnkdA2RIBaGyjdfOAI0d5IKmO
         NDnewY1SYvDSL5RuH1z+JhGQDbhplag8Q+hGr8ZlYxOtxxdYtsIpMw2HjCmlWYEW8zh0
         s6eY4ydIMgTzY4/MgDBY4e2NK/gc0T0NMYxzi7G8SYpKFm8mS22SzPAZCkp1yciCKQww
         HbbbUirDs0j6LRmUvdeso3qdhHUliuQx9CkBodsPq0oOD76t0nzBVR0gg73/q/bps/nG
         w5lA==
X-Gm-Message-State: AFuF++nwFPfs1DoA77ziyhUvdTvCBXcEuSFbNgMCG1+OSgmTcDliih5o
	PAfdb4CAquoNo76+M66+0MNfeObf+2xz8gQJixXSxdaM6u+/XiSi+sI=
X-Gm-Gg: AYBFou2SrCvE9ICLzB7YdZZufX9ZdAQinuJ6EbRQ9D0cDZwKNx/C8tw9MMWXaZtpoxL
	SWfK2U03JoSxF1I2sVAiOZnIRRU217dhJFnrASJah+NlFsbVEJLrZ7fgoXOJ+PogRRjcT6T6gdz
	RIxfjr9Plp+KJMxP61p+EsLTQYs0KZwzgsrSyM9FYm0CHz7F/k1ih7WxY4qW8aauIunmzBtbHwV
	0bbH3NTQTQPZum6UDGViD0v41hzMOGP9/Y72YgbxVwFXJtXh6ILg6JtrxcDXRV5lkoV+xuh/M0j
	hnJrSu+hNq9D9+g5/jKmQFVbl/UwpJ5NLzLnMJLx9ItUFAc1TSnC9GcBPxkn/4+0O0rfoAbeKWW
	cyInLUtvE/JwUuRWLIR/hUKHaQziaSrpy6sVybnMPfU46lC/H/ul/KPyBjLk8PbtAH8xiR/wfuN
	X1Tm88/aoeGc4w8UuZIdY1eQwn14511v12jkoWEPX+kndqp9RtRSBojEQWMeyPuGIySzIdBlHmn
	V3V+fCLQbj7wPWN
X-Received: by 2002:a17:903:19d0:b0:2d9:2688:8be6 with SMTP id d9443c01a7336-2db126346b3mr296688815ad.19.1788796251968;
        Mon, 07 Sep 2026 08:50:51 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm47265405ad.63.2026.09.07.08.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:50:51 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	donggeunyoo.kernel@gmail.com
Subject: [PATCH 0/2] tracing: fix two histogram stacktrace keys that corrupt memory
Date: Tue,  8 Sep 2026 00:50:43 +0900
Message-ID: <20260907155045.692664-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both have the same shape: a histogram field ends up flagged as a
stacktrace while the ftrace_event_field behind it does not describe one.
HIST_FIELD_FN_STACK then reads a __data_loc word out of the record and
follows it, and event_hist_trigger() uses the word it lands on as the
length of a memcpy into a 31 entry array. Neither end of that copy is
bounded. One write to tracefs is enough to take the machine down on a
kernel built with no debug options.

They are independent and have different Fixes tags, so they are two
patches rather than one.

Tested on x86_64:

  - both reproducers panic before and are clean after, with and without
    CONFIG_KASAN
  - ftracetest test.d/trigger gives identical results for all 45 items
    before and after (32 pass, 3 fail, 2 unresolved, 8 unsupported; the
    failures are pre-existing and unrelated)
  - the stacktrace modifier recipe from cc5fc8bfc961 still records
    stacktraces

Donggeun Yoo (2):
  tracing: Fix memory corruption from the stacktrace modifier
  tracing: Fix memory corruption from a "STACKTRACE" histogram key

 kernel/trace/trace_events_hist.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
--
2.53.0

