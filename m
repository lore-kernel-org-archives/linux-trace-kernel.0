Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E533A4BD790;
	Tue, 13 Oct 2026 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791934179; cv=none; b=SQeAE4mG6igRnyce7ty3X7bW59YQZvoAqaQGSfMFEI+tdhYpgaUUzWVQZYU3ZCpNclUc4VhvP41ABv1sGZFAF0RPmN3LVl36vQelS79ToLkIfnfZoMNAZSgnBlZhsxHwFCuqlSFRcsFviCRMm1+G15egkmdczIv6S7/GtLcgUBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791934179; c=relaxed/simple;
	bh=skmpNx0fJOgzLfyKpN7ti09QvIgiuUE2aM5EkfHwxPs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICadIwl1DYhyWwewoEa/uGjVUaoM0O1ogtuqaTWruOELLUikBgsVMSKxSmrByx9/WIZAH3DLvwKdecT4+MfOWUaNshHYq/msW31wb2MguvtqeMfBP1bhWxfOBX36mh/fMu/3kQjzeYZ8rcDtECV1wiRJAaJnAAldqIE9TJDlsi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=G4BVkpwM; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="G4BVkpwM"
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 5654F40397;
	Tue, 13 Oct 2026 23:29:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 5F9462E;
	Tue, 13 Oct 2026 23:29:33 +0000 (UTC)
Date: Tue, 13 Oct 2026 19:29:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Georgi Djakov"
 <georgi.djakov@oss.qualcomm.com>, devicetree@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH 3/6] trace: qpace: Add tracepoints for QPaCE operations
Message-ID: <20261013192931.7b208d17@226.227.38.69.naturalwireless.com>
In-Reply-To: <20260930150006.4FB591F000FF@smtp.kernel.org>
References: <20260930145215.3380977-1-georgi.djakov@oss.qualcomm.com>
	<20260930145215.3380977-4-georgi.djakov@oss.qualcomm.com>
	<20260930150006.4FB591F000FF@smtp.kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 5F9462E
X-Stat-Signature: fjw6unf7fuio961n794qn7ibjk9bhrkk
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18BM2TrhtOMCHiCONhMVqe2rmqKqgc8X6s=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=b1J1SVWeF2QffzvirYSNp0rGn756bwjQeJzTb+Xq4zs=; b=G4BVkpwM/MKzwLUiW4n88kPJdpprRDu12yY9SjV9fR/eMwMh83o3vy1qYGYQv8sRyyd6hFRYZSOPWN0uJ/bonlWZywVZnNrFKUDQauD6N2tWBPW92tIK92OVq0VXPygsJkDrznbW37wVTBZDj99sxV567gvaclqMQqX1vlGzlBQ=
X-HE-Tag: 1791934173-617096
X-HE-Meta: U2FsdGVkX18ceJaP1tFINSafnOqIco6t7sxh4h6E/MksSrZgmAoPXccEMEqP3J8j16SRABDWBbIohAAy88BPCGZDUyg/t7smV4tVtpyMCYAu/AmRCccYWnPP5SHZM6izZNPQe9A++2urrMVK4IkdZkBws5+X2TF6RG0KNI2S/5XFi91Wz87Y/VVy6ilw7xKiDiWW44ZR6d5ZQSl0Web4IJECyPQnb3IcAzx9UwQP4dLIu3qtrhc1rFsheo/lWGNK8sX0y3+LzJep2Cg6F9blvdZbFks65sorBqZJgEEOw4Fh0hBYK/Lu7H0dxbU0zjGNnvqVt20PuuLt0tbyh98eFfbIoKLan84m

On Wed, 30 Sep 2026 15:00:05 +0000
sashiko-bot@kernel.org wrote:

> 
> > diff --git a/include/trace/events/qpace.h b/include/trace/events/qpace.h
> > new file mode 100644
> > index 0000000000000..3f0ccdb8f2060
> > --- /dev/null
> > +++ b/include/trace/events/qpace.h
> > @@ -0,0 +1,99 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > + */
> > +
> > +#undef TRACE_SYSTEM
> > +#define TRACE_SYSTEM qpace
> > +
> > +#if !defined(_TRACE_QPACE_H) || defined(TRACE_HEADER_MULTI_READ)
> > +#define _TRACE_QPACE_H
> > +#include <linux/tracepoint.h>
> > +
> > +TRACE_EVENT(start_qpace_urgent_decompress,  
> 
> [Severity: Low]
> Does this tracepoint name violate the mandatory subsystem_event naming
> convention by using an action prefix instead of the subsystem prefix?

There is no mandatory subsystem_event naming convention. It just should
be unique. The naming is fine.

-- Steve


> 
> Could these be renamed to use the subsystem prefix, such as
> qpace_start_urgent_decompress?
> 

