Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794552073;
	b=BeiMZxVtky0flMXAT/NxekGD5ZW8ufnrdbnzwdFtdPzYHdyDiqID1uqRlGn6dHiMTPdD
	 UhS6ftbr62CMywErQLEt8yZ9EENcLq52mv869Fvq0zBm3DFBOe9w1wovHtkAj9ez3BAGf
	 osqE3g2+obcAN4P1nOaKAjVTHDhpkvQhL+5IpdE6hASmXXpntNgO2q/3O71ysff24HkbE
	 yKjPW4qGQEfGC+zX3Wm10zDL1fdU3ZUvVikgdIFG/WT6IqHGMa21Z41yzVwNjfGm6qtqO
	 2ScdO42kQWXwaqnQK6+/onq3QU9+sfgFjsgUuRa2syFHohmV+vLvzwRozrY49wEfe/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794552073;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
	bh=0gKedmemQ1u4V+B0DJ0y0gXQkOv+yPBdtW4+Ey1vA1s=;
	b=y52oNqX5Z7/HPUABoJA1OCtuSbfkrRn4ywcRsW/99dXAOGC7PE6ldqV6z4vPB4D5GYC9
	 rjKDgfyQQOoqzaCTxntwCsn5bhUguYPMlvEtFZJ0QApM1lmKo2joTfQ6QZ7g6x6OwkEwE
	 uhYDdlvmIyZpIR20VvH+Ru33DEDijAV1IIBy7qGN5RI5JLBLuSXM/e38AIQImfbX2iHlv
	 haIY+6VrC/XovXAIpEdflRiKooM5xzlw6DMLUCfTndliwKA71jhlWP1wRjQjoWKw7XtJU
	 Vph+3PnjvERvc3iUCY8j7a59NXWm3Us5H6Vni2fAeOF7pOF1wittH5QzYe9nC62xalw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V2jRoJ1A;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67121606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 06:41:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67121606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V2jRoJ1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794552071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0gKedmemQ1u4V+B0DJ0y0gXQkOv+yPBdtW4+Ey1vA1s=;
	b=V2jRoJ1AbWTo9o+WGD/nQW+kvzWAHX1b9xDd9ZTGDk7tQme+g6+/qjG+xWvZ6xIV/DZgzp
	SII/OGII2Xw8ZkImmiGxkan3Gn7FVurqag4QmEbDfjSyMTP0gljyr64i5d3+GHQ8M5NAx2
	sU31EC7sST+GOUNW9ANCZ+vFKy7CTpU=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-zJd9YkvwMmKMp6fl3FPiRQ-1; Fri, 13 Nov 2026 01:41:09 -0500
X-MC-Unique: zJd9YkvwMmKMp6fl3FPiRQ-1
X-Mimecast-MFC-AGG-ID: zJd9YkvwMmKMp6fl3FPiRQ_1794552069
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-7035f069837so634904eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:41:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794552068; x=1795156868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0gKedmemQ1u4V+B0DJ0y0gXQkOv+yPBdtW4+Ey1vA1s=;
        b=kHErLB9V/oKsIwRUza19JL4CBk78J9c3vxOg2+j++2DMghoAEuycDpNYBB9P2dXtsi
         h0G9CfQ66ChZLIOnJmtza6mGeSOW33DSTHQt5/lNO0feylt+fd51MrBI/N8vpIxQXn85
         1a3RvQnKqxGk2BhJ7dgPLP+g6o+X+yXYIQy3RwKPxrUle/cmiB7bMPdwvObWkwKT26Nx
         10MAcxuyicx9IyO1D0cPRzWzd5NPBX1MsWGCgCJiEE3vt0V3UqLvh8MdCKj5tF3YJRxE
         4UG989543stehA45xd7UAS9kvgNfaJX3i+ZwlOfNDkaI5pXWwS2wQBXm5/1il9H3eUr/
         dtEA==
X-Forwarded-Encrypted: i=1; AL+hErGtr6p9c1qA/Hnz3lbJUujUw+lZGAGtHNxY8bogFddpcnBvIJkPE3RJ0Wdt/8jy5Y0HKc9FqhPL1RRkgmGFw02kPuQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iHUBVQNAeKTuMMH3aUc0MyT9IRdNdwgmiHe6R/igfEWuMWa/v
	fJSYKCJr34mTQei2eW4H48Zc1ApfLrBN89lnyFqPqA39j/y/CTHfl4uAZpc+1umWvnnMoTEUsG0
	jRynnlYQ09/XvG/fJdjUEyHWGuMGN7zwSKq/nZnlPMQDdCSfT1HawBy8+Ms2sG1F4776O/wT8Kg
	==
