Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E6E34A771
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771518466; cv=none; b=SDR6YVB1TCEQMnzL4YfSEjtAARY62WmSnQC666xdD09ytGwY0UO67nOjPi8qiO1YrqNtCzdEubl32QzkOAZs0IRTc49lOPKkvuZYo+ToOFyIDqTOJQb8MZad+HIl6PjqeuaZe3BealyznNB9Xy5cyhWXSeqqtrb6vF+kZyBRehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771518466; c=relaxed/simple;
	bh=qGEgzEowAKOYqoLetjY4uyHAcod3FdEe26Azz1HZSBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZiZnTA1L45kUftRVLbaFS4rnVUIDV0HiAURqA/IxW+ncyWpi8w8ZElDi+lDW7oivlcLOeHqfXMceL/Rjrbh3z6sasZlQgzaRS899z287mpM1u8Ocr5JI/cms1/2FrL9jXPdrw0ZcG8NAb+k7gJYcKW0svHQ3qnvgCK0oubk7w8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZxQ2VCEz; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZxQ2VCEz"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4834826e5a0so12414775e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Feb 2026 08:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771518463; x=1772123263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFctbIz6tiPHsqiezPeCZfcnyQYkHL5Q+XsVl6eb4Bs=;
        b=ZxQ2VCEzPl+eIbryTLnHFQq6GocvmnTLQFcPF4jCHzW0T7USx6z7fVuPiftsUId1y7
         sLf8KpVfJMUIFIY37TlJD+sfZ3mPfpBDRwAuBayc6JEEJ3Mz8hW1sLFXjfQRonLBUTwm
         /fOzf36UdUWBTrb9G7Cg4Y0q0qul5Rr8/ELjt800Rwz7EgPSVp/RV60MWqb7x08sr2Xo
         0R87vWYTkBvi1hr/diWtgztpwKznMnRw5oP7bNQk9AoYQeWuNwFkgNGTaeJYGOhUNbiQ
         aq3aA0nfD2kWr9S6NBpbJyjzViSas7w5vb0JeNgHv3aLDNpbNPWxFUt+ZiFKeY7Xrluh
         R4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771518463; x=1772123263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFctbIz6tiPHsqiezPeCZfcnyQYkHL5Q+XsVl6eb4Bs=;
        b=G4g6Eu1HkgVExuLuQ6otqyxo1CN18bGc3Uvy87Ya08HpeRzYBVPtyxYf53lQrJt2Ti
         h0q91fYUz05gszVj+7flNVFZYpI2GVZh1tAVxpiJy8wT4O73Kak2AXQfyS9HB0NQsCwM
         pPdwKCDlQMhLuuOsHxcTOBQCDlim72WhKCI0skfqVJfvuPGRXXbz+KNDaF/5CfX/ZbYH
         EPr5E7kAhCDpqVthQMopdLLRV7pRoSnrFNXU3it0xXW4VEtcSS/6Mu+jv609eB/3ajnN
         TFGRJ4Bih+826cRsW0SSkuuAzmq0PnYTqBWig6actarXRj/ahjUtiiPjICYbIGcSTOEw
         AhRg==
X-Forwarded-Encrypted: i=1; AJvYcCUdns5TbbJERC2WXRHOIQy7VYpUHcCZar72sSY2qsmzLRaFRV3bAKT+6ZuBKEtR+jcB/sYlrGAoAjbT2D6A7tnJ1+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDCM6L+XhcsMAZcLPy059El+l0jTqBJ4gd6EygjWSRjAiL75/n
	MezzZZzuj4L3rlwj6EexkQEDrTXrYpz7/iGKbkRnH82KD5lEYbXEolJ3LmTMwQJhGAVpXdGAsg1
	8Artp
X-Gm-Gg: AZuq6aKNHlscfjurBnQZYa5LARojDkyyWcafhZNcKH26H80wNkX0f22y4y5laNRR4k8
	3yNDQOZhooWIhF9fLE6KSU3mbuGlZ3afXmhtBPbh0AVvRNADa8MOdmteTNMJtGzmtfBZLmCQRPI
	J3a02hJeATqkTWRgrk1iogjdcrfHAQjDjryhrcIVzbmcqWKr3dsZjjVP9YaZnZPZSMHVqzLHrXA
	+TLlNWMtzJwzuZ9o0giucE/o8AlXh0rlofDmS/j3Psi8u8u+LYEOuyhQPEOujCSnwF9Cm5/t2Bv
	IWiQeBxEI3a5X5Dgy1Uby3hEsfNHYmvW/pLBeyKBv8h7jSZKPuEAlbugb1RxQc0eFrj4bTq93bn
	2b5sN+qf6NisTnqfkRIc/xJVBOpLLXVerCGLNcSh8yC22rhLkIWbbDkpDihRPLAg9/CcR+4Tsqk
	GysZTeqK8SIScxhpQ2O1tZccprsLsIteLWBj01yQJP
X-Received: by 2002:a05:600c:4f92:b0:482:eec4:76d with SMTP id 5b1f17b1804b1-48398b5e0d0mr103863385e9.17.1771518463404;
        Thu, 19 Feb 2026 08:27:43 -0800 (PST)
Received: from zovi.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ac8075sm47324631f8f.29.2026.02.19.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:27:43 -0800 (PST)
From: Petr Pavlu <petr.pavlu@suse.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v3 1/5] tracing: Fix checking of freed trace_event_file for hist files
Date: Thu, 19 Feb 2026 17:27:01 +0100
Message-ID: <20260219162737.314231-2-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219162737.314231-1-petr.pavlu@suse.com>
References: <20260219162737.314231-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The event_hist_open() and event_hist_poll() functions currently retrieve
a trace_event_file pointer from a file struct by invoking
event_file_data(), which simply returns file->f_inode->i_private. The
functions then check if the pointer is NULL to determine whether the event
is still valid. This approach is flawed because i_private is assigned when
an eventfs inode is allocated and remains set throughout its lifetime.
Instead, the code should call event_file_file(), which checks for
EVENT_FILE_FL_FREED. Using the incorrect access function may result in the
code potentially opening a hist file for an event that is being removed or
becoming stuck while polling on this file.

Correct the access method to event_file_file() in both functions.

Fixes: 1bd13edbbed6 ("tracing/hist: Add poll(POLLIN) support on hist file")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events_hist.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index e6f449f53afc..768df987419e 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5784,7 +5784,7 @@ static __poll_t event_hist_poll(struct file *file, struct poll_table_struct *wai
 
 	guard(mutex)(&event_mutex);
 
-	event_file = event_file_data(file);
+	event_file = event_file_file(file);
 	if (!event_file)
 		return EPOLLERR;
 
@@ -5822,7 +5822,7 @@ static int event_hist_open(struct inode *inode, struct file *file)
 
 	guard(mutex)(&event_mutex);
 
-	event_file = event_file_data(file);
+	event_file = event_file_file(file);
 	if (!event_file) {
 		ret = -ENODEV;
 		goto err;
-- 
2.53.0

