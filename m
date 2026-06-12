Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7962C375A
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781273962; cv=none; b=U7Aw9jRA7BZRnET5pHt9CE/bawjYI933Byx91lauxy4au5mH/sHiJyWBtrXxAQ3sikWoWvToSa3TqavUQcj5mLBmESr+XWs7NjX0m1ivzPOTfml2Nx2LvbQsPtQmATVGF/9umclDPsXelfrSprFxvDJRVG0K4cUw+7dQy2Psr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781273962; c=relaxed/simple;
	bh=N11KqFqqpa8pIXLi3ZH1nreVT0ImrnKzchs5LUB++qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJsofIB9AgxyjeESgNeCmyqKBJTPat3DOxMKyeeqmScAQDI9H3qSpu06E1Flm7FpRwyWwK0zFkL3759FS2KAaCJsMBPBbgwsNY8GHHP3c3r8j0ujvuQ3neYFwC0SPy2rr7GvsDVPlL0hrKX5NyqRh6WIDdjQ0kpieJRu3ajNPjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LJd0peg4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJd0peg4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781273960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4t96VqnC3BD1F7T/58snKnEK4qwB+Yq2QQw8u6ZVkoo=;
	b=LJd0peg4GOj3/W2E68lBEKi5iwVVFqJ8C/HO3oG0lGnjBg2Rn0++u3T8nXCmnvxnLNpda/
	pDttPwXe9nniWjqDxLUGEQAEPCGC0lkHvbbRMwddqJWGpp3M7sd6XSgivAy7YOqVx3uTbG
	3uPToDDM24FDWwpekKPCZbWO0op3r+8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-6ZOMhihTNM63B0sTlK9wZg-1; Fri, 12 Jun 2026 10:19:19 -0400
X-MC-Unique: 6ZOMhihTNM63B0sTlK9wZg-1
X-Mimecast-MFC-AGG-ID: 6ZOMhihTNM63B0sTlK9wZg_1781273958
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-691a67a7b58so824710a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 07:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781273958; x=1781878758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4t96VqnC3BD1F7T/58snKnEK4qwB+Yq2QQw8u6ZVkoo=;
        b=HIPbhQForwujIIVlgDn6oy4vewUhxcxmyfnjPboyIj2wZQsa3cZOYNFs4CIVaDpq7H
         epdU5cUQJ8JOqbENOgBpuq0enp4mFQdwm/hoBZbmzMJNwtwrDfWlsMiKnF0SMKBWtnUh
         0O378MRUkoqozxC82HgqWn1i+qNXZms1RhQmDvLfYNc/TzjfKk7gBy/a7QUlvYWQrjtl
         QfebZOXn4he2BzvIVjGvhxo/5VlIHgKlDRpEDVXXi+JOgJz921+rmcUodq/XcG6BYfB/
         NsnlpTuEpIrYTSsRed6LAOQkTlccA0beE6Y82ib7mujTrsCJn7B8pQFYai3FuMR9k36j
         pkhQ==
X-Forwarded-Encrypted: i=1; AFNElJ/BV1hhyomVIjj9NCIiv5QXWL6mIEpvEGwOUswe4GC0VIt7ywgBcq/Lerm815PJc6H9Rm/dRFPPcv7gL2CEiTrfpOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3ZC8WWEfiOOIbP/G74Gfy4HFl1KeVRrwYofKDhGR3V88FrrBg
	pybu7N++6Dn4cz4oDpLaY5nRdb3QqiN2rMT9JRIgrvpk+vVvpvaR6g8RTWPB+j5OhGjbTDxCobs
	alNzUulNUty0soxb+He86+FYj2WkGysegIJY+M4WUSTpEynfw0alWyxuPwfxib8kwi4gXbpdv53
	a0RVR/fVhrblmeJJwPUwbuNd2Hom1VHS4Ldy1/i3FpOAuBAxTddit4mtFKTyc=
