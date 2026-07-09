Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B292740BCD6
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Jul 2026 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783612846; cv=none; b=tS8GonJ6poLabRbLYqvCAabvgDViP1TqbFTrZaXSW9HtKydjHuCe42coOAPvLXPQMrzQgOfH9k9rMLc77FIuWagiA1ZYQProwL6WOQ/9aHLouK+Eo3nJqdFN3JBA6hY/OS7L/P9B85mTIB2cJ5hjzgELyFc7DbE/pweGh6vcNfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783612846; c=relaxed/simple;
	bh=jO4/QmIN/j3YW9CmJ6GiWepyXK3igV+/JLTRJ0FsvDI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pTtQa8t75rfw+mSjR5rJLD3FGatvuz4FuHy0/mOqTVk2kN8wYgQFq8w8gXzp1z0+QHxIfjlu0rNxwdMFPNDvFqkIsFrxUEv7aqy/6prUr9ezhOlGMWN23mv+35fb79+hsNeJD+TYbGovXb9YnhqDrf5hozJqiCHtlMlOEeitcj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MEUsXmdD; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MEUsXmdD"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-493e3ecd385so25560655e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 09 Jul 2026 09:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783612843; x=1784217643; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BmP8NlFxJ8FVr7DCGqIxDX6layModuuoouK0eFgiUHo=;
        b=MEUsXmdDkjLRByphmuw6hmDBOzVR3UD6LaNiO3AVq5L9QrXAua9YpsAlivgqeWlA0e
         hkp9mxSBTdhyw6BJOn3asiW8vZ6ZoTszXdwzrhWIfcKuM+VnZUQowB+b/Du+vgSKhMy9
         awsky2m5Vo2vVhC4XqsBwh1ujm6jOz6ztSOIUAO75jeLalr1ZYZs3uaKy52dMzXNBRLw
         BhD2gFVFWuvVtlmSrMFR5smeTT9Cs0yvcM2V/vReAnM3TrVN/XYtXDclAmeLOWrsXuT7
         aHidO62ukyP8xOGDwmxg4lYi/4xQ1PQdWKhdpPCakByIEBrI5o8coasFfhwnAbSKzrk3
         qOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783612843; x=1784217643;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmP8NlFxJ8FVr7DCGqIxDX6layModuuoouK0eFgiUHo=;
        b=Zmw2j92lb5dnP/wQ1vbMY9v1m6BVUjzOlZSDcySeD9TXczCHjvVd7PqfqI3OvGOtvu
         +8khfhx+GhL6n+8bVz2TQ75iZjUqkKnTquqCmtET7fTtudTyoPufL+36xrnM9YAoaEjt
         j26PvpLetWPpX3lS9zzKdX5OhphEVo40oBn0s83ernspyw3QVV3D99u6ldaRwSZxArX+
         knyIK4i2WN3ag+We5kNii3wvo+CnGLIUHhoZb6FxtXZkQYvLMK/sF2vDwsYwyMSg5ROB
         8MPgtBs2nIYsmBr3x+4+1K0amx5KMpGT5j1dG+AvApHIQI5aOUTVdjKsDO83cgbCkzqn
         LzxA==
X-Forwarded-Encrypted: i=1; AHgh+RpCro3sdMKoMS9z2W7nq9FUhUgIAO+TSTsqay1ByfT2E41LMIJBiiOQFo/HXq7k9GqjQps4s0NWiSPYuMX+UloXDCE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+VnV6sGS6osP5di7TzO4P1t1ePNGOqRK50sogLprgyRxuInyU
	/0iD04tfE7k+sKNJHsTo8M83XeK/ZR+0+9S8CO2wEfLGbhZk+97CCSqFag+o0H8DXxhlJAjyKaT
	amJLJtHdy10K+6aZn4lisEg==
X-Received: from wmwz19-n2.prod.google.com ([2002:a05:600d:6413:20b0:493:c562:3fc6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:6297:b0:493:ee2b:c8c7 with SMTP id 5b1f17b1804b1-493ee2bcb92mr31248745e9.4.1783612842870;
 Thu, 09 Jul 2026 09:00:42 -0700 (PDT)
Date: Thu,  9 Jul 2026 17:00:14 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709160017.1729517-1-vdonnefort@google.com>
Subject: [PATCH v2 0/3] tracing/remotes: Fix leak in trace_remote_alloc_buffer()
 error path
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

This series addresses a few issues in the trace remote buffers allocation
and descriptor handling, mostly reported by Sashiko bot on top of v1.

Changelog:

v1 -> v2:
  - Leak fix: increment nr_cpus early (after meta_va allocation) instead of
    in the error path.
  - Added struct_len double-counting fix.
  - Added sparse CPU masks support in ring_buffer_desc().

v1: https://lore.kernel.org/all/20260708133201.295072-1-vdonnefort@google.com/

Vincent Donnefort (3):
  tracing/remotes: Fix leak in trace_remote_alloc_buffer() error path
  tracing/remotes: Fix struct_len in trace_remote_alloc_buffer()
  ring-buffer: Allow sparse CPU masks in ring_buffer_desc()

 kernel/trace/ring_buffer.c  |  5 +----
 kernel/trace/trace_remote.c | 18 ++++++------------
 2 files changed, 7 insertions(+), 16 deletions(-)


base-commit: 8cdeaa50eae8dad34885515f62559ee83e7e8dda
-- 
2.55.0.795.g602f6c329a-goog

