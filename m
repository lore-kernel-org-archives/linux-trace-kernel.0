Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156133D75D4;
	Wed,  8 Apr 2026 17:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669984; cv=none; b=bNNS5P8/6i3UKmMgp/0nIbvbPNImpcu7NiLSIWWQ7wFgrgJ/KSYU71YuI3rzI+q69r/1aLeZ2retL2kWQVIk9IgvGiP1CJ0jrfgqBJCVrgRppS5p1y8u7dk6osz6nQYA5gamc5lLqjHKNOwytYd7FMDV5uc9ZJP5FXDTaIK4T2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669984; c=relaxed/simple;
	bh=U85ad5cEAztluCg8Cg1x+q/gNsYNqCa3ODaZ6FfCiKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1dIZX1uUJ9ymrOr8nkct3jYXMBzDKcIrls6MQB3ngGXxkb3Yvp9jAASsiB9QwojIpFymC5gb1DLBLeZKQL4Fa5HR5q46JugtfPXxOkaZ7FDDTLDEvbIweumVIHQYU1hgoAZbqNkq86iLQMq9dNao7tjUj08mDt+4yq/Cj5BS3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id C8D19140258;
	Wed,  8 Apr 2026 17:39:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id B3F6320012;
	Wed,  8 Apr 2026 17:39:32 +0000 (UTC)
Date: Wed, 8 Apr 2026 13:39:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Cao Ruichuang <create0818@163.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Store trace_marker_raw payload length in
 events
Message-ID: <20260408133931.5755684f@robin>
In-Reply-To: <20260408153241.15391-1-create0818@163.com>
References: <20260408153241.15391-1-create0818@163.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B3F6320012
X-Stat-Signature: s3d4qbg4h5fwgxok3oyyomn19dkerhde
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/be3bnzo6PI5XWALwdpZItzz7OxGifuuY=
X-HE-Tag: 1775669972-831830
X-HE-Meta: U2FsdGVkX19A6AH4/kzL0kZ2oI78VJP4jdS4xSIDd5hXYZQT3XiDb/vDv6xRw4L0vckVaj4LLzIrH91ORbQto9DVfFx18TBxiNZXdN4d98Op6Fqb/1lwfrOByarIPAcf9dymupDgOrkU+Xc3uHVMeb76k5RqwVGfLrxbspJdjkeAycx3zzPGK1aImu8j0l9JTwK9UFzWm7K7KOe4M5UfrcAJ8w5/PsK/em1lZhh9EEdp0ZrjSBxhWDebtwhP0pLiHqywooNhe5Htz8K3bFPQDTRnQ1vfxrtLOmD0IMdoQ1KGrSdWANxbTlordoCOgF8yrY0XMTrv9a4NBXMm1kI+1mnMEij7EUy0

On Wed,  8 Apr 2026 23:32:40 +0800
Cao Ruichuang <create0818@163.com> wrote:

> trace_marker_raw currently records its bytes in TRACE_RAW_DATA events,
> but the event output path derives the byte count from the padded record
> size in the ring buffer. As a result, the printed raw-data payload is
> rounded up and small writes do not preserve their true length.
> 
> Keep the true payload length in the TRACE_RAW_DATA event itself and use
> that field when printing the bytes. This leaves the ring buffer record
> size semantics unchanged while letting trace_marker_raw report the exact
> payload that was written.

May I ask why?  The above describes what is happening but fails to
leave out the why? Why does the payload length need to be added to the
event? I mean, it's recording raw data, and the user who writes to it
already knows the length as this was made for applications to write
structures directly into the buffer. When reading back from the buffer
the structure size is the length.

Thus, why record the length? I see no reason to. The length wastes
precious space in the ring buffer when the user of trace_marker_raw
should already know its length.

-- Steve
