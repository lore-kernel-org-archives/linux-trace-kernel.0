Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5724728F;
	Sat, 28 Mar 2026 14:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707592; cv=none; b=aocJZqET2oGhhrIyaw1V1wE1lL0HF0cI46LaQ6rj+rSrSBPFCRFlMUjEIVILvEgOmMvuYz2z6XsjxTOqijWgTkuZZD+PkCuTaBYYArrr0WlmOgIgkn7Y1gqq1A3WB5q/P0hjrz9BjZk9TSoNFi+BoLXii/eapaR3dWBVi01A9Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707592; c=relaxed/simple;
	bh=z86AS1BdwmrdjxjjrLs6o7TpIokD0BCHZjxXqjC23wg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=i5a/NAFwU6mU+fsXi0J/s74Rov7Ia+ssTOtk6z9JIS5auayLE10yePBWDOUVPpv5V+aaEoxOyTNw8a9nE2Wd0d8Y1BfZAxuTzkBvyKnQ96kXu2i6JgW8IXtMvACwM+HDkYmvce9acLcOgePRnM9Nvol4CwnHb6J7O2qt+tLjgNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 1CCEF139942;
	Sat, 28 Mar 2026 14:19:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 5CD6A6000C;
	Sat, 28 Mar 2026 14:19:47 +0000 (UTC)
Date: Sat, 28 Mar 2026 10:19:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Brown <broonie@kernel.org>
Subject: [PATCH] tracing: Remove tracing_alloc_snapshot() when snapshot
 isn't defined
Message-ID: <20260328101946.2c4ef4a5@robin>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5CD6A6000C
X-Stat-Signature: bsazmj1idb8n5obyydtf3n98auyxiwnc
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19TT9LUX4y0U3NrCARBVPTRUYRDeAe8fxU=
X-HE-Tag: 1774707587-643253
X-HE-Meta: U2FsdGVkX1/IglqraDlLwEJCo07RiY6GCZT5GCcAI/ukUz6AT+Qdc6MXbTaZeCeecUEqstCrgJ01DFEBLKbsLOHTlsIRnxMC3iNfgovbiZNLeZzkvKOU0H3CvNGTpazFE2MSi1C4AtebUTfVwlODg8OuEDC7OnQHNCas8BJc/2cd2xgps3iO82h2nbHInneCKTTecyX1/SC2Y6pREfzBl61AW5hrh2m4NruemjKImj9I38QK5oh0KC6diL+eVx55wvLWAUzDwZSY+DUoG78cGzMXQYmTnEsGGrruaqIOHqDaXCvPg4c9tctbEVSk+T166NECcs/VVbU7/Pcu+VAVyZP2qHu0FpSDNK3XcLvAzelMeov/kSjQfOdLwvIFH0uCzxL78m+RLapqUEefjkyXx3rIGustjVr1cxMW7agam5miwIDn3rAqkAn/W3XlKx+KO83LyYbXslha2X19Blkw7g==

From: Steven Rostedt <rostedt@goodmis.org>

The function tracing_alloc_snapshot() is only used between trace.c and
trace_snapshot.c. When snapshot isn't configured, it's not used at all.
The stub function was defined as a global with no users and no prototype
causing build issues.

Remove the function when snapshot isn't configured as nothing is calling
it.

Also remove the EXPORT_SYMBOL_GPL() that was associated with it as it's
not used outside of the tracing subsystem which also includes any modules.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/acb-IuZ4vDkwwQLW@sirena.co.uk/
Fixes: bade44fe546212 (tracing: Move snapshot code out of trace.c and into trace_snapshot.c)
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ec2b926436a7..7f2fbf9c36df 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -810,19 +810,12 @@ int tracing_alloc_snapshot(void)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(tracing_alloc_snapshot);
 #else
 void tracing_snapshot(void)
 {
 	WARN_ONCE(1, "Snapshot feature not enabled, but internal snapshot used");
 }
 EXPORT_SYMBOL_GPL(tracing_snapshot);
-int tracing_alloc_snapshot(void)
-{
-	WARN_ONCE(1, "Snapshot feature not enabled, but snapshot allocation used");
-	return -ENODEV;
-}
-EXPORT_SYMBOL_GPL(tracing_alloc_snapshot);
 void tracing_snapshot_alloc(void)
 {
 	/* Give warning */
-- 
2.51.0

