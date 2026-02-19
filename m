Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C4B340285
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 16:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518465; cv=none; b=bes1e8ae47mpiTiNhouqgUhhJRw6ilNUMoK7n1QqMb7jg0z702rTmDcWququhMlRetJpV4goh4vr+AWKYrxLVvMV5MrTXPUjhgLAiEY2nNszRqvOq8yK2r/316fcn1pWgvWNBUYqrXJsm84PLtIKkWzOkYE6PX4Yt1tSmq4AIn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518465; c=relaxed/simple;
	bh=X88iXnAJXjPGgHPOFT637gekqsG1R9MYy6SqcieCyfU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DQe/mbTyU/n2N5a0urtqIp0Z+ORMv2Q5D6QvPhHsA+FuGK/t7DD5CWyhBylQtio621UghuazigisZ31/PIi6qSbfvvyX2kpUNQ9dksdiuQ2EpvDeeakTrMxM9g51iYCK9vhK7qKqzjRFRYG9bq/KIGSiEyvJhv3HlocMxbE9bHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=baad5W8u; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="baad5W8u"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso8101355e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771518463; x=1772123263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F+wYNkk6D8F5vKMzQAxnBF6GWz9VDw68N2DkIugXpnc=;
        b=baad5W8u30N+SvSETJuBFCZfgIOWQfZ30o8FZt8yqveiP4YAniWcI6AaamAmsWkWlK
         q8arXPBGcBSmzK1VXHq96Ugo/LSaYDRr9RVCxq4ne2pPBTmVlVwXuMs8Z4f/h0DmWE68
         SrhzxSTlpOwpVFzZoI5akOggytkKBosRz9Bved+tkD3mXsiSCvVcu22Dxbrtr54V2xu5
         qOjC4OCfHUmxGf3yQNEHLmIYGEWipPrx4EekBminNRk6dS4J+uzOKVusUT3IZWLbPRRc
         /QkodEYSQynq6HeAQdggiyU3BHjfm57YAyerjzS5Hs6MplBM6kAx1bxVFNFNeUkuiEMR
         5vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518463; x=1772123263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+wYNkk6D8F5vKMzQAxnBF6GWz9VDw68N2DkIugXpnc=;
        b=ZbdlynTcLGQSfXMfeNa+2zW4cGMSUy9u4WKIXbzh+18gfukmQ5ANXecWEO4RzIbIPm
         PTQ3sB5cse2LQIEl+VKijeDGtdo4h5o8CqHbxGsLy74rBIbGIDjuettkaYGdAUXaqYJ2
         g+Lb7lDMlMUoo39aTDHFBxEd+2r+f8XgJkyYQZwpejDabNtaBZ2qfEh7mzFCj62DHA7q
         zGTVnKWa5bD+k08r+4Vyuo3Aaus5hOz4spksXqO4k0mj+DSRJTYsGdx0c22iAI+Nx1xo
         qaoILJi9rOWdwnm3kZ7xq8X0R0qAZVXaSePEuChZ9+Qup1ivQcTMcsGIDxCHoqp3cXeg
         yv3A==
X-Forwarded-Encrypted: i=1; AJvYcCXlmQS04BMAFrpQbGUsRhKzTF2z119FSHSlTAnogICeS0UimGY+ad1GhZJAtyBaDMuR4GE4X5UZbEB3Np/dG8ctKtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYtAOEV68WL8jxwQOlhJD308/7ShLHmlk0/Bm40EyWRnn2CY8o
	feoTXnCNbiliB5AFBvPtUKHeUDDjCo7Y7Fc21gEuXnZwHb72q2v+1hvXdRWBS/5vBLI=
X-Gm-Gg: AZuq6aLFzfp7vntO7dx3nRfUT1gXxg3cBrjlUaATfKluUL+yMsKy2O+KkPFUpoDTAfu
	BKJBUxQgerpS4DchuOf09sbIcVy6Jsk8HGNfiap/yER8L7YHfXyaC5oP4BoUpENugAM0Of/2CVA
	F6+tW3f1tifinbT3le4C67g44bzTbMSv/L24A/6PjGbByPYFLXYQy24hAfZn0rOyV9c9BdLU15h
	uSaFia0rXsXe9LCLxl5leQ8CvV1pFGUL8xfO+BNDG9RsOojlLdkJTyvwltb0IlccLj0nXz7BoQR
	/DSL2HsWTcmjvUR37Ze3ZFFmEZ+o/mFIDP3kXO8Hhq4F9LtMs1FPv9bxcGv4Yry48oQ0nfEo/p1
	XZuseP1yk+eLqmnLy2jz37k2Rncj796KjsBVOyAQFq/bgdZVeoxtYAa3B4FZIBPamr2PMPKpnee
	537bBLrq4asVYmEVG4DantHFeIaYhHWJScwMsxbfFG
X-Received: by 2002:a7b:cc8e:0:b0:47e:e452:ec12 with SMTP id 5b1f17b1804b1-483a00aa58emr27233765e9.15.1771518462656;
        Thu, 19 Feb 2026 08:27:42 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8075sm47324631f8f.29.2026.02.19.08.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:27:42 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 0/5] Clean up access to trace_event_file from a file struct
Date: Thu, 19 Feb 2026 17:27:00 +0100
Message-ID: <20260219162737.314231-1-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
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

Changes since v2 [1]:
* Split the first patch related to hist event files into two: one that
  corrects the trace_event_file access method and another that ensures
  pollers are woken up when the watched event is removed.

Changes since v1 [2]:
* Fix a compilation error when CONFIG_HIST_TRIGGERS is not set.
* Drop a patch that references the trace_event_file data in
  event_file_data() and keep the simpler implementation of storing the
  id in i_private.
* Inline event_file_data() into event_id_read() to enable adding
  additional checks to the former.

[1] https://lore.kernel.org/linux-trace-kernel/20260216134247.1311631-1-petr.pavlu@suse.com/
[2] https://lore.kernel.org/linux-trace-kernel/20260210113427.1068932-1-petr.pavlu@suse.com/

Petr Pavlu (5):
  tracing: Fix checking of freed trace_event_file for hist files
  tracing: Wake up poll waiters for hist files when removing an event
  tracing: Remove unnecessary check for EVENT_FILE_FL_FREED
  tracing: Clean up access to trace_event_file from a file pointer
  tracing: Free up file->private_data for use by individual events

 include/linux/trace_events.h     |  5 +++++
 kernel/trace/trace.c             |  2 --
 kernel/trace/trace.h             | 17 +++++++++++------
 kernel/trace/trace_events.c      | 17 ++++++++---------
 kernel/trace/trace_events_hist.c |  8 ++------
 5 files changed, 26 insertions(+), 23 deletions(-)


base-commit: 2b7a25df823dc7d8f56f8ce7c2d2dac391cea9c2
-- 
2.53.0

