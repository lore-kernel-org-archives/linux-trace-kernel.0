Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E97383994
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Oct 2026 02:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791599045; cv=none; b=GRU0lR3h9KB2xr1HV/oCJ4m0sdbDhYrWIMAR1jU9UHTjsGmmuua8cUtsn0QmEdaHfeuZseao0a43bjdiyIggdliuGBs0cmZ2W6rXhOd1tCZenUbmdFOp7tNv4Vdfsmnso5t2s+CAeWUgiTSfzz2vBrtyfh8SikcwHD7BLma7U3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791599045; c=relaxed/simple;
	bh=ZFbxZxyAAaY0qEyvKQZbDgkqvMfW7sXq+/VR1tDD/Y4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=U9RqauJxegsDYfB16PDSr8usuDtMhnJd3Q93DECQd6qs+JpVUXQcN+uar71jyFa05nDSgCkPTWXtXihvdWrJgNQDyQ7N03NZYqavStH22HLTrGXcUvK48jMZrz55nwgoflsKo3fqIbxTB6T5PHL3VthKhDApEebR1G2/zAKv6cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dfMDdsUZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dfMDdsUZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791599042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SxFPQzgJqSvg0vvA5IwLGCGzmx7XQPqnQHOtHlrrcus=;
	b=dfMDdsUZFm6Ls7o3hhJUWep4zhCSpi7DbAY0Zu731sflKHjsmlN16NrrQ7mCVD0ibnOTT4
	oSO5HsXZ90OABKNgsE34yBjR2wqWyBy6w7xMwsOuic6flLpR9Pw88Lpi6lwBy8/ibJYCLJ
	cqMXeszpFuTg654wNpv7Myb9EAnLlbQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-haOymLRgPAKIVLdXbfZSVQ-1; Sat, 10 Oct 2026 02:24:01 +0000
X-MC-Unique: haOymLRgPAKIVLdXbfZSVQ-1
X-Mimecast-MFC-AGG-ID: haOymLRgPAKIVLdXbfZSVQ_1791599041
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-5338c59f90dso51331851cf.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Oct 2026 19:24:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791599041; x=1792203841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SxFPQzgJqSvg0vvA5IwLGCGzmx7XQPqnQHOtHlrrcus=;
        b=j557wPXe3ZXhRX4rfz3a2GXXhsCMGWOgVUbcHn8r8Zmck2IUF5un3RJuoWt3XudENQ
         8qc0Q7ra9LXkZ1t+2/Gn2nxEzHAOZ4u/PghSDqmzXR63zpI+jTDC63BIQWUO4mYYBQOc
         igZ1PAH9D59JK46V1NFTrg6cbtE5q7wwCGpSRIcey/jDsz63PJHKQLhW9TV3VYShCsqx
         OCYv33eiTVkvVGXjp0+8styBjKOoceBti2er1a2OuUJcApR54Pfx9vTYxzNFh5zU1FK1
         TLtrX1+Si1i/NSLOhAgqwlQ2aKyFL6I70XglRPICBDvrFmZ6hhFBCxzm5F/bEBFiiBod
         Yv0Q==
X-Forwarded-Encrypted: i=1; AKwUvBx89PJ5kyxewD88JY5MffnOFRuCauQWX63ShM52TjocIowBhqqbfZKur0N1NfK/rWcNx4S3PniRh5+uDipaVXcXiVM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvvxm9Z4A75Q7Of73GmbRc+d2bzwe77emGJwY+6SdYn43KPzqE
	hcN6iQtvBcqC7qYIfBEug9dDYT8S7y1jBVJnelxyTO2tNNF6TCInHcMCzh6VweEhus3eXNfsz8h
	UQzL4CDPpoh3E4qvfuLkEV0GNC+XO/BajiZ7n5V088CMvaVuy6j5RiJk3Dtk4ZfOFtvySIZqQ0g
	==
X-Gm-Gg: AYBFou1foqdaYdO3chUSnbvkFfsGpx07z4w+4Jp/5KmxofCugLo1CtcatLXE4ZdvG7s
	1jjmx5RcEy6B3A4VQ2BviC3hPbmzXFmlvk6EFnEhXFCKLrdg7Ak+prfK3VBKvuWf29yOV+ioSka
	E4uY0SgXhMqobxNVGsLuJer4QytjKiWdyfnIBnD4+3w9uw0m5iIVmYwyYo879SjchBF68iwXUM5
	KgYMKnR/Lf+AAOIbc39dFKYUjaKEMiTKrGng0p0wwlc3DVQXAoPc9i+ymtvCdUHKxdvTO+4QoZA
	G1Zqgg9kwAbk68A86zgW7WXeHvfF4VXJ8QsxNC6eLaMZxWe2FhHjk7sxE7DM5R7bwNKC0FLDrdL
	ENJSC72hYHH8VBpOrjJHRyqWKzN2Yb82Cb5Yd0gEfjFar6HdN1NavHM4=
X-Received: by 2002:a05:622a:4d92:b0:535:7258:9fee with SMTP id d75a77b69052e-535a61baa0amr46918541cf.24.1791599040652;
        Fri, 09 Oct 2026 19:24:00 -0700 (PDT)
X-Received: by 2002:a05:622a:4d92:b0:535:7258:9fee with SMTP id d75a77b69052e-535a61baa0amr46918411cf.24.1791599040240;
        Fri, 09 Oct 2026 19:24:00 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb (71-34-25-140.mpls.qwest.net. [71.34.25.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5359b7c0214sm31284151cf.25.2026.10.09.19.23.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 19:23:59 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v2 0/9] tracing/osnoise: Synchronization fixes
Date: Fri,  9 Oct 2026 21:23:29 -0500
Message-ID: <20261010022338.2507589-1-crwood@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ObXAnS8JPm-8PVFekHaT3QDSYEmh_mrBU3u0ytPBvyo_1791599041
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Various improvements to synchronization in osnoise/timerlat.

v2 addresses issues raised by Sashiko, as well as a few more problems
discovered in additional testing.

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
 kernel/trace/trace_osnoise.c            | 462 ++++++++++++++----------
 2 files changed, 280 insertions(+), 187 deletions(-)

-- 
2.54.0

