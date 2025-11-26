Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1900331A069
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764153777; cv=none; b=LOB/A5bFuWC8uOZ2MCBVGEnNh28VxWvQ6iY1JVGbB6NUtOL/+4EBEiv5BEGqjNnq/A9zOOdS8nF7WTdP1o939myrfK8OLyEAwiCU6QrgxdrE095JgiMJeiPydxWjyL5Q3N1NLHXDYg3uUSrwZRslA97oWFDaM6fJchgIkWJ8PUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764153777; c=relaxed/simple;
	bh=pDqF5s4vrbC/Dg4bAcr5imqsIfiRqXuxJzWOgabFdq4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WY8GsBj2smi55/a098JG3dQFNy5vkSeyN4/5Ds5XFqy2Jl09/yQTC40yxA1IPbb1WCDkG1ijzI0+GJmdizYrm1N34Forte3JnnqOs0G4GNQ5N99Bh9nz31fVfqQvaMDrKyqShaXr/6YnIV5KbTeTYgX1No9gdkKrnqhjhI/BXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HeAjvyP1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HeAjvyP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764153775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U00YhU2YZizs8S15xLt3KIYDufrMbbTmVOvotNOUfVI=;
	b=HeAjvyP15RbklRNvqvkwGio0SC32SoNkfZcdmEjZgNhT1OAO8ggiuovFObNX2v6qIA9lMc
	JqWcAtX5pxoXIYFw3+uwJc8zW7NzHVkiLWFSNBx6HUGHxYfRoWPks/gzXpywSZQBtDQjEI
	/XCEI9MWN5cF02/s/bxD4/nP/RDyCu0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-yMQtrvPxMMyYz4w3PKC6cA-1; Wed,
 26 Nov 2025 05:42:48 -0500
X-MC-Unique: yMQtrvPxMMyYz4w3PKC6cA-1
X-Mimecast-MFC-AGG-ID: yMQtrvPxMMyYz4w3PKC6cA_1764153767
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE47A1956046;
	Wed, 26 Nov 2025 10:42:46 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.45.226.131])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 36FFF18004A3;
	Wed, 26 Nov 2025 10:42:43 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 0/8] rv: Refactor and cleanup
Date: Wed, 26 Nov 2025 11:42:31 +0100
Message-ID: <20251126104241.291258-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

This series contains reviewed preparation patches included in [1].

These are namely: refactor to minimise macros, including cleanup and
documentation, python script annotations and cleanup, removal of
superfluous assignments and declarations in monitors code.

The series is based on linux-next and the first two patches had minor
conflicts, mainly resulting from 4f739ed19d22 ("rv: Pass va_list to
reactors").

[1] - https://lore.kernel.org/linux-trace-kernel/20250919140954.104920-1-gmonaco@redhat.com

To: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org

Gabriele Monaco (8):
  rv: Refactor da_monitor to minimise macros
  rv: Cleanup da_monitor after refactor
  Documentation/rv: Adapt documentation after da_monitor refactoring
  verification/rvgen: Adapt dot2k and templates after refactoring
    da_monitor.h
  verification/rvgen: Annotate DA functions with types
  verification/dot2c: Remove __buff_to_string() and cleanup
  verification/dot2c: Remove superfluous enum assignment and add last
    comma
  verification/rvgen: Remove unused variable declaration from containers

 Documentation/trace/rv/monitor_synthesis.rst  |  44 +-
 include/linux/rv.h                            |   4 +
 include/rv/automata.h                         | 132 +--
 include/rv/da_monitor.h                       | 885 +++++++++---------
 kernel/trace/rv/monitors/nrp/nrp.c            |  30 +-
 kernel/trace/rv/monitors/nrp/nrp.h            |  22 +-
 kernel/trace/rv/monitors/opid/opid.c          |  40 +-
 kernel/trace/rv/monitors/opid/opid.h          |  24 +-
 kernel/trace/rv/monitors/rtapp/rtapp.c        |   2 -
 kernel/trace/rv/monitors/sched/sched.c        |   2 -
 kernel/trace/rv/monitors/sco/sco.c            |  26 +-
 kernel/trace/rv/monitors/sco/sco.h            |  14 +-
 kernel/trace/rv/monitors/scpd/scpd.c          |  28 +-
 kernel/trace/rv/monitors/scpd/scpd.h          |  14 +-
 kernel/trace/rv/monitors/snep/snep.c          |  28 +-
 kernel/trace/rv/monitors/snep/snep.h          |  18 +-
 kernel/trace/rv/monitors/snroc/snroc.c        |  26 +-
 kernel/trace/rv/monitors/snroc/snroc.h        |  14 +-
 kernel/trace/rv/monitors/sssw/sssw.c          |  38 +-
 kernel/trace/rv/monitors/sssw/sssw.h          |  22 +-
 kernel/trace/rv/monitors/sts/sts.c            |  34 +-
 kernel/trace/rv/monitors/sts/sts.h            |  28 +-
 kernel/trace/rv/monitors/wip/wip.c            |  26 +-
 kernel/trace/rv/monitors/wip/wip.h            |  14 +-
 kernel/trace/rv/monitors/wwnr/wwnr.c          |  28 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h          |  14 +-
 tools/verification/rvgen/rvgen/automata.py    |  20 +-
 tools/verification/rvgen/rvgen/dot2c.py       | 111 +--
 tools/verification/rvgen/rvgen/dot2k.py       |  26 +-
 .../rvgen/rvgen/templates/container/main.c    |   2 -
 .../rvgen/rvgen/templates/dot2k/main.c        |  25 +-
 31 files changed, 834 insertions(+), 907 deletions(-)


base-commit: 663d0d1af3faefe673cabf4b6b077149a87ad71f
-- 
2.51.1

