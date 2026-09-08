Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5851D51E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Sep 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788858584; cv=none; b=O30mwnK/PVmuzicJInKsRaCa3M+vJB5DHgjCnctVDVjDstPb1rXzCdpJJ7PYqvU8SToYcGd5+GgWt9XMZ/GjaozYb2Vrm8nHb/E9ETi0xTf4a5CtvbqiTmXQu9Tfdy2D2iGk1FHk+trmwsCsiCQKp4bkQxVBuDIjSDfiahg/hVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788858584; c=relaxed/simple;
	bh=4LfdXx5pSz3+/qv8Wpm0//tiA9UTyDM0EU0mGCC5atU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fGcYxhg3w7kP9kfUxMHCGTMQ/wTHrQfCzESOB2rzwwFthlGyv5wwARCxTBtsKeOWm00g+DyPfNd99rRO1yMvUU4/iMFxD0g+k1eP8YVrsKtxRvaNc+xA7ApyYbUX0uaK6sHa5JST8+lHuc41UrVsrAKdBVRN89t82VQV9IOjCuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TpKlqb6Q; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TpKlqb6Q"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-485866e0066so2405814f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 08 Sep 2026 02:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788858580; x=1789463380; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DZXq0mou07tGt2Oj42cxj2xkgY9IF9NZexTvOaYs05w=;
        b=TpKlqb6QtVGxIW7+9CayvDnokiDjZmKvovY6qFcrw7vMwXJzV6msiwi57iz3AHmrvo
         oPEvNSFuPRgWC0LjHztlQZy790M204Dpws29+ylhUnWn3RmrPKAp/suujpcUOTT7KI4D
         y64w1hWei44Ck/2Y8AGaSci7RFdipe+sKiWaCnjPWQKZanxQYXuEc6R5V4DyYMjqGUef
         2VIfVaCuZcSWjHz7gLuJR5xJxUctqTXBa2O1HlnZVi9DexcGyV2th/l8zp4s+dofysTH
         JzKJ4/ZcloZ/KPK8ks3ZoHR8cOVBlJFNlaeVdrlymbDa86u5HyAn/jvVel6IOGT/ga5Q
         M3Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788858580; x=1789463380;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DZXq0mou07tGt2Oj42cxj2xkgY9IF9NZexTvOaYs05w=;
        b=nyB1sg//1l7RH/tfQ9FY2uQOZrK3g5mxtjqtoCOcinp86uCc/ySbLKgkeSObXWB9Er
         7wcMYrEp3fhbk90zQ8+tdufHSig5iah2NPHcmCRHLVxZEUvqWXzyQ1A8rmPSi2asCeR9
         +1b+dvYZ7alfWLa4oTiu6gPWnfH9bUEOJ4ImJSLfAJiOm13c3akv+qJslTJwHagHpHuy
         tVvGMdfLFJef2ypDX5Nx74CnfhWRL7pXVa6S0ByGPS7jUiVYXZIBnouKpLXBHd2kx/h8
         MzsnEwugZOUhc3Viig6nVqdeOe1QW5oETA8JZYWBr+hhIc+6TmQaos2TMXQIty0wSE4O
         bxIA==
X-Forwarded-Encrypted: i=1; AKwUvBwlWU7NacUr66tB3Y3Yl5nXvb2O43KjFJQ1pm5xQBzttWxR4EHQguMRDApnZhzXVP7Qa1dEapRrXzCeNDTsWEA434I=@vger.kernel.org
X-Gm-Message-State: AFuF++mJKh4JLDnQheKGS2eJiUWVPxM3zn3hPWCv2JkIQtAsfmQUJLxw
	36S82rjXDdOLEg9nd82GXzFY+sKJsP/YDXVMHIHisUCcv903C/UL1fCpkGk+/cjkxMfpOi7dLW8
	P6gVcDHom5oo4URDR4penwA==
X-Received: from wroi1.prod.google.com ([2002:adf:f301:0:b0:47d:edc3:d027])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:2508:b0:485:8e8b:7bf4 with SMTP id ffacd0b85a97d-4858e8b7c78mr24677624f8f.33.1788858579813;
 Tue, 08 Sep 2026 02:09:39 -0700 (PDT)
Date: Tue,  8 Sep 2026 10:09:34 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260908090937.838544-1-vdonnefort@google.com>
Subject: [PATCH v2 0/3] tracing: Rename to "capacity"
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

A few places in ring-buffer and tracing are using "size" or "entries"
while it means "capacity", that is the amount of memory available for
raw data in a ring buffer. Rename functions and member where
appropriate.

v2:
  - Fix "subbufer" typo
  - Rename trace_array::entries (Masami)
  - Rename tracing_entries_fops and tracing_total_entries_fops

v1 (https://lore.kernel.org/all/20260907094238.3624013-1-vdonnefort@google.com/)

Vincent Donnefort (3):
  ring-buffer: Rename ring_buffer_size() to ring_buffer_capacity()
  tracing: Rename trace_array::entries to capacity
  tracing: Rename tracing_entries_fops to tracing_capacity_fops

 include/linux/ring_buffer.h   |  2 +-
 kernel/trace/ring_buffer.c    | 13 ++++++---
 kernel/trace/trace.c          | 51 +++++++++++++++++------------------
 kernel/trace/trace.h          |  4 +--
 kernel/trace/trace_snapshot.c | 14 +++++-----
 5 files changed, 43 insertions(+), 41 deletions(-)


base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.55.0.979.g7e5102b832-goog

