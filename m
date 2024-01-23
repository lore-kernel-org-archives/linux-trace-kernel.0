Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EA660BBC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706024251; cv=none; b=qDbTkCcoy+Z4VHPlc9Nn6J5VX3us1/9hwrcJHGNNmWeAsRK1hNI3nlQMp7ykjzER1eaVDCh91QJ/suwSo6LKnR/H+3TZnswEbkTdZ218TPKK5tvfcdAOxeQFb70l+GVT+C+m8zK89ppDw4uA96rIjoLx5DcY5gkV+eB53bnBr6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706024251; c=relaxed/simple;
	bh=SmprmXJKPp6opHqPLLviYvms4SHFNPILVuQUb8Rwo/8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a43/OBw1lvTIiKn/1u/fvQsMfpifT1bfgaPZC4lEJWfgqbvx2SApqjaZtuVSS/znyw8udMDVw8URgvHfSYlRh9bc4AcccZFRRvce/oG9RVB/0PLHCxN0ZstIu7O644o+XCEFlrChouIyFw6PhYgO7+N//9XLHr/TPO9ze3vtIQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=MsISOLUI; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="MsISOLUI"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cf0784d4aaso12051681fa.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:37:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1706024248; x=1706629048; darn=vger.kernel.org;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=veMMcsUebJYkhfmIXUs+5LrZbCXp0fVUgnh9FAkwwJ8=;
        b=MsISOLUIWstqL7yUkebxzfBu/pnfgZU+Svg90v4DNfJ250MNoawySr6YV+xla1ydcP
         rWrPH6Odc6TxYUgQ834XTxugGIBYSGgpMOOe+4HAvLfznpixjYjsBbyRS/cwRdowrRpF
         Joq9DkKkGh260RxSUIdbS4vGn01ZWKRSWnVkyLZswK0EwAXuj6D2/S1AZy+hx0YPqhb4
         SmTzothq5IsenSEqG2vJsyf+5N76jI4UtMtAK7WZJ7a4ymxBymNL6CiR8JE3SE1BTKPs
         FsdOMbNZfAJUa8uXqYmB8QH3/+2K6F8Iet7ktAymN14SSORXyLiePpsEz1dU9+SkTQcX
         FoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706024248; x=1706629048;
        h=content-transfer-encoding:organization:mime-version:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=veMMcsUebJYkhfmIXUs+5LrZbCXp0fVUgnh9FAkwwJ8=;
        b=r5jG5Vk2s+3F2y8XIZ5MZokgP30jVInsdy3EDJO4HqKMxV0RmVhtFjGVWpXVf8W27h
         GcQ+3bMucSwcmdoSv+OXbEZ0hd3MWYv301ZzRTBjwaBjb7OpIgFz7R4Bb3NG8c1Q5GPh
         H7YhQw5rxrDivPPslbxaabC9cVoZAkZVGBI+O54aMvW4uYuZ4ku6/sW1pyRg/oOl4ljy
         3vMtToXxeKQ/5Wf7jYMrgJKZX0ueS3g5T1L6JKQbuB+I6+HUg1w616NbZVN57aLDqlcn
         mExaPq/o3tabZJWMY0j89c8XX1Vjv93Wm7CBJVCFqRrqy5FWlb/34bHzHBMg83bjTybz
         qcRg==
X-Gm-Message-State: AOJu0YweK2MzN2DhQBiwHWNF85F1qJ0pO/WG9efD+h3+OoroCERLYR4o
	GGWGF/hy8Jv8M8IsFsve5kHNomBGlwV7JLN6fwSLxE2HtH247gGOPy+KViC52rw=
X-Google-Smtp-Source: AGHT+IGhlL9oAnwBrOhrZJ0R/VfLySlP45A9B/Vc0ntm6DeD38WuWmDZF1mZUlXPMtYF7otvhtzzRA==
X-Received: by 2002:a05:6512:1295:b0:50e:ca83:887e with SMTP id u21-20020a056512129500b0050eca83887emr1948380lfs.34.1706024247144;
        Tue, 23 Jan 2024 07:37:27 -0800 (PST)
Received: from wkz-x13.addiva.ad (h-158-174-187-194.NA.cust.bahnhof.se. [158.174.187.194])
        by smtp.gmail.com with ESMTPSA id h23-20020a19ca57000000b0050ee3e540e4sm2386790lfj.65.2024.01.23.07.37.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:37:26 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: jiri@resnulli.us,
	ivecera@redhat.com,
	netdev@vger.kernel.org,
	roopa@nvidia.com,
	razor@blackwall.org,
	bridge@lists.linux.dev,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next 0/5] net: switchdev: Tracepoints
Date: Tue, 23 Jan 2024 16:37:02 +0100
Message-Id: <20240123153707.550795-1-tobias@waldekranz.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Addiva Elektronik
Content-Transfer-Encoding: 8bit

This series starts off (1-2/5) by creating stringifiers for common
switchdev objects. This will primarily be used by the tracepoints for
decoding switchdev notifications, but drivers could also make use of
them to provide richer debug/error messages.

Then follows two refactoring commits (3-4/5), with no (intended)
functional changes:

- 3/5: Wrap all replay callbacks in br_switchdev.c in a switchdev
       function to make it easy to trace all of these.

- 4/5: Instead of using a different format for deferred items, reuse
       the existing notification structures when enqueuing. This lets
       us share a bit more code, and it unifies the data presented by
       the tracepoints.

Finally, add the tracepoints.

Tobias Waldekranz (5):
  net: switchdev: Wrap enums in mapper macros
  net: switchdev: Add helpers to display switchdev objects as strings
  net: switchdev: Relay all replay messages through a central function
  net: switchdev: Prepare deferred notifications before enqueuing them
  net: switchdev: Add tracepoints

 include/net/switchdev.h          | 130 ++++++++----
 include/trace/events/switchdev.h |  89 ++++++++
 net/bridge/br_switchdev.c        |  10 +-
 net/switchdev/Makefile           |   2 +-
 net/switchdev/switchdev-str.c    | 278 +++++++++++++++++++++++++
 net/switchdev/switchdev.c        | 346 +++++++++++++++++--------------
 6 files changed, 650 insertions(+), 205 deletions(-)
 create mode 100644 include/trace/events/switchdev.h
 create mode 100644 net/switchdev/switchdev-str.c

-- 
2.34.1

