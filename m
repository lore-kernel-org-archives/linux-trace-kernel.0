Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313263B895A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 12:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777292420; cv=none; b=bXlIEe8KgaBY19KcLZs3nrkfmf0hhti5q0O2H33B/Kb/mHxTAlLEztfsHHv7thg11DoCwUuoHPa9JpZ+l7hY/RHihvIaOQlfweKun90sELoyzRTao6qQb4aJlR+jeGaqdHVgv9QXrmM6fWIXtQa0Sz5tnRxPxYR20h7PBu6LU0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777292420; c=relaxed/simple;
	bh=vfwoasfNMWJSpfAsK91lcEgHR2U+YXlN33dahW6hJhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fpSNgV86WsceECl4yUzRtP0WfY3zeGBIXmCz+pbWf4qq1H5g7gpX01lKeBVFiBHR8uGcIyAGDAzy2bOEFWUdyEg92yCLwRZRac68TKXGAcfhdVhCLb6b8etRQO69JtmiU/YQ2Ul7JcEgtjnZfU2rzuSLUYfjuyac0LyMp8qj/9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IXpgWz2r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IXpgWz2r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777292418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gQCC3LXbAisJgiqfxp2+is0RYrYavB+fY/mgCdio8cg=;
	b=IXpgWz2rEyvqDor5GYwqlerpn7oVYTVk6BBn6w0rteA2RA6Xb+7OA4PuCJxj/YUulB14Q9
	7s2fpQGc8vzbHQOxqEkuwDa91TIRuGlM8sVU3za0ze3tSH/8NaPf86LI5+VGSlodeIxVyE
	HEC88jXgiXJ8Bf8VvfnRLHFBpfGF9n4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-aCvH4pPQMOqGkHWQoYxhOA-1; Mon,
 27 Apr 2026 08:20:14 -0400
X-MC-Unique: aCvH4pPQMOqGkHWQoYxhOA-1
X-Mimecast-MFC-AGG-ID: aCvH4pPQMOqGkHWQoYxhOA_1777292413
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B28D81800464;
	Mon, 27 Apr 2026 12:20:13 +0000 (UTC)
Received: from 192.168.0.21 (unknown [10.22.88.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 92E2A3000707;
	Mon, 27 Apr 2026 12:20:10 +0000 (UTC)
Date: Mon, 27 Apr 2026 09:20:09 -0300
From: Wander Lairson Costa <wander@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, John Kacur <jkacur@redhat.com>, 
	Luis Goncalves <lgoncalv@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Costa Shulyupin <costa.shul@redhat.com>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] rtla/tests: Extend runtime test coverage
Message-ID: <ae9UZFr5Tr-6XB1M@192.168.0.21>
References: <20260423130558.882022-1-tglozar@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260423130558.882022-1-tglozar@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-MFC-PROC-ID: 2wHzwP1mkqYIBOb_Sso-aVK91uRqzrCxInGxr1slcQg_1777292413
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2026 at 03:05:49PM +0200, Tomas Glozar wrote:
> This patchset introduces some new tests to cover more options, especially
> histogram and thread options. Most of the new tests use positive and negative
> output matches, sometimes in combination with action scripts, to verify that
> RTLA is applying the settings correctly.
> 
> Tests were reorganized a little, adding two new sections: thread tests and
> histogram tests, next to basic tests.
> 
> Additionally, coverage of existing tests is extended by adding new matches and
> by extending tests to cover both top and hist tools where possible. For the
> latter, new helpers check_top_hist and check_top_q_hist are added to engine.sh.
> 
> As part of the new action scripts, detection of measurement threads is made more
> robust by following child processes of either RTLA (user workload) or kthreadd
> (kernel workload) rather than grepping through the comms of all processes, which
> might have lead to false positives.
> 
> These changes significantly improve test coverage and make the test suite more
> against false positives from unrelated processes.

Reviewed-by: Wander Lairson Costa <wander@redhat.com>

> 
> Tomas Glozar (9):
>   rtla/tests: Cover both top and hist tools where possible
>   rtla/tests: Add get_workload_pids() helper
>   rtla/tests: Check -c/--cpus thread affinity
>   rtla/tests: Use negative match when testing --aa-only
>   rtla/tests: Extend timerlat top --aa-only coverage
>   rtla/tests: Cover all hist options in runtime tests
>   rtla/tests: Add runtime test for -H/--house-keeping
>   rtla/tests: Add runtime test for -k and -u options
>   rtla/tests: Add runtime tests for -C/--cgroup
> 
>  tools/tracing/rtla/tests/engine.sh            |  15 +++
>  tools/tracing/rtla/tests/osnoise.t            |  73 +++++++----
>  .../rtla/tests/scripts/check-cgroup-match.sh  |  17 +++
>  .../tracing/rtla/tests/scripts/check-cpus.sh  |   9 ++
>  .../tests/scripts/check-housekeeping-cpus.sh  |   4 +
>  .../rtla/tests/scripts/check-priority.sh      |   8 +-
>  .../scripts/check-user-kernel-threads.sh      |  16 +++
>  .../tests/scripts/lib/get_workload_pids.sh    |  11 ++
>  tools/tracing/rtla/tests/timerlat.t           | 113 +++++++++++-------
>  9 files changed, 194 insertions(+), 72 deletions(-)
>  create mode 100755 tools/tracing/rtla/tests/scripts/check-cgroup-match.sh
>  create mode 100755 tools/tracing/rtla/tests/scripts/check-cpus.sh
>  create mode 100755 tools/tracing/rtla/tests/scripts/check-housekeeping-cpus.sh
>  create mode 100755 tools/tracing/rtla/tests/scripts/check-user-kernel-threads.sh
>  create mode 100644 tools/tracing/rtla/tests/scripts/lib/get_workload_pids.sh
> 
> -- 
> 2.53.0
> 