X-Gm-Gg: Acq92OFDyMziL1uMKcfjgNIsRSTKupanyDdjDgseEqQkHizTCrb/nK/P+Pfjssh0/l1
	KdKvKjt2WkSm5ctBjGueDAkq2hzgtI+5DaPFnO4MqkGVIw6oROxzMF8A4Ug1e2jx3xPsHRAOg1M
	ZYLcW8QZNBUaJ13RzZEw5qlkzTUbcDyZeDgdLyaagqFnnwLmifL9jMjUewuBhmhBFh0pLcf8tpX
	Ln2gK11A5JlGPpcBIG4t/hW7wePw3ZJVTjA
X-Received: by 2002:a17:907:a02:b0:bf1:118b:d5e2 with SMTP id a640c23a62f3a-bfe2b7dcb1cmr157759066b.46.1781273957613;
        Fri, 12 Jun 2026 07:19:17 -0700 (PDT)
X-Received: by 2002:a17:907:a02:b0:bf1:118b:d5e2 with SMTP id
 a640c23a62f3a-bfe2b7dcb1cmr157757266b.46.1781273957099; Fri, 12 Jun 2026
 07:19:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529130643.3080315-1-tglozar@redhat.com>
In-Reply-To: <20260529130643.3080315-1-tglozar@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 12 Jun 2026 16:19:04 +0200
X-Gm-Features: AVVi8CfdOUhxTccYgdH0PccD08b_P2nlHLghOP58n65mnSN_tBSEBVopOcbmemM
Message-ID: <CAP4=nvS9MQMeXTnN_hsH7gTDUnV1yeMqyQ=hak5fbZvVQR3jCA@mail.gmail.com>
Subject: Re: [GIT PULL] RTLA changes for 7.2
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oGad-xER4tMDP_Hm4KzOgAmbSTk0IzlGxZ-dE6-feIw_1781273958
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

p=C3=A1 29. 5. 2026 v 15:16 odes=C3=ADlatel Tomas Glozar <tglozar@redhat.co=
m> napsal:
>
> ----------------------------------------------------------------
> Costa Shulyupin (1):
>       tools/rtla: Fix --dump-tasks usage in timerlat
>
> Crystal Wood (1):
>       rtla: Stop the record trace on interrupt
>
> Tomas Glozar (24):
>       rtla/tests: Cover both top and hist tools where possible
>       rtla/tests: Add get_workload_pids() helper
>       rtla/tests: Check -c/--cpus thread affinity
>       rtla/tests: Use negative match when testing --aa-only
>       rtla/tests: Extend timerlat top --aa-only coverage
>       rtla/tests: Cover all hist options in runtime tests
>       rtla/tests: Add runtime test for -H/--house-keeping
>       rtla/tests: Add runtime test for -k and -u options
>       rtla/tests: Add runtime tests for -C/--cgroup
>       rtla/tests: Add unit tests for actions module
>       rtla/actions: Restore continue flag in actions_perform()
>       rtla/tests: Add unit test for restoring continue flag
>       rtla/tests: Run runtime tests in temporary directory
>       rtla/tests: Add runtime tests for restoring continue flag
>       rtla: Add libsubcmd dependency
>       tools subcmd: support optarg as separate argument
>       tools subcmd: allow parsing distinct --opt and --no-opt
>       rtla: Parse cmdline using libsubcmd

This will create a conflict with a fix in master/7.1 [1] as it removes
the code that is fixed by the patch, as reported in linux-next already
[2]. The resolution is trivial (just remove the new, fixed code, as it
is entirely replaced by a new implementation that doesn't have the
bug) but a small note in the final pull request might be useful, so
that it's clear we know about it.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3De9e41d3035032ed6053d8bad7b7077e1cb3a6540
[2] https://lore.kernel.org/linux-next/aimDwlNq_RRLjg6X@sirena.co.uk/T/#u

>       rtla/tests: Add unit tests for _parse_args() functions
>       rtla/tests: Add unit tests for CLI option callbacks
>       rtla/timerlat: Add -A/--aligned CLI option
>       rtla/tests: Add unit tests for -A/--aligned option
>       Documentation/rtla: Add -A/--aligned option
>       rtla: Document tests in README
>

Tomas

