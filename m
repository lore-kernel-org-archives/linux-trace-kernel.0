Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FFA2045AD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786669479; cv=none; b=fVOUwtq16GMyua0yOUgmFRxWV6H307AHu0PBtum8rIat9JYqh22AQvOMvjorEr+5cm9/84ctNlh5eoC+uzaFWUDmhnNZOo5v9eJYljl8Sb9zV2Iq5BvWLE6ieKqR3KHTnRLmdj9qMG8isex7xBWqr/bfMxkC9HTblSmAETiPjVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786669479; c=relaxed/simple;
	bh=i8WnjqxHmS+PKrArGVUl3dEMeIfSO9n5cVHL/oQ5+ts=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bnMX+/IjQE/6P8GsOD5SXw6Xgajcn0Z6t65zAYfHH9VFVkBYuvBeODgR3621daILzYqtSmu7DUYvrXrUfFy1HAvN/6qd4POGHpSnJxaQd0EKkEKihzO/33lH2gNs13/2QCKNJBrDYoF/L/FZ4ELx0s9aIfO6RrvGbotrSM59p5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=cRPsgzzY; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="cRPsgzzY"
Received: from omf02.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id AC0DFC0325;
	Fri, 14 Aug 2026 01:04:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 174E380013;
	Fri, 14 Aug 2026 01:04:29 +0000 (UTC)
Date: Thu, 13 Aug 2026 21:04:45 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: sashiko-bot@kernel.org
Cc: sashiko-reviews@lists.linux.dev, "Vincent Donnefort"
 <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] ring-buffer: Make cpu_buffer::free_page a
 buffer_data_read_page
Message-ID: <20260813210445.74b69fce@gandalf.local.home>
In-Reply-To: <20260813135613.BD3A11F00A3A@smtp.kernel.org>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-4-vdonnefort@google.com>
	<20260813135613.BD3A11F00A3A@smtp.kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 174E380013
X-Stat-Signature: cnbwesfs7betqa87xmhgh1gk9hbab1cr
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+E/J0Mtfi5r8kNh3hrDciSggRftT9B2Jk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=i8WnjqxHmS+PKrArGVUl3dEMeIfSO9n5cVHL/oQ5+ts=; b=cRPsgzzYuYmu74zrcd75rOHCD+BEWSCifloXPNYT/EKsckIW4FVxWLULj5jU/6qLoC+vhCE6VGDjCe2luH437cK7ran5VmUqdnR0+IUGWENJ0KFogcymmf+Jycn/6jX36DFM0n/ZmfJMGnjTrKyPOxeYd+YfVAuRm9b2uy6spoQ=
X-HE-Tag: 1786669468-696948
X-HE-Meta: U2FsdGVkX19X3bdl5vkKSKEQEJleFcaCgNdsUAluQ1L+OqyRTyyftlE48sJNpoSp9c2qdesOI22BwoRxCpvrd2IIAxZDbqK1Tyg1UncaXkY/ntgnVDTEplO0XYq/LauPVwxmOQItVaGuf0df8UB/R4fCB8Y9GkSfv9cB162KMP5BcCPnmIPyN3PUTVb04ZZG7TzzKITJQhi/9jNvcWlf6zta8+r6jTnXnbfZm4geqHwP1/27ffCIIkqsSkOKFDl8TXjCM234dw6Cb0O2MkVFdo4hYpbps9lVnObvm/pA2UA9Ref72AxUYaI/qA2wCTy9XAP+009wv49wg5QRsjrbE/Rl3sNyCDD5

On Thu, 13 Aug 2026 13:56:13 +0000
sashiko-bot@kernel.org wrote:

> This returns -1, which tracing_buffers_read() treats as EOF. Subsequent
> reads see info->spare_size == page_size, reuse the bad page, and
> permanently return EOF.

If you are resizing the ring buffer at the same time as reading
trace_pipe_raw, yeah you may get garbage or an early EOF.

It's stupid to do.

-- Steve
