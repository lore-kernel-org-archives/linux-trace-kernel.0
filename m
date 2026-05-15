Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70E7410D29
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 14:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853739; cv=none; b=bOocDD+AOzUzL95rDXskoDrNi/oLrjDgHZQ04TKv9KUwWnfh3jo5o/Le1UC0a+qxfqA30CFizcPSqsIlIpogPszG4cW/N4h42n1uuKEAPL/WXbs1Hw7lXMWy+jTEeGqETPB6VDVBHEz6M0rBK79/hkf/3aWIH/YrtyN0zyOtp4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853739; c=relaxed/simple;
	bh=3GzXONvA/DKYOT86mzNZlFKYzimsfvjHaKwP/VNbe2M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pia4/hjsSqKBQ2NObZLyEPPrHyzXrY9EDG+T/bGIENe7PvcMlYcKEmQP2QGP1js0erGO2EB9SJDsR2UuOfzXz+9cCGzZPz+2CC3MYdNwcot5kVmFE0E4LjE5Xy1k/oQ3WrE/wavtPFnvlmIYybGZNzAMCTizNmFk9+TU5PhtstE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Lzls9FxZ; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Lzls9FxZ"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-910f734b477so189071485a.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853734; x=1779458534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uJOdi/TzljxZPI9yl1I4A/VL65oRSiUkNPLik5t/1gE=;
        b=Lzls9FxZ3oQuYiGU4Nz2KzjRNfN+OmYxuQnNpUsffpYAZjU+I2kHROYkEFWQv4n6JO
         B2RQZKVN4s3KuBo9aVSL6VHsTdjkLXH2K+L1Iwn+Pfms1tmeDPqdprUJSehswfT18ct5
         /BAqVG1KE5+gxViUDfpnlw8PeX26GDOA/6gVqHc2E1ky0CJQvhIQyFlGEzzg6L0WUzsP
         oaTmHSwhySwkA5Cti/UrxgBS8BLixTtTloU7A5Hi/tHnp1Hkfto3qAY2DUFAB80Le5zS
         lO+oYaGzpO4CLNqx9BNJzTvpFjN7OSX0vxACzg9KQClCJApM4pVZHhNRtlwhCdLgYJ0O
         XZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853734; x=1779458534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJOdi/TzljxZPI9yl1I4A/VL65oRSiUkNPLik5t/1gE=;
        b=DH19qmk0iTtd3BEJ2wFhL0pUJJBwfodrIVKGbaz5O5gBgzwfq9NX0PQuFdal9anetU
         FWfzr7tC5zxFDtTyxwKxROtsnSKxfEPa0gqwzEwHpzW41rT9A2YjjLWnOXWzTbAS/4+y
         n9A7WTneFaegv3SI8gtzHjeCiyePkfJlnxMlgro/1VcepaRV4rvs/Ct3PywvgAS0luUh
         oHSny0EO8P/NQ5EWCZZl3urUelFzwcbuAlAd81rn6NdNVa9MQZvtn9zwrQQxuV+cfqNF
         dIVzaBl248v8KXpskv7M5oOCtLYC0qAuaMURQUW0pr4rlY64l9PA4Hd6vi5TkNuk4h7h
         Z1LA==
X-Forwarded-Encrypted: i=1; AFNElJ+5V6cHCJ9FDgXsqczl5WyjKxpjX45b4caa193yG9Do6QmqPpwsqAuWM4/o2YGG3asm99k1XeVIP9W+LhDV0zfa/V0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhdZ5Utu293XOUOblRHXSqrwBnr6I0nm8SxrYiN5MYUulBVP/w
	CfavL7cq4IeaWJc+Blg/ENuAR6+Bx0cf6FHXRCM2WUORKK04ffdQdz5Hir3oaUB4U2M=
X-Gm-Gg: Acq92OHfBRpVil7ftBF3ZuwqS5XSA50Tw+S1wupMrwODwvLuZJUzx3c/v3ilNumhoPv
	+P/SGdrBSKG9msnCzjpFUUTl0QhQJfU4+MfbBhki0OHMb+n2zQmtoh/mydtCqfSHhr+bjuBVKZ3
	K2v5hk/ISeWnI4oDXGVKgjuTmuNcH1AQQBHAGpOX8/CiKDYHKfzSi71LcNgh5eleooNdAoZ0K5m
	tiw6qkQLjSRmqtXEq+HdRQDhCYAsaEadFFhHB+rRYqgfkdZHlFoT7rolFST8pDzcqFZjGvSI8iw
	qP8bjSUAJtFu0Zmrqdog82TlKvirF+ZxqoL2g1QabTf8dOvCoX48ssLNpfyM0qnj8iieEUZ41W0
	pBW1cUWfMYBAgfVSRwbXd5pzAzncMtI2T/gVivKRwXMUxC+YafIKay3ykxAPrd4KrJnKz1ftcGv
	aifO5nqElwMWfpA68jKlFjTZIii/1b
X-Received: by 2002:a05:620a:454b:b0:8f0:7516:daaf with SMTP id af79cd13be357-911d087bf3cmr649143485a.48.1778853733580;
        Fri, 15 May 2026 07:02:13 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bc83b85asm549789885a.25.2026.05.15.07.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:02:13 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] drm/xe: Use trace_call__##name() at guarded tracepoint call site
Date: Fri, 15 May 2026 10:01:41 -0400
Message-ID: <20260515140141.2239437-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/gpu/drm/xe/xe_guc_ct.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
index a11cff7a20be..8a10a1ede983 100644
--- a/drivers/gpu/drm/xe/xe_guc_ct.c
+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
@@ -1032,8 +1032,9 @@ static int h2g_write(struct xe_guc_ct *ct, const u32 *action, u32 len,
 	 * the fast H2G submission path when tracing is not active.
 	 */
 	if (trace_xe_guc_ctb_h2g_enabled())
-		trace_xe_guc_ctb_h2g(xe, gt->info.id, *(action - 1), full_len,
-				     desc_read(xe, h2g, head), h2g->info.tail);
+		trace_call__xe_guc_ctb_h2g(xe, gt->info.id, *(action - 1),
+					   full_len, desc_read(xe, h2g, head),
+					   h2g->info.tail);
 
 	return 0;
 
-- 
2.54.0

