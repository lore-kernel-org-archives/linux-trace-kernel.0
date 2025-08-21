Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9666D1A7264
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Aug 2025 03:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755748707; cv=none; b=IucaGsjyBHdqm5EosUs6wZKk/Awr/WHwuY3LU/CowL5+6+k6zdjQDetzvvgJXQlqd8Oi38aZP5kptSNu315e3z421/deDIzss1TxyZpw6GVsKi1O3VHkLdA8aY4tSn8GkQFp+U+3mxqw5Q65/ehGc/DP/0Nc0viUajU/kTD22wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755748707; c=relaxed/simple;
	bh=6c5tfL3miIBcZjR402YXNfdNND7jy+jD/KXuvoDSMRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=KIktsJZ3UBmjHfuPOmdOvKHaW8Tt6QeVxK7TaqDptI5NnJ7VxfnjFk1eIZ2Nf0WjWISKxZDmZJnTsCoDRmK1PYSv0y8zkb+xZpIeJaGkmV/Reyo6Qw6ccdZLynpWwLuyoYfGJsHLqSAh+hxSg33s/Wxp/cGm6dQNA4jTalXQAAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3rkgr7Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3rkgr7Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755748704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jYT31GChK7rcC52RL1S/uTdduA8lLeuMD8oNtU6XJSE=;
	b=B3rkgr7QdduWw/CoyWAp1ddDCtObX1B7+vw5ywpsqYxwERqN5Ggmuvnuu7yEa8CYDNRrS0
	zWzdxavEQPp0+0ZyInUP8+yparj8m9UOUzoMQv8/ABXf0/REmwzuBrVCGS08WhlglQ6QYi
	onSHgG5mjCiN08R0oCFiILugXWbJ4XE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-1Fej3RYvOqGxdbOfTPC9VQ-1; Wed, 20 Aug 2025 23:58:22 -0400
X-MC-Unique: 1Fej3RYvOqGxdbOfTPC9VQ-1
X-Mimecast-MFC-AGG-ID: 1Fej3RYvOqGxdbOfTPC9VQ_1755748701
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e933de385cbso1266111276.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755748701; x=1756353501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYT31GChK7rcC52RL1S/uTdduA8lLeuMD8oNtU6XJSE=;
        b=WZC0arYDAhPVj+qafQetUzP4VkuiCLCQAp5TGTfabXIZTBtq/mCZ5anL+4kpaGtYZu
         qIqGdoWWWRZfhOzG/SnpIshRSzmuUQxKo8+T3ANflaflCtIYgAJhI3yYBGsNNYHUJucE
         OxvloIDByxVVhWigSwieYSH3xVrX/fBLlBtXnmSS9MLsEkESrBlJIx+XR4E+PbdKOXFY
         0r23VRPvk8p/kC4/XgW9XFZBDaMiYXUt2y3LDwM1fZOLZGCdzeCXGUwjJ1mChDP1iGMm
         eSD97FHFtMhEgcotiGMSzKsCYDZUW/zuyn8AogxlNkYyPgdwA/f4F/kda7bPnLzqwfdt
         pcUw==
X-Gm-Message-State: AOJu0YxPo00UFvCtFqkkYbX6HnOMSEh68vl10JbeqoslR/T7BFESuSax
	WcO12bTdlDKQXOZUbrRdzHnfZXnTckhOymXF5zeB14RZA36/jIPavQGCaYQyYowPv8kTOXEFe6b
	7t2U/LFrQBRQX8DsS9iK1S23silEbTn5IkFCDfdgjeZBrXW+CRpRbHPPjH9pNIiklffKdFxG1pA
	==
X-Gm-Gg: ASbGncv+UTHhv0JOrl8dKEJI/pv5z6qAxIh/ew8TboU4POoIrfyKhwq0vs5zs/eHihy
	PWw5HB5AZbAWkyEEVWHiWVNixyYgCn2sDJcbzJAfOeqsHQIXqjtKj2OvVTFeOBX4K4umokVxeAx
	6BN+Fb89rEqbVW9o5YZO4T8pf1Y8Kq8jpaC/rGolmq7wD6A8sEv3JmP2BrO9fEPyYq88E7RntEh
	Prc1ViE6ShE4iNZ8nbuQF8Oz8ei1jnZzL0g7QsmRZcGvwmHX/jqpqFWVDibXMNn6cQQAmzSSgbV
	k2B++PX0SMhT+6V3YHcOvFizylfRywUXyEmtax3loz3i5rTjxGOl5aZ5qyBzaYuA/IAVLXQ=