X-Gm-Gg: AYBFou2vP7brnn79/8LjK4FHxzZGZ4yRkdVIdJKzRLBhO/76Dep6SBqMv6KeQhTRThI
	5yynm6Y4ncBzJ6yBMs2hc/2gmdxI/o4OK8BBQzFN5COPsbG7ObzuvJQCgGrfzpvOm0ffhufKjG7
	zJWN2tWjC2teGbfdNEKLEFISD3JNdMCj5C88hJVyOAB6iPm1PWKQOQRXpK0r5ZCyoj/4BBQe9NA
	CHKSvjTa+t4VzKeObCbyn56R1/Era8joR+3rKY3CMYsU/kqHmkxUH/IJLgG2BH0hhBmBp9gxjEW
	gwKWMBHvld5cb/AmjEubpxm7HY/LSSNygYz/Jbf0bp+Jb0kDP3i8U3kyy3mJkcRo6YjiaBfMU33
	+ALrEKzIBHE6npsggUvYYOM7cyiUHYg/IG7yXw2QQfPzdU380vVFfKJl3kLwmP1qW26mSzah7vL
	vg4dtLRjdemLa1K0Rp4uY8QE/a0XZ9
X-Received: by 2002:a05:6820:4306:b0:719:150a:4369 with SMTP id 006d021491bc7-71ab508c7b6mr860832eaf.50.1794552068548;
        Thu, 12 Nov 2026 22:41:08 -0800 (PST)
X-Received: by 2002:a05:6820:4306:b0:719:150a:4369 with SMTP id 006d021491bc7-71ab508c7b6mr860826eaf.50.1794552068139;
        Thu, 12 Nov 2026 22:41:08 -0800 (PST)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862881a965esm1643339a34.25.2026.11.12.22.41.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:41:07 -0800 (PST)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v7 00/10] tracing/osnoise: Synchronization fixes
Date: Fri, 13 Nov 2026 00:40:53 -0600
Message-ID: <20261113064103.3041704-1-crwood@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cci7MXLiCr68qhQXCKOmqgtpS9SNSgzrumSrKl1IQSo_1794552069
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Various improvements to synchronization in osnoise/timerlat.

v7:
 - Fix temporary build break in patch 2, with a change in patch 1
 - Other Sashiko-driven updates to patches 5 and 6

v6:
 - Revived the "Always check OSN_WORKLOAD" and "Split out per-cpu
   variable resets" patches, with fixes, to address minor issues raised
   by Sashiko
 - Other minor Sashiko-requseted fixes

https://lore.kernel.org/all/20261028220120.4005187-1-crwood@redhat.com/

v5:
 - Removed "Split out per-cpu variable resets" due to Sashiko feedback
   about races with NMIs and other tracing hooks; the main motivation
   for that patch was problems with osn->sampling and tlat->thread,
   both of which are now explicitly cleared.

 - Fixed some patch shuffling bugs in fd detachment that were revealed
   by dropping the reset patch

 - Added "Start all eligible cpus from hotplug workfn"

 - Removed "Always check OSN_WORKLOAD" which is no longer needed after the
   hotplug workfn patch

https://lore.kernel.org/all/20261024015614.3095251-1-crwood@redhat.com/

v4: fixed a problem with the v3 fix spotted by Sashiko

https://lore.kernel.org/all/20261014220759.908839-1-crwood@redhat.com/

v3: make sure osn->sampling gets cleared on stop, even for non-workload
osnoise (reported by Sashiko)

https://lore.kernel.org/all/20261014022640.695786-1-crwood@redhat.com/

v2: addresses issues raised by Sashiko, as well as a few more problems
discovered in additional testing.

https://lore.kernel.org/all/20261010022338.2507589-1-crwood@redhat.com/

v1: https://lore.kernel.org/all/20260824211544.3984835-1-crwood@redhat.com/

Crystal Wood (10):
  tracing/osnoise: Variable cleanup
  tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
  tracing/osnoise: Start all eligible cpus from hotplug workfn
  tracing/osnoise: Hold a ref on osn->kthread
  tracing/osnoise: Per-cpu mutexes and fd detachment
  tracing/osnoise: Reset cleanup
  tracing/osnoise: kthreads: Verify CPU after migrate_disable()
  tracing/osnoise: Take trace_types_lock in timerlat_fd_open
  tracing/osnoise: Print taint message for timerlat
  tracing/osnoise: Refuse timerlat fd open if tracer inactive

 Documentation/trace/timerlat-tracer.rst |   5 +-
 kernel/trace/trace_osnoise.c            | 497 ++++++++++++++----------
 2 files changed, 290 insertions(+), 212 deletions(-)

-- 
2.56.0

