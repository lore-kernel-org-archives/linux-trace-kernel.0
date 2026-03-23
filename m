Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895F53BBA00
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281680; cv=none; b=BhvG4A/4kCpwRwS4yu8JsZoPQCHJYWUGOj/TydYt3RweETmTxLuxRW2woWMT2McAaiNY51s3SecBWqAC+nQjjadWCsjs/bOaiyIKfuWiz1Rh0SQNqHBAenkHYJj8P00C3qedtUw+Gont3pDqJ5Qp1XpIfNMRZMl/OSPbeK6/fpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281680; c=relaxed/simple;
	bh=ZopYVyAeHlBFSz+/anofByoCYoLsO3v78kbbq2MzwYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvb1VM7CrmXAqvpOYDQKG4j0nwNf2pC2Vv9J+sCGkwcgBqlJKzqQOmfc+Ar+pNwS51+zXv5eFcJLjpL2ASjBuuFeBbaYBvc2BLQF4St8ahPhTpVoEu4YfzH8TS8QWRIn/vwE4oAe3UNMb1r13JE5Pj4TYMhz8tnJkB3+vrbkLq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=pU/+tjGP; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="pU/+tjGP"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-67c281e3fa1so167344eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281678; x=1774886478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmhohN6RlSLZwmw7GnhmaqXlOUkxWsMUSbvXDFRlGSI=;
        b=pU/+tjGPC+ggbpYMDiWOMwETOyAKB8Sr8a92OBiViizy11szawSQLlypAkz33N4UxN
         wERdMGV0cqGAKzseKphcaq812WcchreqTidJnVj3t6a2hFsT+i1Lc/QHomUTCSixX/ph
         MPkIUwLJNQjiO3YaoapafweLs1LEUt7kU+8Ymtvsz4lfoG/D9ex4zo7feMyoSEnIJFNo
         xQtZlNye8y21J4J2TTGd8SR6EefqsLz6pkMVGFrei68f3cb6lGs2P9jjsO2r+FEEaWH0
         58BJIGsZsboHUegz4fiyyfeRiIfFsIfB1bz8QLYBgUFxOdbRhdRkdE9NkwiPXzo2QbL9
         O4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281678; x=1774886478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rmhohN6RlSLZwmw7GnhmaqXlOUkxWsMUSbvXDFRlGSI=;
        b=oj7XLbmVst8MhBPE8XzuX200nLjm+jQuaQP8fGAA52j0JEAAto3iVATB4S+9bYrHCD
         wJa6NbHqauUq00jRL/Sd6UWwSeCpDGMquhHVRA12udikkqEnrPGmN9SieTK8KFo/k4+d
         hBAtrj89DLr0Sz3aGHSKD46viGx20nxQX7JEGj+KS7wMdyRD1auyquH5tTXALdHu/H84
         6pl+j6joRRWUqNfYUzzYVQMIrZuN1svqPMy56HtkE3h340Od5DrkIjYNoWB7vD+1mStI
         SYzPJ5kCIW+nGbmsfKwK3W2flVQYv2PDvWaw/RsjiuPxhe7vGZM5JtU1XXv9Bw1dPOAq
         2XGA==
X-Forwarded-Encrypted: i=1; AJvYcCUBZQ/RI2UIxE1BQScmnyfKaW6zNjQ2olfLNR9DZ7XF/AVgwn39vS2/6GJW1eWR+xBN1Fx4TGdK54lc+yJuOVxeCH8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp/56qqatj+p1Mk34zg+VyL0+JXWR5v73dWeHCqErGyZPnBawm
	xmYm49vjJAlbjsKbaZUQq7OTBszvzpc+Viqeo9VPcBMNGIeBBEVO6Ip42SPLfTGOEyg=
X-Gm-Gg: ATEYQzwuDOjdkcCxMdoDTuIZuaUJTFiX4RV/N92Uzl38A/+6lp0mrtD+b9ihWoiBLCx
	AMxFRMaMsQ9fkh/2zqdYoaOV22DfRynTzQCJug8d2/Mv64g3+c55lcpE5FMRvUiVEeqGxoA1vmh
	C4SIg0kblhQpvFWn3kC9mgMBhwWXhNqyjCxLXNzcmVhddrXPnDT9c9QCN8ojG/ANVh/oGfHIlaN
	6opm3KOJOW3wZLtNK9lYCBYaOphFqyqyEv7kKRjh/NaBeBqmdTBJ3r7ZKP6cuNKgRb2E2F0Rhox
	a5KqD0e/uRHAAnuOUCBiQK3tJHS4EevUsbDOKFyGgypIaVeTiXVbYbmjAu8r86MeD/0sNv43CEL
	8VLQD1zsZhjMGaJ2EMSz50A0RgfxKOBTbkymhrcRLSDXq8jVV5c7s4q8VffTybDh+5beayoIpNM
	eHDP1y1cupYHBYkavtXbGybFiCFjZnQu6PEMBTWqgTJpSUzzHumWtvu6b+IuzHZE50j8/1V+u7V
	DJw
X-Received: by 2002:a05:6820:179b:b0:67d:6597:4d1f with SMTP id 006d021491bc7-67d65974f79mr5464593eaf.58.1774281678262;
        Mon, 23 Mar 2026 09:01:18 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:17 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 08/19] dma-buf: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:27 -0400
Message-ID: <20260323160052.17528-9-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 35afcfcac5910..232e92196da43 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -535,7 +535,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 
 	if (trace_dma_fence_wait_start_enabled()) {
 		rcu_read_lock();
-		trace_dma_fence_wait_start(fence);
+		trace_call__dma_fence_wait_start(fence);
 		rcu_read_unlock();
 	}
 	if (fence->ops->wait)
@@ -544,7 +544,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 		ret = dma_fence_default_wait(fence, intr, timeout);
 	if (trace_dma_fence_wait_end_enabled()) {
 		rcu_read_lock();
-		trace_dma_fence_wait_end(fence);
+		trace_call__dma_fence_wait_end(fence);
 		rcu_read_unlock();
 	}
 	return ret;
-- 
2.53.0

