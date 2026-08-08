Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399DD41754;
	Sat,  8 Aug 2026 13:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786195079; cv=none; b=d8S7lk2WHpPWcxeiyT00OTcN0URzQqtWBi+41L3wIwqm+QbCyx/umHrHTDbjmSGPZ+6Y5SAG0ZrlbmTZKjQghCtDvLcyAvdnh3vWJXJVeX7wqLksML2Ffu/YifU5D4K5h+l1mnqv67YnVcp6xrMhNvrRt/02P+zgLlf+79gKE9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786195079; c=relaxed/simple;
	bh=hDbZl3qPDBYdxq/eCcIg7ptQGUIlYTZSixApOi6tuRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oifGuOHBNTEslxgzAHW+SLfVlQnUllirOwL/w3/wjAXj2vhWCjPLzhfU3odI42wAKDMG/fxQRTDCCFJ+IR8Va5YZhKJPwUN43uD7fqae/pF5WQfhBLM3Stpppv6KmQ0x/aqkjkyveQ8zu/wJ8FjzF14qMj68iOHJMpLnGViUh8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id CDFF6120374;
	Sat,  8 Aug 2026 13:12:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id EF86417;
	Sat,  8 Aug 2026 13:12:20 +0000 (UTC)
Date: Sat, 8 Aug 2026 09:12:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Pekka Paalanen <ppaalanen@gmail.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 nouveau@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] tracing/mmiotrace: Clean up coding style and
 redundant debug logs
Message-ID: <20260808091219.76d3c382@robin>
In-Reply-To: <20260808131634.4dafadc203a58e9f5b0e7613@kernel.org>
References: <178524298182.56416.7520852015178187644.stgit@devnote2>
	<178524301945.56416.2087305624947649637.stgit@devnote2>
	<20260807205053.7000eef0@gandalf.local.home>
	<20260808131634.4dafadc203a58e9f5b0e7613@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 6joiu4s575cfck7s45iryq7w8f36t4i4
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: EF86417
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19OT0neM9cuPapsa7FWTtaeA+JUyyPMUkg=
X-HE-Tag: 1786194740-47388
X-HE-Meta: U2FsdGVkX1+gLiPXtn6NOrqLtU0+g0sRYVojChVl2xZ6oOD1nexNziDbT3gx+rnL9r59Kv4u+Aq/3M3IVBc88/e1kUXfKdVtet+AB5i4SggvbTuZLdnNqa3pIzMjdPGkSWzJMtI0kGm4rPnYzj/mMahkpZINg1mZQUrw1FEG17oAi+2a6vVECOugmr/esQMYOCRRk7Ix7rOwr2djUZQu6wOezDk3fc0FadaZe9s9YX/e0109qIUsLxsHXs+wVX4rFDRIte14AtGO2itSdGoSaAY/yDlO2o36BNfTuASEjXX1hcROnX6MdG40k3/QTYpuS691fwtJxeGvGy4did4HwR6T4wGSzhoC

On Sat, 8 Aug 2026 13:16:34 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Yeah, this is somewhat machinary fix against the checkpatch.pl.
> Or, maybe it is better to just pass mmio_trace_array directly?

checkpatch.pl isn't for existing code. It is for new patches. And is
also more of a guideline than a rule.

Those two functions don't need to be changed to satisfy checkpatch.
They are fine as is.

-- Steve
