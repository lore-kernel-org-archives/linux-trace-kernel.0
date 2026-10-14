Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1C13E6DE7
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 22:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792015699; cv=none; b=Q1XFrwnSN3cr1pnnuzVgWguUeYRTJxUJAp6yoUbn/OSw40+v7PkCuinSfXwJHRJSqe1WVvdcsSRoHi/PuH2TbzFcRmVwdZ+fEmy+0UMuTNpKr35jVuv8cC1Ys1Lk8RNmV8HQFgM5mS2XFxQGN10RvxFy5+GPyFWbg1nfL8yTpeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792015699; c=relaxed/simple;
	bh=gK1P9uXMiAhIOccXt0DWzPIMDXglrHrytBFJTCunzyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Zqo50EOm0hBrFxDiY42RGhFjeT0U71SdRgy8JuZG7G6hzjipWq/vqXrL5D3kEA8JluJLW/iPV5dzAXkCSt59YZ+4jmy78D+YB7BK57pqfpXC7y0inRq3HM8fMvv2gWUNLVwxSOye4tWskpM5V9c+V2ZxfRLxEUSTX46rJUTCgsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VJY/9cow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VJY/9cow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792015697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=LcnMybryqfZauWaxKt2RttmDBu9+wDeWB20mlGHmBbs=;
	b=VJY/9cowEtsAF+7WaiX89h/ChR2yMcqVk6dmW2rEW+Paps4evY9vF19ozHOhJZzS33jkNy
	pMmPQyLAOWat8keWPZ/DXgZVQuYNfcebhfRcf2twQ0FvtH1ehhpp7fWMjYm191WWrYj8TZ
	9wkSGmVOfB0z0YtnnjnDXbAspn37xQI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-mNhodAiEOtq65LBnubA0Fw-1; Wed, 14 Oct 2026 22:08:16 +0000
X-MC-Unique: mNhodAiEOtq65LBnubA0Fw-1
X-Mimecast-MFC-AGG-ID: mNhodAiEOtq65LBnubA0Fw_1792015696
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-535294e0f64so15244331cf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 15:08:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792015696; x=1792620496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LcnMybryqfZauWaxKt2RttmDBu9+wDeWB20mlGHmBbs=;
        b=gG7g+xUhbiJkAGYUDFlhOCJEpt0lGCTh1HQKkpgTvOgIM12uGuAKf77IXEmTcnR07I
         Em+AjZJKKYp6Pj3g0C43WRvFqAjC8RyshBfWYRDXFmIA5uv/M8wbbmKYr3tk9RnC9zaR
         Jt1PrdJQ6MK4ujrrklIECj4xxZK4fulKgiFuXU9C+3tJ+3InFvCqBDcxMElX7G+SpnLe
         nU4LlGNUEq+VMidDzZGeY4kW4kv0CFiwikU4Eh0VleZfhsRxmjtE6J15Hl704hxicChl
         dFVGUQR+BDlF9CLyDbTyaiEV7E/zPcoef9X5kcqM53eZSZtRqqQYVWXii2tqjhDrEYrn
         oykg==
X-Forwarded-Encrypted: i=1; AKwUvBzOyOmQFsiQpLTtyI3vLxeVHG/O3xwrEf1tOQsKNr0zsSia0KoYcfHudsSChFg2mb5vVoH3fN6IkWYicl2pPoRdx88=@vger.kernel.org
X-Gm-Message-State: AFq9FYIl7ArubDG8sGKTWMGEFJOhYi7ApgbMgzqUNKyOi5U57wcIv4eQ
	tdBoy/oMJ/T6LFOIReimjz0ifHd5BtJZXs0ZuRJ1QtRcb3eZhBmEoM+vwfSlCetu8wmvDGcOqq+
	P3RS9SRKwj4Bk8OHxsAv7TEEsVI839qzjCd+BYjz1Jv7GKcUou8IJLx7m0NO/gYehLeUr/zyYzg
	==
X-Gm-Gg: AYBFou1UyJeZTNmWNeY0jzs6rx7DoutdprZre9LRVlyNGSoO+aWJUiT8uyfPSQujn6i
	PdLszIjFBSE2IB7GLZSOAv/VdCKoMsSfBQbIQmW1UMUUMaC6ZwvuXaFf6yOAXkAJgCCq6SxAMzk
	IdfR799NO/exyQyU4LOp4QZ6a7FRX4BOIz+zaM7xSlMq+68kJcdvizs66MJzO9xhuBAqWndBkbc
	umNqOV28fnySqxjdIweh8I+Rrg0iLvxZ1McY36bZ0WLx+vElkHBNLw22Mmncqd7booAARnf3s6i
	9BCe4734yNFd+fUY7n6KP73gna1df24xWMbNfmb1R7VOnymyM267aB9+wJMNAzA6kwbJi5mIiH9
	ZmtO6nta+nTXcOLeCwfc1jXwjQ6mzHkd+0KNEw1YnetTLV1GZsuZEm9c=
X-Received: by 2002:a05:622a:5a11:b0:535:85e1:ed5c with SMTP id d75a77b69052e-5359fae84e8mr289801041cf.25.1792015695707;
        Wed, 14 Oct 2026 15:08:15 -0700 (PDT)
X-Received: by 2002:a05:622a:5a11:b0:535:85e1:ed5c with SMTP id d75a77b69052e-5359fae84e8mr289799291cf.25.1792015693951;
        Wed, 14 Oct 2026 15:08:13 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-536127b5567sm8224761cf.12.2026.10.14.15.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:08:13 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v4 0/9] tracing/osnoise: Synchronization fixes
Date: Wed, 14 Oct 2026 17:07:50 -0500
Message-ID: <20261014220759.908839-1-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gsmg9g9EXl_xNXNNDn1K7G79GClTfSiTGUat-qCk_kw_1792015696
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Various improvements to synchronization in osnoise/timerlat.

v4: fixed a problem with the v3 fix spotted by Sashiko

v3: make sure osn->sampling gets cleared on stop, even for non-workload
osnoise (reported by Sashiko)

https://lore.kernel.org/all/20261014022640.695786-1-crwood@redhat.com/

v2: addresses issues raised by Sashiko, as well as a few more problems
discovered in additional testing.

https://lore.kernel.org/all/20261010022338.2507589-1-crwood@redhat.com/

v1: https://lore.kernel.org/all/20260824211544.3984835-1-crwood@redhat.com/

Crystal Wood (9):
  tracing/osnoise: Variable cleanup
  tracing/osnoise: Hold a ref on osn->kthread
  tracing/osnoise: Per-cpu mutexes and fd detachment
  tracing/osnoise: kthreads: Verify CPU after migrate_disable()
  tracing/osnoise: start_kthread: Always check OSN_WORKLOAD
  tracing/osnoise: Take trace_types_lock in timerlat_fd_open
  tracing/osnoise: Split out per-cpu variable resets
  tracing/osnoise: Print taint message for timerlat
  tracing/osnoise: Refuse timerlat fd open if tracer inactive

 Documentation/trace/timerlat-tracer.rst |   5 +-
 kernel/trace/trace_osnoise.c            | 463 ++++++++++++++----------
 2 files changed, 280 insertions(+), 188 deletions(-)

-- 
2.54.0

