Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DBF37267E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 14 Oct 2026 02:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791944821; cv=none; b=m3oKS4zCQRbYjz0/Y6aHct1tW3QrVpltY4G5euXb7WJOZbgeiwDi+Hw71SWAVqmmENTaU13HsPHouPP5WSI8PGUyW7w0xu1QPqONwszCjlxSqgfj5DvM5nRhzH/l7xYQuDSX9R1q/7wF7BIuMZtdX4nxb4HfF3mNgWht89GfJE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791944821; c=relaxed/simple;
	bh=bTfyfoSGYmlLpFoJH2XCBxtEhs+Opxo6THk3In2lhAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=fOEkgjPFSMgC2otPR9jxnMmCUUbax3B/mWYzBea5F81P/Pz54C1yeqNkkvq4hmcQZIVGSnujWYE8zkLcPSeyCnUjsQYc4I1tJf9xAKwSjwXCh4k1OJVR8nIb6CLx4On6QK+5GHc1zold6uyk87BXnQc6ckL5hJF7DKzvhvaAz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NEumHHNp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEumHHNp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791944818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZKHAhokxOK/hGBo7OX92Mvp/keyvbbEP4Qb41lKRXJo=;
	b=NEumHHNp/QoLvrDKqTBO4KJS0cuevRUDLxYFFpUE/aIRnmGFomuoOrgzXLG2Kq7NJqCitg
	IYEGhYj8QMyMnYXv3V2mGsLILTt4TO3l569mo7EZ5rL/7FcPw3/IbIKScgRTTBw1M8hoDL
	1HpkCvi4gx2vP4ghxGQCiO98HdTNe20=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-tiftSLZ6M_ebIlK6xSIK0Q-1; Wed, 14 Oct 2026 02:26:57 +0000
X-MC-Unique: tiftSLZ6M_ebIlK6xSIK0Q-1
X-Mimecast-MFC-AGG-ID: tiftSLZ6M_ebIlK6xSIK0Q_1791944817
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-91b92acedd9so54329396d6.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Oct 2026 19:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791944817; x=1792549617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZKHAhokxOK/hGBo7OX92Mvp/keyvbbEP4Qb41lKRXJo=;
        b=uF9GHhiSoqF35hmkDuG/XTvI9sR71M/AewAfZaLS+q/Mu7QLe442VxZB+RRWv0iHcx
         uadOIojezl3YWq6Mu/XrbcVDayRBO9XzY6ZskcJiPQvyQ3KjzNQWRWKn7a7U7deU8fMA
         BILwW8KCsBFTWpXMtnuLZH/YHmitXsz0lzhfcAPnEAaOCqeWZ00IA+rekp4OxSvfKVAZ
         Nznn7QqUUuVsn1jyrDDUphk3jZsfaLU5l/n+ebvHclQE2wMbynk2F8/ejP1dJSK/0puH
         N6oc0nEWkAGR/oobQ6mpYjzdxFKW4Sv46rXwoI//sf3W2uf7wNrNUAE+I62cBmzm7n5L
         o/mw==
X-Forwarded-Encrypted: i=1; AKwUvBzKZbmRdg9KL4xS+JzKN7rlxo3/KGD4Qh2TsJSnZLU1yVo+GvQOtXBnFVodWh0oHmBQ6a3BPHojbW5PLvPCwJD/fFw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmsz7E4tjGgnsd/r/oIMGRicNFEVAAg7l+Kuuh6vsacp18+qP8
	+iSdGJkiu1sA+kTHhxV5PUds1WFwXNDsnDW56mznnM3ENj3azYS4qwUiLS4Nb6hogjQVE/+ABlF
	siLlFhEQ+nCRty+QVKPlF/ZQR4CJSlJ+APtpdk28hwgsiYHUawTHn8mKB3ADDypyaMr3pQm9sBA
	==
X-Gm-Gg: AYBFou3z5U7z/G4bEyJ+daZyETsR6efUDJTh88eBq/f5zk7xtJ10AYbUF0tIHHRIXzh
	tS3M45KOLEyJb83VEPq+mTHEhXjyNx2MOGL3XBJEDuwUICu8BiQOKG/qaBDE2Pic/lhGeWrjcNv
	E/GgZ679tslmjQm0NTEKKGF8R0Jg1ZLHQs/sKJAWcNPNQmox1BKIqGuPErZCCYW3HqKn1l5sa+K
	eA1rS6PhW2TwhG8+1ogmB/d0xEPgBh+tZufpqlvkedjrVftuOeG8LO8NZ7WOr+OyPBfogYDEmwV
	8kV9EzHyCsPgRNqsGYsbIxBy5ZBwddgOvOvJUXuI0STSESjRShVHhNEbbF3xyAWxncVHxYHSpje
	T1gNd4K63C6XENd0LUoVephSwn6CI8dCJPr/RmF3eNIrlFN3dJyYDo88=
X-Received: by 2002:a05:6214:da6:b0:91b:8b10:ce14 with SMTP id 6a1803df08f44-91b8b10d2abmr98923416d6.45.1791944816628;
        Tue, 13 Oct 2026 19:26:56 -0700 (PDT)
X-Received: by 2002:a05:6214:da6:b0:91b:8b10:ce14 with SMTP id 6a1803df08f44-91b8b10d2abmr98923186d6.45.1791944816204;
        Tue, 13 Oct 2026 19:26:56 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97b387e0sm41051566d6.12.2026.10.13.19.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 19:26:55 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v3 0/9] tracing/osnoise: Synchronization fixes
Date: Tue, 13 Oct 2026 21:26:31 -0500
Message-ID: <20261014022640.695786-1-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VaslbTIs1nAV3RHSLqZ1U_SPRi4oG4lKSLuA7bfQ_WQ_1791944817
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Various improvements to synchronization in osnoise/timerlat.

v3: make sure osn->sampling gets cleared on stop, even for non-workload
osnoise (reported by Sashiko)

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
 kernel/trace/trace_osnoise.c            | 464 ++++++++++++++----------
 2 files changed, 280 insertions(+), 189 deletions(-)

-- 
2.54.0

