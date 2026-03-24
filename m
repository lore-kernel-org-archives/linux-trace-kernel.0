Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEC73C5DB2
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 22:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774390423; cv=none; b=hJw5eR2WAGou+rgiFrXzQgjwjhQt81nLfxUlqGvL0bJGr/6kQiPdokYUBZIg59vplNKs6aztddyGsXNYQm6l5I51PCzLjW0M9Lx9LYrY2eu+uVEWFYkDiYjk2O5HFyhYaeOPUcPKdEwtwmsKxBJrn388qIUhluRBMkFfxp79L3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774390423; c=relaxed/simple;
	bh=GIb9Vsbf0ApRi2YdZPpGpSbwAvhIWfK+4OjojOsP30M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eWq3OplSxDERcfrrlKX6Q1SVuE+A2OT4Kr2RWmHKMEiFmMLw42Lo2n+oBFxGuSt4kQ6XA47HA4IEtMlTQi9AoLS6OzlsKz5Lyu5bTIi1pQSFZJiKGs8rwtdIx3FVjFKZvbDbfHDNbTXX6J/474xMsLk+5i6NkNaQytBhsIGryRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YavN2gQj; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YavN2gQj"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40ee9b945d5so1299452fac.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Mar 2026 15:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774390421; x=1774995221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gYvrLn8elSJN03Kj+buzJrR9/VujdS1ptlfGYshbCDI=;
        b=YavN2gQju/TO5wO74EjguwAM74c7+AavSDkaMEQrNQtiv/OgBH+r2pRb9cchfj52mY
         h2ZG6NCO4QtkoDF/h1jrYldvGeDIc6dPKEAfsqWMOFSCT6YSekMgP906rTcQE837oit0
         g/8u2P8d5x3WqVuIC14xgcXD2p7ne+HtPoYj9lwWT9n8EnOo6xnP+A9ejEag76vZBWgd
         Jfgo10XAlbtOUKdIbCINsm6OK1Krbec6T/VvV3NGz8RM8jwPK6FRTUVMO2TvE3rcSAA3
         uNQ28M42Vx0AoA7AQwA5gJh/4PJM33clDRDcqIXRVEVWF+gOjpdyLPWI77JMra3KYOSC
         SJjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774390421; x=1774995221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYvrLn8elSJN03Kj+buzJrR9/VujdS1ptlfGYshbCDI=;
        b=BaGnudGATlSE4qVeif6pD6K/vN/nevnHU7H+hfFjZ4VTGWZ98mk3J2ZEo3Iz5iEQBS
         mcGbGCe+vyPl7bRdyyRz7NpRUjPaYPqmM8lZR35ixzUGNYiytSAGDVjWdAXqagrVtq+x
         jGKj5T01LXdP+gDUagyGySS40f2aUeJn+X+it2NlflPWgVDOsMhffB5Za30yD+X60y+m
         4Ww2R8K6Uzp3xEQjGXs0yzniee/WO6FzQr3VcOHacY8p+3u+k+1UM5AZWL13JIdzmV20
         JisVSH0qkiROuUtvg7lBU+IRliFIe8iHJUHErmTkFlQQypf6SNTel7YMc6864JPD8GPu
         /bKw==
X-Gm-Message-State: AOJu0YzNf3+nWhRqLPiiKQlTsIybBdW/uCxXlZfElVg32o/s//Sof3Uf
	V8rmZWvfsrv4F1iAstc7T2o2CzlKF1JQ+QYUDce9j5azdLI/Dbuh6K5cSRjXDtDi
X-Gm-Gg: ATEYQzysgkmTKEhmi5UpnAmRG73K6Jfp8PXJqpnGPKbSQvzL1WNo6TXExodcWb7scY8
	gnOaLGf3r4Q8NO8Gg0+VvpdqVE3rCJrF67mJS4sbv5cdmbJ24gmR1A5pgUlzmku/cJyNv3ogvF3
	FcZPrwaWMGkdKryblOHVVr89fu4EZ8Z1Nn2s0FAhiXfukFAbKSYbVqCLtc7v+gqmwgHDM+CD4zL
	bQTQBweq43VGOzGZpABRdI59sSyxSsYwQLiR0acN60TD6j3kxidJL/TbUXL5KbQAVNOgonAWedy
	0UGBS+GHLRxWEDzPIlXSI5vh1ekUTzSbJ/DY+GgWUkU7l3OYTxY/XRQ16nJ1+E7UIc9bkKMxYeS
	gDQlVuzwweQLDSG6gpd0/cX6SoypjrXqNuTeS8Eb4hfZhtOKfSopa1PHKFJLI+HIQZm7c9foHTe
	jG/81rgAps7og3B8sznunrlKuLUdzZDDYw9W+3iiz/VeEat/9aJCQ576ABoqpXHxAeEitBJI4/z
	cjF9LaBjcZ09O2oeCIt0OgYZE9Zs5uNJXu83VNXxg==
X-Received: by 2002:a05:6870:14cb:b0:41c:d38:f3b0 with SMTP id 586e51a60fabf-41ca70c277dmr756536fac.42.1774390421116;
        Tue, 24 Mar 2026 15:13:41 -0700 (PDT)
Received: from Atwell-Laptop.. (108-212-132-20.lightspeed.irvnca.sbcglobal.net. [108.212.132.20])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41c57bdf2b0sm8966606fac.7.2026.03.24.15.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:13:40 -0700 (PDT)
From: Wesley Atwell <atwellwea@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	tom.zanussi@linux.intel.com,
	Wesley Atwell <atwellwea@gmail.com>
Subject: [PATCH v4 0/2] tracing: Preserve repeated boot-time parameters and drain deferred trigger frees
Date: Tue, 24 Mar 2026 16:13:24 -0600
Message-ID: <20260324221326.1395799-1-atwellwea@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 preserves repeated boot-time tracing parameters by appending to
the existing parser buffers instead of overwriting earlier values, so
repeated command-line entries and Bootconfig array expansions work with
the delimited formats the parsers already consume.

Patch 2 fixes the deferred event-trigger free path so queued frees are
still drained if the cleanup kthread never comes up after boot.

v4:
 - drop the kernel-parameters.txt update from patch 1
 - move trace_append_boot_param() into trace.c and keep only the
   prototype in trace.h
 - capitalize the tracing patch subjects
 - rename trigger_start_kthread_locked() to trigger_create_kthread_locked()
 - change the failure comment to say "creation failed"

Wesley Atwell (2):
  tracing: Preserve repeated boot-time tracing parameters
  tracing: Drain deferred trigger frees if kthread creation fails

 kernel/trace/ftrace.c               | 12 +++--
 kernel/trace/trace.c                | 31 ++++++++++-
 kernel/trace/trace.h                |  2 +
 kernel/trace/trace_events.c         | 26 ++++++++--
 kernel/trace/trace_events_trigger.c | 79 ++++++++++++++++++++++++-----
 kernel/trace/trace_kprobe.c         |  3 +-
 6 files changed, 131 insertions(+), 22 deletions(-)

-- 
2.43.0
