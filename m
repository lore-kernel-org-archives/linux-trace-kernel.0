Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584823AAF5F;
	Fri, 14 Aug 2026 01:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786671251; cv=none; b=FJjuH/W6A+DckwCGHAkZ3caBYOS8wl9+HuiSJBGX/pcOxdSaQjGb73sIhc5En18N+zrCZzUmxmFoLEwMSCrHbgaznSvdR4USkNGcgzDEXX0+eIvr+8cevkmdEdIU8UzH1YVKkkyf5dzawgOBe/VRfPFbbl45HrTnWSwaqGCQreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786671251; c=relaxed/simple;
	bh=GwfoK/vAsuu6LTjPjOijH/3D+fwtVxMahdSdRVharwk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HeXHGF47+MsD8WJcEaQ/tjvVUYS43nSMLIa2UIJwO/osw15dV0zY6ntKk6c4HyK6cdvp8x5xMnJOSlw3CXn0GQcC7HkzGy+z9ze2FCLsmtS4ZCs7OD5xWq8DiJxb/S9npDj/aanpNfGlnkCGIMShqtDRcGXo+QOBLt3sortqKm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=zuFUuvLX; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="zuFUuvLX"
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2884F401C0;
	Fri, 14 Aug 2026 01:33:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 506AC2F;
	Fri, 14 Aug 2026 01:33:50 +0000 (UTC)
Date: Thu, 13 Aug 2026 21:34:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/10] ring-buffer: Dynamically calculate
 max_data_size
Message-ID: <20260813213407.6bc29cc9@gandalf.local.home>
In-Reply-To: <20260813131152.3589632-8-vdonnefort@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-8-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 506AC2F
X-Stat-Signature: bf7eaenckpahw1odwei6rwysmewg9b4p
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/VGeGWvAZB+B/H3kABJ3EveVW8rhTNM10=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=QF8s/Atg7sXvRdhUbdxDe5D4DAHKHFlxb51rVAFQqGQ=; b=zuFUuvLX/Uax0T1yFD5sHSlvgj4pZS6HgdRp/3Wd9r8yBZzYxPjPP+QMGzbeq91to2GNJQeEB50Q5z/UfYG/jCVOBcxq8o0jB5/uCK1S++HLktpcN895HKhgaclo5Sc4NReMWV1SKGT1JTsCNYJhCqjDcjoAiYZInQhwS3YaKT4=
X-HE-Tag: 1786671230-893487
X-HE-Meta: U2FsdGVkX19Dc4DzHznZeuZpQDHwoQPBWzeqm57yRjzUeJGcC/mqvDCMbjIb0HZ1lQtVRtecP600NKKhnKHCr5IYKB4sBhyOgmGqVHXIi4SSkVDsDpRqBHy271ZG0fWkhNyOCRH6IA92S3mAsGhAS4fOLFCtGfueVTWHU3BLsXc5DtKLKiQXNrsYLqbY1PkaaKiqsGE/0dOnCdV/PDGI/i/u/GP2/vY2b2sbBmphI+36f07jbuEfEcSseEFuG07Zj1gq4LP5p8cHTDRCjoGXnLqZhOEJOl0/yGofFQpL0JcGwFp/R3PNWoBswo6TMOe/p8wLtv842feQN5vKuSbikplMMi6Sq6xw

On Thu, 13 Aug 2026 14:11:49 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> The ring buffer order can be dynamically modified and temporarily
> disables writing to do so. It is therefore safe to use the updated value
> to calculate the maximum event size which can be written onto the ring
> buffer.
> 
> However, notice it is hardly making any difference for trace_marker
> because of the TRACE_MARKER_MAX_SIZE limit. For an 8KiB subbuf size,
> trace_marker can take 4096 characters while it can 'only' take 4054
> bytes for smaller subbufs.
> 
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")

Why the fixes tag? What is it fixing?

-- Steve

> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