X-Received: by 2002:a05:6902:15cf:b0:e90:69a1:1785 with SMTP id 3f1490d57ef6-e95089bdcb9mr1425357276.23.1755748701510;
        Wed, 20 Aug 2025 20:58:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV8kYvvZ72fECJP80LGYegslCOyCfgvlEKsYaZeznbj4Rd4sfZ/pmlgu6QUvGfil40VpNa7Q==
X-Received: by 2002:a05:6902:15cf:b0:e90:69a1:1785 with SMTP id 3f1490d57ef6-e95089bdcb9mr1425346276.23.1755748701085;
        Wed, 20 Aug 2025 20:58:21 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e95078a1bdasm385457276.34.2025.08.20.20.58.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:58:20 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 0/7] tools/rtla: Code consolidation and osnoise actions
Date: Wed, 20 Aug 2025 22:57:12 -0500
Message-ID: <20250821035719.137161-1-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BrXEV_ETdXiVcOcgbOgsW2oaE5NIy4VhBXoduooz_wk_1755748701
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Consolidate code between osnoise/timerlat and top/hist for easier
maintenance and less future divergence.

As a consequence, actions work on osnoise as well as timerlat, so
expose it to the user, document it, and test it.

Costa Shulyupin (1):
  tools/rtla: Consolidate common parameters into shared structure

Crystal Wood (6):
  tools/rtla: Move top/hist union members elsewhere
  tools/rtla: Create common_apply_config()
  tools/rtla: Consolidate code between osnoise/timerlat and hist/top
  tools/rtla: Fix -A option name in test comment
  tools/rtla: Add test engine support for unexpected output
  tools/rtla: Add remaining support for osnoise actions

 Documentation/tools/rtla/common_options.rst   |  61 ++
 .../tools/rtla/common_osnoise_options.rst     |   8 +
 .../tools/rtla/common_timerlat_options.rst    |  74 +-
 Documentation/tools/rtla/rtla-hwnoise.rst     |   2 +
 .../tools/rtla/rtla-osnoise-hist.rst          |   2 +
 Documentation/tools/rtla/rtla-osnoise-top.rst |   2 +
 .../tools/rtla/rtla-timerlat-hist.rst         |   2 +
 .../tools/rtla/rtla-timerlat-top.rst          |   2 +
 tools/tracing/rtla/src/Build                  |   1 +
 tools/tracing/rtla/src/actions.c              |   8 +-
 tools/tracing/rtla/src/actions.h              |   2 +-
 tools/tracing/rtla/src/common.c               | 345 ++++++++++
 tools/tracing/rtla/src/common.h               | 154 +++++
 tools/tracing/rtla/src/osnoise.c              | 101 ++-
 tools/tracing/rtla/src/osnoise.h              | 114 +---
 tools/tracing/rtla/src/osnoise_hist.c         | 369 ++++------
 tools/tracing/rtla/src/osnoise_top.c          | 303 +++------
 tools/tracing/rtla/src/timerlat.c             | 210 ++++--
 tools/tracing/rtla/src/timerlat.h             |  55 +-
 tools/tracing/rtla/src/timerlat_bpf.c         |  22 +-
 tools/tracing/rtla/src/timerlat_hist.c        | 642 +++++-------------
 tools/tracing/rtla/src/timerlat_top.c         | 568 ++++------------
 tools/tracing/rtla/src/trace.h                |   3 -
 tools/tracing/rtla/tests/engine.sh            |  22 +-
 tools/tracing/rtla/tests/hwnoise.t            |   2 +-
 tools/tracing/rtla/tests/osnoise.t            |  29 +-
 tools/tracing/rtla/tests/timerlat.t           |   4 +-
 27 files changed, 1394 insertions(+), 1713 deletions(-)
 create mode 100644 tools/tracing/rtla/src/common.c
 create mode 100644 tools/tracing/rtla/src/common.h

-- 
2.48.1

