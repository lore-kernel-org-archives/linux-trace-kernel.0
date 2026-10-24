Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792806990;
	b=1+tfaNtzKMqmuGXXwO+EshkYUdR7g3Bm6LdyDgZ+hV4sThNaJAp63FsL35crMeORtmgw
	 +XqD9qycve83yZjQYvaZ2W/HfVw3L99bhW3KqTYRMEa/dJx+dSWJsEywadzbARDEl91Wy
	 +xeb6eIePk8/FoqvkKITSPFHIxhrj/ZJeU4pEFvpd0cZ15TyTHh19KK3rNaFOKukMJBIm
	 jzBZGZf4I610jXEFcAnvH8Im0rLYa0idwY+SyIpV/BOVkn/hnuchn4SKI6AnNton3+hba
	 RQPd58hJW77HKbIbXmNuLAJCCbGReqA63Z4x8xVYCHv+uyCFRZSh6Z+JNT7dXUbPoRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792806990;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
	bh=sLMw0QjZdZaIMmUsB/g92UwSnIGY0aITRpwAFmztFlI=;
	b=yZkF54YsxB+kG20tOs/1S1+k2X61EE4n5eOlgf8FfhunB2f1oWGIvY6uu9S/Aw/PXrce
	 Qk3AxrnOQA413wadNbB4dKV9wx4tbDICmZiNOK7UOFCl9vhPkcdWAnaYa9ejt9JmYAJA4
	 +33JJVkApL5Z960tm+PraUkUJPbIC1NLkTQycOcOn4SZ9nmPQMhlakPAoRC7+om30arva
	 b5+B6xaJE9xjjxH1R8iPvQ5sxdT2xqaCby745eMtb8xCJfKFelELDnm2u/TjP2Q8Iu/2f
	 SU8tgYBQGWJf4PlM4P1D9iiLq5CQUlaAkPO28xj1DsmBODFg2+1/ykrBDvAVOUCuB+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Yk/ty9M8";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5016C606A31E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 01:56:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5016C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Yk/ty9M8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792806988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sLMw0QjZdZaIMmUsB/g92UwSnIGY0aITRpwAFmztFlI=;
	b=Yk/ty9M8ViGTKuMaggkX3MAiyAh0ac2GqxnE59AfUyoHso3CCwrziH8yvmg/1BZrWw8eDo
	wdsIfNLJhVZs4350pqwcxg3J4WL+nwNU76cXigf+iSY3EfsMkeUP9DyKKNft4HMcnK8Vfb
	YIvJRBydNDh2axZKkWshe5LazVzY+Us=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-uBLEJH62NqOX6pDMMNQivg-1; Fri, 23 Oct 2026 21:56:21 -0400
X-MC-Unique: uBLEJH62NqOX6pDMMNQivg-1
X-Mimecast-MFC-AGG-ID: uBLEJH62NqOX6pDMMNQivg_1792806981
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93c5ab5c136so237737085a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 18:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792806980; x=1793411780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sLMw0QjZdZaIMmUsB/g92UwSnIGY0aITRpwAFmztFlI=;
        b=l2nqOiHNnStsrdy4W6nSuAKETNgVFKd2cOeeBNhnz3IkT5sV1e7BkxfF+Pfzocev5i
         Rf2JHcGWPY7Z1u01QxqUxqavu8LssWADYrhZfCrzFq11ja3xlu60zComMUX+TYuHveqw
         JZcjSsM9zLhlcweIF6rKTFiFQ1zJG7v2a66qq+W63TbQJLslFbph+tv6X564WkmGt5+w
         1DD8NQUZJ3L9PVNIMOGmNhFpwXxdsLwWePGw247MHH1oF65C6Dc5M5zlGa6eaxEQWzfG
         MJQwwAc/QEGicWlXOjuOq5fyTyaYfL4RaUai46dklUPsukp/mTdV8Wsimf5MpgHVNJzv
         hNmA==
