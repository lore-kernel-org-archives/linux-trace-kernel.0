Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74426CE3C
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Oct 2025 01:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320338; cv=none; b=Jh1f/OF5p/gTeV1e7is7D99YlQ0zGnPAiWAPzoVKtiqIk3Ec3BsdIwwB5uAzJ6XCpZ/SPBUjKlwNU1BOjO+IsPM9iE6LIqfPUIdLMzrP7sMDaMCz0Lo9RNW3xkFNYBiJJygfdygo1GgZrEUu+ZiZtQha4bMZHfpr1aikBtN0GXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320338; c=relaxed/simple;
	bh=uwhmf3HHMdzGiNGOGPfqkDj/FI1GzglANXwo8s9sdOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Or7HGXnpW75w2PSdSYdiAD/tRty4FpYuJ1IxZLqaw4MD4Lp5kOJKC8ysqb2l9x5Aavj02UUFjkzrBVa+9/0PqNUdpHaHvtHkOqh3W3TEDZLds/FlFYlkdQR46YFLun4pZY03uaqpwwqik6EQsHvxfx9rs6yZTYl6avtzBKPy4Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7mhA/tw; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7mhA/tw"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-279e2554b5fso28039715ad.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 12 Oct 2025 18:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760320336; x=1760925136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cwkgnTg2DHDaQ2RkX3ciR9SF56jSYXArtqinhDMsIj0=;
        b=O7mhA/twKMJrbDV6sqqHGnkCbwI5do7lIyOjAWskLY3oryIueqfrAYUhOb5K4/fR2d
         KtoiRDW4KWpnyK/5tdtiC6fkWek0yB9xz4MdfSm09J+2BKondqLyY7PAYFjfR4PYCb5J
         OBLHURthrgt+Fe0/eMHCpCoX4doo7739U0PtYdVbdllQ3BwHEtWnU3hQiN65qS7tLI+f
         MvMLTL7P63hDcgfcqPK5VQg/kOazqXtpAFCmK604CBc65G7I8klhda2Uyd7Q2VEvs0gJ
         Q0zj+YL8BsYtLnktSEP1nP8bbQafxRVHDuqrMbteSWvaW6KqhB2/EQV+qMQyA6XWCKXW
         WqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760320336; x=1760925136;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cwkgnTg2DHDaQ2RkX3ciR9SF56jSYXArtqinhDMsIj0=;
        b=g74zi+8UXGyJjqhTuI8lS/W6G4W5z3bHlt+qyA64vwulPXg6lwuRhSXBycDV7U2rA+
         KxVjxlLh0UZNZT46tmPODjQ5vs2k+EjohyCAdI4T3FEbHr5cQoJgbV8fl48+y6efYrhH
         JT1ooy2f9FRNWONO4c6mdePKl83RG14PMzDAdUKVr6Z+8PsBpAJs02GvxP40sJZ8lQ02
         Gr/DI8SGvET6+Wp847DovcOCFZNuPqIU6rEuZtapys8vSwunV05iakTTssnkXW1Lysvu
         yu0napA1f2fi9Obcy8onrgzGBCH9k+StsXYpDspvbK0FVBRSuPiejplp3VsMqAdnM2xM
         HbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWC/a0M87759A6XSdiXepTVJ4BuwVIWQTa7H4kR0I9+rm7eaUupYcc2Yq4XYhOnzkHVHeEo803KhOV6ZpeLtGYLLxk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCWR6sc5zRjKQwrL9FUgnXPpYHEmH7Hkd8AzODMYiBG/qlwT3b
	0wa9bHThtf0ogpizlFkIRLt7ukrhuq/eRfMjJYt/eVLxrslahzlGwyHo
X-Gm-Gg: ASbGncvCfRNkh1vZcC8N8BJOA8/wIa8CvnaSI5iwRIr0yjzoy7A4lVFoIFb1xdZD/N1
	xlScghkXIkq2Gos2vdzRX3hBfzY2a7Dulm074jK8mk3kOgPAZbfJPeXtY+oLswetiZa5iaJNzbY
	M1f341NM8O2DLIlMhwpP6A19oehIlz5y3jpK0XfecwGWceRyfPXQGMZSLfFIaFHT9QkwE2WSRhQ
	kyZdT06bxR3JTfEDrfTuAOoL6U5dXbj2CFoU0blzfodNpM41XHDMSZi3j9JL9uezU248W3yNx8e
	mEjkQzhCNj3cZTvbIGQ3+TtyscTjAUokmLFNRSHyIuw502iBVOnEi1I1DAmTn8UOFzOUm8cZV+2
	9I94SBzDbzycwxU9LNGW3FbPMDWlRVHIgxzGQ73oHGQ==
X-Google-Smtp-Source: AGHT+IHpAzOl7PxOE6HEv3Zlp1zcnBNgWCh+Kl2XRmqr57OnEcz8X/TFj6k/1J1zH7+3kBZWzatJHQ==
X-Received: by 2002:a17:902:c410:b0:249:71f5:4e5a with SMTP id d9443c01a7336-29027f3e32emr272696225ad.26.1760320336022;
        Sun, 12 Oct 2025 18:52:16 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034deaa54sm117224925ad.5.2025.10.12.18.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:52:15 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] tracing: fprobe: optimization for entry only case
Date: Mon, 13 Oct 2025 09:52:07 +0800
Message-ID: <20251013015209.30949-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch is to optimize the fprobe for entry only case.
The second patch is to add testcase for mixed fprobe.

This series base on the "linux-trace" tree and "for-next" branch.

Changes since V2:
* add some comment to the rcu_read_lock() in fprobe_ftrace_entry() in the
  1st patch

Changes since V1:
* merge the rename of fprobe_entry into one
* add some document for fprobe_fgraph_entry as Masami suggested
* use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
* add the testcase for mixed fprobe

Menglong Dong (2):
  tracing: fprobe: optimization for entry only case
  lib/test_fprobe: add testcase for mixed fprobe

 kernel/trace/fprobe.c   | 109 ++++++++++++++++++++++++++++++++++++----
 lib/tests/test_fprobe.c |  99 +++++++++++++++++++++++++++++++++++-
 2 files changed, 196 insertions(+), 12 deletions(-)

-- 
2.51.0

