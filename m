Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B29743634B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Jul 2026 16:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783443569; cv=none; b=MUeq4TWNIV4NREy1qqQsn2u7jQOD1f7Prd/2690/cWnN2XLhZr6UM9/E031y8dmRp2wDTkz+2sBJ3hB3HjoiehUy9o5OVizfaMo4p8TVhGA+cawl75BFTgaWgwpb3+F3KwRvVY8fYNjN/0ktiiHCEZQmDXMu5di8X+O6HkEdFBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783443569; c=relaxed/simple;
	bh=nUUN0xPWz7q2RyvUCKORU7VqMpHCgFB281JF3872N24=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqtmqURerrNmJp1BB69NWZ74jQFCh8qAB5TnA4P3vnc0vHFtmdEY0D5xYWGPJk4N71Er8QsLoJvaOeIwJDINuIAPT7Ur6qBEEOGRSlJDLWLttfSHTXPVl9d9c/7KwenfmVSv+ZHt+dJilI3pJPnFwz63+SZMrU+WBC41V5muYRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuBZQp97; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuBZQp97"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e53581361so230976785a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Jul 2026 09:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783443566; x=1784048366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yXrrKa9i86QRbnd8WzAz8n5WCs4Qj9PVK9gVjYwwX4I=;
        b=XuBZQp97fCN21qhSYUd3Ikv/WqP/EV4C4Scjrzwt7OV48cLuevXOAtcgJBThJ4bRIZ
         WWMdxtMXInMfkUTh2hn1Ek2H5eS28NVADBgcNxIpIUXUDGF+hHIrnGVnkJ85kcFV+M1Z
         Mie120JmQcfY+a+0iaxBsrE8RC07ijoYKXLRw5swfoKtB4902Y3TXw/1d/PHINg1wx0I
         dL9KFWe77GGbiwdC04Dd+ZouxbbusTJ3Q5kC3ohK+JsmowZxiU3gJzompLQQCX97Igrt
         R1RVzy6Gtg1UmJ+ec1QB4J9LedOl9GFbDn7+XVfdpqP5Nn+T9BW7rYgzSlBOmZDfyUTt
         1LlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783443566; x=1784048366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yXrrKa9i86QRbnd8WzAz8n5WCs4Qj9PVK9gVjYwwX4I=;
        b=fukp3c78Qpk2GDhhxxg1AfeXKUJ3PWl5a3k2wS0kLLdpU+VLcLxqMHP4kaIXXOdakb
         GFU86qPWNc/yKcVCGJuhGPTevZ6RM/a+X7aEUbCmaAo6RZJipNRLAngFM1/GKCQZNs1n
         TSYFba5QdPnA0KwNwR2yq4DXTwS9b2xjyY6Uo1t1fn8/nYj2KoEbjcpSRWVH/UPUFJKA
         AHtDClDaFz9+8mLJ3+415F+l7kccUUdHJu9HR0MPCKV2RcJ0GNW+iKSmulQGICK+1yjv
         Eltgksl0i+2CNnEM3xGBtcujAK9x/eCECi+vtBtBzbe3zW3qAO3zgX9apRzdPcXiqWVx
         TZ9A==
X-Forwarded-Encrypted: i=1; AHgh+Rps8d5oBB55pl5B9sAUO2usTR9CDcuKXAbUifB6V5EeARKHMG+9qO4adbHs0KZVzn7o+xnoVq7e8OTZbs/uhEuQToU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEmV7KdaY0XmU5wDLUczYMoUC0MTEW7ZKolr5Fp9SiTvHWCSE2
	PhAaDWQf+GIUuqC5XlOApqldm4uJLIFKy3RnQZcVaYF9bXk50E4lbjyR
X-Gm-Gg: AfdE7cnToyVDp/oddw+v7oU8ehDGxGtocAtCiihgVXiULSF1HDeyDwGquA5ivQQCgXg
	j9B5xbP0zN3+kKItdDmbhjRQVpVM2rs83gxHJbEEyOeTVcnBL5Kp+ncsq45kAC/vMMdJ22R3rpX
	X1XSBXqMc5Jukut8TkMkdCAwiD6KR0KSjupw1HpC+E0hjRVq6fAKwz5SWkuPk9hAxtufjGu//i4
	NFHzFlSnRz+kXjDaQdDDWE509CxnlF6vqgAll+0vyrxYx49QfVBcgIX5pDZBmIu2dkRBxdWzGv9
	s4Z0YF2PRJmXd7OyS5nCT765GL0kOQx1oraSNU3nMZbJBRhPilT1vjrHMNDBaqZYmQh9xCX/C3h
	KDNgjrQ5QWgTB+AAIKzm4SzCPVmtwS6tiQf3SmvMS/jOrVjM+QbQPx7BLQCCf03EJqtMnVzxHxB
	ADqsu0HEDKhpbiq8Sz9CfhhII/Wn34uGIe+DFkWBHjcJG8qZGXiFurmKiq32vKGf4AXG6PbHmkC
	NUi6Do3InBiKGmDDvmmIbfomDe2UqWV
X-Received: by 2002:a05:620a:2711:b0:927:25f5:ee08 with SMTP id af79cd13be357-92ebb5d59e8mr731266985a.43.1783443566238;
        Tue, 07 Jul 2026 09:59:26 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e90bb91adsm1209145385a.20.2026.07.07.09.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 09:59:25 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	XIAO WU <xiaowu.417@qq.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/2] tracing/user_events: fix use-after-free in user_event_mm_dup()
Date: Tue,  7 Jul 2026 12:59:10 -0400
Message-ID: <20260707165912.2560537-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This replaces the earlier single patch "tracing/user_events: fix
use-after-free of enabler in user_event_mm_dup()" that is in the tracing
for-linus branch; Steven agreed to drop that one and take this instead.

user_event_enabler_destroy() removes an enabler from the mm enabler list
that user_event_mm_dup() walks locklessly under rcu_read_lock() during
fork(), then drops the enabler's event reference and frees the enabler
without waiting for a grace period. A concurrent fork() walker can
therefore both dereference the freed enabler and take a reference on a
user_event that the put has already freed -- two use-after-frees, one on
the enabler and one on the user_event. The enabler use-after-free was
found first; XIAO WU then reported the user_event one, with a PoC and a
KASAN slab-use-after-free (write) in user_event_mm_dup(), and the
enabler-only fix did not address it.

Patch 1 holds both the enabler and its event reference until an RCU grace
period has elapsed, by deferring the put and the free to a work item
queued with queue_rcu_work(). The approach was suggested by Beau
Belgrave; it supersedes the enabler-only fix.

Patch 2 adjusts two user_events selftests that assumed the event is torn
down the instant an unregister returns; with the deferred put, DIAG_IOCSDEL
can briefly return -EBUSY, so they now wait for the delete to take effect.

Verified under KASAN on x86-64: the race faults on the unpatched kernel
(and panics with kasan.fault=panic), a benign serialized control is clean,
and the patched kernel is clean across repeated runs. The user_events
selftests pass on both kernels with patch 2 applied.

Michael Bommarito (2):
  tracing/user_events: fix use-after-free in user_event_mm_dup()
  selftests/user_events: wait for deferred event teardown after
    unregister

 kernel/trace/trace_events_user.c              | 39 +++++++++++++++----
 .../testing/selftests/user_events/abi_test.c  | 24 +++++++++++-
 .../testing/selftests/user_events/perf_test.c | 26 +++++++++++--
 3 files changed, 78 insertions(+), 11 deletions(-)


base-commit: f24ca6729076623c9a0547ecc71e4fc1c4b65c3c
-- 
2.53.0

