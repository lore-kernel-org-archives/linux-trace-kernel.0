Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E2143FD1F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Aug 2026 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667862; cv=none; b=gqDv6qWZzNBqvSaaX6og+pGovm6W0vxg44ekwW6lhIZZ9lUOccxi7RRz07VNWcwfcTkcc1nMVGCmukCbVYfrFFuWuiU9fcXJoKKy31f7NJKyTigxCC8MRrFfl61fxxPgYpg+9UOjkjnjKB52zuPWyzVSdB4zunOVGqGRUeSPvPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667862; c=relaxed/simple;
	bh=9++JWN/yKgRE8XrtygCSlSPL3MHI13Vl5tFyltuByl8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyOHB3HLte6xOBIduKxDdwUdSjnID1IjDRhx23Ah5F+N6ROMEkwQ5+q64/y2CA2mA8eUCNAubMsfw4BjOuurM3gKR9xAQWR99Otfwy+W0pajSRpUL4e+YdZGc2SXAyFwWjMI4C5AdDNTSZvQmVx3hgtqHQ3gQuem5PCxC66nCEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=7hoY08tf; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="7hoY08tf"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id BB9A9140434;
	Tue, 25 Aug 2026 14:24:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 1BA8180013;
	Tue, 25 Aug 2026 14:24:17 +0000 (UTC)
Date: Tue, 25 Aug 2026 10:25:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260825102500.558559d3@gandalf.local.home>
In-Reply-To: <ao2P-4a2aJFYVT6k@google.com>
References: <20260817134750.3909384-1-vdonnefort@google.com>
	<20260817134750.3909384-2-vdonnefort@google.com>
	<20260817140812.2C7D41F00A3A@smtp.kernel.org>
	<20260822110424.346fa3c8@fedora>
	<aotTYT0zE5LNik06@google.com>
	<20260824105315.27377f30@gandalf.local.home>
	<ao1Rn8ZKr5XafWRZ@google.com>
	<20260825084707.4c9cf9f5@gandalf.local.home>
	<ao2P-4a2aJFYVT6k@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1BA8180013
X-Stat-Signature: 7ufuyuryyh7d8smczdqc1p1mqjydwus9
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19f6F0CU/DJiEAYoNza6KLOHumBfFArKLI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=9++JWN/yKgRE8XrtygCSlSPL3MHI13Vl5tFyltuByl8=; b=7hoY08tfAPQva++WdUuT4PDDTZKYt8+iEM+5sP6JuhMF1+XwNlcT5lq+xcRJcKEBT6TlEDkKX5wPrM/ejwMq6+IZ2Lb4XVUr6pcUxPgm6nweu7keLvf88sHnRwUFqoaQUtuIeiycf8goJ+Ln5j7x5Zw1gMjzmcnStDAKzpx52QA=
X-HE-Tag: 1787667857-469038
X-HE-Meta: U2FsdGVkX19q0QCio8Wf3urQjGj1lYHyRPJ4avWengtSkO0Kt4ibjn8URNvUPU0ua3GSAkygtNm+NAsJlE5B/91+WfUUxzqjVe83ccFbvd8nEXtMUKYt5Rn2cyLoXOFeB0p9cnhB3GwgmdJielz96KGUJ8/AdX1Ci64zz8FtaW9fL2fAHkDTr9gQloVDFiKf5EgbIJzEJCPNJ71CBN75bQbuUmv3HqDFb5Dy8ts70xQZMntV/zXTCcwXU0TynBmH3qTaM/3L65oORumuRf48CSKUPV+W3c/cnpUTid6IKMOLA4jMJK8aUR7QRZjvy3WiOFAvAmPX1l/b15tamSDxwR6dKNQ5CX+0+dd3cd8YGnwZl11nLi3Jag==

On Tue, 25 Aug 2026 13:52:11 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> But now with the idea of copying the data when data_page->order !=
> reader_page->order, I am less convinced there's any gain.

Yeah, let's leave this alone for now.

-- Steve
