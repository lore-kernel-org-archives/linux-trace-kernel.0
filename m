Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01628CF5F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762961139; cv=none; b=aKv41Rsik2wz6BcV0XI03+Hz4JjUx6t6vozg2q9EHJfvs2hZYy0lJN+Ev+ZBM4xTAPQbfP3HqGOB1OaKt9b3VdCLLgDjmqt+oIMdPSHAEpeU5dvXM3aCErByuMNmoIhTaEZ+PPJyAYoit0MsKG8hxS5IOBUiWcFDnnjkFZCon5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762961139; c=relaxed/simple;
	bh=hIlbGlcIYFOlEj82NKOpaOaAnPhcR+e/jBqkVZam/wI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Q7pzXQFdwsB1Xl2U5sA7bhCDSh+DJNAAMPoA7kQdsaTZAcit9UpYR+GEbllMao9yoPymiGCgKA7bphb6QrhyIjCtW104qowrmn9bQmFy91N1Y39l6tyxfvIR9IejJh9lHXHaOPVUXpCPRBJavNvKcVdtOaB7ZvjcS9MXv4+Vu+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QEpaC9rY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QEpaC9rY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762961136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pSW/Yc+wEQijlEL7jfxDnPeAQ2zhUWulmV6d+AWSPak=;
	b=QEpaC9rYmZf03q9G91pidpxFIvvQN7HPCLDA6sDY7qm3xOpsQXzlGy9VJEd3zQBoxYgJLP
	JLKsVTCVU6JMqyO6jQ7hS+6kq8O2xT7kYXdmtdA5DdvpmlORghom2yAkuMUrBDLpeQyjog
	IO7TJLLAp+oNNVPvouG78jc+LJTLkZM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-AWZ-UvSBNuaQnoWecN4slQ-1; Wed, 12 Nov 2025 10:25:35 -0500
X-MC-Unique: AWZ-UvSBNuaQnoWecN4slQ-1
X-Mimecast-MFC-AGG-ID: AWZ-UvSBNuaQnoWecN4slQ_1762961135
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-433783ff82aso27939085ab.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762961135; x=1763565935;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pSW/Yc+wEQijlEL7jfxDnPeAQ2zhUWulmV6d+AWSPak=;
        b=BcZVu//Hh2sYQL1KvUVQPFb32oLPGc06Z+BbvdfjfQp3SMPRDTZ2W4wrc39JTVROa0
         8d1B2eHsa3BoUfj0HQ36zytoJ7w75y3VOH3jhNIxsVGgciQI86RBynNwlLQyi9GFecXl
         +YYUQByxEUcNEhVzWcRWh3XnScN/C5jiJVyYFu5KXSLyUK/8dRqpB1BubUPdmQP3yREU
         DEs6wnbc4bSkB1VP1RiWdHNn3+zjl7mFDTuMi2Y4BUw3icxEKgXv0Jm/0OcuWijfQsGI
         U/ZA2gFHccTo8F6VcK4klPXllSjyYQZmOUlcPFIn4ee0mO6oeDGihehdVR8BC9UU0350
         ifWQ==
X-Gm-Message-State: AOJu0YyTLHfvttm/yH4ubQqqmMakOJUJxDlkyiJcpGU/NXLjS3g+9BwK
	TIor49yL2LD8ESgx9LJCdu9C/VL/BdOEiAagBoMp9kBNsA6BXq4M4PKPqSCtSTSo3Rjc1cnnLz3
	O4JEa1eTN2+WnAAjyHVUFm4qxj+rkqxJ2kmAhCtje3OTxMdwkHvzEa7E+84iQWcR/cDSZ4r4/Jg
	==
X-Gm-Gg: ASbGncvf773fOAUeAfYD8fJnHVNM/xuwxCJM9RWlFaFoAQ+LFtwtJJrDfMCegJA9ykV
	IbOoGec6mDhZBlSWUjbazsmSkVRKS6+ocg8XCQZMnZSvJ/FjbnvPnvX3A8nO9xPy90LEm/7FG5O
	H8zRJRKTPbMCsbhl5xFF5Sqc9u4ONDFNDAlAteMM9JGiDWUiHkuYUR+BLBSReHQYa8uOg2X2l0B
	e97u7tpjxHl7yWoRQBVsw7v0jPvmqCuIX0S1CW0oHWbAx+h+TWC+e1o+1MVxmv9IE9OKLAgdp4U
	UnpFWwwldK1Y2X8W+OmSTJIRZgfJRTYk5Au0+NQyOl/InAb0KKLBwEc1meJUUW9yhwLS9wI06fZ
	rf9gGz/Gq86e0eGHi022TGCt0KdWmAcs=
X-Received: by 2002:a05:6e02:1646:b0:433:78b8:9456 with SMTP id e9e14a558f8ab-43473d0ba3emr43436605ab.2.1762961134895;
        Wed, 12 Nov 2025 07:25:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFk7QNigbBZWYI2smskpaw+yeHl3g3llYYspv4bwprWljONLuoZaSkpNL59+PFeECG8BN2kQ==
X-Received: by 2002:a05:6e02:1646:b0:433:78b8:9456 with SMTP id e9e14a558f8ab-43473d0ba3emr43436305ab.2.1762961134527;
        Wed, 12 Nov 2025 07:25:34 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-4347327f820sm11680325ab.0.2025.11.12.07.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:25:34 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	John Kacur <jkacur@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Costa Shulyupin <costa.shul@redhat.com>,
	Wander Lairson Costa <wander@redhat.com>,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH 0/5] rtla, osnoise: Fixes to address intermittent test issues
Date: Wed, 12 Nov 2025 09:25:24 -0600
Message-ID: <20251112152529.956778-1-crwood@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uUOQk7gfrZqhb8W6R7napOBR27BGxVPklypJr2Ls79Q_1762961135
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

With these fixes, I'm able to run the tests in a loop overnight with no
failures.

Crystal Wood (5):
  rtla/tests: Don't rely on matching ^1ALL
  tracing/osnoise: Dump stack on timerlat uret threshold event
  tracing/osnoise: Array printk init and cleanup
  rtla/timerlat: Exit top main loop on any non-zero wait_retval
  rtla: Set stop threshold after all instances are enabled

 kernel/trace/trace_osnoise.c          | 46 +++++++++++++++++----------
 tools/tracing/rtla/src/common.c       | 20 ++++++++++++
 tools/tracing/rtla/src/common.h       |  4 +++
 tools/tracing/rtla/src/osnoise.c      | 17 +++-------
 tools/tracing/rtla/src/osnoise.h      |  5 ---
 tools/tracing/rtla/src/timerlat.c     | 29 ++++++-----------
 tools/tracing/rtla/src/timerlat_top.c |  2 +-
 tools/tracing/rtla/tests/timerlat.t   |  2 +-
 8 files changed, 69 insertions(+), 56 deletions(-)

-- 
2.48.1

