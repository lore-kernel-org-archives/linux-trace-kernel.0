Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00193FA5F2
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420332; cv=none; b=gCQQQ3QNVljE0lgf72EL5UDBsSAZhZlxYIiaEMxpNfozXVziB4ZDVaMqjsdbpL+Z4+37A/IHfTdUOVvn6oqb/WoqppVsoLb0RciaAQRtbX51rrM7dokqMoOD742c3PiQbk/ptdZrScB9NE4ujCWxpKpY8t2KUpp01P6F+A1gWqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420332; c=relaxed/simple;
	bh=gBAloulHckL2ywMW6AzMYFT3Y2wMFq0fLNgW8kT66qY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hnAmDBwSITNjq79DBPK9c80CEHy2zrmB2zeT7OywCm8v0LqNgTZobcK0VCSDLtAklXVF2z5V/Mzr5FayMhZzgic+HHUvLnLIRxWWSUdYtand8ybCqGvw/sFCt7+riVET/gyPFIpmrQO15cISt3WcbX4H5WVtxxbTiBDn2g+zu58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XdVGLFXt; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XdVGLFXt"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso21943955e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780420327; x=1781025127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwLZpX6/tc119NO6A9kD9//0DDd/fWjU2sDBvSy/SlU=;
        b=XdVGLFXtmpVw9XHaw7tbq7dopd5b5UF58ldGdQVKtg6rP/+i+NdaULLsFTGo2kS8HX
         em5xiHS0/DOL9qiZGgIN2ZzPH4TvVNbm1i3dAroHb7ZjG0ZGbRGPGEoFM7h6bSnI3Y9s
         +QBtV4ZbRakbxiQCTP67Yh27L4pzyX4679OSoyRbiGzXti7vgfYXoLUpd0KUd/VHnI9+
         kolzN3IxgbTYIwMVvubeAg2ZsXmi5EQpKrfDzRSvD9i9W4Z0Ddj6iXKgEz20puNUOCth
         UAquNKrSMed+snop1Rk6FzYjTLPrkktyZbiUju80auktMRU+i99sIjk4RuGCaDBOzECx
         8I3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420327; x=1781025127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hwLZpX6/tc119NO6A9kD9//0DDd/fWjU2sDBvSy/SlU=;
        b=YNEh7v+Mz1hEovryqlUi2liWc1zNIkS9JqKfrHUR7qMUrTnYPDzJ1tJs03Ioq8bfx3
         0W2wq2nsOE7R5wPyvn1+qDe4k18CMb792J6lnQryw62QMrph+ylcfPysBsx0ATcrnjAQ
         Vh9mT75MKZSHAJgfcwcYOIA05G3Gsx/wZQzpMkKpfLCMJZsFUpHJcrv4E7Dz1A5cM6u9
         a4lrXCZRb6qJDme9546tBBZmO1QtjUoDSPoo4+LrVtI9FS8s68f1h+iTBhcX9E17VrrR
         aX7RQM3YG2885N0i3CYTsrYczqLwmKl/PIvXiX6ciZHyCeTbFPIV32fimRpIJmX+N9uw
         So+A==
X-Forwarded-Encrypted: i=1; AFNElJ/Y+yQRFQJEwnwNvO4xmVCHINZQHHPGo/2tep6QDZiQDi3DgfPavzbZxJcv4YzlCVSATcR1wceWe71QPijXXX2hBr4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9lsYVL0UeAICywzDs6Gge7W00ri6oij76tqW2LCYXg3/VbW3O
	ZnNKrfKwqC4X/wyeahE+QDW063CcbjkBfFJXB/lrs3jWGTHnBemENwHwNx2Ra9Ip7brK8Hd8pB7
	6AnUFcYtm/o/v6mO2IkIhQQ==
X-Received: from wrxa6.prod.google.com ([2002:a05:6000:1006:b0:453:508e:615a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:35c5:b0:490:3b87:be0e with SMTP id 5b1f17b1804b1-490b50be585mr9813985e9.29.1780420326700;
 Tue, 02 Jun 2026 10:12:06 -0700 (PDT)
Date: Tue,  2 Jun 2026 18:11:39 +0100
In-Reply-To: <20260602171146.2238998-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602171146.2238998-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260602171146.2238998-8-vdonnefort@google.com>
Subject: [PATCH 07/13] tracing/remotes: selftests: Prefix hypervisor folder
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Avoid interleaving run tests by prefixing the hypervisor folder.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/buffer_size.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/buffer_size.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/hotplug.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/hotplug.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/printk.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/printk.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/printk.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/printk.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/reset.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/reset.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/trace_pipe.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/trace_pipe.tc
diff --git a/tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc b/tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
similarity index 100%
rename from tools/testing/selftests/ftrace/test.d/remotes/hypervisor/unloading.tc
rename to tools/testing/selftests/ftrace/test.d/remotes/00hypervisor/unloading.tc
-- 
2.54.0.1032.g2f8565e1d1-goog

