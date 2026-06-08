Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B824B33CEB0;
	Mon,  8 Jun 2026 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780937601; cv=none; b=Hzl/ifFSH7+02yZJuv1P2CfXSYYj9foGneM2oEhLLCw1d2I6hl9Y/X4PG/NCGxcgqoEKBKr55fRULnmGWwK0y/K+Y/u4IpwxD5BW6ugZF+fnWVDlMDv4lG2FXLE2hFQrQeBHSCQe6jIJdwe/oY2x/x/x2RjdUtBlGez/bBsLm5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780937601; c=relaxed/simple;
	bh=vsxmJN1M8Ch3pdXlX0dvcnSfge9XXdXS3NbSQlIgf2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L0DbqpY9zG6YzAMHXyI/VRxTqz+oGMzLMFcKgrygD3JZigZS/s6Y/KvWRgxIytzx+4dIFAaFKAovY1661bbZg92Jf47VJLB5L6Kt4xANJ/IEXp9U4s3LdFqB6KWKvGJyUZF1lYMT55TndqsU4tG8aPbJ3HCeyvAO9wUkEVYLP4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 980B1C01E0;
	Mon,  8 Jun 2026 16:53:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id D77F01B;
	Mon,  8 Jun 2026 16:53:05 +0000 (UTC)
Date: Mon, 8 Jun 2026 12:52:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Hui Wang <hui.wang@canonical.com>, mathieu.desnoyers@efficios.com,
 pjw@kernel.org, linux-trace-kernel@vger.kernel.org, shuah@kernel.org,
 wangfushuai@baidu.com, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/2] ring-buffer: Fix event length with forced 8-byte
 alignment
Message-ID: <20260608125254.2598ef4e@fedora>
In-Reply-To: <20260608180245.09e083867a7d4d96058d7323@kernel.org>
References: <20260607072431.125633-1-hui.wang@canonical.com>
	<20260607072431.125633-2-hui.wang@canonical.com>
	<20260608180245.09e083867a7d4d96058d7323@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D77F01B
X-Rspamd-Server: rspamout01
X-Stat-Signature: frn34bd9u7h6q3x3kwrgh3uq9bomi3ft
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18jnziM3XX+0T0XRuDuf+vSrL7HIQZofaI=
X-HE-Tag: 1780937585-537194
X-HE-Meta: U2FsdGVkX1+9KA2eXuJ2sotvKKBN6F0+BmyRxALg/KHhYOGovWpxKlSnN2p83nKSKsBhl0ZoYv8LWG8qQ/G4Dk9BmczrU7miLaz3lEJbD/c1/5bJd9B1jWDmle/0OuTcFoyFze5IZ6dmP6+Mgb4vk6KmQcuy2hLrObkBowTQCmEvXD/bluxG7qFCr09dJ7hsZOWin/SX8e6odIqQF8H0NVZBzN4+0pea09vXwrUh+FQpAUj+Bt41Iv58R+HKd/DeAk6FKWUF8jI1CYhJawT3kaCAJKjziQlpcBc41YacvzCdGPKWOTbRo5K4Hw6eIVBo7sSr32YqTL9sHDlNeSGBNAPs8hwB+xv4IX25urtl4PmkOE/8r8azjwXVRB7FWlDIzkvw3Vq++bVuIt4qUZdARbc8RdmN9OOf3WHmd2YFYfQ=

On Mon, 8 Jun 2026 18:02:45 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Sun,  7 Jun 2026 15:24:30 +0800
> Hui Wang <hui.wang@canonical.com> wrote:
> 
> > When RB_FORCE_8BYTE_ALIGNMENT is true, rb_calculate_event_length()
> > reserves the space of event->array[0] for placing the data length and
> > rb_update_event() stores the data length in event->array[0]
> > accordingly. As a result the whole event length will add extra 4 bytes
> > for sizeof(event.array[0]) unconditionally.
> > 
> > But ring_buffer_event_length() only subtracts the
> > sizeof(event->array[0]) for events larger than RB_MAX_SMALL_DATA +
> > sizeof(event->array[0]). As a result, small events on architectures
> > with RB_FORCE_8BYTE_ALIGNMENT=true report a data length that is 4
> > bytes larger than expected.
> > 
> > To fix it, add the RB_FORCE_8BYTE_ALIGNMENT as a condition to subtract
> > the size of that length field whenever RB_FORCE_8BYTE_ALIGNMENT is
> > true.
> > 
> > This issue is observed in a riscv64 kernel with
> > CONFIG_HAVE_64BIT_ALIGNED_ACCESS set to y, when we run ftrace selftest
> > trace_marker_raw.tc, we get the weird log: for cases where the id is
> > 1..100, the number of data field is 8*N, but once id exceeds 100, the
> > number of data field becomes 8*N+4:
> >  # 1 buf: 58 00 00 00 80 5e d1 63 (number of data field is 8*1)
> >  ...
> >  # a buf: 58 ...                  (number of data field is 8*2)
> >  ...
> >  # 64 buf: 58 ...                 (number of data field is 8*13)
> >  # 65 buf: 58 ...                 (number of data field is 8*13+4)
> > 
> > After applying this change, the number of data field keeps being 8*N+4
> > consistently.
> >   
> 
> Good catch!
> 
> This looks good to me.
> 
> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

This is the patch I meant to reply to.

NACK as the test is broken and not the kernel.

There's a pending fix already:

  https://lore.kernel.org/all/20260601023251.1916483-1-dtcccc@linux.alibaba.com/


-- Steve
