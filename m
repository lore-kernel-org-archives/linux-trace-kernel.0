Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A684A13A1;
	Wed, 13 May 2026 17:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778693110; cv=none; b=B1N2jYPnZkpQSgLJCuBtO8yBXUB7GcOXbby1o8yVk66H56w6R8KQ0H028CCUTj8YsLMOeO8LhYAxZ8Toy5d4cYfwFXsrCq514p6rtvofVJAnnbes2jtqrUe6v2C8jPhK6NHPEyINZtJ4GrQiCy0qZR0zl41b0sIF3huDOcy+NQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778693110; c=relaxed/simple;
	bh=XoPwTd4LYKyXmB588AhIasYO2rJRGvyQ0Kwn6wDBy6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UgL2W8sy0qUb/I4qv2w+l+aH+vXcFy3eosCRRutAcSkXCuO+Q8ivr71KvTr5ZTGhqmv7wrCK6gorDKolbrYlBZruIqe+CX5wqZjph4eGbH0FbIIT/YvKt+w04VOADDCUbsY/bLSYaFN3UecOtsYgXB2jAV3OBK/69NaDmiGlFhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=Pg30inMF; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="Pg30inMF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=smfBSAMRXNSqgAf1NrxQkOvOSzSW0Bzdr9HPl7C+Tmw=; b=Pg30inMFcIBFGWC+cIQNKPPFfp
	j9cPeEacKaRoHjijyKso//FYRF3/Sv1RcdWyAeNpKYw5hmop6o903shlfT5HRBX8mWjaoKw8VOk7c
	zKeSjApV5qyKFJl2D1GbzpSsoAe1TZveVvjiwOC3r4QGk2ddOVoLIDXqFjq1lsPoM938lcUSaRBUO
	cYmAt1HlXvVSQOVaoKSmuxfxlWYT2tJQasgFYWplX9d24lQr09itp2clLvI6iQtPoMNLil1vomckt
	kFj0XkDQP8sly8ZGoEGpDjHmmFjAwxh4PasbJRrjRtmx2aU0ywcBgXK4+5DdH49X6mTGo1dN2HGv6
	pEImPvFA==;
Received: from [2601:18c:8180:83cc:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wNDKA-000000007GQ-4ANy;
	Wed, 13 May 2026 13:24:47 -0400
Date: Wed, 13 May 2026 13:24:45 -0400
From: Rik van Riel <riel@surriel.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2] perf/ftrace: Fix WARNING in
 __unregister_ftrace_function
Message-ID: <20260513132445.24d8d9f6@fangorn>
In-Reply-To: <20260513123344.05b6bcfe@gandalf.local.home>
References: <20260513121607.14eab1f6@fangorn>
	<20260513123344.05b6bcfe@gandalf.local.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 12:33:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

>=20
> Instead of duplicating code, what about doing:

That is much nicer. Thank you!

---8<---

=46rom 9de86227b917c49315b7b67aac3a83afae8d792d Mon Sep 17 00:00:00 2001
From: Rik van Riel <riel@meta.com>
Date: Sat, 25 Apr 2026 03:33:54 -0700
Subject: [PATCH] perf/ftrace: Fix WARNING in __unregister_ftrace_function

perf_ftrace_function_unregister() unconditionally calls
unregister_ftrace_function() without checking whether the ftrace_ops
was ever successfully registered. This triggers a WARN_ON in
__unregister_ftrace_function() when the ops doesn't have
FTRACE_OPS_FL_ENABLED set.

This can happen during perf_event_alloc() error cleanup when
perf_trace_destroy() is called via __free_event() on an event whose
ftrace_ops registration failed or was already torn down by
perf_try_init_event()'s err_destroy path.

The call path is:
  perf_event_alloc() error cleanup
    -> __free_event()
      -> event->destroy() [tp_perf_event_destroy]
        -> perf_trace_destroy()
          -> perf_trace_event_close()
            -> TRACE_REG_PERF_CLOSE
              -> perf_ftrace_function_unregister()
                -> unregister_ftrace_function()
                  -> __unregister_ftrace_function()
                    -> WARN_ON(!(ops->flags & FTRACE_OPS_FL_ENABLED))

Fix this by checking FTRACE_OPS_FL_ENABLED before attempting to
unregister. If the ops is not enabled, just free the filter and
return success.

Assisted-by: Claude:claude-opus-4.7 syzkaller
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 kernel/trace/trace_event_perf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_event_perf.c b/kernel/trace/trace_event_per=
f.c
index a6bb7577e8c5..58e1b427b576 100644
--- a/kernel/trace/trace_event_perf.c
+++ b/kernel/trace/trace_event_perf.c
@@ -497,7 +497,11 @@ static int perf_ftrace_function_register(struct perf_e=
vent *event)
 static int perf_ftrace_function_unregister(struct perf_event *event)
 {
 	struct ftrace_ops *ops =3D &event->ftrace_ops;
-	int ret =3D unregister_ftrace_function(ops);
+	int ret =3D 0;
+
+	if (ops->flags & FTRACE_OPS_FL_ENABLED)
+		ret =3D unregister_ftrace_function(ops);
+
 	ftrace_free_filter(ops);
 	return ret;
 }
--=20
2.52.0


