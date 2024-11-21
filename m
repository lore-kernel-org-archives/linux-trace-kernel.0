Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352C827447
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 15:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201252; cv=none; b=PjEPox/VVZ8eRMFuFCOdkL228yw+FzwrzMRC97kE8r/SEaTe/hXS/1DO8NUgpEHinqaFm525BLYkS7xQPGFJy+dRTb0Q4vfKBa4uV0hBgO5fKCWR/q7xIEHmSyVDrD98JcXjYHW9Xi135GpAE8ueh9eOyR+r+EcmaAIUIymlBYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201252; c=relaxed/simple;
	bh=vWAVyZ1Qpd2TF3q7Kuf52puyFtCUmA2bpiXLbuZLfpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ImmUsYc0H+A+ZShp9Og/nNLGbWB6u95NEZeESPoGpbGzv4Yed6zO2+rhy0G+cxM3YJ4QyOrPIlMnCkSrmJaA5ZBHFHOVLwLY7XFbsD3QXR0hCs6DpH6/P0xVJHuqj+ddQ3plbOvMv1T6kcBZZ8FO+BFNvNmYEXpI/aPY8g2cx/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O6vFewH3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6vFewH3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732201250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=luuZg0mNRVeYLGmqIko3blyVtSbkzA3a9WF2cYc+YUY=;
	b=O6vFewH3ov9m+ARKsvRe5FEaxiF7YSlXuGK4TZrfpjNKVRf+9GNTQIDgCLq+bp4jNGssl8
	y4hQZe4J4ahl9tqOHut31r/A3A5v8CLGT0EtLpzcZ7+cGu+uoIekEtNCdqxsOdDNOneI1b
	BnC/ybHXETCOInuDG0vWfB7DGUQzySg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-z4xeZ0ekNHC4Q0j4caQYCg-1; Thu,
 21 Nov 2024 10:00:48 -0500
X-MC-Unique: z4xeZ0ekNHC4Q0j4caQYCg-1
X-Mimecast-MFC-AGG-ID: z4xeZ0ekNHC4Q0j4caQYCg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 769211955F77;
	Thu, 21 Nov 2024 15:00:47 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.194.245])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4576B30000DF;
	Thu, 21 Nov 2024 15:00:43 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH 0/4] verification/dot2k: Improve template management
Date: Thu, 21 Nov 2024 15:59:53 +0100
Message-ID: <20241121145957.145700-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

This patchset implements a couple of options in the dot2k command and
makes the templates a little more robust.

The base is linux-next.

Gabriele Monaco (4):
  verification/dot2k: Fix template directory if not installed
  verification/dot2k: Unify main.c templates
  verification/dot2k: More robust template variables
  verification/dot2k: Add support for name and description options

 tools/verification/dot2/automata.py           |  4 +-
 tools/verification/dot2/dot2c.py              |  4 +-
 tools/verification/dot2/dot2k                 |  6 +-
 tools/verification/dot2/dot2k.py              | 41 +++++----
 .../dot2k_templates/{main_global.c => main.c} | 50 +++++-----
 .../dot2/dot2k_templates/main_per_cpu.c       | 91 -------------------
 .../dot2/dot2k_templates/main_per_task.c      | 91 -------------------
 7 files changed, 54 insertions(+), 233 deletions(-)
 rename tools/verification/dot2/dot2k_templates/{main_global.c => main.c} (50%)
 delete mode 100644 tools/verification/dot2/dot2k_templates/main_per_cpu.c
 delete mode 100644 tools/verification/dot2/dot2k_templates/main_per_task.c


base-commit: ac24e26aa08fe026804f678599f805eb13374a5d
-- 
2.47.0