X-Forwarded-Encrypted: i=1; AKwUvBylY9jn5uxsvcqNxNmk4Dw2wYj8MMYMy626yZz9tdpU2BRIu1GPSkKyXr8/mpkTXTNGk1HzgMs7pTx8rvLjsRxNgso=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDPg00KvMHOQSbkKZVC2ZTA2fQmyhD71TEeoCqgrcSKpPF+P+C
	E9Svv0kKdQL9EzVKcHmP0S5VO8nhc5XCp3/tHSYHYTG+3sLzWmaM6PYZrfGOt3uurNthMpIxBOs
	+7gVjV6m5QbmBIFuGDwDY5Sk3Y2sESgpwjrAg1JemlKRLNrttiTrpQZTHjxQR+eNI56WTDN7Ydw
	==
X-Gm-Gg: AYBFou31WNlD5KFTiALaNMNXmE/BTr6oPhb7PgVgeIeUQ4yJQVEnMI1xRKaKCfe0NrV
	6l2VV5zlNfa2/4Q+05j4CbrSzQrEpJ0l5IzdpHBz91Uoh31n55eOBi+IYG65LVk+eqBNQ6tlVA+
	mJAOA+LoIxkXsUAyWj3ni7tezfkLn9iaSEgy1Clk34F9v2gNUY5VjE4L5DTFUcdTe5DrPs5Vgb5
	lEVUuMVegQtx9WK1UZsmYyWPwNV1oYKlEBZBulsCJOS53uGVvVHv1Uqj7gw7J9j+8/6RE4QNzuL
	so4vLNV1kShskkqUzljFfvjlWOwl396pLJyajcsG1A1/Cwn8rWgz3sQ/XZ7SoPeUacV42snE7eJ
	mDyqZhqWQRNSbpaixIBj/8SIMtTdbgohx+bJ0aW3PcZLkuh3HHnZScds=
X-Received: by 2002:a05:620a:6887:b0:93b:d7a0:d9db with SMTP id af79cd13be357-940ef967653mr115366685a.53.1792806980451;
        Fri, 23 Oct 2026 18:56:20 -0700 (PDT)
X-Received: by 2002:a05:620a:6887:b0:93b:d7a0:d9db with SMTP id af79cd13be357-940ef967653mr115365585a.53.1792806979995;
        Fri, 23 Oct 2026 18:56:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.redhat.corp (71-34-16-191.mpls.qwest.net. [71.34.16.191])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47c4c6besm9448136d6.23.2026.10.23.18.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 18:56:19 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH v5 0/9] tracing/osnoise: Synchronization fixes
Date: Fri, 23 Oct 2026 20:56:06 -0500
Message-ID: <20261024015614.3095251-1-crwood@redhat.com>
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
X-Mimecast-MFC-PROC-ID: z83mY5cVsd9JEvBxVSAqNllkJ5CmQpdHwNbb3y9uOlw_1792806981
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

Various improvements to synchronization in osnoise/timerlat.

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

v4: fixed a problem with the v3 fix spotted by Sashiko

https://lore.kernel.org/all/20261014220759.908839-1-crwood@redhat.com/

v3: make sure osn->sampling gets cleared on stop, even for non-workload
osnoise (reported by Sashiko)

https://lore.kernel.org/all/20261014022640.695786-1-crwood@redhat.com/

v2: addresses issues raised by Sashiko, as well as a few more problems
discovered in additional testing.

https://lore.kernel.org/all/20261010022338.2507589-1-crwood@redhat.com/

v1: https://lore.kernel.org/all/20260824211544.3984835-1-crwood@redhat.com/

Crystal Wood (8):
  tracing/osnoise: Variable cleanup
  tracing/osnoise: Start all eligible cpus from hotplug workfn
  tracing/osnoise: Hold a ref on osn->kthread
  tracing/osnoise: Per-cpu mutexes and fd detachment
  tracing/osnoise: kthreads: Verify CPU after migrate_disable()
  tracing/osnoise: Take trace_types_lock in timerlat_fd_open
  tracing/osnoise: Print taint message for timerlat
  tracing/osnoise: Refuse timerlat fd open if tracer inactive

 Documentation/trace/timerlat-tracer.rst |   5 +-
 kernel/trace/trace_osnoise.c            | 395 +++++++++++++++---------
 2 files changed, 246 insertions(+), 154 deletions(-)

-- 
2.54.0

