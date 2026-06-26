Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B021B388397;
	Fri, 26 Jun 2026 10:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470556; cv=none; b=UipMcZxUDwmQQrG1oG/wWXmaXBb/FNYMZfRTJPRx3/j+nGSjzTLNtR+8b8XI0hVplKJ6GJYYvN+nrhHd3puSJ7UrkcnM7RDYSKKU21ajpoEei2fplbWsFk9eTWdwekqb3bX8OFMK4o+0aAeHySQ09uGa6/zu0MMDIwHub2KHu0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470556; c=relaxed/simple;
	bh=o4Ef5WodEoKWBYVZ8+hsbYTrDPckpmcgvOzyc7mX5n4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aPu4W+x+P0l/6Zn0IQkRCkHtfwV13ne0u+7Z3D1HfeLzR9h9slXiTVGbPhPVTVkc4Sqr5PEyzroHRmMJpmvHoP5BlyL1wGyfyPDFXjkzVGWcSacCdbKb8o3F5H1x3NVcLuBppMI62qM6pX4kLpxf3PxEQ+yD+DNZweBQC+Y53JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id E5B9D1A03A4;
	Fri, 26 Jun 2026 10:42:27 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id E3FE52000E;
	Fri, 26 Jun 2026 10:42:25 +0000 (UTC)
Date: Fri, 26 Jun 2026 06:42:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-ID: <20260626064223.60ffeeaa@fedora>
In-Reply-To: <aj5SdK9gUIVoPmmE@akranes.kaiser.cx>
References: <20260615145500.2662456-1-martin@kaiser.cx>
	<20260616110910.e6420488b6a798d49951cde9@kernel.org>
	<ajJbkeK0zXb8MtcS@akranes.kaiser.cx>
	<20260618105227.c58c85e9cb19bce673d9a79b@kernel.org>
	<ajasLMUt_AMM3ztH@akranes.kaiser.cx>
	<20260622125815.7416792c020bd3d81c01e51b@kernel.org>
	<20260626055440.76c28d25@fedora>
	<aj5SdK9gUIVoPmmE@akranes.kaiser.cx>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: k17confegmngzkk7hujeb6axb54amsi6
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: E3FE52000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19+58OVjlaZUwor3sUxVZXii9lRzH2NEaM=
X-HE-Tag: 1782470545-550183
X-HE-Meta: U2FsdGVkX18a8k77nkdJ/Z+G7GsR73ttNOl0rhlIvVOyf/oyL9pH+YyCi6vZw/XB8RGymPvVp0OqZzvWSeqi6VpmV+M0zbaJoqrWkcixbjcPuib6gFxDGpLMb7Erd25kZr/FbBhmqGGYbPSfSnjKOew5cg7lTXe53K2KZlWKR/91DdfW51neDiF5CL5rZOVluhH/3QTmQr2PXq8a3GTNsZpBIdHpye74BvFcjDu015PeSViqoZ35fBwiMc8BUtDggPriKpmNwJkJy/GH7uIPcuNRDxXmTnmKr+wTYgbu4Tm82rEvCi37Fy6d+Vxg3H9b

On Fri, 26 Jun 2026 12:20:36 +0200
Martin Kaiser <martin@kaiser.cx> wrote:

> > That is, to have +u0() say "this is going to be dereferencing user space".  
> 
> > I'll add Martin's patch and see if it makes the above work.  
> 
> I've just tried your command with my patch. It works for me, filenames are
> logged correctly.

Yep, this definitely looks like a fix. We have;

	addr = rec + field->offset;

Where addr points to the location of the field on the ring buffer, thus
your change to make it:

	val = *(unsigned long *)addr;

Reads the full "long size" of the event on the ring buffer, instead of
reading just one byte. It is "val" that gets dereferenced later by the
probe logic (the "+0u()"), which has all the protections we need.

I'll queue this up.

Thanks!

-- Steve
