Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A199735C1A0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Jul 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785487400; cv=none; b=hRtWTwxAXG1iQAghkP0q3iQme3/ucJwRbHTv2/2uQbnfIBDtt47qAlxtxHgLbyodj9H/noECmfSIjsPCYHqm9SjVrtCbS4vIF4ZEYSgxMfh/RYH0/vpZjxt0E3KNRP6MPDF+xakI6CPdoSXp9ERGKAP2azmFLqQn6ZvT5vGThr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785487400; c=relaxed/simple;
	bh=j2SjsKR12g2/eBbTkDmKpAIozQiKr2CRlxunr3mLRqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=baJ6ES/e3P+GEkKKZU23gsfS8qfbEXgflNRk1DvG4yZRmUGmvrRIPK4GNGs/bApWiXMLd+kB/GjXLsQdL5RpaodAgymEvz5yn0cvTC/H8qXLtTjzH+UU4g+ilDxEJD8V7YqA1rHCyBrs9N29PSFdjRiYdf7Kz2rkKoFsaSjW8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vu6XRK7W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vu6XRK7W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785487397;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UQglzxkkmdxU07t5W1fs1kSnAyCyTXHTL6VYsYOcl9s=;
	b=Vu6XRK7WzCWyDJs/yC7i9feGUXneRDzxxSxIbRoO2bYi/kmqMciHfKi6LAshW2p+nZBtl0
	HO3Wwt12lih60DovtiAr9X/j8fjok5ackYGLWtuGSv3FwtKLODoirfH5wv7qFUVAwvK/sQ
	jcduGkM/1oeNCcQEtPjxeVYuw1XZnVQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-192-XyIQaXvYO3eIdU7voCsnIw-1; Fri,
 31 Jul 2026 04:43:14 -0400
X-MC-Unique: XyIQaXvYO3eIdU7voCsnIw-1
X-Mimecast-MFC-AGG-ID: XyIQaXvYO3eIdU7voCsnIw_1785487391
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6274E19560AA;
	Fri, 31 Jul 2026 08:43:11 +0000 (UTC)
Received: from fedora (unknown [10.44.33.21])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1C1CD1956089;
	Fri, 31 Jul 2026 08:43:04 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 31 Jul 2026 10:43:11 +0200 (CEST)
Date: Fri, 31 Jul 2026 10:43:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] uprobes: Fix NULL pointer dereference in hprobe_expire()
Message-ID: <amxgF3S7jfmjHvPv@redhat.com>
References: <20260729-uprobe-v1-1-61896b87c867@debian.org>
 <amokG13tEnA7VVVf@redhat.com>
 <CAEf4BzYON57L_HD71qUOdRdni_=1S-Xomz27PeDBxbbXDy0Jug@mail.gmail.com>
 <20260730085421.d455361164695270bd764a4b@kernel.org>
 <20260730103824.GD751831@noisy.programming.kicks-ass.net>
 <20260731095652.fc5d64f8c122d7dc6ddd89be@kernel.org>
 <20260731083039.GD776954@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260731083039.GD776954@noisy.programming.kicks-ass.net>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: qgYUft2Vlh-NUApQIVjgl2DpE_y3bQFuBCreKdxy420_1785487391
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 07/31, Peter Zijlstra wrote:
>
> On Fri, Jul 31, 2026 at 09:56:52AM +0900, Masami Hiramatsu wrote:
> > On Thu, 30 Jul 2026 12:38:24 +0200
> >
> > Either way works. Can we update MAINTAINERS file if you will maintain
> > uprobe in tip tree?
>
> Well it is in kernel/events/ which MAINTAINERS should already assign to
> me, no?

Confused... you are already listed as a maintainer. From MAINTAINERS:

	UPROBES
	M:	Masami Hiramatsu <mhiramat@kernel.org>
	M:	Oleg Nesterov <oleg@redhat.com>
	M:	Peter Zijlstra <peterz@infradead.org>
	L:	linux-kernel@vger.kernel.org
	L:	linux-trace-kernel@vger.kernel.org
	S:	Maintained
	F:	arch/*/include/asm/uprobes.h
	F:	arch/*/kernel/probes/uprobes.c
	F:	arch/*/kernel/uprobes.c
	F:	include/linux/uprobes.h
	F:	kernel/events/uprobes.c

Oleg.

